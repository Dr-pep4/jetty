<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    String idToDelete = request.getParameter("idToDelete"); // 삭제할 ID 값

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
        String deleteSql = "DELETE FROM table1 WHERE ID = ?";
        pstmt = conn.prepareStatement(deleteSql);
        pstmt.setString(1, idToDelete);
        pstmt.executeUpdate();

        // 삭제된 ID 이후의 ID 값을 조정하여 채웁니다.
        String adjustSql = "UPDATE table1 SET ID = ID - 1 WHERE ID > ?";
        pstmt = conn.prepareStatement(adjustSql);
        pstmt.setString(1, idToDelete);
        pstmt.executeUpdate();
    } catch (Exception e) {
        // 예외 처리: 오류 메시지 출력 또는 로깅
        out.println("오류가 발생했습니다: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
        if (conn != null) try { conn.close(); } catch(Exception e) {}
    }
    
    // 삭제 및 조정 후 원하는 페이지로 리다이렉트합니다.
    response.sendRedirect("/admin_main");
%>
