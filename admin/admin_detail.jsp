<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>final_detail</title>
    <style>
        body {
            background-color:white;

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


try {
  conn = getConnection();
  stmt = conn.createStatement();
  String query = "SELECT * FROM table1 WHERE ID = " + ID;
  rs = stmt.executeQuery(query);

  // Process the fetched row data
  if (rs.next()) {
     A = rs.getString("count");
     B = rs.getString("item_name");  // 변수 값 할당
     C = rs.getString("item_describe");    // 변수 값 할당
     D = rs.getString("ID");
 
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
            <img src=" <%= rs.getString("image_url") %>">
    </div>
    <div>
      <h1>Car Details</h1>
      <p>상품 번호 : <%= A %></p>
      <p>경품명 : <%= B %></p>
      <p>경품설명 : <%= C %></p>
      <p>응모자 수 : <%= D %></p>
      
    </div>
</div>
<button onclick="success()">뒤로 </button>
</body>
<script>

    function success(){
        window.location.href ="/main.jsp";
    }
</script>
</html>
