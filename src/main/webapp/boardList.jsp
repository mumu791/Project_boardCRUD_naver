<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
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
	
	//DB접속
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	Connection conn = DriverManager.getConnection(url, "hr", "hr");
	//System.out.println("DB접속 완료");
	
	//sql - 유저수 표시
	String sql ="select count(id) from board_user";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	int count_user =0;
	if(rs.next()){
		count_user=rs.getInt(1);
	}
	
	//sql - 게시글 목록
	sql = "select board_post.*,board_user.nickname,board_user.imgurl "+
				"from board_post,board_user where board_post.id = board_user.id order by seq desc";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	
    %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="author" content="kmj">
  <meta name="description" content="Portfolio, RWD Template">
  <title>네이버 게시판</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="shortcut icon" href="./images/favicon/mj_fav32.png">
  <link rel="apple-touch-icon=precomposed" href="./images/favicon/mj_fav32.png">
  <link rel="stylesheet" href="./css/notosans_kr_CDN.css">
  <!-- 페이지css -->
  <link rel="stylesheet" href="./css/reset.css">
  <link rel="stylesheet" href="./css/display_none_scrollbar.css">
  <link rel="stylesheet" href="./css/boardList.css">
    <!-- JS -->
  <script src="./js/jquery-1.12.4.min.js"></script>
  <script src="./js/jquery-3.3.1.min.js"></script>
  <script src="./js/prefixfree.min.js"></script>
 
</head>
<body>
  <div id="wrap">
    <header>
      <h1 class="logo_font"><a href="login_result.jsp">NAVER</a> Cafe</h1>
      <div>
        <img src="./images/login_ad.png" alt="카페이미지" width="100px" height="100px">
        <div>
          <h2><a href="#">[노원이젠엠씨쌤]풀스택</a></h2>
          <p><br>멤버수 [<%=count_user %>] </p>
        </div>
      </div>
    </header>
    <main role="main">
      <section id="content">
        <article>
          <ul>
            <li><a href="#">전체글</a></li>
            <li><a href="boardPosting.jsp">글등록</a></li>
            <li><input type="text">&nbsp;&nbsp;<i class="fa fa-search" aria-hidden="true"></i></li>
          </ul>
        </article>
        <ul>
       <%
       while(rs.next()){
    	   int seq = rs.getInt("seq");
    	   String title = rs.getString("title");
    	   Date regdate = rs.getDate("regdate");
    	   int cnt =rs.getInt("cnt");
    	   String username = rs.getString(7);
       %> 
          <li>
          	<div><%=seq %></div>
            <a href="boardPost.jsp?num=<%=seq%>">
              <h3><%=title %></h3>
              <%=username %> <%=regdate %>
            </a>
            <p>조회수<br><%=cnt %></p>
          </li>
          <%}
       rs.close();
		stmt.close();
		conn.close();
		%>
        </ul>
      </section>
      <aside>
        맨위로
      </aside>
    </main>
    <footer>
      <h3>
        <a href="#">이용약관</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
        <a href="#">개인정보처리방침</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
        <a href="#">책임의 한계와 법적고지</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
        <a href="#">회원정보 고객센터</a>
      </h3>
      <p><span class="lobo_c">NAVER</span> Copyright <span class="font_c">&copy; NAVER Corp.</span> All Rights Reserved.</p>
    </footer>
  </div>

</body>
<script>
</script>
</html>