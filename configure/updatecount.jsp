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
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // 현재 세션에 저장된 logon_id 가져오기
        String logonId = (String) session.getAttribute("logon_id");

        // user 테이블에서 logon_id가 일치하는 데이터 조회
        String userQuery = "SELECT * FROM user WHERE id = ?";
        pstmt = conn.prepareStatement(userQuery);
        pstmt.setString(1, logonId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String pickValue = rs.getString("pick");

            if (pickValue == null) {
                // pick 컬럼이 null인 경우, 값을 업데이트
                String updateQuery = "UPDATE user SET pick = ? WHERE id = ?";
                pstmt = conn.prepareStatement(updateQuery);
                pstmt.setString(1, id);
                pstmt.setString(2, logonId);
                pstmt.executeUpdate();
            } else {
                // 이미 투표한 경우, 메시지 출력
                out.println("<script>alert('You already voted');</script>");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch(Exception e) {}
        if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
        if (conn != null) try { conn.close(); } catch(Exception e) {}
    }
%>
