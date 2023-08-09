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
        *{
            color:white;
            margin:0 auto;
            align-item:center;
            text-align:center;
        }
        body {
            background-color:black;}
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
            height:10%;
        }
        #search_section{
            justify-content: space-around;
            width:80%;
            display: flex;
        }
         #enroll_table{
            width:400px;
            height:100%;
            margin:100px auto;
            border:1px solid white;
        }
        .enroll_row{
            display: flex;
            margin: 10px 0;
            height:25%;
        }
        .enroll_row li{
            text-align: center;
            list-style: none;
            width:50%;
            height:40px;
        }
        #add_btn{
            margin:0 auto;
            width: 90%;
            height:30px;
            border:1px solid #1fa7f8;
            background-color:black;
            color:white;
            border-radius:5px;
        }
         #add_btn:hover{
            cursor: pointer;
            background-color:white;
            color:black;
        }
        li input,select{
            width:80%;
        }
        
    </style>
</head>
<body>
    <h1>ADD Items</h1>
    <hr>
     <div id="enroll_table">
        <form action="/enroll" method="post" style="height=100%;">
        <ul class="enroll_row">
            <li>item</li>
            <li>
                <input name="col1" type="text" required>
            </li>
        </ul>
        <ul class="enroll_row">
            <li>
                describe
            </li>
            <li>
                <input name="col2"type="text" required>
            </li>
        </ul>

       
        <ul class="enroll_row">
            <li>
                picture
            </li>
            <li>
                <select name="col6" id="car">
                    <option value="1">하얀 아이폰</option>
                    <option value="2">노란 아이폰</option>
                    <option value="3">갤럭시 플립</option>
                    <option value="4">에어팟 프로</option>
                    <option value="5">에어팟 맥스</option>
                    <option value="6">테슬라</option>
                    <option value="7">초전도체</option>
                    <option value="8">애플워치 울트라</option>
                    <option value="9">옵티머스 프라임</option>
                    <option value="10">아이언맨 MK1</option>
                    <option value="11">애플 고글</option>
                    <option value="12">전동 고라니</option>
                </select>
            </li>
        </ul>
        <input id="add_btn" style="" type="submit" value="ADD" />
    </form>
    </div>

    <%
    String col1 = request.getParameter("col1");
    String col2  = request.getParameter("col2");
  
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

        String insertQuery = "INSERT INTO table1 (item_name, item_describe, image_url) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(insertQuery);

        // 파라미터에 값 할당
        pstmt.setString(1, col1);
        pstmt.setString(2, col2);
        pstmt.setString(3, image_url);
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
