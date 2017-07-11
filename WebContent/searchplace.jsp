<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<!-- sql로 날짜 검색해서 상영에 해당하는 영화들을 넣을거라서 세세하게 구현하지않음
다만 나중에 지역별 공연장 검색으로 사용 , 상영상연하는 공연들은 기간을 2달로 고정 할 것 -->

<select name="s_cate" id="s_cate">
	<option value="name">이름</option>
	<option value="address">위치</option>
</select>

극장 검색 : 
<input type="text" id="s_place" name="s_place" >
<button onclick="getSearch(1);">검색</button>

<input type="hidden" id="pnum" value="1">

<table>
	<thead>
		<tr>
			<th><input type="checkbox" id="ckall" name="ckall" onclick="selectAll(this);"></th>
			<th>종류</th>
			<th>명칭</th>
			<th>관</th>
			<th>좌석수</th>
			<th>주소</th>
		</tr>
	</thead>
	<tbody id="addlist">
		
	</tbody>
</table>
<script type="text/javascript">

$(document).ready(function(){




var add = $("#addlist");



});

</script>

<script type="text/javascript">



function getSearch(pnum){
	
	var cate = $("#s_cate option:selected").val();
	var place = $("#s_place").val();
	var add = $("#addlist");
	
	jQuery.ajax({
	    type:"POST",
	    url:"./searchPlaceSelectAction.pl",
	    data : "pnum="+pnum+"&s_cate="+cate+"&s_place="+place,
	    dataType:"JSON",
	    success : function(data) {
	    	
	    	add.empty();
	    	var total = data.total;
	    	if(total == 0){
	    		var str = "<tr><td colspan='4'> NO DATA </td></tr>";
	    		add.append(str);
	    	}else{
	    		
	    	var str="";
	    	 $.each(data.placeList, function(key, value){
		            str += "<tr><td><input type='checkbox' name='ck_pcode' value='"+value.p_code+"' ></td>'" +
		                        "<td>" + value.type + "</td>" +
		                        "<td>" + value.name + "</td>"+
		                        "<td>" + value.screen_name + "</td>" +
		                        "<td>" + value.capacity + "</td>" +
		                        "<td>" + value.address + "</td>" +
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


function selectAll(obj){
	
	var checkbox = document.getElementsByName('ck_pcode');
	var isAllch = document.getElementById('ckall').checked;
	var size = checkbox.length;
	
	//선택되면
	if(isAllch == true)
	{	//전체 선택하기
		for(var i =0; i<size; i++){
			checkbox[i].checked = true;
		}	
	} else {
		//전체선택 해제하기
		for(var i=0; i<size; i++){
			checkbox[i].checked = false;
		}
	}
}

function selectNone(){
	var checkbox = document.getElementsByName('ck_pcode');
	var checkall = document.getElementById('ckall');
	
	for(var i=0; i<checkbox.length; i++){
		checkbox[i].checked = false;
	}
	checkall.checked = false;
	
	
}
</script>
</body>
</html>