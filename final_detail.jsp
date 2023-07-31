<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=, initial-scale=1.0">
    <title>final_detail</title>
    <style>
        body {
            background-image: url(https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2670&q=80);

        }
        #wrap {
            margin: 0 auto;
            width: 85%;
            height: 100px;

            display: flex;
            justify-content: center;
            border: 1px solid black;
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
        #result{
            border: 1px solid black;
            width: 90%;
            height:30%;
            margin: 0 auto;
            display:flex;
            justify-content:space-around;
        }
    </style>
</head>
<body>
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
String ID = request.getParameter("id");

// Fetch the row data corresponding to the id from the 'car' table
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String A = null;  // 변수 선언 위치 변경
String B = null;   // 변수 선언 위치 변경
String C = null;
String D = null;
String E = null;

try {
  conn = getConnection();
  stmt = conn.createStatement();
  String query = "SELECT * FROM table1 WHERE ID = " + ID;
  rs = stmt.executeQuery(query);

  // Process the fetched row data
  if (rs.next()) {
     A = rs.getString("col1");
     B = rs.getString("col2");  // 변수 값 할당
     C = rs.getString("col3");    // 변수 값 할당
     D = rs.getString("col4");
     E = rs.getString("col5");
     // Retrieve other column values as needed

     // Use the fetched data as required
     // For example, display the values in the page
  }
} catch (Exception e) {
  e.printStackTrace();
} finally {
  // Close the database resources
  try {
     if (rs != null) rs.close();
     if (stmt != null) stmt.close();
     if (conn != null) conn.close();
  } catch (Exception e) {
     e.printStackTrace();
  }
}
%>

<h1>상세 페이지</h1>
<hr>
<div id="wrap">
    <div id="search_section">
        <input type="text" id="search_box" style="width:90%; height: 40px; font-size: 20px; text-align: center;">
        <input type="button" value="찾기" onclick="search()" style="width:5%; height: 45px;">

    </div>
</div>
<div id="result">
    <div>
            <img src="#">
    </div>
    <div>
      <h1>Car Details</h1>
      <p>column1 : <%= A %></p>
      <p>column2: <%= B %></p>
      <p>column3: <%= C %></p>
      <p>column4: <%= D %></p>
      <p>column5: <%= E %></p>
    </div>
</div>

</body>
</html>
