



```sql=
DROP TABLE student;
DROP TABLE stu_class;
DROP TABLE administrator;


CREATE TABLE administrator(
    admin_id int PRIMARY KEY,
    admin_name varchar2(20),
    admin_gender varchar2(20),
    admin_account_no varchar2(16),
    admin_password varchar2(16)
);

CREATE TABLE stu_class(
    sc_id int PRIMARY KEY,
    sc_class_name varchar2(20),
    sc_teacher varchar2(20),
    sc_create_date DATE,
    fk_sc_creater_id int,
    sc_update_date DATE,
    fk_sc_updater_id int,
    FOREIGN KEY (fk_sc_creater_id) REFERENCES administrator (admin_id),
    FOREIGN KEY (fk_sc_updater_id) REFERENCES administrator (admin_id)
);


CREATE TABLE student (
    stu_id int PRIMARY KEY,
    stu_name varchar2(20),
    stu_no varchar2(10) unique,
    stu_gender varchar2(20),
    fk_stu_class_id int,
    stu_create_date DATE,
    fk_stu_creater_id int,
    stu_update_date DATE,
    fk_stu_updater_id int,
    FOREIGN KEY (fk_stu_class_id) REFERENCES stu_class (sc_id),
    FOREIGN KEY (fk_stu_creater_id) REFERENCES administrator (admin_id),
    FOREIGN KEY (fk_stu_updater_id) REFERENCES administrator (admin_id)
);

DROP SEQUENCE seq_admin_id;
DROP SEQUENCE seq_sc_id;
DROP SEQUENCE seq_stu_id;

CREATE SEQUENCE seq_admin_id;
CREATE SEQUENCE seq_sc_id;
CREATE SEQUENCE seq_stu_id;
```
