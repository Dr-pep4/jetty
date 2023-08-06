<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.util.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.jsp.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>final enroll</title>
    <style>
        body {
            background-image: url(https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2670&q=80);
        }
        #wrap {
            margin: 0 auto;
            width: 85%;
            height: 500px;

            display: flex;
            justify-content: center;
            align-items: center;
        }
        h1{
            text-align: center;
        }
        #search_section{
            justify-content: space-around;
            width:80%;
            display: flex;
        }
         #enroll_table{
            width:600px;
            height:1000px;
        }
        .enroll_row{
            display: flex;
        }
        .enroll_row li{
            text-align: center;
            list-style: none;
            width:50%;
            border:1px solid black;
            height:40px;
        }
    </style>
</head>
<body>
    <h1>차량 등록</h1>
    <hr>
     <div id="enroll_table">
        <form action="/enroll" method="post" enctype="multipart/form-data">
        <ul class="enroll_row">
            <li>번호판</li>
            <li>
                <input name="col1" type="text" required>
            </li>
        </ul>
        <ul class="enroll_row">
            <li>
                제조사
            </li>
            <li>
                <input name="col2" type="text" required>
            </li>
        </ul>
        <ul class="enroll_row">
            <li>
                가격
            </li>
            <li>
                <input type="number" name="col3" required min="0" max="99999" step="5" placeholder="0">
            </li>
        </ul>
        <ul class="enroll_row">
            <li>
                car_size
            </li>
            <li>
                <input name="col4" type="text" required>
            </li>
        </ul>
        <ul class="enroll_row">
                <li>
                    상품 사진
                </li>
                <li>
                    <select name="col6">
                        <option value="1">1등 상품</option>
                        <option value="2">2등 상품</option>
                        <option value="3">3등 상품</option>
                        <option value="4">4등 상품</option>
                        <option value="5">5등 상품</option>
                        <option value="6">6등 상품</option>
                        <option value="7">7등 상품</option>
                        <option value="8">8등 상품</option>
                        <option value="9">9등 상품</option>
                        <option value="10">10등 상품</option>
                        <option value="11">11등 상품</option>
                        <option value="12">12등 상품</option>
                    </select>
                </li>
            </ul>
        <ul class="enroll_row">
            <li>
                상품 설명
            </li>
            <li>
                <input name="col5" type="text" required>
            </li>
        </ul>
        <input type="submit" value="Submit" />
    </form>
    </div>

    <%
    String col1 = request.getParameter("col1");
    String col2  = request.getParameter("col2");
    String col3 = request.getParameter("col3");
    String col4 = request.getParameter("col4");
    String col5 = request.getParameter("col5");
    String col6 = request.getParameter("col6");
    String image_url = "https://recaimagebucket.s3.ap-northeast-1.amazonaws.com/image/"+col6+".jpg";
    %>



<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%
if (request.getMethod().equals("POST")) {
    String url = "jdbc:mysql://team2-db.coccer63gd4o.ap-northeast-1.rds.amazonaws.com:3306/schema1";
    String dbUsername = "admin";
    String dbPassword = "qwer1234";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

        String insertQuery = "INSERT INTO table1 (col1, col2, col3, col4, col5, image_url) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(insertQuery);

        // 파라미터에 값 할당
        pstmt.setString(1, col1);
        pstmt.setString(2, col2);
        pstmt.setInt(3, col3);
        pstmt.setString(4, col4);
        pstmt.setString(5, col5);
        pstmt.setString(6, image_url);
     
        pstmt.executeUpdate();

        // 등록 성공 시, 성공 페이지로 리다이렉트하거나 성공 메시지를 표시합니다.
        out.println("<script>window.location.href='/admin_main';</script>");

       
    }catch (Exception e) {
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
%>




</body>
</html>
