<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>final_sign_up</title>
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
    <h1>회원가입</h1>
    <hr>
    <div id="wrap">
  <form method="post" action="/sign_up">
    <label for="user_email">email:</label>
    <input type="text" id="first_email" name="first_email" required>@<input type="text" id="last_email" name="last_email" required><br><br>
    <label for="password">password:</label>
    <input type="password" id="user_password" name="user_password" required><br><br>
    <label for="text">name:</label>
    <input type="text" id="user_name" name="user_name" required><br><br>
    <label for="text">address:</label>
    <input type="text" id="user_address" name="user_address" required><br><br>
     <label for="password">phone:</label>
      <input type="text" value="010" readonly id="first_phone" name="first_phone" required>- <input type="text" id="mid_phone" name="mid_phone" required>- <input type="text" id="last_phone" name="last_phone" required><br><br>
    <input type="submit" value="회원가입">

  </form>
  <button onclick="success()">aaa </button>
    </div>
    <%
    String user_password = request.getParameter("user_password");
    
    String user_name = request.getParameter("user_name");
    String user_address = request.getParameter("user_address");

    String first_email = request.getParameter("first_email");
    String last_email = request.getParameter("last_email");
    String user_email = first_email+"@"+last_email;


    String first_phone = request.getParameter("first_phone");
    String mid_phone = request.getParameter("mid_phone");
    String last_phone = request.getParameter("last_phone");
    String user_phone = first_phone+"-"+mid_phone+"-"+last_phone;

    String id = request.getParameter("id");
    String pick = request.getParameter("id");
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

      String checkQuery = "SELECT COUNT(*) FROM user WHERE user_email = ?";
            pstmt = conn.prepareStatement(checkQuery);
            pstmt.setString(1, user_email);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                // ID already exists, display an error message or redirect to a duplicate ID error page
                out.println("<script>alert('이미 추첨함ㅋ 욕심이 많으시네요~');</script>");
            } else {
                // Insert new user record
                String insertQuery = "INSERT INTO user (user_email, user_password, user_phone, user_name, user_address, pick) VALUES (?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(insertQuery);
                pstmt.setString(1, user_email);
                pstmt.setString(2, user_password);
                pstmt.setString(3, user_phone);
                pstmt.setString(4, user_name);
                pstmt.setString(5, user_address);
                pstmt.setString(6, id);

                out.println("<script>alert('1');</script>");
                int insertResult = pstmt.executeUpdate();
                out.println("<script>alert('2');</script>");
                if (insertResult > 0) {
                    // 회원가입 성공한 경우에만 count 증가 처리
                    String updateCountQuery = "UPDATE table1 SET count = count + 1 WHERE ID = ?";
                    PreparedStatement updateCountPstmt = conn.prepareStatement(updateCountQuery);
                    updateCountPstmt.setString(1, id);
                    updateCountPstmt.executeUpdate();

                    out.println("<script>alert('추첨 완료');</script>");
                    out.println("<script>window.location.href='/main';</script>");
                }
            }

    } catch (Exception e) {
out.println("<script>alert('예외 발생: " + e.getMessage() + "');</script>");
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

    function success(){
        window.location.href ="/admin_main";
    }

</script>
</html>
