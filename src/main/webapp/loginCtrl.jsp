<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%
    request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String nickname="";
	String db_pwd="";
	
	//DB접속
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	Connection conn = DriverManager.getConnection(url, "hr", "hr");
	//System.out.println("DB접속 완료");
	
	//sql - 비밀번호 확인
	String sql = "select * from board_user where id=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, id);
	ResultSet rs= stmt.executeQuery();
	
	
	if(rs.next()){
		db_pwd=rs.getString("pwd");
		nickname = rs.getString("nickname");
	}
	if(db_pwd.equals(pwd)){
		session.setAttribute("id", id);
		session.setAttribute("nickname", nickname);
		response.sendRedirect("login_result.jsp");
	}else{
	response.sendRedirect("login.jsp");
	}
	rs.close();
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