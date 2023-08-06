<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // 세션 무효화
    out.println("<script>window.location.href='/login';</script>");
%>
