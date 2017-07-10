<%@page import="team.place.db.LocationBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert page</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="//cdn.rawgit.com/fgelinas/timepicker/master/jquery.ui.timepicker.css">
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script src='//cdn.rawgit.com/fgelinas/timepicker/master/jquery.ui.timepicker.js'></script>

<!-- import 파일 정리 할 것 -->
영화
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
		영화관 목록
		<input type="hidden" id="setFlag" value="${setFlag }">
		<form action="./PlaceInsertAction.pl" method="post">
			<table>
				<thead>
					<tr>
						<th>지역코드</th>
						<th>영화관번호</th>
						<th>영화관</th>
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
						<td>
							<select id="l_code" name="l_code" onchange="javascript:setp_code(this.value, 'l');">
								<option value="지역">선택</option>
			                    	<c:forEach var="value" items="${l_codeList}" varStatus="status">
		                        		<option value="${value.l_code }">${value.l_code }</option>
			                    	</c:forEach>
	                  		</select>
						</td>
						<td><input type="text" name="p_num" id="p_num" ></td>
						<td>
							<select id="p_th" name="p_th" onchange="javascript:setp_code(this.value, 't');">
								<option value="영화관">선택</option>
								<option value="cv">CGV</option>
								<option value="lc">롯데시네마</option>
								<option value="mb">메가박스</option>
							</select>
						</td>
						<td><input type="text" name="p_code" id="p_code"></td>
						<td><input type="text" name="name"></td>
						<td><input type="text" name="screen_name"></td>
						<td><input type="text" name="address"></td>
						<td><input type="text" name="capacity"></td>
						<td><input type="text" name="contact_num"></td>
						<td><input type="text" name="homepage"></td>
					</tr>
				</tbody>
			</table>
		<button>추가</button>
		
		</form>
		
		<button onclick="location.href='./PlaceListSelectAction.pl'">목록보기</button>
		
		<br>
		지역코드추가
		<form action="./LocationInsertAction.pl" method="post">
			<table>
				<thead>
					<tr>
						<th>l_code</th>
						<th>지역</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" name="l_code"></td>
						<td><input type="text" name="location"></td>
				</tbody>
			</table>
		<button>추가</button>
		
		</form>
		
		상영영화 추가
		<form action="./PlayingInsertAction.pg" method="post">
			<table>
				<thead>
					<tr>
						<th>ping_num</th>
						<th>p_code</th>
						<th>nc_code</th>
						<th>시작일</th>
						<th>종료일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" id="ping_num" name="ping_num" value="${pnumMax }"></td>
						<td><input type="text" name="p_code" onclick="searchPlace()"></td>
						<td><input type="text" name="nc_code"></td>
						<td><input type="text" name="start_day" id="start_day"></td>
						<td><input type="text" name="end_day" id="end_day"></td>
					</tr>
					<tr>
						<th>회차</th>
						<td colspan="4">
						<input type="text" name="time" class="time">
						<input type="text" name="time" class="time">
						<input type="text" name="time" class="time">
						</td>
					</tr>
				</tbody>
			</table>
		<button>추가</button>
		
		</form>
	
<script type="text/javascript">

$(document).ready(function(){
	
	
	
	var setflag = $("#setFlag").val();
	
	if(setflag != 'y'){
	
	//지역코드 리스트 가져와서 select 목록으로 보여주기
	 jQuery.ajax({
         type:"POST",
         url:"./getIndexSetInfo.pl",
         dataType:"JSON",
         success : function(data) {
               // select 목록
               $.each(data.l_codeList, function(key, value){
            	   $("#l_code").append("<option value='"+value.l_code+"'>"+value.location+"</option>");
               });
               
               //영화관 번호 설정
               //현재는 영화관 기준으로만 코드 가져옴. 극장 추가시 수정 필요
               $("#p_num").val(data.placeMax+1);
               
	       		var zero = "";
	
		    	for(var i=1; i+pnum.val().length<=4; i++){
		    			zero += "0";
	    		}
	    		
	    		repnum = zero+pnum.val();
	    		$("#p_code").val( $("#l_code option:selected").val() + zero + pnum.val() + $("#p_th option:selected").val());

         },
         complete : function(data) {
               // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
               // TODO
         },
         error : function(xhr, status, error) {
               alert("에러발생");
         }
  	 });
	
	 jQuery.ajax({
         type:"POST",
         url:"./getIndexSetInfo.pg",
         dataType:"JSON",
         success : function(data) {
	    		$("#ping_num").val(data.pnumMax);
         },
         complete : function(data) {
               // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
               // TODO
         },
         error : function(xhr, status, error) {
               alert("에러발생");
         }
  	 });
	}
	
	
});

</script>

<script type="text/javascript">

//p_code 자동출력
var pnum = $("#p_num");
var repnum="";
var zero="";

pnum.keyup(function (){
	for(var i=1; i+pnum.val().length<=4; i++){
		zero += "0";
	}
	
});


function setp_code(value, s){
	
	var pcode = $("#p_code").val();
	
	if(s == 'l'){
		$("#p_code").val(value + pcode.substring(2));
	}else if(s == 't'){
		$("#p_code").val(pcode.substring(0,6)+value);
	}
	
}


$(function() {
    $('.time').timepicker();
});

$( "#start_day" ).datepicker({
	dateFormat: 'yy/mm/dd',
	onClose: function( selectedDate ) {    
       $("#end_day").datepicker( "option", "minDate", selectedDate );
	}
});

$( "#end_day" ).datepicker({
	dateFormat: 'yy/mm/dd',
	onClose: function( selectedDate ) {    
       $("#start_day").datepicker( "option", "maxDate", selectedDate );
	}
});

function searchPlace(){
	window.open("./searchPlaceSelectAction.pl","","width=500, height=300, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
}

</script>

</body>
</html>