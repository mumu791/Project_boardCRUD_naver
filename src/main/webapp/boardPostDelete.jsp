<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.eclipse.jdt.internal.compiler.env.NameEnvironmentAnswer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
	if(id==null){
		response.sendRedirect("login.jsp");
	}
	
	int seq = Integer.parseInt(request.getParameter("num"));
	
	//DB접속
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	Connection conn = DriverManager.getConnection(url, "hr", "hr");
	//System.out.println("DB접속 완료");
	
	//sql - 게시글 삭제. 
	String sql = "delete from board_post where seq=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, seq);
	stmt.executeUpdate();
	
	response.sendRedirect("boardList.jsp");
	

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