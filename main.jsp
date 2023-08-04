<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=, initial-scale=1.0">
    <title>final_main</title>
    <style>
        * {
            font-family: 'Noto Sans KR', Arial, sans-serif;
        }
        header{
            display: flex;
            padding: 0px 10px;
        }
        body {
            background-image: url(https://plus.unsplash.com/premium_photo-1670426500311-708bbb8a7432?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2036&q=80);
            height: 100%;
            text-align:center;
            margin: 0 auto;
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
            width: 90%;
            margin: 0 auto;
            
        }
        li {
            border: 2px solid red;
            list-style: none;
            border-radius: 5px;
            width: 50%;
            height: 5%;
            margin: 0 auto;
        }



        #all_items {
            padding:10px;
            margin: auto;
            overflow: scroll;
            height: 1000px;
            width: 95%;
            flex-flow: wrap;
            display:flex;
            border: 3px solid red;
            background-color: rgba(255, 255, 255, 0.7);
            margin-bottom: 10px;

        }
        .item_box {
            text-decoration: none;
            border-radius: 10px;
            padding: 10px;
            width: 270px;
            height:370px;
            margin: 5px auto;
            display: block;
            color: black;
            
        }
        .item_box:hover{
            box-shadow: 0px 0px 20px red;
        }
        .car_image {
            margin: auto;
            width: 80%;
            height: 200px;
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
            
        }
    </style>
</head>
<body>
    <header style="display: flex; flex-direction: row; align-items: center;">
        <h1 style="margin-right: 10px;">RECA</h1>
        <div id="wrap" style="display: flex; flex-direction: row; align-items: center;">
            <div id="search_section" style=" display: flex; flex-direction: row; align-items: center;">
                <form action="main.jsp" style="width: 50%; display: flex; flex-direction: row; align-items: center;">
                    <input type="text" id="search_box" name="keyword" style="width: 80%; height: 40px; font-size: 20px; text-align: center;">
                    <input type="button" value="find" onclick="search()" style="width: 10%; height: 45px;">
                    <input type="button" value="show all" onclick="showAllItems()" style="width: 10%; height: 45px;">
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
                <h1> 이벤트 경품 리스트</h1>
            </div>

            <div id="all_items">
                <% while (rs.next()) { %>
                    <a class="item_box" href="/detail.jsp?id=<%= rs.getString("ID") %>" >
                        <p style="height: 6%; margin: 10px auto; width: 92%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; font-weight: bold;">
                            <%= rs.getString("col1") %>등
                        </p>
                        <div class="car_image">
                            <img src="#" alt="<%= rs.getString("col1") %>" style="width: 100%; height: 100%" >
                        </div>
                        <ul class="brand_size">
                            <li>참가자 : <%= rs.getString("count") %> 명</li>
                            <button class="pick" data-id="<%= rs.getString("ID") %>" onclick="alarm(event)">추첨하기</button>
                        </ul>
                        <p style="text-align: center; font-weight: bold;"><%= rs.getString("col4") %></p>
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
            document.forms[0].action = "main.jsp?keyword=" + document.getElementById("search_box").value;
            document.forms[0].submit();
        }
        function showAllItems() {
            document.forms[0].action = "main.jsp";
            document.forms[0].submit();
        }
        function enroll() {
            location.href = "/enroll.jsp";
        }
        function alarm(event, id) {
    event.stopPropagation();
    var button = event.target;
    
    // AJAX 요청을 보내기 전에 버튼을 비활성화합니다.
    button.disabled = true;

    // AJAX 요청을 사용하여 데이터베이스에서 count 값을 업데이트합니다.
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "updatecount.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
            // 업데이트가 성공적으로 완료된 경우, 여기서 응답을 처리할 수 있습니다.
            location.reload(true); // AJAX 요청이 완료되면 페이지를 새로고침합니다.
        } else {
            // 만약 에러가 발생하면 다시 버튼을 활성화하여 다시 시도할 수 있도록 합니다.
            button.disabled = false;
            alert("업데이트 실패! 다시 시도하세요."); // 실패 메시지를 사용자에게 표시해도 좋습니다.
        }
    };
    xhr.send("id=" + encodeURIComponent(id)); // 업데이트할 행의 ID를 보냅니다.
}

    var buttons = document.querySelectorAll(".pick");
    buttons.forEach(function (button) {
        button.addEventListener("click", function (event) {
            event.preventDefault();
            var id = this.getAttribute("data-id");
            alarm(event, id);
        });
    });
    </script>
</body>
</html>
