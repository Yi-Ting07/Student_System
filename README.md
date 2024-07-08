這是一個在我學習 JAVA 後，練習從無到有建立的一個 Web 專案，<br>
內容為學生管理系統，其中包含註冊/登入功能與學生/班級的「增、刪、改、查」功能。<br><br>
畫面初始的登入網址：http://localhost:8085/login_page<br><br>
可使用此ngrok轉址連結瀏覽實際作品網頁 (2024.07.08更新)：<br>https://7d77-2407-4d00-2c04-82a6-5146-d772-80d9-3d85.ngrok-free.app/student.system/login_page <br>
(歡迎實際註冊帳號並體驗操作裡面的所有功能，不用擔心把資料玩壞喔!)

### 使用的語言及框架有：
1. 前端： HTML、CSS、JavaScript、JQuery、JSP。
2. 後端： JAVA、Spring MVC、Spring Boot、Spring Data Jpa。
3. 建構工具：Maven。
4. 資料庫：Oracle、SQL、SQL Developer。

### 功能描述：
1. 登入頁面：
   - 可以從登入頁面進到註冊頁面，進行管理員帳號註冊。
   - 註冊完成後，可以使用剛剛註冊的帳號密碼進行登入。
   - 登入後即可進入學生查詢與維護的頁面。
2. 班級管理頁面：
   -  可從學生查詢頁面的右上角點選「管理班級」按鈕，進入班級管理頁面，查看所有班級資訊。
   -  在此頁面亦可以進行「新增」、「編輯」、「刪除」班級資訊。
3. 學生管理頁面：
   - 此頁面可以依照使用者輸入的查詢條件進行學生查詢操作。
   - 亦可以進行「新增」、「編輯」、「刪除」學生資訊。

### 使用技術：
1. 註冊帳號時：<br>
   - 帳號欄位有使用 ajax 的技術檢核帳號是否重複。
   - 使用 javascript 檢核使用者輸入的密碼與確認密碼是否相符。
   - 若上述兩點檢核沒過時，則無法進行註冊。
2. 刪除的 checkbox 提供全選的功能，可一鍵勾選所有的資料並一次刪除。
3. 將登入資訊存放在 session 中，讓使用者在進行各個頁面操作的時候，不用重新登入。
4. 使用過濾器 (Filter) 檢核是否為登入狀態，若沒有登入時，會導回登入頁面，讓使用者重新登入。
5. 在學生查詢頁面，使用 JPA 的 Specification 進行多條件的複合式查詢。
6. 在刪除班級時，會一併刪除該班級底下的所有學生資料。(使用 cascade = CascadeType.ALL)

### 環境配置：
- 資料庫版本： Oracle 11c
- Java版本： Java 17
- 啟用前須先至 /student.system/src/main/resources/application.yml 修改spring.datasource.username 和 password (改成自己的)

### 以下是建立 table 的 SQL：
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
    stu_no varchar2(20),
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
