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
	
	int seq = Integer.parseInt(request.getParameter("num"));
	
	//DB접속
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	Connection conn = DriverManager.getConnection(url, "hr", "hr");
	//System.out.println("DB접속 완료");
	
    //sql - seq 증가
    String sql="update board_post set cnt = (select cnt+1 from board_post where seq=?) where seq=?";
	PreparedStatement stmt =conn.prepareStatement(sql);
	stmt.setInt(1, seq);
	stmt.setInt(2, seq);
	stmt.executeUpdate();
    
	//sql - 유저수 표시
	sql ="select count(id) from board_user";
	stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	int count_user =0;
	if(rs.next()){
		count_user=rs.getInt(1);
	}
	
	//sql - 글번호에 맞는 글 출력
	sql = "select board_post.*,board_user.nickname,board_user.imgurl "+
			"from board_post,board_user where board_post.id = board_user.id and seq=?";
	stmt =conn.prepareStatement(sql);
	stmt.setInt(1, seq);
	rs = stmt.executeQuery();
	
	String title = "";
	String content ="";
	Date regdate=null;
	int cnt =0;
	String userid = "";
	String nickname="";
	String imgurl = "";
	
    while(rs.next()){
 	  title = rs.getString("title");
 	  content =rs.getString("content");
 	  regdate = rs.getDate("regdate");
 	  cnt =rs.getInt("cnt");
 	  userid = rs.getString("id");
 	  nickname = rs.getString(7);
 	  imgurl = rs.getString(8);
    }
    
    
    rs.close();
	stmt.close();
	conn.close();

	%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="author" content="kmj">
  <meta name="description" content="Portfolio, RWD Template">
  <title>네이버 로그인</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="shortcut icon" href="./images/favicon/mj_fav32.png">
  <link rel="apple-touch-icon=precomposed" href="./images/favicon/mj_fav32.png">
  <link rel="stylesheet" href="./css/notosans_kr_CDN.css">
  <!-- 페이지css -->
  <link rel="stylesheet" href="./css/reset.css">
  <link rel="stylesheet" href="./css/display_none_scrollbar.css">
  <link rel="stylesheet" href="./css/boardPost.css">
    <!-- JS -->
  <script src="./js/jquery-1.12.4.min.js"></script>
  <script src="./js/jquery-3.3.1.min.js"></script>
  <script src="./js/prefixfree.min.js"></script>
  <script>
  function deletemove(){
	  var answer = confirm('작성글을 삭제하시겠습니까?');
	  if(answer){
		  location.href="boardPostDelete.jsp?num=<%=seq%>";
	  }
  }
  </script>
 
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
      <aside>
        <a href="boardList.jsp">게시글 목록</a>
        <%
        if(userid.equals(id)){
        	%>
        <a href="boardPostUpdate.jsp?num=<%=seq%>">글 수정</a>
        <a onclick ="deletemove();">글 삭제</a>
        	<%        	
        }        
        %>
      </aside>
      <section id="content">
        <article id="title">
          <h3><%=title %></h3>
          <div>
            <img src="<%=imgurl %>" alt="프로필" width="50px" height="50px">
            <p><%=nickname %><br><span><%=regdate %><br>조회수 <%=cnt %></span></p>
          </div>
        </article>
        <article id="content_text">
          <%=content %>
        </article>

      </section>
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