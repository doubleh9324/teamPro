<%@page import="team.movie.db.MovieBean"%>
<%@page import="team.movie.db.MovieDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	MovieDAO dao= new MovieDAO();
 	MovieBean mb =new MovieBean();
 	mb=dao.selectMovie("3");

%>
<table>
	<tr>
		<td>영화제목</td>
		<td><%=mb.getName() %></td>	
	</tr>
	<tr>
		<td>감독</td>
		<td><%=mb.getDirector() %></td>	
	</tr>
	<tr>
		<td>개봉일</td>
		<td><%=mb.getPlaying_day() %></td>	
	</tr>
	<tr>
		<td>이용가</td>
		<td><%=mb.getAge() %></td>	
	</tr>
	

</table>

</body>
</html>