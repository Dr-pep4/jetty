<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    String id = request.getParameter("id");

    // 데이터베이스 연결 정보
    String url = "jdbc:mysql://team2-db.coccer63gd4o.ap-northeast-1.rds.amazonaws.com:3306/schema1";
    String username = "admin";
    String password = "qwer1234";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // ID가 일치하는 행을 삭제합니다.
        String sql = "DELETE FROM table1 WHERE ID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
        if (conn != null) try { conn.close(); } catch(Exception e) {}
    }
    
    // 삭제 후 원하는 페이지로 리다이렉트합니다.
    out.println("<script>window.location.href='/admin_main';</script>");
%>
