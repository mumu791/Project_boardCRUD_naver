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
	System.out.println("DB접속 완료");
	
	//sql - 유저 정보 불러오기
	String sql ="select * from board_user where id = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, id);
	ResultSet rs = stmt.executeQuery();
	
	String pwd ="";
	String name ="";
	String nickname ="";
	String address ="";
	int tel =0;
	String email ="";
	String imgurl ="";
	if(rs.next()){
		pwd=rs.getString(2);
		name=rs.getString(3);
		nickname=rs.getString(4);
		address=rs.getString(5);
		tel=rs.getInt(6);
		email=rs.getString(7);
		imgurl=rs.getString(8);
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
  <title>개인정보 수정</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="shortcut icon" href="./images/favicon/mj_fav32.png">
  <link rel="apple-touch-icon=precomposed" href="./images/favicon/mj_fav32.png">
  <link rel="stylesheet" href="./css/notosans_kr_CDN.css">
  <!-- 페이지css -->
  <link rel="stylesheet" href="./css/reset.css">
  <link rel="stylesheet" href="./css/display_none_scrollbar.css">
  <link rel="stylesheet" href="./css/signup.css">
    <!-- JS -->
  <script src="./js/jquery-1.12.4.min.js"></script>
  <script src="./js/jquery-3.3.1.min.js"></script>
  <script src="./js/prefixfree.min.js"></script>

 
 
 
</head>
<body>
  <div id="wrap">
    <header>
      <h1><a href="login.jsp">NAVER</a></h1>
    </header>
    <main role="main">
      <form action="memberUpdateCtrl.jsp" method="post">
        <ul>
          <li>
            <label for="id">아이디 <span>*변경불가</span></label>
            <div class="normal_input"><input type="text" name="id" id="id" value="<%=id%>" readonly><span id="id_email">@naver.com</span></div>
          </li>
          <li>
            <label for="pwd">비밀번호<span>*변경가능(주의!)</span></label>
            <input type="password" name="pwd" id="pwd" value="<%=pwd%>" class="normal_input">
          </li>
          <li>
            <label for="name">이름</label>
            <input type="text" name="name" id="name" value="<%=name %>" class="normal_input">
          </li>
          <li>
            <label for="nickname">닉네임</label>
            <input type="text" name="nickname" id="nickname" value="<%=nickname %>" class="normal_input">
          </li>
          <li>
            <label for="address">주소</label><br>
            <input type="text" name="address" id="address" value="<%=address %>" class="normal_input">
          </li>
          <li>
            <label for="tel">휴대전화</label>
            <input type="tel" name="tel" id="tel" value="<%=tel %>" class="normal_input">
          </li>
          <li>
            <label for="email" >본인 확인 이메일<span>(선택)</span></label>
            <input type="email" name="email" id="email" value="<%=email %>" class="normal_input">
          </li>
          <li>
            <label for="profile_url">프로필사진</label>
            <input type="text" name="profile_url" id="profile_url" value="<%=imgurl %>" class="normal_input">
          </li>
        </ul>
        <input type="submit" value="수정하기">
        <input type="hidden" name="id" value="[id값]">
      </form>
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
  $('input').on('focus',function(){
    $(this).css({"border-color": "#03c75a"});
  })
  $('input').on('blur',function(){
    $(this).css({"border-color": "#ccc"});
  })

  $('.normal_input>input').on('focus',function(){
    $(this).parent().css({"border-color": "#03c75a"});
  })
  $('.normal_input>input').on('blur',function(){
    $(this).parent().css({"border-color": "#ccc"});
  })
  
  $('#gender').on('focus',function(){
    $(this).css({"border-color": "#03c75a"});
  });
  $('#gender').on('blur',function(){
    $(this).css({"border-color": "#ccc"});
  });

</script>
</html>