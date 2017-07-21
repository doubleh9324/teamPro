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
 * 
 * @param event
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
		
		window.alert("얍");
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
	        		
	        		timeStr = "<li id='test' data-index='"+i+"' data-remain_seat='"+value.capacity+"' play_start_tm='"+value.ptime.replace(':','')+
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
 * 좌석선택 넘어가기 버튼
 */

function OnTnbRightClick(){
	//우선 앞의 모든 항목들이 체크되어 있는지 확인 필요
	
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

