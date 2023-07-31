~                                                                                                                                                                                                                                                                                                                                                  80,1          All
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=, initial-scale=1.0">
    <title>final_login</title>
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
    </style>
</head>
<body>
    <h1>로그인 페이지</h1>
    <hr>
    <div id="wrap">
  <form method="post" action="login">
    <label for="username">아이디:</label>
    <input type="text" id="username" name="user_email" required><br><br>
    <label for="password">비밀번호:</label>
    <input type="password" id="password" name="user_pw" required><br><br>
    <input type="submit" value="로그인">
  </form>
  <button onclick="success()">aaa </button>
    </div>
      <%
    String username = request.getParameter("user_email");
    String password = request.getParameter("user_pw");
    %>
        <%@ page import="java.sql.*" %>
        <%@ page import="javax.naming.*" %>
        <%@ page import="javax.sql.*" %>
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

      String query = "SELECT * FROM user WHERE user_email = ? AND user_password = ?";
      pstmt = conn.prepareStatement(query);
      pstmt.setString(1, username);
      pstmt.setString(2, password);

      rs = pstmt.executeQuery();

      if ( (request.getMethod().equals("POST"))&&rs.next()) {
      out.println("<script>window.location.href=\"/main\";</script>");
        }else{
         out.println("<script>alert('로그인에 실패했습니다.');</script>");
        }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      if (rs != null) {
        try { rs.close(); } catch (SQLException e) { }
      }
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
<script>
    var valu = document.getElementById("search_box");

    function login(){
        window.location.href ="/login";
    }
    function logout(){
        window.location.href ="/sign_up";
    }
    function success(){
        window.location.href ="/main";
    }
</script>
</html>
