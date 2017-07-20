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
	
	//요일에 따른 클래스 추가
	$(".dayweek").each(function(i){
		if($(this).text() == '토'){
			$(this).parent().parent().addClass('day-sat');
		}else if($(this).text() == '일'){
			$(this).parent().parent().addClass('day-sun');
		}
	});
	
});


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
		
	$(".area_theater_list > ul > div > li").each(function(i){
		if($(this).hasClass("rating-18"))
			isSelectedTheater = true;
		console.log(isSelectedTheater);
	});
	
	$(".movie-list > ul > li").each(function(i){
		if($(this).hasClass("selected"))
			isSelectedMovie = true;
		console.log(isSelectedTheater);
	});
	
	
	//영화, 상영관이 선택되지 않았으면
	if(!isSelectedMovie && !isSelectedTheater){
		
		window.alert("수정");
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
		    		
		    		
		    		// 

		    		
		    		window.alert($(".area_theater_list > ul > li[class='selected']").attr("data-index"));
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
	 	 
	 	 
	}else if(!isSelectedMovie && isSelectedTheater){
		//영화선택없고 상영관만 선택되어있으면
		//선택된 상영관이 해당 날짜에 상연이 있으면 그대로 두고 (dimmed추가, 순서 재정렬만) 
		//상연이 없으면 selected 제거하기
		
	}
});
