<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<form action="./MovieInsertAction.mo" method="post">

	<table width="1000" border="0" align="center">
		
		<tr>
			<td align="center">영화번호</td>
			<td><input type="text" name="movie_num"></td>
			<td align="center">장르코드</td>
			<td><input type="text" name="g_code"></td>
			<td align="center">개봉일</td>
			<td align="center"><input type="date" name="playing_day"></td>
			<td align="center">영화제목</td>
			<td><input type="text" name="name"></td>
			<td align="center">감독</td>
			<td><input type="text" name="director"></td>
			<td align="center">제작사</td>
			<td><input type="text" name="production"></td>
			<td align="center">관람가</td>
			<td><input type="text" name="age"></td>
		</tr>
			
		<tr>
		
			<td align="center">
				<input type="submit" value="추가하기">
			</td>		
		</tr>

	</table>
		</form>
		<br>
		영화관 목록 조회
		<form action="./PlaceInsertAction.pl" method="post">
			<table>
				<thead>
					<tr>
						<th>p_code</th>
						<th>이름</th>
						<th>관</th>
						<th>주소</th>
						<th>좌석수</th>
						<th>연락처</th>
						<th>홈페이지</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" name="p_code"></td>
						<td><input type="text" name="name"></td>
						<td><input type="text" name="screen_name"></td>
						<td><input type="text" name="address"></td>
						<td><input type="text" name="capacity"></td>
						<td><input type="text" name="contact_num"></td>
						<td><input type="text" name="homepage"></td>
				</tbody>
			</table>
		<button>추가</button>
		</form>
		
		<a href="./PlaceListSelectAction.pl">목록보기</a>
		
</body>
</html>