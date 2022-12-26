<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
	if(id==null){
		response.sendRedirect("login.jsp");
	}
	
	//form 정보 받기
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String nickname = request.getParameter("nickname");
	String address = request.getParameter("address");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");
	String imgurl = request.getParameter("profile_url");

	
	
	//DB접속
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	Connection conn = DriverManager.getConnection(url, "hr", "hr");
	System.out.println("DB접속 완료");
	
	//sql - 유저정보 수정하기
	String sql ="update board_user set pwd=?,name=?,nickname=?,address=?,tel=?,email=?,imgurl=? where id =?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, pwd);
	stmt.setString(2, name);
	stmt.setString(3, nickname);
	stmt.setString(4, address);
	stmt.setString(5, tel);
	stmt.setString(6, email);
	stmt.setString(7, imgurl);
	stmt.setString(8, id);
	stmt.executeUpdate();
    response.sendRedirect("login_result.jsp");
	
	stmt.close();
	conn.close();
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>