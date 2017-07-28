function browser_Event(){
	//step3 에서 창 닫을경우 선택된 좌석 application 영역에서 지워주기
	if(event.clientY<0){
		window.alert("browser closed!!!");
	}
	else{
		if(document.readyState=="complete"){
			//새로고침
		}else if(document.readyState=="loading"){
			//다른 페이지 이동
		}
	}
}	 


/*===================================================
 * 페이지 로딩이 완료되면 동작
 */
$(document).ready(function(){
	
	//페이지 로딩이 완료되면 info부분 영역 display none, 영화선택 글자만 block
//	$("span[class='movie_poster']").css("display", "none");
//	$("div[class='placeholder'][title='영화선택'] ").css("display","block");
	
	//아래 배너의 모든 요소 none
	$(".info div").css("display", "none");
	//영화 포스터 none
	$("span[class='movie_poster']").css("display", "none");
	//영화선택, 극장선택, 좌석선택 글씨 block
	$("div[class='placeholder'] ").css("display","block");
	$(".info.path, .info.path > div").css("display","block");
	
	//요일에 따른 클래스 추가
	$(".dayweek").each(function(i){
		if($(this).text() == '토'){
			$(this).parent().parent().addClass('day-sat');
		}else if($(this).text() == '일'){
			$(this).parent().parent().addClass('day-sun');
		}
	});
	
});



//TODO
/**
 * 첫 선택 : 영화, 극장, 날짜 완료
 * 두번째 선택 :
 * 	영화 > (선택시 날짜, 상영관 모두 세팅. 상영하는 날짜가 모두 같아서 수정 할 필요 없음)
 * 	상영관 > (선택시 날짜, 영화 모두 세팅) 다음 영화 눌렀을 때 날짜 설정 완료 / 다음 날짜 눌렀을 때 설정 완료
 * 	날짜 > (선택시 날짜, 영화 모두 세팅) 다음 영화 눌렀을 때 날짜 
 * 
 * dimmed랑 disabled 클릭을 좀 막자
 */

/*===================================================
 * 극장 지역 선택
 */
function theaterAreaClickListener(event){
	
	//.theater-area-list > ul > li.selected > div
	
	//var id = String(event);
	//$("#"+id).css("display", "block");

//	console.log(event.relatedTarget.tagName);
	$(".theater-area-list > ul > li.selected").removeClass("selected");
	$(".area_theater_list > ul > li.selected").removeClass("selected");
	
	$("#"+event.target.id).parent().addClass("selected");
	 
}

/*===================================================
 * 극장 선택
 */
function theaterListClickListener(event){
	//event가 li 밑에 a태그에 걸려있음
	//선택하지않은 극장들 클래스 제거
	$(".area_theater_list > ul > li.selected").removeClass("selected");
	
	//선택한 극장 상위 태그(li) 
	$("#"+event.target.id).parent().addClass("selected");
	
	//극장 글자 block, 극장이름 띄우기
	$(".theater > div").css("display", "block");
	//극장선택 글씨 none
	$("div[class='placeholder'][title='극장선택'] ").css("display","none");
	//극장이름 띄우기
	$(".theater .ellipsis-line1").text($("#"+event.target.id).text());
	
	var pcode = $("#"+event.target.id).parent().attr("p_code");
	
	// 상영관 선택시 그 상영관에서 상영하는 영화가 있는 날만 띄우기
	// 상영관 기준으로 날짜 가져오기
	// 영화, 날짜 아무것도 선택되지 않았을 때
	
	//앞의 영화, 상영관이 선택되었는지 여부 selected된 li가 있으면 ture 반환
	var isSelectedMovie = false;
	var isSelectedDate = false ; 
	
		
	$(".date-list > ul > div > li").each(function(i){
		if($(this).hasClass("selected"))
			isSelectedDate = true;
	});
	
	$(".movie-list > ul > li").each(function(i){
		if($(this).hasClass("selected"))
			isSelectedMovie = true;
	});
	
	//영화, 날짜가 선택되지 않았으면
	if(!isSelectedMovie && !isSelectedDate){
		
		jQuery.ajax({
	        type:"POST",
	        url:"./getPlayingDate.rs",
	        data:"val="+pcode+"&flag="+"theater",
	        dataType:"JSON",
	        success : function(data) {
	        	
	        	//날짜 지정
	        	var duration = data.duration;
	        	
	        	if(duration[0] == "n"){
	        		//상영 일자가 존재하지 않을 경우 모든 날짜에 dimmed 추가
	        		$(".date-list > ul > div > li").addClass("dimmed");
	        	}else{
		        	var sindex = $(".date-list > ul > div > li[date="+duration[0].replace(/-/g, '')+"]").attr("data-index");
		        	var eindex = $(".date-list > ul > div > li[date="+duration[1].replace(/-/g, '')+"]").attr("data-index");
		        	
		        	//시작일자가 오늘 날짜보다 이전이면 
		        	if(typeof sindex=="undefined"){
		        		sindex = 0;
		        	}
		        	
		    		//전체날짜를 dimmed하고
		    		$(".date-list > ul > div > li").addClass("dimmed");
		    		
		    		//해당하는 인덱스사이의 값은 dimmed 제거
		    		for(var d=sindex; d<=eindex; d++){
		    			$(".date-list > ul > div > li[data-index="+d+"]").removeClass("dimmed");
		    		}
	        	}
	        	
	        },
	        complete : function(data) {
	        },
	        error : function(xhr, status, error) {
	              alert("에러발생");
	        }
	 	 });
		
		//해당 상영관 기준으로 영화 목록 가져오기
		jQuery.ajax({
	        type:"POST",
	        url:"./getPlayingMonum.rs",
	        async : false,
	        data:"val="+pcode+"&flag="+"theater",
	        dataType:"JSON",
	        success : function(mdata) {
	        	//해당 날짜에 상영하는 영화 번호 리스트를 받아오면
	    		//전체 영화 중 해당하지 않는 영화 li에 dimmed 추가
		    	var mocount = $(".movie-list > ul > li").length;
		    	
		    	//현재 존재하는 movie_num 배열로 저장
		    	var m = [];
		    	$(".movie-list > ul > li").each(function(i) {
					  m[i] = $(this).attr('movie_num');
				});
		    	//모든 영화를 비활성화 시킨 후
		    	$(".movie-list > ul > li").addClass("dimmed");
		    	
		    	
		    	$.each(mdata.monumList, function(key, value){
		    		if($("li[movie_num="+value.movie_num+"]").hasClass("dimmed")){
		    			$("li[movie_num="+value.movie_num+"]").removeClass("dimmed");
		    			console.log("if");
					}else{
						//$("li[movie_num="+value.movie_num+"]").addClass("dimmed");
					}
		    	});
		    	
		    	
		    	//순서 재정리하기
		    	for(var j=0; j<=mocount; j++){
	    			var moUl =  $(".movie-list > ul");
	    			var movie_num = "";
	    			$(".movie-list > ul > li[class!='dimmed']").each(function(i){
	    		 		movie_num = $(this).attr("movie_num");
	    		 		//window.alert($(".movie_list > ul > li[class!='dimmed']").attr("movie_num"));
	    		 		moUl.prepend($("li[movie_num="+movie_num+"]"));
	    		 	});		    	
		    	}
	        },
	        complete : function(data) {
	              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	        },
	        error : function(xhr, status, error) {
	              alert("getPlayingMonum date 에러발생");
	        }
	 	 });
		}else if(!isSelectedMovie && isSelectedDate){
			//날짜만 선택되어있을 때
			window.alert("이미 날짜 선택(극장선택)");
			//극장 선택하면 해당 극장, 날짜에 상영하는 영화 목록 고치기
			//해당 상영관 기준으로 영화 목록 가져오기
			jQuery.ajax({
		        type:"POST",
		        url:"./getPlayingMonum.rs",
		        async : false,
		        data:"val="+pcode+"&flag="+"theater",
		        dataType:"JSON",
		        success : function(mdata) {
		        	//해당 날짜에 상영하는 영화 번호 리스트를 받아오면
		    		//전체 영화 중 해당하지 않는 영화 li에 dimmed 추가
			    	var mocount = $(".movie-list > ul > li").length;
			    	
			    	//현재 존재하는 movie_num 배열로 저장
			    	var m = [];
			    	$(".movie-list > ul > li").each(function(i) {
						  m[i] = $(this).attr('movie_num');
					});
			    	//모든 영화를 비활성화 시킨 후
			    	$(".movie-list > ul > li").addClass("dimmed");
			    	
			    	$.each(mdata.monumList, function(key, value){
			    		if($("li[movie_num="+value.movie_num+"]").hasClass("dimmed")){
			    			$("li[movie_num="+value.movie_num+"]").removeClass("dimmed");
			    			console.log("if");
						}else{
							//$("li[movie_num="+value.movie_num+"]").addClass("dimmed");
						}
			    	});
			    	
			    	
			    	//순서 재정리하기
			    	for(var j=0; j<=mocount; j++){
		    			var moUl =  $(".movie-list > ul");
		    			var movie_num = "";
		    			$(".movie-list > ul > li[class!='dimmed']").each(function(i){
		    		 		movie_num = $(this).attr("movie_num");
		    		 		//window.alert($(".movie_list > ul > li[class!='dimmed']").attr("movie_num"));
		    		 		moUl.prepend($("li[movie_num="+movie_num+"]"));
		    		 	});		    	
			    	}
		        },
		        complete : function(data) {
		              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
		        },
		        error : function(xhr, status, error) {
		              alert("getPlayingMonum date 에러발생");
		        }
		 	 });
			
		}else if(isSelectedMovie && isSelectedDate){
			setTime();
		}
		
}


/*===================================================
 * 특정 영화 선택
 */

$(document).on("click",".movie-list > ul > li > a ", function(){
	
	//선택하지 않은 영화들 클래스 제거
	$(".movie-list > ul > li.selected").removeClass("selected");
	
	//선택한 영화 클래스 추가
	$(this).parent().addClass("selected");
	
	var movie_num = $(".movie-list > ul > li.selected").attr("movie_num");
	
	//앞의 영화, 상영관이 선택되었는지 여부 selected된 li가 있으면 ture 반환
	var isSelectedDate = false;
	var isSelectedTheater = false ; 
	
		
	$(".area_theater_list > ul > li").each(function(i){
		if($(this).hasClass("selected")){
			isSelectedTheater = true;
			return true;
		}
		console.log(isSelectedTheater);
	});
	
	$(".date-list > ul > div > li").each(function(i){
		if($(this).hasClass("selected"))
			isSelectedDate = true;
	});
	
	
	//날짜, 상영관이 선택되지 않았으면
	if(!isSelectedDate && !isSelectedTheater){
	
		//해당하는 상영관 p_code 목록 받아오기, 지역 목록 set
		jQuery.ajax({
	        type:"POST",
	        url:"./getPlayingPcode.rs",
	        data:"val="+movie_num+"&flag="+"movie",
	        dataType:"JSON",
	        success : function(data) {
	
		    		//해당하는 pcodelist를 받아오면
		    		//전체 상영관 중 pcode에 해당하지 않는 상영관 li에 dimmed 추가
		    		//총 상영관 갯수 (p_code 갯수) 나중에 수정 할 것
		    		//$(".area_theater_list > ul > li").length
		    		var pcount = $(".area_theater_list > ul > li").length;
	        		
	        		//현재 페이지에 있는 pcode 배열로 저장
					var p= [];
					$(".area_theater_list > ul > li").each(function(i) {
						  p[i] = $(this).attr('p_code');
					});
					
					
					//모든 상영관에 추가 후 검색하여 없애기
					//다른 방법이 있나 찾아보자
					$(".area_theater_list > ul > li").addClass("dimmed");
		    				 
		   			 $.each(data.pcodeList, function(key, value){
						if($("li[p_code="+value.p_code+"]").hasClass("dimmed")){
							$("li[p_code="+value.p_code+"]").removeClass("dimmed");
						}else{
	
						}
	                });
	
		    		//총 카운트 지정하기
		    		var cnt= [];
		    		for(var j=1; j<=9; j++){
		    			//지역이름에 해당하는 요소 지정하기
		    			var parUl =  $("li[areaindex ="+j+"][class!='dimmed']").parent();
		    			var pcode = "";
		    			//예매 가능한 상영관의 갯수를 찾아서 배열에 저장
		    		 	cnt[j] = $("li[areaindex ="+j+"][class!='dimmed']").length;
		    		 	//예매 가능한 상영관을 위쪽으로 배치
		    		 	$("li[areaindex ="+j+"][class!='dimmed']").each(function(i){
		    		 		pcode = $(this).attr("p_code");
		    		 		
		    		 		parUl.prepend($("li[p_code="+pcode+"]"));
		    		 	});
		    		 	$(".theater-area-list > ul > li[areaindex ="+j+"] > a > span").text(cnt[j]);
		    		}
		    		
		    		$(".theater-area-list > ul > li > a > span").each(function(i) {
						  $(this).text(cnt[i+1]);
					});
		    		
		    	//	
		    		
		    		
					$(".area_theater_list > ul > li.selected").removeClass("selected");
					$(".theater-area-list > ul > li.selected").removeClass("selected");
		    		
		    		
		    		
	        },
	        complete : function(data) {
	              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	        },
	        error : function(xhr, status, error) {
	              alert("에러발생");
	        }
	 	 });
		
	    //글자없애고 포스터 띄우기
	    $("div[class='placeholder'][title='영화선택'] ").css("display","none");
	    $("span[class='movie_poster']").css("display", "inline");
	    
		//해당 영화에 대한 정보 받아오기 (마지막 날짜 포함)
		jQuery.ajax({
	        type:"POST",
	        url:"./getPlayingMV.rs",
	        data:"mo_num="+movie_num,
	        dataType:"JSON",
	        success : function(data) {
	        	
	        	//아래 배너의 모든 요소 block
	        	$(".info.movie div").css("display", "block");
	        	//영화선택 글씨 none
	        	$("div[class='placeholder'][title='영화선택'] ").css("display","none");
	        	
	        	
	        	//포스터 지정
	        	$("img[alt='영화 포스터']").attr("src","./poster/"+ data.movieInfo.image);
	        	//이름 지정
	        	//a태그 추가해서 상세정보 화면으로 넘어가도록 수정할것
	        	$(".movie_title > span").css("display", "block").text(data.movieInfo.name);
	        	
	        	//등급지정
	        	var age = "";
	        	if(data.movieInfo.age == 'all'){
	        		age = "전체관람가";
	        	}else if(data.movieInfo.age == '18'){
	        		age = "청소년 관람불가";
	        	}else{
	        		age = data.movieInfo.age + "세 관람가";
	        	}
	        	$(".movie_rating > span").text(age).css("display", "block");
	        	
	        	//날짜 지정
	        	var duration = data.duration;
	        	var sindex = $(".date-list > ul > div > li[date="+duration[0].replace(/-/g, '')+"]").attr("data-index");
	        	var eindex = $(".date-list > ul > div > li[date="+duration[1].replace(/-/g, '')+"]").attr("data-index");
	        	
	        	//시작일자가 오늘 날짜보다 이전이면 
	        	if(typeof sindex=="undefined"){
	        		sindex = 0;
	        	}
	        	
	    		//전체날짜를 dimmed하고
	    		$(".date-list > ul > div > li").addClass("dimmed");
	    		
	    		//해당하는 인덱스사이의 값은 dimmed 제거
	    		for(var d=sindex; d<=eindex; d++){
	    			$(".date-list > ul > div > li[data-index="+d+"]").removeClass("dimmed");
	    		}
	        },
	        complete : function(data) {
	        },
	        error : function(xhr, status, error) {
	              alert("에러발생");
	        }
	 	 });
	}else if(!isSelectedTheater && isSelectedDate){
		//날짜만 선택되어 있을 때 해당하는 날에 상영하는 영화가 있는 상영관 지정
		
		var playday = $(".date-list > ul > div > li[class*='selected']").attr("date");
		
		jQuery.ajax({
	        type:"POST",
	        url:"./getPlayingPcode.rs",
	        data:"val="+movie_num+playday+"&flag="+"all",
	        dataType:"JSON",
	        success : function(data) {
	
		    		//해당하는 pcodelist를 받아오면
		    		//전체 상영관 중 pcode에 해당하지 않는 상영관 li에 dimmed 추가
		    		//총 상영관 갯수 (p_code 갯수) 나중에 수정 할 것
		    		//$(".area_theater_list > ul > li").length
		    		var pcount = $(".area_theater_list > ul > li").length;
	        		
	        		//현재 페이지에 있는 pcode 배열로 저장
					var p= [];
					$(".area_theater_list > ul > li").each(function(i) {
						  p[i] = $(this).attr('p_code');
					});
					
					
					//모든 상영관에 추가 후 검색하여 없애기
					//다른 방법이 있나 찾아보자
					$(".area_theater_list > ul > li").addClass("dimmed");
		    				 
		   			 $.each(data.pcodeList, function(key, value){
						if($("li[p_code="+value.p_code+"]").hasClass("dimmed")){
							$("li[p_code="+value.p_code+"]").removeClass("dimmed");
						}else{
	
						}
	                });
	
		    		//총 카운트 지정하기
		    		var cnt= [];
		    		for(var j=1; j<=9; j++){
		    			//지역이름에 해당하는 요소 지정하기
		    			var parUl =  $("li[areaindex ="+j+"][class!='dimmed']").parent();
		    			var pcode = "";
		    			//예매 가능한 상영관의 갯수를 찾아서 배열에 저장
		    		 	cnt[j] = $("li[areaindex ="+j+"][class!='dimmed']").length;
		    		 	//예매 가능한 상영관을 위쪽으로 배치
		    		 	$("li[areaindex ="+j+"][class!='dimmed']").each(function(i){
		    		 		pcode = $(this).attr("p_code");
		    		 		
		    		 		parUl.prepend($("li[p_code="+pcode+"]"));
		    		 	});
		    		 	$(".theater-area-list > ul > li[areaindex ="+j+"] > a > span").text(cnt[j]);
		    		}
		    		
		    		$(".theater-area-list > ul > li > a > span").each(function(i) {
						  $(this).text(cnt[i+1]);
					});
		    		
		    	//	
		    		
		    		
					$(".area_theater_list > ul > li.selected").removeClass("selected");
					$(".theater-area-list > ul > li.selected").removeClass("selected");
		    		
		    		
		    		
	        },
	        complete : function(data) {
	              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	        },
	        error : function(xhr, status, error) {
	              alert("에러발생");
	        }
	 	 });
		
	}else if(isSelectedTheater && !isSelectedDate){

		//상영관만 선택되어 있을 때  해당하는 관에서 해당하는 영화상영하는 날짜 지정
		var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
		window.alert("여기");
		jQuery.ajax({
	        type:"POST",
	        url:"./getPlayingDate.rs",
	        data:"val="+pcode+movie_num+"&flag="+"all",
	        dataType:"JSON",
	        success : function(data) {
	        	
	        	//날짜 지정
	        	var duration = data.duration;
	        	
	        	if(duration[0] == "n"){
	        		//상영 일자가 존재하지 않을 경우 모든 날짜에 dimmed 추가
	        		$(".date-list > ul > div > li").addClass("dimmed");
	        	}else{
		        	var sindex = $(".date-list > ul > div > li[date="+duration[0].replace(/-/g, '')+"]").attr("data-index");
		        	var eindex = $(".date-list > ul > div > li[date="+duration[1].replace(/-/g, '')+"]").attr("data-index");
		        	
		        	//시작일자가 오늘 날짜보다 이전이면 
		        	if(typeof sindex=="undefined"){
		        		sindex = 0;
		        	}
		        	
		    		//전체날짜를 dimmed하고
		    		$(".date-list > ul > div > li").addClass("dimmed");
		    		
		    		//해당하는 인덱스사이의 값은 dimmed 제거
		    		for(var d=sindex; d<=eindex; d++){
		    			$(".date-list > ul > div > li[data-index="+d+"]").removeClass("dimmed");
		    		}
	        	}
	        	
	        },
	        complete : function(data) {
	        },
	        error : function(xhr, status, error) {
	              alert("에러발생");
	        }
	 	 });
	}else if(isSelectedTheater && isSelectedDate){
		setTime();
	}
});

/*===================================================
 * 특정 날짜 선택
 */

$(document).on("click",".date-list > ul > div > li > a ", function(){
	//선택하지 않은 날짜들 클래스 제거
	$(".date-list > ul > div > li.selected").removeClass("selected");

	//선택한 날짜 클래스 추가
	$(this).parent().addClass("selected");
	
	var pdate = $(".date-list > ul > div > li.selected").attr("date");
	
	var vdate = pdate.substring(0,4)+"년 "+pdate.substring(4,6)+"월 "+pdate.substring(6)+"일";
	
	//header 글씨 띄우기
	$(".theater div").css("display", "block");
	//극장선택 글씨 none
	$("div[class='placeholder'][title='극장선택'] ").css("display","none");

	//bottom bar 날짜 지정
	$(".row.date span[class='data']").text(vdate);

	
	//앞의 영화, 상영관이 선택되었는지 여부 selected된 li가 있으면 ture 반환
	var isSelectedMovie = false;
	var isSelectedTheater = false ; 
	
		
	$(".area_theater_list > ul > li").each(function(i){
		if($(this).hasClass("selected")){
			isSelectedTheater = true;
			return true;
		}
		console.log(isSelectedTheater);
	});
	
	$(".movie-list > ul > li").each(function(i){
		if($(this).hasClass("selected"))
			isSelectedMovie = true;
		console.log(isSelectedTheater);
	});
	
	
	//영화, 상영관이 선택되지 않았으면
	if(!isSelectedMovie && !isSelectedTheater){
		
		//해당하는 날짜에 상영하는 영화가 있는 상영관만 표시
		jQuery.ajax({
	        type:"POST",
	        url:"./getPlayingPcode.rs",
	        data:"val="+pdate+"&flag="+"date",
	        async : false,
	        dataType:"JSON",
	        success : function(data) {
		    		//해당하는 pcodelist를 받아오면
		    		//전체 상영관 중 pcode에 해당하지 않는 상영관 li에 dimmed 추가
		    		//총 상영관 갯수 (p_code 갯수) 나중에 수정 할 것
		    		//$(".area_theater_list > ul > li").length
		    		var pcount = $(".area_theater_list > ul > li").length;
	        		
	        		//현재 페이지에 있는 pcode 배열로 저장
					var p= [];
					$(".area_theater_list > ul > li").each(function(i) {
						  p[i] = $(this).attr('p_code');
					});
					
					
					//모든 상영관에 추가 후 검색하여 없애기
					//다른 방법이 있나 찾아보자
					$(".area_theater_list > ul > li").addClass("dimmed");
		    				 
		   			 $.each(data.pcodeList, function(key, value){
						if($("li[p_code="+value.p_code+"]").hasClass("dimmed")){
							$("li[p_code="+value.p_code+"]").removeClass("dimmed");
						}else {
				    		$(".theater-area-list > ul > li.selected").removeClass("selected");
				    		$(".area_theater_list > ul > li.selected").removeClass("selected");
						}
	                });
	
		    		//지역(총 카운트) 지정하기
		    		var cnt= [];
		    		for(var j=1; j<=9; j++){
		    			var parUl =  $("li[areaindex ="+j+"][class!='dimmed']").parent();
		    			var pcode = "";
		    		 	cnt[j] = $("li[areaindex ="+j+"][class!='dimmed']").length;
		    		 	$("li[areaindex ="+j+"][class!='dimmed']").each(function(i){
		    		 		pcode = $(this).attr("p_code");
		    		 		
		    		 		parUl.prepend($("li[p_code="+pcode+"]"));
		    		 	});
		    		 	$(".theater-area-list > ul > li[areaindex ="+j+"] > a > span").text(cnt[j]);
		    		}
		    		
		    		$(".theater-area-list > ul > li > a > span").each(function(i) {
						  $(this).text(cnt[i+1]);
					});
		    		
		    		

		    		//여기 동작이 안되는거같은데 dimmed된 클래스 selected 제거하기
		    		$(".theater-area-list > ul > li[class='dimmed']").each(function(i){
		    			window.alert($(this).attr("data-index"));
		    			if($(this).hasClass("selected"))
		    				$(this).removeClass("selected");
		    		});
	        },
	        complete : function(data) {
	              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	        },
	        error : function(xhr, status, error) {
	              alert("getPlayingPcode date 에러발생");
	        }
	 	 });
		
		// 
		

		//해당하는 날짜에 상영하는 영화만 표시
		jQuery.ajax({
	        type:"POST",
	        url:"./getPlayingMonum.rs",
	        async : false,
	        data:"val="+pdate+"&flag="+"date",
	        dataType:"JSON",
	        success : function(mdata) {
	        	//해당 날짜에 상영하는 영화 번호 리스트를 받아오면
	    		//전체 영화 중 해당하지 않는 영화 li에 dimmed 추가
		    	var mocount = $(".movie-list > ul > li").length;
		    	
		    	//현재 존재하는 movie_num 배열로 저장
		    	var m = [];
		    	$(".movie-list > ul > li").each(function(i) {
					  m[i] = $(this).attr('movie_num');
				});
		    	//모든 영화를 비활성화 시킨 후
		    	$(".movie-list > ul > li").addClass("dimmed");
		    	
		    	
		    	$.each(mdata.monumList, function(key, value){
		    		if($("li[movie_num="+value.movie_num+"]").hasClass("dimmed")){
		    			$("li[movie_num="+value.movie_num+"]").removeClass("dimmed");
		    			console.log("if");
					}else{
						//$("li[movie_num="+value.movie_num+"]").addClass("dimmed");
					}
		    	});
		    	
		    	
		    	//순서 재정리하기
		    	for(var j=0; j<=mocount; j++){
	    			var moUl =  $(".movie-list > ul");
	    			var movie_num = "";
	    			$(".movie-list > ul > li[class!='dimmed']").each(function(i){
	    		 		movie_num = $(this).attr("movie_num");
	    		 		//window.alert($(".movie_list > ul > li[class!='dimmed']").attr("movie_num"));
	    		 		moUl.prepend($("li[movie_num="+movie_num+"]"));
	    		 	});		    	
		    	}
    		 		
    		 		
	        },
	        complete : function(data) {
	              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	        },
	        error : function(xhr, status, error) {
	              alert("getPlayingMonum date 에러발생");
	        }
	 	 });
	 	 
	 	 
	}else if(isSelectedMovie && !isSelectedTheater){
		//상영관 선택 없이 영화만 선택되어있으면
		//영화 선택시 날짜와 상영관이 셋팅되기 때문에 따로 수정 할 내용 없음.
		//(모든 상영관이 상영하는 날짜가 같다고 설정해놔서, 이 부분을 	변경하면 수정 할 것)
	}else if(!isSelectedMovie && isSelectedTheater){
		//영화 선택 없이 상영관만 선택되어있으면
		//해당하는 일자에 해당하는 상영관에서 상영하는 영화 설정하기
		var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
		
		jQuery.ajax({
	        type:"POST",
	        url:"./getPlayingMonum.rs",
	        async : false,
	        data:"val="+pcode+pdate+"&flag="+"all",
	        dataType:"JSON",
	        success : function(mdata) {
	        	//해당 날짜에 상영하는 영화 번호 리스트를 받아오면
	    		//전체 영화 중 해당하지 않는 영화 li에 dimmed 추가
		    	var mocount = $(".movie-list > ul > li").length;
		    	
		    	//현재 존재하는 movie_num 배열로 저장
		    	var m = [];
		    	$(".movie-list > ul > li").each(function(i) {
					  m[i] = $(this).attr('movie_num');
				});
		    	//모든 영화를 비활성화 시킨 후
		    	$(".movie-list > ul > li").addClass("dimmed");
		    	
		    	$.each(mdata.monumList, function(key, value){
		    		if($("li[movie_num="+value.movie_num+"]").hasClass("dimmed")){
		    			$("li[movie_num="+value.movie_num+"]").removeClass("dimmed");
		    			console.log("if");
					}else{
						//$("li[movie_num="+value.movie_num+"]").addClass("dimmed");
					}
		    	});
		    	
		    	
		    	//순서 재정리하기
		    	for(var j=0; j<=mocount; j++){
	    			var moUl =  $(".movie-list > ul");
	    			var movie_num = "";
	    			$(".movie-list > ul > li[class!='dimmed']").each(function(i){
	    		 		movie_num = $(this).attr("movie_num");
	    		 		//window.alert($(".movie_list > ul > li[class!='dimmed']").attr("movie_num"));
	    		 		moUl.prepend($("li[movie_num="+movie_num+"]"));
	    		 	});		    	
		    	}
	        },
	        complete : function(data) {
	              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	        },
	        error : function(xhr, status, error) {
	              alert("getPlayingMonum date 에러발생");
	        }
	 	 });
		
	}else if(isSelectedMovie && isSelectedTheater){
		setTime();
	}
	
});

/*=========================================================================
 * 시간표 불러오기
 */
//TODO 관이 10개 이상이면 정렬했을떄 두자리수가 먼저 나와버린당.. 나중에 고칠 것
function setTime(){	
	
	var playday = $(".date-list > ul > div > li[class*='selected']").attr("date");
	var mo_num = $(".movie-list > ul > li[class*='selected']").attr("movie_num");
	var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
	
	jQuery.ajax({
        type:"POST",
        url:"./getPlayingTime.rs",
        async : false,
        data:"pcode="+pcode+"&playday="+playday+"&mo_num="+mo_num,
        dataType:"JSON",
        success : function(data) {
        	//TimeInfoList 가져와썽
        	//선택하라는 div none
    		$(".section-time > .col-body > .placeholder").css("display", "none");
    		
        	var addList = $(".time-list > div");
        	var screenStr = "";
        	var timeStr = "";
        	var preScreen = "";
        	var i = 0;
        	var playnum = 1;
        	var str = "";
        	
        	//이전에 선택해서 나온 값이 있으면 지우기
        	addList.empty();
        	
        	$.each(data.TimeInfoList, function(key, value){
        		
        		//이전에 저장된 관 이름과 현재 관 이름이 다를 때만
        		if(value.screen_name != preScreen){
        			if(screenStr != "")
        				str += screenStr + "<ul>" + timeStr + "</ul></div>";
        			screenStr ="";
        			timeStr = "";
        			playnum=1;
        			
	        		screenStr = "<div  class='theater' screen_code='"+value.screen_name + "' movie_num='"+mo_num +"' style='border: none;'>" +
	        				"<span class = 'title'>"+
	        					"<span class='name'>2D</span>"+
	        					"<span class='floor'>"+value.screen_name+"</span>"+
	        					"<span class='seatcount'>(총"+value.capacity+"석)</span>"+
	        				"</span>";
	        		
	        		preScreen=value.screen_name;
	        		
	        		timeStr = "<li data-index='"+i+"' data-remain_seat='"+value.capacity+"' play_start_tm='"+value.ptime.replace(':','')+
					"' screen='"+value.screen_name + "'play_num='"+playnum+"' class >"+
						"<a class='button' href='#' onclick='screenTimeClickListener(event);return false;'>"+
							"<span class='time'><span>"+value.ptime+"</span></span>"+
							"<span class='count'>"+value.capacity+"석</span>"+
							"<div class='sreader'>종료시간</div>"+
							"<span class='sreader mod'></span>"+
						"</a>"+
					"</li>";
		playnum++;
		i++;
        		}else {
        			timeStr += "<li data-index='"+i+"' data-remain_seat='"+value.capacity+"' play_start_tm='"+value.ptime.replace(':','')+
	        					"' screen='"+value.screen_name + "'play_num='"+playnum+"' class >"+
	        						"<a class='button' href='#' onclick='screenTimeClickListener(event);return false;'>"+
	        							"<span class='time'><span>"+value.ptime+"</span></span>"+
	        							"<span class='count'>"+value.capacity+"석</span>"+
	        							"<div class='sreader'>종료시간</div>"+
	        							"<span class='sreader mod'></span>"+
	        						"</a>"+
	        					"</li>";
        			playnum++;
        			i++;
	        					
        		}
        		
        	});
        	addList.append(str);
        	
        	//오늘 상영 중 시간대가 현재 시간보다 이전이면 dimmed 클래스 추가하기
        	
        	//선택된 date가 오늘일때만
        	var today = $(".date-list > ul > div > li[data-index='1']").attr("date");
        	if(playday == today){
        		
	        	var gettime = new Date();
	        	var now = "";
	        	if(gettime.getHours().toString().length == 1){
	        		now = "0"+gettime.getHours().toString()+gettime.getMinutes().toString();
	        	}else{
	        		now = gettime.getHours().toString()+gettime.getMinutes().toString();
	        	}
	        	$(".time-list .theater > ul > li").each(function(i){
	                 var time = $(this).attr("play_start_tm");
	                 if(now.localeCompare(time)==1){
	                    $(this).addClass("disabled");
	                 }
	                 if(Number(time.substring(0,2))>21){
	                    $(this).addClass("night");
	                 }
	                 if(Number(time.substring(0,2))<9){
	                    $(this).addClass("morning");
	                 }
	                 
	              });
        	}
        	
        },
        complete : function(data) {
              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
        },
        error : function(xhr, status, error) {
              alert("getPlayingMonum date 에러발생");
        }
 	 });
}


/*====================================================================
 * 시간 선택
 */
function screenTimeClickListener(event){
	//TODO
//	console.log(event.relatedTarget.tagName);
	$(".time-list > div > div > ul > li.selected").removeClass("selected");
	$(event.currentTarget).parent().addClass("selected");
	
	//bottom bar 추가
	$(".row.screen span[class='data']").text($(event.currentTarget).parent().attr("screen"));
	
	//버튼 활성화
	$("#tnb_step_btn_right").addClass("on");
	
}
/*====================================================================
 * 이전단계 버튼
 */
function OnTnbLeftClick(){
	
	var step = $(".tnb").attr("class");
	window.alert(step);
	
	//넘어가기 버튼을 누른 페이지
	var step2 = step.match(/step2/g);
	var step3 = step.match(/step3/g);
	
	if(step2 != null){
		//레이어 옮기기, bottom bar 수정, 버튼 on 제거
		$(".step.step2").css("display", "none");
		$(".tnb.step2").removeClass("step2").addClass("step1");
		$(".step1").css("display", "block");
		$("#tnb_step_btn_right").addClass("on")
		
		//사람 수 선택 제거
		$(".group.adult > ul > li ").removeClass("selected");
		//좌석 선택 제거
		$(".seat_group > div > .seat").removeClass("selected");
	}else if(step3 != null){
		//레이어 옮기기, bottom bar 수정, 버튼 on 제거
		$(".step.step3").css("display", "none");
		$(".tnb.step3").removeClass("step3").addClass("step2");
		$(".step2").css("display", "block");
		$("#tnb_step_btn_right").addClass("on")
		
	}
}
/*====================================================================
 * 다음단계 버튼
 */

function OnTnbRightClick(){
	//우선 앞의 모든 항목들이 체크되어 있는지 확인 필요
	//단계에 따라서 눌렀을 때 확인이 필요해
	var step = $(".tnb").attr("class");
	window.alert(step);
	
	//넘어가기 버튼을 누른 페이지
	var step1 = step.match(/step1/g);
	var step2 = step.match(/step2/g);
	var step3 = step.match(/step3/g);
	
	if(step1 != null){
		if(!$("#tnb_step_btn_right").hasClass("on")){
			//모든 요소가 선택되어 on 클래스를 가지고 있는게 아니라면
			window.alert("영화, 상영관, 날짜, 시간을 선택해주세요");
			//나중에 세부 요소 알림창 띄우기로 수정 할 것
		}else{
			//원래는 여기서 로그인 확인해야함
			//TODO
			
			//레이어 옮기기, bottom bar 수정, 버튼 on 제거
			$(".step.step1").css("display", "none");
			$(".tnb.step1").removeClass("step1").addClass("step2");
			$(".step2").css("display", "block");
			$("#tnb_step_btn_right").removeClass("on")
			
			//step2 정보 띄우기
			$(".theater-info > .site").text($(".area_theater_list > ul > li.selected > a").text());
			$(".theater-info > .screen").text($(".time-list .theater").attr("screen_code"));
			$(".theater-info > .seatNum > .restNum").text($(".time-list .theater > ul > li.selected > a > span.count").text());
			$(".theater-info > .seatNum > .totalNum").text($(".time-list .theater > ul > li.selected").attr("data-remain_seat"));
			
			var dateInfo = "<b>"+$(".row.date > span.data").text() + "</b> <b class='exe'>("+$(".date-list > ul > div > li.selected > a > span.dayweek").text()
							+")</b><b> "+$(".time-list .theater > ul > li.selected > a > span.time > span").text() + "</b>";
			$(".playYMD-info").empty();
			$(".playYMD-info").append(dateInfo);
			//시간
			$(".time-list .theater > ul > li.selected > a > span.time > span").text();
			//날짜 연월일
			$(".row.date > span.data").text();
			//요일
			$(".date-list > ul > div > li.selected > a > span.dayweek").text();
			
			//인원 선택 전 좌석표에 dimmed 추가
			$(".section-seat").addClass("dimmed");
			
			//좌석표 뿌리기
			var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
			getSeatMap(pcode);
		}
	}else if(step2 != null){
		
		if(!$("#tnb_step_btn_right").hasClass("on")){
			//모든 요소가 선택되어 on 클래스를 가지고 있는게 아니라면
			window.alert("인원수에 맞는 좌석을 선택해주세요");
			//나중에 세부 요소 알림창 띄우기로 수정 할 것
		}
		
		var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
		var mo_num = $(".movie-list > ul > li[class*='selected']").attr("movie_num");
		var screen_name = $(".info.theater .row.screen .data").text();
		var viewdate = $(".day.selected").attr("date") + $(".time-list li.selected").attr("play_start_tm");
		var seat = $(".info.seat .row.seat_no .data").text();

		
		//TODO
		//선택한 좌석이 이미 선택된 좌석인지 확인하기
		//예매내역 테이블로 넣기
		jQuery.ajax({
	        type:"POST",
	        url:"./checkedSeat.rs",
	        async : false,
	        data:"pcode="+pcode+"&mo_num="+mo_num+"&screen_name="+screen_name+"&viewdate="+viewdate+"&seat="+seat,
	        dataType:"JSON",
	        success : function(data) {
	        	//data.checkFlag == n 이면 통과 아니면 다시 선택
	        	
	        	if(data.checkedFlag == "y"){
	        		window.alert("이미 선택된 좌석입니다.");
	        		//$(".seat_group > div > .seat").removeClass("selected");
	        		
	        		//좌석표를 다시 불러오는게 어떨까
	        		//아냐 코드가 너무 길어!
	        		
	        		
	        		$.each(data.checkedSeats, function(key, value){
	            		var seat_fl = value.seat_fl;
	            		var seat_no = value.seat_no;
	            		$(".seats > .rows .row").find(".label").each(function(i){
	            			if($(this).text() == seat_fl){
	            				//예약되어있는 열의 class를 가져와서 rating관련 클래스 빼주고
	            				var c = $(this).parent().find(".seat[data-index="+seat_no+"]").attr("class");
	            				if(c.search("vip")>0){
	            					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_vip");
	            				}else if(c.search("r")>0){
	            					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_r");
	            				}else if(c.search("s")>0){
	            					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_s");
	            				}
	            				//reserved 클래스 추가
	            				$(this).parent().find(".seat[data-index="+seat_no+"]").addClass("reserved");
	            				$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("selected");
	            			}
	            		});
	            	});
	            	
	        	}else if(data.checkedFlag == "n"){
	        		//레이어 옮기기, bottom bar 수정, 버튼 on 제거
	        		$(".step.step2").css("display", "none");
	        		$(".tnb.step2").removeClass("step2").addClass("step3");
	        		$(".step3").css("display", "block");
	        		$("#tnb_step_btn_right").removeClass("on");
	        		
	        		$("#summary_total_amount").text($(".row.payment-final > span.data > span.price").text());
	        		$("#summary_payment_total").text($(".row.payment-final > span.data > span.price").text());
	        	}
	        	
	        },
	        complete : function(data) {
	              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	        },
	        error : function(xhr, status, error) {
	              alert("checkedSeat date 에러발생");
	        }
	 	 });
		
		
		
		
	}else if(step3 != null){
		//내역 확인 팝업창 띄우기
		$(".ft_layer_popup.popup_reservation_check").css("display", "block");
		
		//팝업창 안에 필요한 정보들 입력
		$(".article.reservation_info .poster img").attr("src",$(".info.movie .movie_poster img").attr("src"));
		$(".article.reservation_info tr.movie_name > td").text($(".info.movie .row.movie_title span").text());
		$(".article.reservation_info tr.theater > td").text($(".info.theater .row.name .data").text());
		$(".article.reservation_info tr.screen > td").text($(".info.theater .row.screen .data").text());
		$(".article.reservation_info tr.movie_date > td").text($(".info.theater .row.date .data").text());
		$(".article.reservation_info tr.people > td").text($(".info.theater .row.number .data").text());
		$(".article.reservation_info tr.seat > td").text($(".info.seat .row.seat_no .data").text());
		
		$(".article.payment_info tr.payment_price > td .price").text($("#summary_payment_total").text());
		$(".article.payment_info .payment_methods .price").text($("#summary_payment_list .code_0010 > dt").text());
	}
}

/*=======================================================================
 * 인원선택
 * 
 */

//일반 그룹
$(document).on("click",".group.adult > ul > li ", function(){
	//다른 사람그룹(? 이 추가되면 전체 목록에서 remove selected 하도록 수정
	$(".group.adult > ul > li ").removeClass("selected");
	$(this).addClass("selected");
	
	//bottom bar 인원 나타내기
	$(".row.number > span.data").text("일반 "+$(this).attr("data-count")+"명");
	
	$(".section-seat").removeClass("dimmed");
});

/*========================================================================
 * 좌석표 구성하기
 */
//한 종류 영화관에 관 좌석 수가 같아서 일단 pcode만 받기
function getSeatMap(pcode){
	
	var mo_num = $(".movie-list > ul > li[class*='selected']").attr("movie_num");
	var screen_name = $(".info.theater .row.screen .data").text();
	var viewdate = $(".day.selected").attr("date") + $(".time-list li.selected").attr("play_start_tm");
	// 좌석표 뿌려주기
	
	$("#seats_list > div").empty();
	
	jQuery.ajax({
        type:"POST",
        url:"./getSeatMap.rs",
        data:"pcode="+pcode+"&mo_num="+mo_num+"&screen_name="+screen_name+"&viewdate="+viewdate,
        dataType:"JSON",
        success : function(data) {
        	//좌석표 정보를 전달받으면
        	
        	var TotalRowCount = data.seatMap.totalrowcount;
        	var RowGroupCount = data.seatMap.rowgroupcount;
        	//각 열의 구분은 _ 열안의 값 구분은 , 지금은 모든 열의 갯수가 같아서 나중에 수정 할 것
        	//(_기준으로 나눈 후에) 잘라서 배열의 한 열에 넣을 것
        	var temp = (data.seatMap.rowgroupseatcount.toString()).split("_");
        	var RowGroupSeatCount = new Array();
	        	for(var a=0; a<TotalRowCount; a++){
	        		RowGroupSeatCount[a] = temp.toString().split(",");
	        	}
        	var ColGroupCount = data.seatMap.colgroupcount;
        	var ColGroupRowCount = (data.seatMap.colgrouprowcount.toString()).split(",");
        	
        	//vipscope
        	var vipScope = new Array();
        	temp = (data.seatMap.vipscope.toString()).split("_");
        		for(var v =0; v<temp.length; v++){
        			vipScope[v] = temp[v].toString().split(",");
        		}
        		
	    	//rscope
	    	var rScope = new Array();
	    	temp = (data.seatMap.rscope.toString()).split("_");
	    		for(var r =0; r<temp.length; r++){
	    			rScope[r] = temp[r].toString().split(",");
	    		}
	    		
	    	//sscope
	    	var sScope = new Array();
	    	temp = (data.seatMap.sscope.toString()).split("_");
	    		for(var s =0; s<temp.length; s++){
	    			sScope[s] = temp[s].toString().split(",");
	    		}
	    		
	    	var vacantSeats = new Array();
	    	temp = (data.seatMap.vacantseat.toString()).split("_");
		    	for(var vas =0; vas<temp.length; vas++){
		    		vacantSeats[vas] = temp[vas].toString().split(",");
	    		}
        	
        	//열 이름 배열
        	var RowNames = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "N", "M", "O", "P", "Q", "R", "S", "T", "U"];
        	//열 이름 배열 인덱스
        	var RowNameIndex = 0;
        	//하나의 열 결과 텍스트
        	var RowStr = "";
        	//하나의 열에 속한 좌석 결과 텍스트
        	var RowSeatsStr = "";
        	//열 간격 top px값
        	var pxTop=0;
        	//행 간격 data-left px값
        	var pxLeft=0;
        	//열 간격
        	var top=16;
        	//행 간격
        	var left=16;
        	

        	//하나의 열에 총 좌석 갯수
        	
        	var RowSeatCount=0;
        	
        	var rindex = 0;
        	
        	//열 시작 div
        	var startDiv="";
        	//열 끝 div
        	var endDiv="";
        	
        	var isFirstCol = true;
        	var sindex = 0;
        	var rowRe = "";
        	//총 열의 갯수동안
        	for(var r=0 ; r<TotalRowCount; r++){
        		var isFirstCol = true;
        		RowSeatCount=0;
        		//가로그룹 갯수만큼 반복하면서 한 열의 총 좌석 수 구하기
        		for(var sc=0; sc < RowGroupCount; sc++){
        			RowSeatCount += RowGroupSeatCount[r][sc];
        		}
        		
        		pxLeft=0;
        		//열
        		RowStr = "<div class='row' style='top:"+pxTop+"px'>"+
        					"<div class='label'>"+RowNames[RowNameIndex]+"</div>";
        		pxLeft = pxLeft + left; 
        		//가로그룹이 두개라면 첫번째 가로그룹의 좌석을 붙인 후 (RowGroupSeatCount의 두번째 값)
        		//pxLeft값을 한번 더 더해주기
        		pxTop = pxTop + top;
        		RowNameIndex++;
        		RowSeatsStr="";
        		
        		var colSeats = new Array();
        		var i=1;
        		for(sc=0; sc < RowGroupCount; sc++){
        			//첫번째 가로그룹엔 left 클래스 추가
        				if(isFirstCol){
        					startDiv = "<div class='seat_group left'><div class='group'>";
        				}else{
        					startDiv = "<div class='seat_group'><div class='group'>";
        				}
        				sindex=0;
        				while( sindex < parseInt(RowGroupSeatCount[r][sc]) ){
        					//window.alert(parseInt(RowGroupSeatCount[r][sc]));
        					RowSeatsStr += "<div class='seat' style='left:"+pxLeft+"px' data-left='"+pxLeft+"' data-index='"+i+"'>"+
        					"<a href='#' onclick='return false;'>"+
        						"<span class='no'></span>"+
        						"<span class='sreader'></span>"+
        						"<span class='sreader mod'></span>"+
        					"</a>"+
        					"</div>";
        					pxLeft = pxLeft + left;
        					sindex ++;
        					i++;
        				}
        				//하나의 가로그룹 좌석 열이 다 붙으면
        				rowRe += startDiv + RowSeatsStr+"</div></div>";
        				isFirstCol = false;
        				RowSeatsStr = "";
        				pxLeft = pxLeft + left;
        		}
        		$("#seats_list > .rows").append(RowStr +rowRe +"</div></div>");
        		rowRe = "";
        		i=1;
        		
        	}
        	
        	
        	//좌석을 다 붙이고나면  세로그룹 대로 재배치
        	//세로그룹 나누기
        	var findr = false;
        	var firstrow = 0;
        	var col = 0;
        	 for(var cgc=0; cgc<ColGroupCount; cgc++){
        		 col += ColGroupRowCount[cgc]*1;
        		$("#seats_list div .row .label").each(function(){
        				
        	
        				 if($(this).text() == RowNames[col]){
        		
        					 findr = true;
        					 firstrow = top*col + (cgc*16);
        					 
        				 }
        				 
        				 if(findr){
        					 firstrow = firstrow + top;
        					 $(this).parent().css("top", firstrow);
        				 }
        			 
        		});
        		firstrow += 16;
        		findr=false;
        	 }
        	 
        	//좌석 위치 배정 후 감싸고있는 div 크기 정해주기(가운데 정렬)
        	//지금은 가로로 좌석 갯수가 같아서 쓰던걸 가져왔는데 나중에 달라지면 max값으로 가져오기
        	$("#seats_list").css("width", RowSeatCount*(left-1)+(RowGroupCount-1)*(left-1));
        	
        	//등급 나누기
        	for(var ri=0; ri<rScope.length; ri++){
        		for(var rs=0; rs<rScope[ri].length; rs++){
        			//첫번째 인수는 열 번호
        			var rownum = rScope[ri][0]-1;
        			
        			
        			if(rScope[ri].length > 1){
	        			//시작 좌석 번호
	        			var s = rScope[ri][1]-1;
	        			//끝 좌석 번호
	        			var e = rScope[ri][2]-1;
	        			
	        			$("#seats_list > .rows > .row:eq("+rownum+") .seat").each(function(i){
	        				if(s<=i && i<=e){
	        					$(this).addClass("rating_r");
	        					$(this).find(".sreader").not(".sreader.mod").text("R");
	        				}
	        			});
	    			}else {
	    				//없으면 열  전체
	    				$("#seats_list > .rows > .row:eq("+rownum+") .seat").each(function(){
	        					$(this).addClass("rating_r");
	        					$(this).find(".sreader").not(".sreader.mod").text("R");
	        			});
	    			}
        		}
        	}
        	for(var si=0; si<sScope.length; si++){
        		for(var ss=0; ss<sScope[si].length; ss++){
        			//첫번째 인수는 열 번호
        			var rownum = sScope[si][0]-1;
        			
        			if(sScope[si].length > 1){
	        			//시작 좌석 번호
	        			var s = sScope[si][1]-1;
	        			//끝 좌석 번호
	        			var e = sScope[si][2]-1;
	        			
	        			$("#seats_list > .rows > .row:eq("+rownum+") .seat").each(function(i){
	        				if(s<=i && i<=e){
	        					$(this).addClass("rating_s");
	        					$(this).find(".sreader").not(".sreader.mod").text("S");
	        				}
	        			});
	    			}else {
	    				//없으면 열  전체
	    				$("#seats_list > .rows > .row:eq("+rownum+") .seat").each(function(){
	        					$(this).addClass("rating_s");
	        					$(this).find(".sreader").not(".sreader.mod").text("S");
	        			});
	    			}
        		}
        	}
        	for(var vi=0; vi<vipScope.length; vi++){
        		for(var vs=0; vs<vipScope[vi].length; vs++){
        			//첫번째 인수는 열 번호
        			var rownum = vipScope[vi][0]-1;
        			
        			if(vipScope[vi].length > 1){
        				//시작, 끝 번호가 있을때만
        				
	        			//시작 좌석 번호
	        			var s = vipScope[vi][1]-1;
	        			//끝 좌석 번호
	        			var e = vipScope[vi][2]-1;
	        			
	        			$("#seats_list > .rows > .row:eq("+rownum+") .seat").each(function(i){
	        				if(s<=i && i<=e){
	        					$(this).addClass("rating_vip");
	        					$(this).find(".sreader").not(".sreader.mod").text("VIP");
	        				}
	        			});
        			}else {
        				//없으면 열  전체
        				$("#seats_list > .rows > .row:eq("+rownum+") .seat").each(function(){
	        					$(this).addClass("rating_vip");
	        					$(this).find(".sreader").not(".sreader.mod").text("VIP");
	        			});
        			}
        		}
        	}	
        	
        	//TODO
        	//좌석표가 구성되고나면 예약된 좌석, 선택된 좌석 비활성화 시키기
        	
        	//예약된 좌석에 reserved 클래스 추가
        	$.each(data.reservedSeats, function(key, value){
        		var seat_fl = value.seat_fl;
        		var seat_no = value.seat_no;
        		$(".seats > .rows .row").find(".label").each(function(i){
        			if($(this).text() == seat_fl){
        				//예약되어있는 열의 class를 가져와서 rating관련 클래스 빼주고
        				var c = $(this).parent().find(".seat[data-index="+seat_no+"]").attr("class");
        				if(c.search("vip")>0){
        					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_vip");
        				}else if(c.search("r")>0){
        					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_r");
        				}else if(c.search("s")>0){
        					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_s");
        				}
        				//reserved 클래스 추가
        				$(this).parent().find(".seat[data-index="+seat_no+"]").addClass("reserved");
        			}
        		});
        	});
        	
        	//선택중인 좌석 비활성화
    		var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
    		var mo_num = $(".movie-list > ul > li[class*='selected']").attr("movie_num");
    		var screen_name = $(".info.theater .row.screen .data").text();
    		var viewdate = $(".day.selected").attr("date") + $(".time-list li.selected").attr("play_start_tm");
        	
        	jQuery.ajax({
    	        type:"POST",
    	        url:"./checkedSeat.rs",
    	        async : false,
    	        data:"pcode="+pcode+"&mo_num="+mo_num+"&screen_name="+screen_name+"&viewdate="+viewdate+"&seat="+"0",
    	        dataType:"JSON",
    	        success : function(data) {
    	        	//data.checkFlag == n 이면 통과 아니면 다시 선택
    	        		
	        		$.each(data.checkedSeats, function(key, value){
	            		var seat_fl = value.seat_fl;
	            		var seat_no = value.seat_no;
	            		window.alert(seat_fl + seat_no);
	            		$(".seats > .rows .row").find(".label").each(function(i){
	            			if($(this).text() == seat_fl){
	            				//예약되어있는 열의 class를 가져와서 rating관련 클래스 빼주고
	            				var c = $(this).parent().find(".seat[data-index="+seat_no+"]").attr("class");
	            				if(c.search("vip")>0){
	            					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_vip");
	            				}else if(c.search("r")>0){
	            					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_r");
	            				}else if(c.search("s")>0){
	            					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_s");
	            				}
	            				//reserved 클래스 추가
	            				$(this).parent().find(".seat[data-index="+seat_no+"]").addClass("reserved");
	            				$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("selected");
	            			}
	            		});
	            	});
    	        	
    	        },
    	        complete : function(data) {
    	              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
    	        },
    	        error : function(xhr, status, error) {
    	              alert("checkedSeat2 에러발생");
    	        }
    	 	 });
        	
        	
        	
        	
        	
        },
        complete : function(data) {
              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
        },
        error : function(xhr, status, error) {
              alert("에러발생");
        }
 	 });
}

/*======================================================================
 * 좌석 선택
 */
$(document).on("click",".seat_group > div > .seat > a", function(i){
	
	var num = $(".numberofpeople-select ul li.selected").attr("data-count");
	//선택하지 않은 좌석들 클래스 제거
	
	if($(".seat_group > div > .seat").hasClass("selected")){
		//다음 요소부터 num개만큼 선택을 위해서 하나 뒤로
		var selectLi = $(this).parent();
		var re = window.confirm("이미 선택된 좌석이 있습니다. 변경하시겠습니까?");
		
		if(re){
			$(".seat_group > div > .seat").removeClass("selected");
			
			for(var n=0; n<num; n++){
				if(n==0)
					$(this).parent().addClass("selected");
				else
					$(this).parent().next().addClass("selected");
			}
		}
	}else{
		for(var n=0; n<num; n++){
			
			if(n==0)
				$(this).parent().addClass("selected");
			else
				$(this).parent().next().addClass("selected");
		
		}
	}
	//bottom bar 설정하기
	//글씨 모두 살리기
	$(".info.seat div").css("display", "block");
	$(".row.payment-adult").css("display", "block");
	
	//좌석 선택 글씨 none
	$("div[class='placeholder'][title='좌석선택'] ").css("display","none");
	
	var selectedGrade = $("#seats_list > .rows > .row .seat.selected" ).find(".sreader").text();
	var grade = new Array();
	
	//좌석이름지정
	$(".info.seat > .row.seat_name > .data").text($("#seats_list > .rows > .row .seat.selected:eq(0)" ).find(".sreader").text());
	var seats = "";
	//좌석 지정
	$(".seat_group > div > .seat.selected").each(function(i){
		seats += $(this).parents(".row").find(".label").text()+ $(this).attr("data-index")+ " ";
	});
	$(".info.seat > .row.seat_no > .data").text(seats);
	
	//가격 지정
	var price = new Array();
	var vip = selectedGrade.match(/VIP/g);
	var r = selectedGrade.match(/R/g);
	var s = selectedGrade.match(/S/g);
	//var price = vip.lenght*10000 + r.lenght*9000 + s.lenght*8000;
	
	var ttt;
	   if($(".time-list .theater > ul > li").hasClass("night")){ttt = "night";}
	   else if($(".time-list .theater > ul > li").hasClass("morning")){ttt = "morning";}
	   if(vip != null){
	      price += vip.length * 10000;
	   if(ttt=="night"){price-= vip.length*3000}
	   if(ttt=="morning"){price-= vip.length*5000}
	   }else if( r != null){
	      price += r.length * 9000;
	   if(ttt=="night"){price-= r.length*3000}
	   if(ttt=="morning"){price-= r.length*5000}
	   }else if(s != null){
	      price += s.length * 8000;
	   if(ttt=="night"){price-= s.length*3000}
	   if(ttt=="morning"){price-= s.length*5000}
	   }
	
	//현재는 어른일경우에만 적용
	$(".row.payment-adult > span.data > span.price").text(price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	
	//총 금액
	$(".row.payment-final").css("display", "block");
	$(".row.payment-final > span.data > span.price").text(price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	
	//버튼 활성화
	$("#tnb_step_btn_right").addClass("on");
});


/*-===================================================================
 * step2 다시하기
 */
function ftResetAllSeats(){
	
	$(".group.adult > ul > li ").removeClass("selected");
	$(".seat_group > div > .seat").removeClass("selected");
	
	//bottombar
	$(".info.seat div").css("display", "none");
	$(".row.payment-adult").css("display", "none");
	$("div[class='placeholder'][title='좌석선택'] ").css("display","block");
	$(".row.payment-final").css("display", "none");
	$(".row.number > span.data").text('');
	
	//인원선택
	$(".group.adult > ul > li ").removeClass("selected");
	$(".section-seat").addClass("dimmed");
	
}
/*-===================================================================
 * 결제창 할인수단 reset
 */
function ticketStep3Step1Reset(){
	
	
}

/*-===================================================================
 * step3 step1 펼치기, 닫기
 */
$(document).on("click",".tpm_header", function(event){
	//펼치기 부분 이벤트 전파하여 전체 바 클릭시 opened 클래스 추가 할 것
	 event.stopPropagation();
	//현재 클래스가 opened를 가지고있으면(열려있는 상태라면)
	if($(this).parent().hasClass("opened")){
		$(this).parent().removeClass("opened")
		//span의 글자를 펼치기로 바꾸기
		$(this).find("tpmh_btn").text("펼치기");
	}else{
		$(this).parent().addClass("opened")
		//span의 글자를 펼치기로 바꾸기
		$(this).find("tpmh_btn").text("닫기");
	}
	
	//summary_discount_total 최종 할인금액
});


/*-===================================================================
 * step3 step2 결제수단 정하기
 */
$(document).on("click","input[name='last_pay_radio']", function(event){
	var payment = $("input[name='last_pay_radio']:checked").attr("value");
	
	if(payment=="0"){
		//신용카드
		//payment_card
		$(".payment_input").css("display", "none");
		$(".payment_input.payment_card").css("display", "block");
	}else if(payment == "1"){
		$(".payment_input").css("display", "none");
		$(".payment_input.payment_phone").css("display", "block");
		//payment_phone
	}else if(payment == "2"){
		//payment_transfer
		$(".payment_input").css("display", "none");
		$(".payment_input.payment_transfer").css("display", "block");
	}

});

/*-===================================================================
 * step3 내역확인 팝업창 닫기
 */
$(document).on("click",".layer_close", function(event){
	$(".ft_layer_popup.popup_reservation_check").css("display", "none");
});


/*-===================================================================
 * step3 약관 모두 동의(팝업)
 */
$(document).on("click",".inputModel:eq(0)", function(event){
	$(".inputModel").attr("checked", "checked");
});

/*-===================================================================
 * step3 예매 결제하기(팝업)
 */
$(document).on("click",".ft a.reservation", function(event){
	
	//약관에 모두 동의했는지 확인 필요
	
	
	//팝업창 닫기
	$(".ft_layer_popup.popup_reservation_check").css("display", "none");
	
	//정보를 다른 방식으로 다룰 방법이 없을까
	var viewdate = $(".day.selected").attr("date");
	var mo_num = $(".movie-list > ul > li[class*='selected']").attr("movie_num");
	var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
	var screen_name = $(".info.theater .row.screen .data").text();
	var seat_no = $(".info.theater .row.number .data").text();
	var price = $("#summary_payment_total").text();
	var seat = $(".info.seat .row.seat_no .data").text();
	var time = $(".time-list li.selected").attr("play_start_tm");
	
	//예매내역 테이블로 넣기
	jQuery.ajax({
        type:"POST",
        url:"./makeReservation.rs",
        async : false,
        data:"mnum="+1+"&pcode="+pcode+"&mo_num="+mo_num+"&screen_name="+screen_name+
        		"&viewdate="+viewdate+"&seat_no="+seat_no+"&price="+price+"&seat="+seat+"&time="+time,
        dataType:"JSON",
        success : function(data) {
        	//예매 정보 받아오기
        	
        },
        complete : function(data) {
              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
        },
        error : function(xhr, status, error) {
              alert("getPlayingMonum date 에러발생");
        }
 	 });
	
	$(".step.step3").css("display", "none");
	$(".tnb.step3").removeClass("step3").addClass("step4");
	$(".step4").css("display", "block");
	$(".tnb_container").css("display", "none");
	
});

