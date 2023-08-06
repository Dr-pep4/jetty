<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>final_main</title>
    <style>
        * {
            font-family: 'Noto Sans KR', Arial, sans-serif;
        }
        body {
            background-color:white;
            height: 100%;
            text-align:center;
        }
        #wrap {
            margin: 10px auto;
            width: 85%;
            height: 5%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        h1 {
            text-align: center;
        }
        #search_section {
            justify-content: space-around;
            width: 80%;
            display: flex;
            height: 20%;
        }
        #search_result {
            border: 1px solid black;
            width: 90%;
            height: %;
            margin: 0 auto;
        }
        li {
            list-style: none;
            border: 2px solid black;
            border-radius: 5px;
            width: 90%;
            height: 5%;
            margin: 0 auto;
        }
        #all_items {
            margin: auto;
            
            overflow: scroll;
            height: 1000px;
            width: 95%;
            
            border: 3px solid black;
            background-color: rgba(255, 255, 255, 0.7);
            margin-bottom: 10px;
        }
        .item_box {
            text-decoration: none;
            border: 2px solid Red;
            width: 98%;
            height:50px;
            margin: 5px auto;
            display: block;
            color: black;
            background-color: gray;
        }
        .car_image {
            float:left;
            width: 10%;
            height: 90%;
            border: 3px solid black;
            margin-bottom: 5px;
        }
        #header_bar {
            position: relative;
            width: 100%;
            height: 100px;
        }
        #btn_enroll {
            width: 100px;
            height: 50px;
            background-color: pink;
            color: black;
            border-radius: 10px;
            border: 2px solid red;
            position: relative;
            float: right;
            top: -50px;
            margin-right: 30px;
            font-weight: bold;
        }
        #btn_enroll:hover {
            cursor: pointer;
            color: white;
            border: 1px solid white;
        }
        .brand_size {
            padding: 0;
            display: flex;
            justify-content: space-around;
        }
    </style>
</head>
<body>
    <header style="display: flex; flex-direction: row; align-items: center;">
        <h1 style="margin-right: 10px;">RECA</h1>
        <div id="wrap" style="display: flex; flex-direction: row; align-items: center;">
            <div id="search_section" style=" display: flex; flex-direction: row; align-items: center;">
                <form action="admin_main" style="width: 50%; display: flex; flex-direction: row; align-items: justify-content:space-evenly;">
                    <input type="text" id="search_box" name="keyword" style="width: 80%; height: 40px; font-size: 20px; text-align: center;">
                    <input type="button" value="find" onclick="search()" style="width: 10%; height: 45px;">
                    <input type="button" value="All" onclick="showAllItems()" style="width: 10%; height: 45px;">
                </form>
            </div>
        </div>
    </header>
    
    <hr>
    
    <div id="search_result">
        <div>
            <%-- MariaDB 연결 정보 --%>
            <% String url = "jdbc:mysql://team2-db.coccer63gd4o.ap-northeast-1.rds.amazonaws.com:3306/schema1";
               String username = "admin";
               String password = "qwer1234";
               String driver = "com.mysql.jdbc.Driver"; %>

            <%@ page import="java.sql.*" %>
            <%@ page import="javax.naming.*" %>
            <%@ page import="javax.sql.*" %>

            <%!
                public Connection getConnection() throws Exception {
                    String driver = "com.mysql.jdbc.Driver";
                    String url = "jdbc:mysql://team2-db.coccer63gd4o.ap-northeast-1.rds.amazonaws.com:3306/schema1";
                    String username = "admin";
                    String password = "qwer1234";
                    Class.forName(driver);
                    Connection conn = DriverManager.getConnection(url, username, password);
                    return conn;
                }
            %>

            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    conn = getConnection();
                    stmt = conn.createStatement();
                    String keyword = request.getParameter("keyword");
                    String sql = "SELECT * FROM table1";
                    if (keyword != null && !keyword.trim().isEmpty()) {
                        sql += " WHERE col1 LIKE '%" + keyword + "%' OR col2 LIKE '%" + keyword + "%' OR col3 LIKE '%" + keyword + "%' OR col4 LIKE '%" + keyword + "%' OR col5 LIKE '%" + keyword + "%'";
                    }
                    rs = stmt.executeQuery(sql);
            %>
            <div id="header_bar">
                <h1> 경품 목록 </h1>
                <button onclick="enroll()"; id="btn_enroll">등록하기</button>
            </div>

            <div id="all_items">
            <% while (rs.next()) { %>
                <a class="item_box" href="/detail?id=<%= rs.getString("ID") %>" style="display:flex;">
                    <p style="height: 6%; margin: 10px auto; width: 92%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; font-weight: bold;">
                        <%= rs.getString("col1") %>
                    </p>
                    <div class="car_image">
                        <img src="<%= rs.getString("image_url") %>" alt="<%= rs.getString("col1") %>" style="width: 100%; height: 100%" >
                    </div>
                    <ul class="brand_size" style="width:">
                        <li><%= rs.getString("col2") %></li>
                        <li><%= rs.getString("col3") %></li>
                    </ul>
                    <p style="text-align: center; font-weight: bold; width:20%;"><%= rs.getString("col4") %></p>
                    <button data-id="<%= rs.getString("ID") %>" onclick="deleteItem(event, this)">삭제하기</button>
                </a>
            <% } %>
            </div>
            <%
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch(Exception e) {}
                    if (stmt != null) try { stmt.close(); } catch(Exception e) {}
                    if (conn != null) try { conn.close(); } catch(Exception e) {}
                }
            %>
        </div>
    </div>
    <script>
        function search() {
            document.forms[0].action = "admin_main?keyword=" + document.getElementById("search_box").value;
            document.forms[0].submit();
        }
        function showAllItems() {
            document.forms[0].action = "admin_main";
            document.forms[0].submit();
        }
        function enroll() {
            location.href = "/enroll";
        }
        function deleteItem(event, button) {
    event.preventDefault(); // 클릭 동작 막기
    
    var itemId = button.getAttribute("data-id");
    
    // AJAX 호출을 통해 서버에 삭제 요청을 보냄
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/delete", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                // 요청이 성공적으로 처리됨
                var response = xhr.responseText;
                if (response === "success") {
                    // 데이터 삭제 성공 시 페이지 새로고침
                    location.reload();
                } else {
                    alert("데이터 삭제 중 오류가 발생했습니다.");
                }
            } else {
                // 요청에 문제가 발생함
                alert("데이터 삭제 요청에 문제가 발생했습니다.");
            }
        }
    };
    xhr.send("id=" + itemId); // 삭제할 아이템의 ID를 서버에 전달
}


    </script>
</body>
</html>
