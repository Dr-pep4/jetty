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
        body {
            background-image: url(https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2670&q=80);
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
            border: 2px solid red;
            border-radius: 5px;
            width: 30%;
            height: 5%;
            margin: 0 auto;
        }
        #all_items {
            margin: auto;
            display: flex;
            overflow: scroll;
            height: 1000px;
            width: 95%;
            flex-wrap: wrap;
            border: 3px solid red;
            background-color: rgba(255, 255, 255, 0.7);
            margin-bottom: 10px;
        }
        .item_box {
            text-decoration: none;
            border-radius: 10px;
            border: 2px solid Red;
            width: 270px;
            height:370px;
            margin: 5px auto;
            display: block;
            color: black;
            background-color: pink;
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
            display: flex;
            justify-content: space-around;
        }
    </style>
</head>
<body>
    <h1>차량정보</h1>
    <hr>
    <div id="wrap">
        <div id="search_section">
            <form action="main">
                <input type="text" id="search_box" name="keyword" style="width: 90%; height: 40px; font-size: 20px; text-align: center;">
                <input type="button" value="찾기" onclick="search()" style="width: 5%; height: 45px;">
                <input type="button" value="전체보기" onclick="showAllItems()" style="width: 10%; height: 45px;">
            </form>
        </div>
    </div>
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
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                String dbUsername = "admin";
                String dbPassword = "qwer1234";
                Connection conn = null;
                PreparedStatement pstmt = null;
        
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUsername, dbPassword);
        
                    String updateQuery = "UPDATE table1 SET count = count + 1 WHERE ID = ?";
                    pstmt = conn.prepareStatement(updateQuery);
                    pstmt.setString(1, id);
        
                    int rowsAffected = pstmt.executeUpdate();
        
                    if (rowsAffected > 0) {
                        out.println("<script>alert('추첨이 완료되었습니다.');</script>");
                    } else {
                        out.println("<script>alert('추첨 실패ㅜㅜ');</script>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (pstmt != null) {
                        try { pstmt.close(); } catch (SQLException e) { }
                    }
                    if (conn != null) {
                        try { conn.close(); } catch (SQLException e) { }
                    }
                }
            }
            response.sendRedirect("main");
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
                <h1> 중고차 </h1>
                <button onclick="enroll()"; id="btn_enroll">등록하기</button>
            </div>

            <div id="all_items">
            <% while (rs.next()) { %>
                <form method="post" action="./">
                    <input type="submit" value="추첨하기">
                </form>
                <a class="item_box" href="/detail?id=<%= rs.getString("ID") %>" >
                    
            
                    <p style="height: 6%; margin: 10px auto; width: 92%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; font-weight: bold;">
                        <%= rs.getString("col1") %>
                    </p>
                    <div class="car_image">
                        <img src="#" alt="<%= rs.getString("col1") %>" style="width: 100%; height: 100%" >
                    </div>
                    <ul class="brand_size">
                        <li><%= rs.getString("col2") %></li>
                        <li><%= rs.getString("col3") %></li>
                        <li>신청자수 <%= rs.getString("count") %></li>
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
            document.forms[0].action = "main?keyword=" + document.getElementById("search_box").value;
            document.forms[0].submit();
        }
        function showAllItems() {
            document.forms[0].action = "main";
            document.forms[0].submit();
        }
        function enroll() {
            location.href = "/enroll";
        }
    </script>
</body>
</html>
