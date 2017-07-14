<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search Place</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<style type="text/css">

table td{
border : black 1px solid;}

</style>



</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!-- 세모가 지맘대로군 -->
<!-- 전체 선택 후 그룹요소 해제되면 대표 체크 지우기 -->
<!-- sql로 날짜 검색해서 상영에 해당하는 영화들을 넣을거라서 세세하게 구현하지않음
다만 나중에 지역별 공연장 검색으로 사용 , 상영상연하는 공연들은 기간을 2달로 고정 할 것 -->

<select name="s_cate" id="s_cate">
	<option value="all">전체</option>
	<option value="name">이름</option>
	<option value="address">위치</option>
</select>

극장 검색 : 
<input type="text" id="s_place" name="s_place" >
<button onclick="getSearch();">검색</button>

<form action="passPcode.pg" id="pcodeList" method="post" >
<table>
	<thead>
		<tr>
			<th>></th>
			<th><input type="checkbox" id="ckall" name="ckall" onclick="selectAll(this);"></th>
			<th>종류</th>
			<th>명칭</th>
			<th>주소</th>
		</tr>
	</thead>
	<tbody id="addlist">
	</tbody>
</table>
<button onclick="fn_goToParent();">추가</button>
</form>

<script type="text/javascript">

$(document).ready(function(){

	$(".screen td").attr("colspan", $(".tb_contract_list thead th").length);




});

</script>

<script type="text/javascript">

function fn_goToParent() {
	   var f = document.getElementById("pcodeList");  // 전송할 폼 ID(현재 자식창내)
	   f.action = "passPcode.pg";    // 실행할 액션
	   opener.window.name = "Insert Page";   // 부모창 이름 설정(임의 설정 가능)
	   f.target = opener.window.name;     // 액션 실행 방향 (부모창)
	   f.submit();
	   window.close();
	   opener.document.focus();            // 부모창 포커스
	   
}

$("#showbtn").click( function(){
	if( $(this).html() == '▶'){
		$(this).html('▼');
	} else {
		$(this).html('▶');
	}
});

function getSearch(){
	
	var cate = $("#s_cate option:selected").val();
	var place = $("#s_place").val();
	var add = $("#addlist");
	
	jQuery.ajax({
	    type:"POST",
	    url:"./searchPlaceSelectAction.pl",
	    data : "s_cate="+cate+"&s_place="+place,
	    dataType:"JSON",
	    success : function(data) {
	    	
	    	add.empty();
	    	var total = data.total;
	    	if(total == 0){
	    		var str = "<tr><td colspan='4'> NO DATA </td></tr>";
	    		add.append(str);
	    	}else{
	    		
	    	var place="";
	    	var screen=""
	    	var str="";
	    	var prepcode="";
 	    	var place="";
 	    	var screen=""
	    	var func = "";
 	    	var num =1;
 	    	
	    	 $.each(data.placeList, function(key, value){
				
	 	    	
					
					if(prepcode!=value.p_code){
						
						//값이 다르면 str에 저장된 정보들을 넣은 후에 새로 place를 저장 후 같은 과정 반복
						str += place+screen;
						screen="";
						num =1;
						place = "<tr><td><a id='showbtn' onclick='showScreen(\""+value.p_code+"\")'>▶</a></td>"+
	            			"<td><input type='checkbox' name='a_pcode' value='"+value.p_code+"' onclick='selectGroup();'></td>" +
	                        "<td>" + value.type + "</td>" +
	                        "<td>" + value.name + "</td>" +
	                        "<td>" + value.address + "</td>" +
	                        "</tr>";
						
						do{
							//처음 place를 추가하고 해당하는 열의 screen을 한번만 넣어주기
							screen += "<tr name='sc"+value.p_code+"' style='display:none;' class='screen'>"+
	   						"<td></td>" +
	   						"<td><input type='checkbox' id='"+value.p_code+num+"' name='pcode' value='"+value.p_code+num+"' ></td>"+
	   						"<td>"+value.screen_name +"</td>"+ 
	   						"<td>"+value.capacity+"</td>"+
	   						"</td>"+
		                    "</tr>";
		                    
		                   
						}while(false);
						 num++;
						prepcode=value.p_code;
						
					}else{
						//현재 조회하는 pcode와 이전에 추가한 pcode의 값이 같으면 screen 정보만 추가하고
						screen += "<tr name='sc"+value.p_code+"' style='display:none;'>"+
   						"<td></td>" +
   						"<td><input type='checkbox'id='"+value.p_code+num+"' name='pcode' value='"+value.p_code+num+"' ></td>"+
   						"<td>" + value.screen_name + "</td>" +
                        "<td>" + value.capacity + "</td>" +
	                    "</tr>";					
	                    
						prepcode=value.p_code;
						
						num++;
					}
		           
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


function showScreen(pcode){
	
	//모양먼저 바꿔주고
//	$("#").val('▼');
	
//	$("#"+pcode).css("display", "none");
	
	if( $("#showbtn").html() == '▶'){
		$("#showbtn").html('▼');
		
		$("[name = 'sc"+pcode+"']").css("display", "table-row");
	} else {
		$("#showbtn").html('▶');
		$("[name = 'sc"+pcode+"']").css("display", "none");
	}
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

function selectGroup(obj){
	//p_code값을 value값으로 가짐
	var pcheckbox = document.getElementsByName('a_pcode');
	var scheckbox = document.getElementsByName('pcode');
	
	for(var i=0; i<pcheckbox.length; i++){
		if(pcheckbox[i].checked == true){
			
			
			//
			$('input:checkbox[name="pcode"]').each(function() {
			var pcode = this.value;
     			if(pcode.substring(0,6) == pcheckbox[i].value){ //값 비교
            		this.checked = true; //checked 처리
				}
 			});



			
		}else if(pcheckbox[i].checked ==  false){
			$("input:checkbox[name='"+pcheckbox[i].value+"']").prop("checked",false);
		}
	}
}

function selectNone(){
	var checkbox = document.getElementsByName('a_pcode');
	var checkall = document.getElementById('ckall');
	
	for(var i=0; i<checkbox.length; i++){
		checkbox[i].checked = false;
	}
	checkall.checked = false;
	
	
}
</script>
</body>
</html>