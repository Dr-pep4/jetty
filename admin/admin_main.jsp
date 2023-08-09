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
            background-color:black;
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
            border: 1px solid #1;
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
            
            border: 1px solid white;
            
            margin-bottom: 10px;
        }
        .item_box {
            text-decoration: none;
            box-shadow: 0 0 3px 0 white;
            width: 98%;
            height:65px;
            margin: 5px auto;
            display: block;
            color: white;
            
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
            width: 10%;
            height: 20px;
            color: black;
            border-radius: 10px;
            border: 2px solid #ee0000;
            position: relative;
            float: right;
            top: -50px;
            margin-right: 30px;
            font-weight: bold;
        }
        #btn_enroll:hover {
            cursor: pointer;
            color: black;
            background-color: white;
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
        <h1 style="margin-left: 10px;"><a href="/main" style="text-decoration:none; color:white">RECA</a></h1>
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
    
    <hr style="background-color:#1fa7f8;">
    
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
                        sql += " WHERE item_name LIKE '%" + keyword + "%' OR item_describe LIKE '%" + keyword + "%' OR count LIKE '%" + keyword + "%' OR image_url LIKE '%" + keyword + "%'";
                    }
                    rs = stmt.executeQuery(sql);
            %>
            <div id="header_bar">
                <h1 style="color:white"> List </h1>
                <button onclick="enroll()"; id="btn_enroll">Add Items</button>
            </div>

            <div id="all_items">
            <% while (rs.next()) { %>
                <a class="item_box" href="/admin_detail?id=<%= rs.getString("ID") %>" style="display:flex;">
                    <p style="width:5%"><%= rs.getString("ID") %></p>
                    <p style="width:10%"><%= rs.getString("item_name") %></p>
                    <p style="width:50%"><%= rs.getString("item_describe") %></p>
                    <p style="width:10%">응모인원 : <%= rs.getString("count") %></p>
                    <button style="width:5%; float:right;" data-id="<%= rs.getString("ID") %>" onclick="deleteItem(event, this)">삭제</button>
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
                    // 성공적으로 삭제되었을 경우 해당 아이템을 화면에서 제거
                    var itemBox = button.closest(".item_box");
                    itemBox.parentNode.removeChild(itemBox);
                } else {
                    alert("삭제 했습니다");
                    location.href="/admin_main";
                }
            } else {
                // 요청에 문제가 발생함
                alert("데이터 삭제 요청에 문제가 발생했습니다2.");
            }
        }
    };
    xhr.send("id=" + itemId); // 삭제할 아이템의 ID를 서버에 전달
}



    </script>
</body>
</html>
