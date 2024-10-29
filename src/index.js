// Script to handle form submission, data export, etc.

document.getElementById("idea-form").addEventListener("submit", function (e) {
    e.preventDefault();
    // Simulate idea submission with a notification
    alert("Idea submitted! Notifications sent to the Department’s QA Coordinator.");
    this.reset();
  });
  
  function exportData() {
    // Function to export data as CSV
    alert("Data export initiated. A CSV file will be downloaded.");
  }
  
  function exportDocs() {
    // Function to download documents as ZIP
    alert("Documents export initiated. A ZIP file will be downloaded.");
  }
  
  // Placeholder functionality for admin actions, notifications, etc.
  