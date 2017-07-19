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
	
	console.log(event.target.id);
	 $("#"+event.target.id).parent().addClass("selected");
	 console.log($("#"+event.target.id).parent().id);
	 
	 
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
				//i번째 li의  p_code값이 목록에 존재하는 pcode값과 같지 않으면 dimmed추가
				//같은게 생기면 break;
				
				//	window.alert($("li[p_code="+p[i]+"]").attr("data-index"));
					if($("li[p_code="+value.p_code+"]").hasClass("dimmed"))
						{$("li[p_code="+value.p_code+"]").removeClass("dimmed");
						}else
							$("li[p_code="+value.p_code+"]").addClass("dimmed");
                });

	    		//총 카운트 지정하기
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
	    		
	    		
	    		//현재 상영중인 영화관만 상위 목록으로 올리기
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
    
	//해당 영화에 대한 정보 받아오기
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
// TODO
$(document).on("click",".date-list > ul > div > li > a ", function(){
	//선택하지 않은 날짜들 클래스 제거
	$(".date-list > ul > div > li.selected").removeClass("selected");
	
	//선택한 날짜 클래스 추가
	$(this).parent().addClass("selected");
	
	var pdate = $(".date-list > ul > div > li.selected").attr("date");
	
	var vdate = pdate.substring(0,4)+"년 "+pdate.substring(4,6)+"월 "+pdate.substring(6)+"일";
	
	//극장 글자 block, 극장이름 띄우기
	$(".theater div").css("display", "block");
	//극장선택 글씨 none
	$("div[class='placeholder'][title='극장선택'] ").css("display","none");

	//bottom bar 날짜 지정
	$(".row.date span[class='data']").text(vdate);

	
	//앞의 영화, 상영관이 선택되지 않은 경우에 날짜를 선택하면 해당 날짜에 상영하는 영화가 있는 상영관만 표시하기
	if(!$(".area_theater_list > ul > div > li").hasClass("selected")){
	
		jQuery.ajax({
	        type:"POST",
	        url:"./getPlayingPcode.rs",
	        data:"val="+pdate+"&flag="+"date",
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
					//i번째 li의  p_code값이 목록에 존재하는 pcode값과 같지 않으면 dimmed추가
					//같은게 생기면 break;
					
					//	window.alert($("li[p_code="+p[i]+"]").attr("data-index"));
						if($("li[p_code="+value.p_code+"]").hasClass("dimmed"))
							{$("li[p_code="+value.p_code+"]").removeClass("dimmed");
							}else
								$("li[p_code="+value.p_code+"]").addClass("dimmed");
	                });
	
		    		//총 카운트 지정하기
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
		    		
		    		//현재 상영중인 영화관만 상위 목록으로 올리기
	        },
	        complete : function(data) {
	              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	        },
	        error : function(xhr, status, error) {
	              alert("에러발생");
	        }
	 	 });
	}
});
