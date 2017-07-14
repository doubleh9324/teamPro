<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search Content(mo)</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<style type="text/css">

table td{
border : black 1px solid;}

</style>

</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>


<select name="s_cate" id="s_cate">
	<option value="all">전체</option>
	<option value="name">이름</option>
	<option value="director">감독</option>
	<option value="production">제작사</option>
</select>

영화 검색 : 
<input type="text" id="s_movie" name="s_movie" >
<button onclick="getSearch();">검색</button>

<form action="passMOcode.pg" id="mocodeList" method="post" >
<table>
	<thead>
		<tr>
			<th>제목</th>
			<th>감독</th>
			<th>제작사</th>
			<th>개봉일</th>
		</tr>
	</thead>
	<tbody id="addlist">
	</tbody>
</table>
<button onclick="fn_goToParent();">추가</button>


<script type="text/javascript">

function fn_goToParent(monum, mday) {
	
	window.alert(mday);
	var box = document.getElementsByName("mocode"); 
	var temp = String(mday);

	var day = temp.substring(0,4) + "/" + temp.substring(4,6) + "/" + temp.substring(6,8);
	//for(var i=0; i<box.length; i++){ //box 개수만큼 반복문 
	//	if(box[i].checked){ //checked가 되있으면 true
		//	opener.document.getElementById("nc_code").value="mo"+box[i].value; //true일때 들어와서 해당 value를 띄워준다..
			opener.document.getElementById("nc_code").value="mo"+monum; //true일때 들어와서 해당 value를 띄워준다..
			opener.document.getElementById("start_day").value=day;

	//	}
//	}
			//f.action = "passMOcode.pg";    // 실행할 액션
	//   opener.document.getElementById("nc_code").value="mo"+monum;
	  // f.target = opener.window.name;     // 액션 실행 방향 (부모창)
	  // f.submit();
	  window.close();
	  opener.document.getElementById("start_day").focus();
	  
	   
}

function getSearch(){
	
	var cate = $("#s_cate option:selected").val();
	var movie = $("#s_movie").val();
	var add = $("#addlist");
	
	jQuery.ajax({
	    type:"POST",
	    url:"./searchPlayingMvSelectAction.mo",
	    data : "s_cate="+cate+"&s_movie="+movie,
	    dataType:"JSON",
	    success : function(data) {
	    	
	    	add.empty();
	    	var total = data.total;
	    	if(total == 0){
	    		var str = "<tr><td colspan='5'> NO DATA </td></tr>";
	    		add.append(str);
	    	}else{
	    		
		    	var place="";
		    	var screen=""
		    	var str="";
	 	    	
	    	 $.each(data.movieList, function(key, value){
				str += "<tr>"+
                       "<td><a onclick='fn_goToParent("+value.movie_num+","+value.open_day.replace(/-/g, '')+")'>" + value.name + "</a></td>" +
                       "<td>" + value.director + "</td>" +
                       "<td>" + value.production + "</td>" +
                       "<td>" + value.open_day + "</td>" +
                       "</tr>";
	        });
	    	 
	    	add.append(str).trigger("create");
	    	}
	    },
	    complete : function(data) {
	          return false;
	    },
	    error : function(xhr, status, error) {
	          alert("에러발생");
	    }
		 });
}

function selectAll(){
	
	//전체 선택버튼 isAllch - ckall , 그룹 선택버튼 pcheckbox - a_pcode, 개별 선택버튼 scheckbox - p_code(값) (name값)
	var isAllch = document.getElementById('ckall').checked;
	
	
	//전체선택 제어
	if(isAllch == true){	//전체 선택하기
	
		$("input:checkbox").prop("checked", true);
		
	//	$("input:checkbox[name:'"+pcheckbox.value+"']").prop("checked", true);
	} else {
		//전체선택 해제하기
		$("input:checkbox").prop("checked", false);
	//	$("input:checkbox[name:'"+pcheckbox.value+"']").prop("checked", false);
	}
}


function selectNone(){
	var checkbox = document.getElementsByName('movie_num');
	var checkall = document.getElementById('ckall');
	
	for(var i=0; i<checkbox.length; i++){
		checkbox[i].checked = false;
	}
	checkall.checked = false;
	
	
}

</script>
</form>
</body>
</html>