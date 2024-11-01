PGDMP                  	    |         	   IdeaHubDB    14.13    16.4 Y    R           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            S           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            T           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            U           1262    16394 	   IdeaHubDB    DATABASE     �   CREATE DATABASE "IdeaHubDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "IdeaHubDB";
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            V           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    4            �            1259    16463 
   Categories    TABLE     z   CREATE TABLE public."Categories" (
    category_id integer NOT NULL,
    category_name character varying(100) NOT NULL
);
     DROP TABLE public."Categories";
       public         heap    postgres    false    4            W           0    0    TABLE "Categories"    COMMENT     Q   COMMENT ON TABLE public."Categories" IS 'Allows tagging of ideas by categories';
          public          postgres    false    222            �            1259    16462    Categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Categories_category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public."Categories_category_id_seq";
       public          postgres    false    222    4            X           0    0    Categories_category_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public."Categories_category_id_seq" OWNED BY public."Categories".category_id;
          public          postgres    false    221            �            1259    16444    Comments    TABLE     �   CREATE TABLE public."Comments" (
    comment_id integer NOT NULL,
    idea_id integer,
    user_id integer,
    content text NOT NULL,
    is_anonymous boolean DEFAULT false,
    comment_date time without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public."Comments";
       public         heap    postgres    false    4            Y           0    0    TABLE "Comments"    COMMENT     B   COMMENT ON TABLE public."Comments" IS 'Stores comments on ideas';
          public          postgres    false    218            �            1259    16443    Comments_comment_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Comments_comment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."Comments_comment_id_seq";
       public          postgres    false    218    4            Z           0    0    Comments_comment_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public."Comments_comment_id_seq" OWNED BY public."Comments".comment_id;
          public          postgres    false    217            �            1259    16425    Departments    TABLE        CREATE TABLE public."Departments" (
    department_id integer NOT NULL,
    department_name character varying(100) NOT NULL
);
 !   DROP TABLE public."Departments";
       public         heap    postgres    false    4            [           0    0    TABLE "Departments"    COMMENT     _   COMMENT ON TABLE public."Departments" IS 'Represents different departments in the university';
          public          postgres    false    214            �            1259    16424    Departments_department_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Departments_department_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public."Departments_department_id_seq";
       public          postgres    false    214    4            \           0    0    Departments_department_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public."Departments_department_id_seq" OWNED BY public."Departments".department_id;
          public          postgres    false    213            �            1259    16432    Idea    TABLE     ?  CREATE TABLE public."Idea" (
    idea_id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    user_id integer,
    category_id integer,
    submit_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_anonymous boolean DEFAULT false,
    is_active boolean DEFAULT true
);
    DROP TABLE public."Idea";
       public         heap    postgres    false    4            ]           0    0    TABLE "Idea"    COMMENT     H   COMMENT ON TABLE public."Idea" IS 'The main table for submitted ideas';
          public          postgres    false    216            �            1259    16431    Idea_idea_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Idea_idea_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."Idea_idea_id_seq";
       public          postgres    false    4    216            ^           0    0    Idea_idea_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public."Idea_idea_id_seq" OWNED BY public."Idea".idea_id;
          public          postgres    false    215            �            1259    16470    Notifications    TABLE     �   CREATE TABLE public."Notifications" (
    notification_id integer NOT NULL,
    idea_id integer,
    user_id integer,
    notification_type character varying(100) NOT NULL,
    is_read boolean DEFAULT false
);
 #   DROP TABLE public."Notifications";
       public         heap    postgres    false    4            �            1259    16469 !   Notifications_notification_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Notifications_notification_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public."Notifications_notification_id_seq";
       public          postgres    false    224    4            _           0    0 !   Notifications_notification_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public."Notifications_notification_id_seq" OWNED BY public."Notifications".notification_id;
          public          postgres    false    223            �            1259    16416    Roles    TABLE     l   CREATE TABLE public."Roles" (
    role_id integer NOT NULL,
    role_name character varying(50) NOT NULL
);
    DROP TABLE public."Roles";
       public         heap    postgres    false    4            `           0    0    TABLE "Roles"    COMMENT     q   COMMENT ON TABLE public."Roles" IS 'Defines user roles in the system (e.g., QA Coordinator, QA Manager, Staff)';
          public          postgres    false    212            �            1259    16415    Roles_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Roles_role_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Roles_role_id_seq";
       public          postgres    false    4    212            a           0    0    Roles_role_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Roles_role_id_seq" OWNED BY public."Roles".role_id;
          public          postgres    false    211            �            1259    16478 
   SystemData    TABLE     |   CREATE TABLE public."SystemData" (
    setting_id integer NOT NULL,
    closure_date date,
    comment_closure_date date
);
     DROP TABLE public."SystemData";
       public         heap    postgres    false    4            b           0    0    TABLE "SystemData"    COMMENT     `   COMMENT ON TABLE public."SystemData" IS 'For administrative configurations like closure dates';
          public          postgres    false    226            �            1259    16477    SystemData_setting_id_seq    SEQUENCE     �   CREATE SEQUENCE public."SystemData_setting_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."SystemData_setting_id_seq";
       public          postgres    false    4    226            c           0    0    SystemData_setting_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public."SystemData_setting_id_seq" OWNED BY public."SystemData".setting_id;
          public          postgres    false    225            �            1259    16406    Users    TABLE     �   CREATE TABLE public."Users" (
    user_id integer NOT NULL,
    name character varying(100)[] NOT NULL,
    email character varying(100)[] NOT NULL,
    department_id integer,
    role_id integer,
    agreed_terms boolean DEFAULT false
);
    DROP TABLE public."Users";
       public         heap    postgres    false    4            d           0    0    TABLE "Users"    COMMENT     �   COMMENT ON TABLE public."Users" IS 'Represents staff members who can submit ideas, comment, vote, and assume roles (e.g., QA Coordinator, QA Manager)';
          public          postgres    false    210            �            1259    16405    Users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Users_user_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Users_user_id_seq";
       public          postgres    false    4    210            e           0    0    Users_user_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Users_user_id_seq" OWNED BY public."Users".user_id;
          public          postgres    false    209            �            1259    16455    Votes    TABLE     �   CREATE TABLE public."Votes" (
    vote_id integer NOT NULL,
    idea_id integer,
    user_id integer,
    vote_type smallint
);
    DROP TABLE public."Votes";
       public         heap    postgres    false    4            f           0    0    TABLE "Votes"    COMMENT     W   COMMENT ON TABLE public."Votes" IS 'Tracks votes on ideas (Thumbs Up or Thumbs Down)';
          public          postgres    false    220            �            1259    16454    Votes_vote_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Votes_vote_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Votes_vote_id_seq";
       public          postgres    false    220    4            g           0    0    Votes_vote_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Votes_vote_id_seq" OWNED BY public."Votes".vote_id;
          public          postgres    false    219            �           2604    16466    Categories category_id    DEFAULT     �   ALTER TABLE ONLY public."Categories" ALTER COLUMN category_id SET DEFAULT nextval('public."Categories_category_id_seq"'::regclass);
 G   ALTER TABLE public."Categories" ALTER COLUMN category_id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    16447    Comments comment_id    DEFAULT     ~   ALTER TABLE ONLY public."Comments" ALTER COLUMN comment_id SET DEFAULT nextval('public."Comments_comment_id_seq"'::regclass);
 D   ALTER TABLE public."Comments" ALTER COLUMN comment_id DROP DEFAULT;
       public          postgres    false    217    218    218            �           2604    16428    Departments department_id    DEFAULT     �   ALTER TABLE ONLY public."Departments" ALTER COLUMN department_id SET DEFAULT nextval('public."Departments_department_id_seq"'::regclass);
 J   ALTER TABLE public."Departments" ALTER COLUMN department_id DROP DEFAULT;
       public          postgres    false    214    213    214            �           2604    16435    Idea idea_id    DEFAULT     p   ALTER TABLE ONLY public."Idea" ALTER COLUMN idea_id SET DEFAULT nextval('public."Idea_idea_id_seq"'::regclass);
 =   ALTER TABLE public."Idea" ALTER COLUMN idea_id DROP DEFAULT;
       public          postgres    false    215    216    216            �           2604    16473    Notifications notification_id    DEFAULT     �   ALTER TABLE ONLY public."Notifications" ALTER COLUMN notification_id SET DEFAULT nextval('public."Notifications_notification_id_seq"'::regclass);
 N   ALTER TABLE public."Notifications" ALTER COLUMN notification_id DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    16419    Roles role_id    DEFAULT     r   ALTER TABLE ONLY public."Roles" ALTER COLUMN role_id SET DEFAULT nextval('public."Roles_role_id_seq"'::regclass);
 >   ALTER TABLE public."Roles" ALTER COLUMN role_id DROP DEFAULT;
       public          postgres    false    212    211    212            �           2604    16481    SystemData setting_id    DEFAULT     �   ALTER TABLE ONLY public."SystemData" ALTER COLUMN setting_id SET DEFAULT nextval('public."SystemData_setting_id_seq"'::regclass);
 F   ALTER TABLE public."SystemData" ALTER COLUMN setting_id DROP DEFAULT;
       public          postgres    false    225    226    226            �           2604    16409    Users user_id    DEFAULT     r   ALTER TABLE ONLY public."Users" ALTER COLUMN user_id SET DEFAULT nextval('public."Users_user_id_seq"'::regclass);
 >   ALTER TABLE public."Users" ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    209    210    210            �           2604    16458    Votes vote_id    DEFAULT     r   ALTER TABLE ONLY public."Votes" ALTER COLUMN vote_id SET DEFAULT nextval('public."Votes_vote_id_seq"'::regclass);
 >   ALTER TABLE public."Votes" ALTER COLUMN vote_id DROP DEFAULT;
       public          postgres    false    219    220    220            K          0    16463 
   Categories 
   TABLE DATA           B   COPY public."Categories" (category_id, category_name) FROM stdin;
    public          postgres    false    222   f       G          0    16444    Comments 
   TABLE DATA           g   COPY public."Comments" (comment_id, idea_id, user_id, content, is_anonymous, comment_date) FROM stdin;
    public          postgres    false    218   ,f       C          0    16425    Departments 
   TABLE DATA           G   COPY public."Departments" (department_id, department_name) FROM stdin;
    public          postgres    false    214   If       E          0    16432    Idea 
   TABLE DATA           y   COPY public."Idea" (idea_id, title, description, user_id, category_id, submit_date, is_anonymous, is_active) FROM stdin;
    public          postgres    false    216   ff       M          0    16470    Notifications 
   TABLE DATA           h   COPY public."Notifications" (notification_id, idea_id, user_id, notification_type, is_read) FROM stdin;
    public          postgres    false    224   �f       A          0    16416    Roles 
   TABLE DATA           5   COPY public."Roles" (role_id, role_name) FROM stdin;
    public          postgres    false    212   �f       O          0    16478 
   SystemData 
   TABLE DATA           V   COPY public."SystemData" (setting_id, closure_date, comment_closure_date) FROM stdin;
    public          postgres    false    226   �f       ?          0    16406    Users 
   TABLE DATA           ]   COPY public."Users" (user_id, name, email, department_id, role_id, agreed_terms) FROM stdin;
    public          postgres    false    210   �f       I          0    16455    Votes 
   TABLE DATA           G   COPY public."Votes" (vote_id, idea_id, user_id, vote_type) FROM stdin;
    public          postgres    false    220   �f       h           0    0    Categories_category_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."Categories_category_id_seq"', 1, false);
          public          postgres    false    221            i           0    0    Comments_comment_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Comments_comment_id_seq"', 1, false);
          public          postgres    false    217            j           0    0    Departments_department_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."Departments_department_id_seq"', 1, false);
          public          postgres    false    213            k           0    0    Idea_idea_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Idea_idea_id_seq"', 1, false);
          public          postgres    false    215            l           0    0 !   Notifications_notification_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public."Notifications_notification_id_seq"', 1, false);
          public          postgres    false    223            m           0    0    Roles_role_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Roles_role_id_seq"', 1, false);
          public          postgres    false    211            n           0    0    SystemData_setting_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."SystemData_setting_id_seq"', 1, false);
          public          postgres    false    225            o           0    0    Users_user_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Users_user_id_seq"', 1, false);
          public          postgres    false    209            p           0    0    Votes_vote_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Votes_vote_id_seq"', 1, false);
          public          postgres    false    219            �           2606    16468    Categories Categories_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_pkey" PRIMARY KEY (category_id);
 H   ALTER TABLE ONLY public."Categories" DROP CONSTRAINT "Categories_pkey";
       public            postgres    false    222            �           2606    16453    Comments Comments_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Comments"
    ADD CONSTRAINT "Comments_pkey" PRIMARY KEY (comment_id);
 D   ALTER TABLE ONLY public."Comments" DROP CONSTRAINT "Comments_pkey";
       public            postgres    false    218            �           2606    16430    Departments Departments_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public."Departments"
    ADD CONSTRAINT "Departments_pkey" PRIMARY KEY (department_id);
 J   ALTER TABLE ONLY public."Departments" DROP CONSTRAINT "Departments_pkey";
       public            postgres    false    214            �           2606    16442    Idea Idea_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public."Idea"
    ADD CONSTRAINT "Idea_pkey" PRIMARY KEY (idea_id);
 <   ALTER TABLE ONLY public."Idea" DROP CONSTRAINT "Idea_pkey";
       public            postgres    false    216            �           2606    16476     Notifications Notifications_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public."Notifications"
    ADD CONSTRAINT "Notifications_pkey" PRIMARY KEY (notification_id);
 N   ALTER TABLE ONLY public."Notifications" DROP CONSTRAINT "Notifications_pkey";
       public            postgres    false    224            �           2606    16421    Roles Roles_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Roles"
    ADD CONSTRAINT "Roles_pkey" PRIMARY KEY (role_id);
 >   ALTER TABLE ONLY public."Roles" DROP CONSTRAINT "Roles_pkey";
       public            postgres    false    212            �           2606    16483    SystemData SystemData_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public."SystemData"
    ADD CONSTRAINT "SystemData_pkey" PRIMARY KEY (setting_id);
 H   ALTER TABLE ONLY public."SystemData" DROP CONSTRAINT "SystemData_pkey";
       public            postgres    false    226            �           2606    16414    Users Users_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (user_id);
 >   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_pkey";
       public            postgres    false    210            �           2606    16460    Votes Votes_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Votes"
    ADD CONSTRAINT "Votes_pkey" PRIMARY KEY (vote_id);
 >   ALTER TABLE ONLY public."Votes" DROP CONSTRAINT "Votes_pkey";
       public            postgres    false    220            �           2606    16461    Votes check_vote_type    CHECK CONSTRAINT     }   ALTER TABLE public."Votes"
    ADD CONSTRAINT check_vote_type CHECK ((vote_type = ANY (ARRAY[1, '-1'::integer]))) NOT VALID;
 <   ALTER TABLE public."Votes" DROP CONSTRAINT check_vote_type;
       public          postgres    false    220    220            �           2606    16423    Users unique_email 
   CONSTRAINT     P   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT unique_email UNIQUE (email);
 >   ALTER TABLE ONLY public."Users" DROP CONSTRAINT unique_email;
       public            postgres    false    210            �           2606    16499    Idea category_id    FK CONSTRAINT     �   ALTER TABLE ONLY public."Idea"
    ADD CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES public."Categories"(category_id) NOT VALID;
 <   ALTER TABLE ONLY public."Idea" DROP CONSTRAINT category_id;
       public          postgres    false    216    222    3236            �           2606    16484    Users department_id    FK CONSTRAINT     �   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT department_id FOREIGN KEY (department_id) REFERENCES public."Departments"(department_id) NOT VALID;
 ?   ALTER TABLE ONLY public."Users" DROP CONSTRAINT department_id;
       public          postgres    false    210    3228    214            �           2606    16504    Comments idea_id    FK CONSTRAINT     �   ALTER TABLE ONLY public."Comments"
    ADD CONSTRAINT idea_id FOREIGN KEY (idea_id) REFERENCES public."Idea"(idea_id) NOT VALID;
 <   ALTER TABLE ONLY public."Comments" DROP CONSTRAINT idea_id;
       public          postgres    false    3230    216    218            �           2606    16514    Votes idea_id    FK CONSTRAINT     ~   ALTER TABLE ONLY public."Votes"
    ADD CONSTRAINT idea_id FOREIGN KEY (idea_id) REFERENCES public."Idea"(idea_id) NOT VALID;
 9   ALTER TABLE ONLY public."Votes" DROP CONSTRAINT idea_id;
       public          postgres    false    3230    220    216            �           2606    16524    Notifications idea_id    FK CONSTRAINT     �   ALTER TABLE ONLY public."Notifications"
    ADD CONSTRAINT idea_id FOREIGN KEY (idea_id) REFERENCES public."Idea"(idea_id) NOT VALID;
 A   ALTER TABLE ONLY public."Notifications" DROP CONSTRAINT idea_id;
       public          postgres    false    224    3230    216            �           2606    16489    Users role_id    FK CONSTRAINT        ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT role_id FOREIGN KEY (role_id) REFERENCES public."Roles"(role_id) NOT VALID;
 9   ALTER TABLE ONLY public."Users" DROP CONSTRAINT role_id;
       public          postgres    false    212    210    3226            �           2606    16494    Idea user_id    FK CONSTRAINT     ~   ALTER TABLE ONLY public."Idea"
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public."Users"(user_id) NOT VALID;
 8   ALTER TABLE ONLY public."Idea" DROP CONSTRAINT user_id;
       public          postgres    false    210    216    3222            �           2606    16509    Comments user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public."Comments"
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public."Users"(user_id) NOT VALID;
 <   ALTER TABLE ONLY public."Comments" DROP CONSTRAINT user_id;
       public          postgres    false    210    3222    218            �           2606    16519    Votes user_id    FK CONSTRAINT        ALTER TABLE ONLY public."Votes"
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public."Users"(user_id) NOT VALID;
 9   ALTER TABLE ONLY public."Votes" DROP CONSTRAINT user_id;
       public          postgres    false    210    3222    220            �           2606    16529    Notifications user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public."Notifications"
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public."Users"(user_id) NOT VALID;
 A   ALTER TABLE ONLY public."Notifications" DROP CONSTRAINT user_id;
       public          postgres    false    224    210    3222            K      x������ � �      G      x������ � �      C      x������ � �      E      x������ � �      M      x������ � �      A      x������ � �      O      x������ � �      ?      x������ � �      I      x������ � �     