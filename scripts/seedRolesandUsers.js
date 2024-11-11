const bcrypt = require('bcrypt');
const pool = require('../src/db');  // Database Connection File

async function seedRolesAndUsers() {
  const adminPassword = await bcrypt.hash('admin_password', 10);
  const qaManagerPassword = await bcrypt.hash('qa_manager_password', 10);
  const qaCoordinatorPassword = await bcrypt.hash('qa_coordinator_password', 10);

  try {
    // Insert departments if they don't exist
    await pool.query(`
      INSERT INTO "Departments" (department_name) VALUES 
      ('IT'), 
      ('QA'), 
      ('Business'), 
      ('Engineering'), 
      ('Education'), 
      ('Health'), 
      ('Social Sciences')
      ON CONFLICT (department_name) DO NOTHING
    `);

    // Insert roles if they don't exist
    await pool.query(`
      INSERT INTO "Roles" (role_name) VALUES 
      ('Admin'), 
      ('QA Manager'), 
      ('QA Coordinator'), 
      ('User')
      ON CONFLICT (role_name) DO NOTHING
    `);

    // Insert admin user if it doesn't exist, associated with IT department
    await pool.query(`
      INSERT INTO "Users" (name, email, password, role_id, department_id)
      VALUES ('admin', 'admin@ideahub.com', $1, (SELECT id FROM roles WHERE role_name='Admin'), 
      (SELECT id FROM departments WHERE department_name='IT'))
      ON CONFLICT (email) DO NOTHING
    `, [adminPassword]);

    // Insert QA Manager user if it doesn't exist, associated with QA department
    await pool.query(`
      INSERT INTO "Users" (name, email, password, role_id, department_id)
      VALUES ('qamanager', 'qa_manager@ideahub.com', $1, (SELECT id FROM roles WHERE role_name='QA Manager'), 
      (SELECT id FROM departments WHERE department_name='QA'))
      ON CONFLICT (email) DO NOTHING
    `, [qaManagerPassword]);

    // Insert QA Coordinator users for each department (5 accounts)
    const qaCoordinators = [
      { username: 'eng_qa_coordinator', email: 'eng.qa@ideahub.com', departmentName: 'Engineering' },
      { username: 'soc_qa_coordinator', email: 'soc.qa@ideahub.com', departmentName: 'Social Science' },
      { username: 'edu_qa_coordinator', email: 'edu.qa@ideahub.com', departmentName: 'Education' },
      { username: 'bus_qa_coordinator', email: 'bus.qa@ideahub.com', departmentName: 'Business' },
      { username: 'health_qa_coordinator', email: 'health.qa@ideahub.com', departmentName: 'Health Sciences' }
    ];

    for (const coordinator of qaCoordinators) {
      await pool.query(`
        INSERT INTO "Users" (name, email, password, role_id, department_id)
        VALUES ($1, $2, $3, (SELECT id FROM roles WHERE role_name='QA Coordinator'), 
        (SELECT id FROM departments WHERE department_name=$4))
        ON CONFLICT (email) DO NOTHING
      `, [coordinator.username, coordinator.email, qaCoordinatorPassword, coordinator.departmentName]);
    }

    console.log('Departments, roles, and super users seeded');
  } catch (error) {
    console.error('Error seeding roles and users:', error);
  }
}

seedRolesAndUsers();
