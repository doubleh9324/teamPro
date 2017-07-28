<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko" xml:lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<head id="ctl00_Head1">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="No-Cache" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="keywords" content="CGV, 시지브이, 영화관, 극장, 영화, 티켓, 박스오피스, 극장, Movie, Theater, Cinema, Cgv, cgv, 예매, 상영작" />
<meta name="description" content="영화 그 이상의 감동. CGV" />
<title>TicketLion 영화예매</title>
<link rel="stylesheet" href="http://img.cgv.co.kr/CGV_RIA/Ticket/Common/css/2017/06/CGV_YS/common.css" />
<link rel="stylesheet" href="css/reservation.css">
<link rel="stylesheet" href="css/reservation_step3.css">

<link rel="stylesheet" href="http://img.cgv.co.kr/CGV_RIA/Ticket/Common/css/2017/06/CGV_YS/reservation_tnb.css" />
<link rel="stylesheet" href="http://img.cgv.co.kr/CGV_RIA/Ticket/Common/css/2017/06/CGV_YS/reservation_popup.css" />
<link rel="stylesheet" href="http://img.cgv.co.kr/CGV_RIA/Ticket/Common/css/2017/06/CGV_YS/reservation_step3_special.css" />
<link rel="stylesheet" href="http://img.cgv.co.kr/CGV_RIA/Ticket/Common/css/2017/06/CGV_YS/reservation_step3_step1.css" />
<link rel="stylesheet" href="http://img.cgv.co.kr/CGV_RIA/Ticket/Common/css/2017/06/CGV_YS/reservation_step3_step2.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript" src="js/reservation.js"></script>
<script for="window" event="onunload" language="javascript">
browser_Event();
</script>

</head>

<body>
<a name="t"></a>
<div id="wrap" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<!-- 컨텐츠 -->
	<div id="container">
		<!-- 빠른예매 -->
		<div id="ticket" class="ticket ko">
			
			<!-- 타이틀 -->
			<div class="navi">
				<div  class="newsletter">
					<p><a href="#">Click here</a> if you want to receive newsletter about English subtitle movies</p>
				</div>
				<span class="right">
				
					<a class="button button-english" href="#" onmousedown="javascript:logClick('옵션/ENGLISH');" onclick="switchLanguage(); return false;"><span>ENGLISH</span></a>
					<a class="button button-guide" href="#" onmousedown="javascript:logClick('옵션/예매가이드');" onclick="ticketPopupShow('popup_guide'); return false;"><span>예매가이드 - 레이어로 서비스 되기 때문에 가상커서를 해지(Ctrl+Shift+F12)한 후 사용합니다.</span></a>
					<a class="button button-discount" href="#" onmousedown="javascript:logClick('옵션/제휴할인혜택');" onclick="ticketNewWindow('http://section.cgv.co.kr/discount/Special/discount/Default.aspx');return false;" title="새창열기"><span>제휴할인혜택</span></a>
					<a class="button button-schedule" href="#" onmousedown="javascript:logClick('옵션/상영시간표');" onclick="openSchedulePopup();return false;" title="새창열기"><span>상영시간표</span></a>
					<a class="button button-reservation-restart" href="#" onmousedown="javascript:logClick('옵션/예매다시하기');" onclick="ticketRestart(); return false;"><span>예매 다시하기</span></a>
				
				</span>
				<div class="ie7_sucks" id="ie7_sucks"><span>Internet Explorer 9 이상에서 최적화된 서비스 이용이 가능합니다.</span></div>
			</div>
			<!-- //타이틀 -->
			<!-- 메인컨텐츠 -->
			<div class="steps">
				<!-- step1 -->
				<div class="step step1 ">
					<!-- MOVIE 섹션 -->
					<div class="section section-movie">
						<!-- col-head -->
						<div class="col-head" id="skip_movie_list">
							<h3 class="sreader">영화</h3>
							<a href="#" class="skip_to_something" onclick="skipToSomething('skip_theater_list');return false;">영화선택 건너뛰기</a>
						</div>
						<!-- col-body -->
						<div class="col-body">
							<!-- 영화선택 -->
							<div class="movie-select">
							
							
							<%-- 
								<div class="tabmenu">
									<span class="side on"></span>
									<a href="#" class="button menu1 selected">전체</a>
									<span class="side on"></span>
									<a href="#" class="button menu2">아트하우스<span class="arrow"></span></a>
									<div class="tabmenu-selectbox MOVIECOLLAGE" style="display:none;">
										<ul>
											<li><a href="#" onclick="return false;">전체</a></li>
											<li><a href="#" onclick="return false;">최신작</a></li>
										</ul>
									</div>
									<span class="side"></span>
									<a href="#" onclick="return false;" class="button menu3">특별관<span class="arrow"></span></a>
									<div class="tabmenu-selectbox SPECIALTHEATER" style="display:none;">
										<ul>
											<li><a href="#" onclick="return false;">전체</a></li>
											<li><a href="#" onclick="return false;">4DX</a></li>
											<li><a href="#" onclick="return false;">IMAX</a></li>
											<li><a href="#" onclick="return false;">STARIUM</a></li>
											<li><a href="#" onclick="return false;">CINE DE CHEF</a></li>
											<li><a href="#" onclick="return false;">GOLD CLASS</a></li>
											<li><a href="#" onclick="return false;">Brand관</a></li>
											<li><a href="#" onclick="return false;">Premium관</a></li>
											<li><a href="#" onclick="return false;">CINE KIDS</a></li>
										</ul>
									</div>
									<span class="side"></span>
								</div>
								
								--%>
								
								
								<div class="sortmenu">
									<a href="#" onclick="sortMovieByRank();return false;" id="movieSortRankBtn" class="button btn-rank selected">예매율순</a>
									<a href="#" onclick="sortMovieByName();return false;" id="movieSortNameBtn" class="button btn-abc">가나다순</a>
								</div>
								
								<!-- 영화 리스트 -->
								<div class="movie-list nano" id="movie_list">
									<ul class="content scroll-y" onscroll="movieSectionScrollEvent();">
									
									<c:set var="index" value="0"/>
            	   
			                    	<c:forEach var="value" items="${movieList}" varStatus="status">
			                    		<!-- 관람가 정하기 -->
			                    		<c:choose>
			                    			<c:when test="${value.age eq 'all' }">
			                    				<c:set var="rating" value="rating-all"/>
			                    			</c:when>
			                    			<c:when test="${value.age eq '12' }">
			                    				<c:set var="rating" value="rating-12"/>
			                    			</c:when>
			                    			<c:when test="${value.age eq '15' }">
			                    				<c:set var="rating" value="rating-15"/>
			                    			</c:when>
			                				<c:when test="${value.age eq '18' }">
			                    				<c:set var="rating" value="rating-18"/>
			                    			</c:when>
			                    		</c:choose>
		                        		<li class="${rating }" data-index="${index }" movie_num="${ value.movie_num}">
										<a id = "${index }" href='#' onclick="return false;"><span class="icon">&nbsp;</span>
										<span class="text">${value.name} </span><span class="sreader"></span></a></li>
										
										<c:set var="index" value="${index + 1}"/>
										
			                    	</c:forEach>
			                    	
			                    	
									</ul>
								</div>
								<div class="selectbox-movie-type" style="display:none;">
									<a href="#" onclick="closeSelectboxMovieType();return false;" class="btn-close">영화속성 레이어 닫기</a>
									<ul>
										<li id="sbmt_all" class="GROUP1 ALL"><a data-type="ALL" href="#" onclick="SelectboxMovieTypeClickListener(event);return false;">전체</a></li>
										<li id="sbmt_digital" class="GROUP1 DIGITAL proplist"><a data-type="DIGITAL" href="#" onclick="SelectboxMovieTypeClickListener(event);return false;">2D</a></li>
										<li id="sbmt_imax" class="GROUP1 IMAX proplist"><a data-type="IMAX" href="#" onclick="SelectboxMovieTypeClickListener(event);return false;">IMAX</a></li>
										<li id="sbmt_4dx" class="GROUP1 4DX proplist"><a data-type="4DX" href="#" onclick="SelectboxMovieTypeClickListener(event);return false;">4DX</a></li>
										<li id="sbmt_soundx" class="GROUP1 SOUNDX proplist"><a data-type="SOUNDX" href="#" onclick="SelectboxMovieTypeClickListener(event);return false;">SOUNDX</a></li>
										<li id="sbmt_screenx" class="GROUP1 SCREENX proplist"><a data-type="SCREENX" href="#" onclick="SelectboxMovieTypeClickListener(event);return false;">SCREENX</a></li>
										<li id="sbmt_3d" class="GROUP1 3D proplist"><a data-type="3D" href="#" onclick="SelectboxMovieTypeClickListener(event);return false;">3D</a></li>
										<li id="sbmt_dubbing" class="GROUP2 DUBBING proplist"><a data-type="DUBBING" href="#" onclick="SelectboxMovieTypeClickListener(event);return false;">더빙</a></li>
										<li id="sbmt_subtitle" class="GROUP2 SUBTITLES proplist"><a data-type="SUBTITLES" href="#" onclick="SelectboxMovieTypeClickListener(event);return false;">자막</a></li>
										<li id="sbmt_lovemom" class="GROUP3 LOVEMOM proplist"><a data-type="LOVEMOM" href="#" onclick="SelectboxMovieTypeClickListener(event);return false;">러브맘</a></li>
										<li id="sbmt_liveTalk" class="GROUP3 LIVETALK proplist"><a data-type="LIVETALK" href="#" onclick="SelectboxMovieTypeClickListener(event);return false;">스타라이브톡</a></li>
										<li id="sbmt_wheelchairAccess" class="GROUP3 WHEELCHAIRACCESS proplist"><a data-type="WHEELCHAIRACCESS" href="#" onclick="SelectboxMovieTypeClickListener(event);return false;">배리어프리</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<!-- THEATER 섹션 -->
					<div class="section section-theater">
						<!-- col-head -->
						<div class="col-head" id="skip_theater_list">
							<h3 class="sreader">극장</h3>
							<a href="#" class="skip_to_something" onclick="skipToSomething('skip_date_list');return false;">극장선택 건너뛰기</a>
						</div>
						<!-- col-body -->
						<div class="col-body">
							<!-- 자주가는 CGV -->
							<div class="favorite_cgv" id="favorite_cgv">
								<p class="tit"></p>
								<p class="setting" style="display:none;"><a href="#" onclick="favoriteCGVSettingClickListener();return false;" class="btn_setting">설정 &gt;</a></p>
								<ul class="theaters"></ul>
								<div class="nolist">자주가는 CGV를<br>등록해주세요</div>
							</div>
							<!-- 극장선택 -->
							<div class="theater-select">
								<div class="tabmenu">
									<span class="side on"></span>
									<a href="#" onclick="return false;" class="button menu1 selected">전체</a>
									<span class="side on"></span>
									<a href="#" onclick="return false;" class="button menu2"></a>
									<span class="side"></span>
									<a href="#" onclick="return false;" class="button menu3"></a>
									<span class="side"></span>
								</div>
								<!-- 영화관 리스트 -->
								<div class="theater-list">
									<div class="theater-area-list" id="theater_area_list">
										<ul>
										
										<c:set var="areaindex" value="1"/>
										<c:set var="dataindex" value="1"/>
										
										<!-- 지역명  -->
										<c:forEach var="location" items="${locationList }" varStatus="status">
											<li>
												<a id="${location.l_code }" href="#" onclick="theaterAreaClickListener(event);return false;">
												${location.location }(<span>${location.count }</span>)</a>
												
												<!-- 지역상세 -->
												<div class="area_theater_list nano" >
												
													<ul class="content scroll-y">
														<c:forEach var="place" items="${placeList}" varStatus="status">
															<c:if test="${fn:contains(location.l_code, place.l_code) }">
																<li class="" data-index="${dataindex }" areaindex="${areaindex }" p_code="${place.p_code }" rating_cd="undefined" style="display: list-item;">
																<a id="${place.p_code }"href="#" onclick="theaterListClickListener(event);return false;">${place.name }<span class="sreader"></span></a></li>
																<c:set var="dataindex" value="${dataindex + 1 }"/>
															</c:if>
														
														</c:forEach>
													</ul>
													<div class="pane pane-y" style="display: block; opacity: 1; visibility: visible;"><div class="slider slider-y" style="height: 50px; top: 0px;"></div></div>
													<div class="pane pane-x" style="display: none; opacity: 1; visibility: visible;"><div class="slider slider-x" style="width: 50px;"></div></div>
												</div>
											</li>
											
											<c:set var="areaindex" value="${areaindex + 1 }"/>
										</c:forEach>	
												
										</ul>
									</div>
									<div class="theater-cgv-list nano" id="theater_cgv_list">
										<ul class="content scroll-y"></ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- DATE 섹션 -->
					<div class="section section-date">
						<div class="col-head" id="skip_date_list">
							<h3 class="sreader">날짜</h3>
							<a href="#" onclick="return false;" class="skip_to_something" onclick="skipToSomething('skip_time_list');return false;">날짜 건너뛰기</a>
						</div>
						<div class="col-body">
							<!-- 날짜선택 -->
							<div class="date-list nano" id="date_list">
								<ul class="content scroll-y">
									<div>
										<c:set var="dindex" value="1"/>
										<c:forEach var="playday" items="${playdayList}" varStatus="status">
											<c:if test="${playday.month != preMonth }">
												<li class="month dimmed">
													<div>
														<span class="year">${playday.year }</span>
														<span class="month">${playday.month }</span>
														<div></div>
													</div>
												</li>
											</c:if>
											<li data-index="${dindex }" date="${playday.pday }" class="day">
												<a href="#" onclick="return false;">
													<span class="dayweek">${fn:substring(playday.dayname,0,2) }</span>
													<span class="day">${playday.day }</span>
													<span class="sreader"></span>
												</a>
											</li>
												<c:set var="dindex" value="${dindex + 1 }"/>
												<c:set var="preMonth" value="${playday.month }"/>
										</c:forEach>								
									</div>
								</ul>
							</div>
						</div>
					</div>
					<!-- TIME 섹션 -->
					<div class="section section-time">
						<div class="col-head" id="skip_time_list">
							<h3 class="sreader">시간</h3>
							<a href="#" class="skip_to_something" onclick="skipToSomething('tnb_step_btn_right');return false;">시간선택 건너뛰기</a>
						</div>
						<div class="col-body">
							<!-- 시간선택 -->
							<div class="time-option">
								<span class="morning">조조</span>
								<span class="night">심야</span>
							</div>
							<div class="placeholder">영화, 극장, 날짜를 선택해주세요.</div>
							<div class="time-list nano has-scrollbar">
								<div class="content scroll-y" tabindex="-1" style="right: -17px;">
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- //step1 -->
				<!-- step2 -->
				<div class="step step2" >
					<!-- SEAT 섹션 -->
					<div class="section section-seat">
						<div class="col-head" id="skip_seat_list">
							<h3 class="sreader">
								인원 / 좌석
								<span class="sreader">인원/좌석선택은 레이어로 서비스 되기 때문에 가상커서를 해지(Ctrl+Shift+F12)한 후 사용합니다.</span>
							</h3>
							<a href="#" class="skip_to_something" onclick="skipToSomething('tnb_step_btn_right');return false;">인원/좌석선택 건너뛰기</a>
						</div>
						<div class="col-body">
							<div class="person_screen">
								<!-- NUMBEROFPEOPLE 섹션 -->
								<div class="section section-numberofpeople">
									<div class="col-body">
										<div class="numberofpeople-select">
											<div class="group adult" id="nop_group_adult">
												<span class="title">일반</span>
												<ul>
													<li data-count="0" class="selected"><a href="#" onclick="return false;"><span class="sreader mod">일반</span>0<span class='sreader'>명</span></a></li>
													<li data-count="1"><a href="#" onclick="return false;"><span class="sreader mod">일반</span>1<span class='sreader'>명</span></a></li>
													<li data-count="2"><a href="#" onclick="return false;"><span class="sreader mod">일반</span>2<span class='sreader'>명</span></a></li>
													<li data-count="3"><a href="#" onclick="return false;"><span class="sreader mod">일반</span>3<span class='sreader'>명</span></a></li>
													<li data-count="4"><a href="#" onclick="return false;"><span class="sreader mod">일반</span>4<span class='sreader'>명</span></a></li>
													<li data-count="5"><a href="#" onclick="return false;"><span class="sreader mod">일반</span>5<span class='sreader'>명</span></a></li>
													<li data-count="6"><a href="#" onclick="return false;"><span class="sreader mod">일반</span>6<span class='sreader'>명</span></a></li>
													<li data-count="7"><a href="#" onclick="return false;"><span class="sreader mod">일반</span>7<span class='sreader'>명</span></a></li>
													<li data-count="8"><a href="#" onclick="return false;"><span class="sreader mod">일반</span>8<span class='sreader'>명</span></a></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
								<!-- 인접좌석 -->
								<div class="adjacent_seat_wrap">
									<div class="adjacent_seat" id="adjacent_seat">
										<span class="title">좌석 붙임 설정</span>
										<div class="block_wrap">
											<span class="seat_block block1"><label><input type="radio" name="adjacent_seat" onclick="ftSetAdjacentSeatSelector(1, this);" disabled><span class="box"></span><span class="sreader">1석 좌석붙임</span></label></span>
											<span class="seat_block block2"><label><input type="radio" name="adjacent_seat" onclick="ftSetAdjacentSeatSelector(2, this);" disabled><span class="box"></span><span class="box"></span><span class="sreader">2석 좌석붙임</span></label></span>
											<span class="seat_block block3"><label><input type="radio" name="adjacent_seat" onclick="ftSetAdjacentSeatSelector(3, this);" disabled><span class="box"></span><span class="box"></span><span class="box"></span><span class="sreader">3석 좌석붙임</span></label></span>
											<span class="seat_block block4"><label><input type="radio" name="adjacent_seat" onclick="ftSetAdjacentSeatSelector(4, this);" disabled><span class="box"></span><span class="box"></span><span class="box"></span><span class="box"></span><span class="sreader">4석 좌석붙임</span></label></span>
										</div>
									</div>
								</div>
								<!-- NUMBEROFPEOPLE 섹션 -->
								<div class="section section-screen-select">
									<!-- UI 변경으로 삭제 
									<div class="title">선택하신 상영관<span>/</span>시간</div>
									-->
									<!-- UI 변경
									<div class="screen-time">
										<span class="screen"><b></b></span>
										<span class="seats seat_all"></span>
										<span class="time"></span>
										<span class="seats seat_remain"></span>
									</div>
									-->
									<div id="user-select-info">
										<p class="theater-info">
											<span class="site"></span>
											<span class="screen"></span>
											<span class="seatNum"> <b class="restNum">100</b>/<b class="totalNum">900</b></span>
										</p>
										<p class="playYMD-info"></p>
									</div>	
									<a class="change_time_btn" href="#" onmousedown="if(event.stopPropagation){event.stopPropagation();}return false;" onclick="ticketStep2TimeSelectPopupShow();return false;"><span>상영시간 변경하기</span></a>
								</div>
							</div>
							<!-- THEATER -->
							<div class="theater_minimap">
								<div class="theater nano" id="seat_minimap_nano">
									<div class="content">
										<div class="screen" title="SCREEN"><span class="text"></span></div>
										<div class="seats" id="seats_list" style="width: 240px; height: 192px;">
											<div class="rows">
												<div class="row" style="top:0px;">
												<div class="label">A</div>
												<a href="#" onclick="skipToNextRow(event);return false;" class="skip_row">A열 건너뛰기</a>
												<div class="seat_group left">
													<div class="group">
														<div class="seat handicap" style="left:64px" data-left="64" data-left_zoom="96">
															<a href="#" "="" onclick="return false;">
																<span class="no">3</span>
																<span class="sreader"> 장애인석</span>
																<span class="sreader mod"></span>
															</a>
														</div>
														<div class="seat handicap" style="left:80px" data-left="80" data-left_zoom="120">
															<a href="#" "="" onclick="return false;">
																<span class="no">4</span>
																<span class="sreader"> 장애인석</span>
																<span class="sreader mod"></span>
															</a>
														</div>
													</div>
												</div>
												<div class="seat_group">
												<div class="group">
												<div class="seat rating_economy" style="left:128px" data-left="128" data-left_zoom="192">
													<a href="#" "="" onclick="return false;">
														<span class="no">7</span>
														<span class="sreader"> Economy</span>
														<span class="sreader mod"></span>
													</a>
												</div>
												<div class="seat rating_economy" style="left:144px" data-left="144" data-left_zoom="216">
												<a href="#" "="" onclick="return false;"><span class="no">8</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:160px" data-left="160" data-left_zoom="240"><a href="#" "="" onclick="return false;"><span class="no">9</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:176px" data-left="176" data-left_zoom="264"><a href="#" "="" onclick="return false;"><span class="no">10</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:192px" data-left="192" data-left_zoom="288"><a href="#" "="" onclick="return false;"><span class="no">11</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:208px" data-left="208" data-left_zoom="312"><a href="#" "="" onclick="return false;"><span class="no">12</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:224px" data-left="224" data-left_zoom="336"><a href="#" "="" onclick="return false;"><span class="no">13</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div></div></div></div><div class="row" style="top:16px;"><div class="label">B</div><a href="#" onclick="skipToNextRow(event);return false;" class="skip_row">B열 건너뛰기</a><div class="seat_group"><div class="group"><div class="seat rating_economy" style="left:64px" data-left="64" data-left_zoom="96"><a href="#" "="" onclick="return false;"><span class="no">3</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:80px" data-left="80" data-left_zoom="120"><a href="#" "="" onclick="return false;"><span class="no">4</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:96px" data-left="96" data-left_zoom="144"><a href="#" "="" onclick="return false;"><span class="no">5</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:112px" data-left="112" data-left_zoom="168"><a href="#" "="" onclick="return false;"><span class="no">6</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:128px" data-left="128" data-left_zoom="192"><a href="#" "="" onclick="return false;"><span class="no">7</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:144px" data-left="144" data-left_zoom="216"><a href="#" "="" onclick="return false;"><span class="no">8</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:160px" data-left="160" data-left_zoom="240"><a href="#" "="" onclick="return false;"><span class="no">9</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:176px" data-left="176" data-left_zoom="264"><a href="#" "="" onclick="return false;"><span class="no">10</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:192px" data-left="192" data-left_zoom="288"><a href="#" "="" onclick="return false;"><span class="no">11</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:208px" data-left="208" data-left_zoom="312"><a href="#" "="" onclick="return false;"><span class="no">12</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div><div class="seat rating_economy" style="left:224px" data-left="224" data-left_zoom="336"><a href="#" "="" onclick="return false;"><span class="no">13</span><span class="sreader"> Economy</span><span class="sreader mod"></span></a></div></div></div></div><div class="row" style="top:32px;"><div class="label">C</div><a href="#" onclick="skipToNextRow(event);return false;" class="skip_row">C열 건너뛰기</a><div class="seat_group"><div class="group reserved"><div class="seat reserved rating_comfort" style="left:64px" data-left="64" data-left_zoom="96"><a href="#" "="" onclick="return false;"><span class="no">3</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:80px" data-left="80" data-left_zoom="120"><a href="#" "="" onclick="return false;"><span class="no">4</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div></div><div class="group"><div class="seat rating_comfort" style="left:96px" data-left="96" data-left_zoom="144"><a href="#" "="" onclick="return false;"><span class="no">5</span><span class="sreader"> Comfort</span><span class="sreader mod"></span></a></div><div class="seat rating_comfort" style="left:112px" data-left="112" data-left_zoom="168"><a href="#" "="" onclick="return false;"><span class="no">6</span><span class="sreader"> Comfort</span><span class="sreader mod"></span></a></div></div><div class="group reserved"><div class="seat reserved rating_comfort" style="left:128px" data-left="128" data-left_zoom="192"><a href="#" "="" onclick="return false;"><span class="no">7</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:144px" data-left="144" data-left_zoom="216"><a href="#" "="" onclick="return false;"><span class="no">8</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:160px" data-left="160" data-left_zoom="240"><a href="#" "="" onclick="return false;"><span class="no">9</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:176px" data-left="176" data-left_zoom="264"><a href="#" "="" onclick="return false;"><span class="no">10</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div></div><div class="group"><div class="seat rating_comfort" style="left:192px" data-left="192" data-left_zoom="288"><a href="#" "="" onclick="return false;"><span class="no">11</span><span class="sreader"> Comfort</span><span class="sreader mod"></span></a></div><div class="seat rating_comfort" style="left:208px" data-left="208" data-left_zoom="312"><a href="#" "="" onclick="return false;"><span class="no">12</span><span class="sreader"> Comfort</span><span class="sreader mod"></span></a></div><div class="seat rating_comfort" style="left:224px" data-left="224" data-left_zoom="336"><a href="#" "="" onclick="return false;"><span class="no">13</span><span class="sreader"> Comfort</span><span class="sreader mod"></span></a></div></div></div></div><div class="row" style="top:48px;"><div class="label">D</div><a href="#" onclick="skipToNextRow(event);return false;" class="skip_row">D열 건너뛰기</a><div class="seat_group"><div class="group reserved"><div class="seat reserved rating_comfort" style="left:64px" data-left="64" data-left_zoom="96"><a href="#" "="" onclick="return false;"><span class="no">3</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:80px" data-left="80" data-left_zoom="120"><a href="#" "="" onclick="return false;"><span class="no">4</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:96px" data-left="96" data-left_zoom="144"><a href="#" "="" onclick="return false;"><span class="no">5</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:112px" data-left="112" data-left_zoom="168"><a href="#" "="" onclick="return false;"><span class="no">6</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:128px" data-left="128" data-left_zoom="192"><a href="#" "="" onclick="return false;"><span class="no">7</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:144px" data-left="144" data-left_zoom="216"><a href="#" "="" onclick="return false;"><span class="no">8</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:160px" data-left="160" data-left_zoom="240"><a href="#" "="" onclick="return false;"><span class="no">9</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:176px" data-left="176" data-left_zoom="264"><a href="#" "="" onclick="return false;"><span class="no">10</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:192px" data-left="192" data-left_zoom="288"><a href="#" "="" onclick="return false;"><span class="no">11</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:208px" data-left="208" data-left_zoom="312"><a href="#" "="" onclick="return false;"><span class="no">12</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:224px" data-left="224" data-left_zoom="336"><a href="#" "="" onclick="return false;"><span class="no">13</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div></div></div></div><div class="row" style="top:64px;"><div class="label">E</div><a href="#" onclick="skipToNextRow(event);return false;" class="skip_row">E열 건너뛰기</a><div class="seat_group"><div class="group reserved"><div class="seat reserved rating_comfort" style="left:64px" data-left="64" data-left_zoom="96"><a href="#" "="" onclick="return false;"><span class="no">3</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:80px" data-left="80" data-left_zoom="120"><a href="#" "="" onclick="return false;"><span class="no">4</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:96px" data-left="96" data-left_zoom="144"><a href="#" "="" onclick="return false;"><span class="no">5</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:112px" data-left="112" data-left_zoom="168"><a href="#" "="" onclick="return false;"><span class="no">6</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:128px" data-left="128" data-left_zoom="192"><a href="#" "="" onclick="return false;"><span class="no">7</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:144px" data-left="144" data-left_zoom="216"><a href="#" "="" onclick="return false;"><span class="no">8</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:160px" data-left="160" data-left_zoom="240"><a href="#" "="" onclick="return false;"><span class="no">9</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:176px" data-left="176" data-left_zoom="264"><a href="#" "="" onclick="return false;"><span class="no">10</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:192px" data-left="192" data-left_zoom="288"><a href="#" "="" onclick="return false;"><span class="no">11</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:208px" data-left="208" data-left_zoom="312"><a href="#" "="" onclick="return false;"><span class="no">12</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:224px" data-left="224" data-left_zoom="336"><a href="#" "="" onclick="return false;"><span class="no">13</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div></div></div></div><div class="row" style="top:80px;"><div class="label">F</div><a href="#" onclick="skipToNextRow(event);return false;" class="skip_row">F열 건너뛰기</a><div class="seat_group"><div class="group reserved"><div class="seat reserved rating_comfort" style="left:64px" data-left="64" data-left_zoom="96"><a href="#" "="" onclick="return false;"><span class="no">3</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:80px" data-left="80" data-left_zoom="120"><a href="#" "="" onclick="return false;"><span class="no">4</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:96px" data-left="96" data-left_zoom="144"><a href="#" "="" onclick="return false;"><span class="no">5</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:112px" data-left="112" data-left_zoom="168"><a href="#" "="" onclick="return false;"><span class="no">6</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:128px" data-left="128" data-left_zoom="192"><a href="#" "="" onclick="return false;"><span class="no">7</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:144px" data-left="144" data-left_zoom="216"><a href="#" "="" onclick="return false;"><span class="no">8</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:160px" data-left="160" data-left_zoom="240"><a href="#" "="" onclick="return false;"><span class="no">9</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:176px" data-left="176" data-left_zoom="264"><a href="#" "="" onclick="return false;"><span class="no">10</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:192px" data-left="192" data-left_zoom="288"><a href="#" "="" onclick="return false;"><span class="no">11</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:208px" data-left="208" data-left_zoom="312"><a href="#" "="" onclick="return false;"><span class="no">12</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_comfort" style="left:224px" data-left="224" data-left_zoom="336"><a href="#" "="" onclick="return false;"><span class="no">13</span><span class="sreader"> 예매완료 Comfort</span><span class="sreader mod"> 선택불가</span></a></div></div></div></div><div class="row" style="top:96px;"><div class="label">G</div><a href="#" onclick="skipToNextRow(event);return false;" class="skip_row">G열 건너뛰기</a><div class="seat_group"><div class="group reserved"><div class="seat reserved rating_prime" style="left:64px" data-left="64" data-left_zoom="96"><a href="#" "="" onclick="return false;"><span class="no">3</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:80px" data-left="80" data-left_zoom="120"><a href="#" "="" onclick="return false;"><span class="no">4</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:96px" data-left="96" data-left_zoom="144"><a href="#" "="" onclick="return false;"><span class="no">5</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:112px" data-left="112" data-left_zoom="168"><a href="#" "="" onclick="return false;"><span class="no">6</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:128px" data-left="128" data-left_zoom="192"><a href="#" "="" onclick="return false;"><span class="no">7</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:144px" data-left="144" data-left_zoom="216"><a href="#" "="" onclick="return false;"><span class="no">8</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:160px" data-left="160" data-left_zoom="240"><a href="#" "="" onclick="return false;"><span class="no">9</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div></div><div class="group"><div class="seat rating_prime" style="left:176px" data-left="176" data-left_zoom="264"><a href="#" "="" onclick="return false;"><span class="no">10</span><span class="sreader"> prime zone Prime</span><span class="sreader mod"></span></a></div></div><div class="group reserved"><div class="seat reserved rating_prime" style="left:192px" data-left="192" data-left_zoom="288"><a href="#" "="" onclick="return false;"><span class="no">11</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:208px" data-left="208" data-left_zoom="312"><a href="#" "="" onclick="return false;"><span class="no">12</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:224px" data-left="224" data-left_zoom="336"><a href="#" "="" onclick="return false;"><span class="no">13</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div></div></div></div><div class="row" style="top:112px;"><div class="label">H</div><a href="#" onclick="skipToNextRow(event);return false;" class="skip_row">H열 건너뛰기</a><div class="seat_group"><div class="group reserved"><div class="seat reserved rating_prime" style="left:64px" data-left="64" data-left_zoom="96"><a href="#" "="" onclick="return false;"><span class="no">3</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:80px" data-left="80" data-left_zoom="120"><a href="#" "="" onclick="return false;"><span class="no">4</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:96px" data-left="96" data-left_zoom="144"><a href="#" "="" onclick="return false;"><span class="no">5</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:112px" data-left="112" data-left_zoom="168"><a href="#" "="" onclick="return false;"><span class="no">6</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:128px" data-left="128" data-left_zoom="192"><a href="#" "="" onclick="return false;"><span class="no">7</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:144px" data-left="144" data-left_zoom="216"><a href="#" "="" onclick="return false;"><span class="no">8</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:160px" data-left="160" data-left_zoom="240"><a href="#" "="" onclick="return false;"><span class="no">9</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:176px" data-left="176" data-left_zoom="264"><a href="#" "="" onclick="return false;"><span class="no">10</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:192px" data-left="192" data-left_zoom="288"><a href="#" "="" onclick="return false;"><span class="no">11</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:208px" data-left="208" data-left_zoom="312"><a href="#" "="" onclick="return false;"><span class="no">12</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:224px" data-left="224" data-left_zoom="336"><a href="#" "="" onclick="return false;"><span class="no">13</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div></div></div></div><div class="row" style="top:128px;"><div class="label">I</div><a href="#" onclick="skipToNextRow(event);return false;" class="skip_row">I열 건너뛰기</a><div class="seat_group left"><div class="group reserved"><div class="seat reserved" style="left:16px" data-left="16" data-left_zoom="24"><a href="#" "="" onclick="return false;"><span class="no">1</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved" style="left:32px" data-left="32" data-left_zoom="48"><a href="#" "="" onclick="return false;"><span class="no">2</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div></div></div><div class="seat_group"><div class="group reserved"><div class="seat reserved rating_prime" style="left:64px" data-left="64" data-left_zoom="96"><a href="#" "="" onclick="return false;"><span class="no">3</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:80px" data-left="80" data-left_zoom="120"><a href="#" "="" onclick="return false;"><span class="no">4</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:96px" data-left="96" data-left_zoom="144"><a href="#" "="" onclick="return false;"><span class="no">5</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:112px" data-left="112" data-left_zoom="168"><a href="#" "="" onclick="return false;"><span class="no">6</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:128px" data-left="128" data-left_zoom="192"><a href="#" "="" onclick="return false;"><span class="no">7</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:144px" data-left="144" data-left_zoom="216"><a href="#" "="" onclick="return false;"><span class="no">8</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:160px" data-left="160" data-left_zoom="240"><a href="#" "="" onclick="return false;"><span class="no">9</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:176px" data-left="176" data-left_zoom="264"><a href="#" "="" onclick="return false;"><span class="no">10</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:192px" data-left="192" data-left_zoom="288"><a href="#" "="" onclick="return false;"><span class="no">11</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:208px" data-left="208" data-left_zoom="312"><a href="#" "="" onclick="return false;"><span class="no">12</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:224px" data-left="224" data-left_zoom="336"><a href="#" "="" onclick="return false;"><span class="no">13</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div></div></div></div><div class="row" style="top:144px;"><div class="label">J</div><a href="#" onclick="skipToNextRow(event);return false;" class="skip_row">J열 건너뛰기</a><div class="seat_group left"><div class="group reserved"><div class="seat reserved" style="left:16px" data-left="16" data-left_zoom="24"><a href="#" "="" onclick="return false;"><span class="no">1</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved" style="left:32px" data-left="32" data-left_zoom="48"><a href="#" "="" onclick="return false;"><span class="no">2</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div></div></div><div class="seat_group"><div class="group reserved"><div class="seat reserved rating_prime" style="left:64px" data-left="64" data-left_zoom="96"><a href="#" "="" onclick="return false;"><span class="no">3</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:80px" data-left="80" data-left_zoom="120"><a href="#" "="" onclick="return false;"><span class="no">4</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:96px" data-left="96" data-left_zoom="144"><a href="#" "="" onclick="return false;"><span class="no">5</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:112px" data-left="112" data-left_zoom="168"><a href="#" "="" onclick="return false;"><span class="no">6</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:128px" data-left="128" data-left_zoom="192"><a href="#" "="" onclick="return false;"><span class="no">7</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:144px" data-left="144" data-left_zoom="216"><a href="#" "="" onclick="return false;"><span class="no">8</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:160px" data-left="160" data-left_zoom="240"><a href="#" "="" onclick="return false;"><span class="no">9</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:176px" data-left="176" data-left_zoom="264"><a href="#" "="" onclick="return false;"><span class="no">10</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:192px" data-left="192" data-left_zoom="288"><a href="#" "="" onclick="return false;"><span class="no">11</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:208px" data-left="208" data-left_zoom="312"><a href="#" "="" onclick="return false;"><span class="no">12</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved rating_prime" style="left:224px" data-left="224" data-left_zoom="336"><a href="#" "="" onclick="return false;"><span class="no">13</span><span class="sreader"> 예매완료 prime zone Prime</span><span class="sreader mod"> 선택불가</span></a></div></div></div></div><div class="row" style="top:160px;"><div class="label">K</div><a href="#" onclick="skipToNextRow(event);return false;" class="skip_row">K열 건너뛰기</a><div class="seat_group left"><div class="group reserved"><div class="seat reserved" style="left:16px" data-left="16" data-left_zoom="24"><a href="#" "="" onclick="return false;"><span class="no">1</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved" style="left:32px" data-left="32" data-left_zoom="48"><a href="#" "="" onclick="return false;"><span class="no">2</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div></div></div><div class="seat_group"><div class="group reserved"><div class="seat reserved" style="left:64px" data-left="64" data-left_zoom="96"><a href="#" "="" onclick="return false;"><span class="no">3</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved" style="left:80px" data-left="80" data-left_zoom="120"><a href="#" "="" onclick="return false;"><span class="no">4</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved" style="left:96px" data-left="96" data-left_zoom="144"><a href="#" "="" onclick="return false;"><span class="no">5</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved" style="left:112px" data-left="112" data-left_zoom="168"><a href="#" "="" onclick="return false;"><span class="no">6</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved" style="left:128px" data-left="128" data-left_zoom="192"><a href="#" "="" onclick="return false;"><span class="no">7</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved" style="left:144px" data-left="144" data-left_zoom="216"><a href="#" "="" onclick="return false;"><span class="no">8</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved" style="left:160px" data-left="160" data-left_zoom="240"><a href="#" "="" onclick="return false;"><span class="no">9</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved" style="left:176px" data-left="176" data-left_zoom="264"><a href="#" "="" onclick="return false;"><span class="no">10</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved" style="left:192px" data-left="192" data-left_zoom="288"><a href="#" "="" onclick="return false;"><span class="no">11</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div><div class="seat reserved" style="left:208px" data-left="208" data-left_zoom="312"><a href="#" "="" onclick="return false;"><span class="no">12</span><span class="sreader"> 예매완료 sweetbox</span><span class="sreader mod"> 선택불가</span></a></div></div></div></div></div><div class="exit top" style="top: -30px; left: 30px;"></div></div>
									</div>
								</div>
								<div class="minimap opened" id="minimap">
									<div class="mini_header" onclick="ftSeatMinimapToggle();event.preventDefault();">Minimap<span></span></div>
									<div class="mini_container">
										<div class="mini_screen">SCREEN</div>
										<div class="mini_seats"></div>
										<div class="mini_exits"></div>
									</div>
									<div class="mini_region"><span></span></div>
								</div>
								<div class="legend">
									<div class="buttons">
										<a class="btn-zoom" id="seat_zoom_btn" href="#" onclick="ts2SeatZoomClickListener();return false;">크게보기</a>
									</div>
									<div class="seat-icon-desc">
										<span class="icon selected"><span class="icon"></span>선택</span>
										<span class="icon reserved"><span class="icon"></span>예매완료</span>
										<span class="icon notavail"><span class="icon"></span>선택불가</span>
									</div>
									<div class="seat-type">
										<span class="radiobutton type-prime" title="최적의 영상과 사운드로 영화를 감상할 수 있는 CGV 추천좌석"><span class="icon"></span>Prime Zone</span>
										<span class="radiobutton type-normal"><span class="icon"></span>일반석</span>
										<span class="radiobutton type-couple" title="연인, 가족, 친구를 위한 둘만의 좌석"><span class="icon"></span>커플석</span>
										<span class="radiobutton type-handicap"><span class="icon"></span>장애인석</span>
										<span class="radiobutton type-sweetbox" title="국내 최대 넓이의 프리미엄 커플좌석"><span class="icon"></span>SWEETBOX</span>
										<span class="radiobutton type-veatbox" title="음향 진동 시스템이 적용된 특별좌석"><span class="icon"></span>VEATBOX</span>
										<span class="radiobutton type-4d" title="바람, 진동 등 오감으로 영화 관람, 4DX"><span class="icon"></span>4DX</span>
										<span class="radiobutton type-widebox" title="일반석보다 더 넓고 편안한 좌석"><span class="icon"></span>WIDEBOX</span>
										<span class="radiobutton type-cinekids last" title="365일 어린이 전용 상영관"><span class="icon"></span>CINEKIDS</span>
									</div>
								</div>
							</div>
						   <div class="mouse_block"></div>
						</div>
					</div>
					<a class="btn-refresh" href="#" onclick="ftResetAllSeats(true);return false;">
						<span>다시하기</span>
					</a>
					<!-- 시간표 변경 -->
					<div class="section_time_popup" id="section_time_popup">
						<div class="canvas">
							<div class="sprite">
								<div class="time-option">
									<span class="morning">조조</span><span class="night">심야</span>
								</div>
								<div class="time-list nano" id="time_popup_list">
									<div class="content scroll-y"></div>
								</div>
							</div>
							<div class="buttons">
								<a href="#" onclick="return false;" class="btn_ok"><span>확인</span></a>
								<a href="#" onclick="return false;" class="btn_cancel"><span>취소</span></a>
								<a href="#" onclick="return false;" class="sreader" onfocus="ticketStep2TimeSelectPopupHide();">시간표 변경 팝업 닫기</a>
							</div>
						</div>
						<div class="corner"></div>
					</div>
					<!-- 시간표 변경 -->
				</div>
				<!-- //step2 -->
				<!-- step3 -->
				<div class="step step3">
					
					<div class="ticket_payment_method">
						<a href="#" onclick="return false;" id="ticket_payment_top" class="sreader">결제시작</a>
					
					<div class="tpm_special tpm_special_membership" style="display: none;">
						<div class="special_header">
							<h3 class="title"> 멤버십</h3>
							<span class="desc">멤버십 결제는 다른 할인수단 적용 및 결제와 중복으로 사용하실 수 없습니다.</span>
							<a class="tpmh_btn" href="#" onclick="return false;"><span>펼치기</span></a>
						</div>
						<div class="special_body membership">
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// 임직원 결제  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->	
							<div class="row cgv_employee_payment" style="display: none;">
								<div class="divider"></div>
								<div class="title">	CGV 임직원 결제</div>
								<div class="msg">	정상 조회되었습니다. 아래 적용 버튼을 클릭해주세요.</div>
								<!-- // 카드번호 //-->
								<div class="card_no">
									<div class="title">		<label for="cgv_employee_payment_no">카드번호</label></div>
									<div class="wrap_input"><input type="text" value="" id="cgv_employee_payment_no" maxlength="50" class="type-n nohan"><span></span></div>
									<a class="btn_toggle" href="#none">
										<span class="default">	조회/적용	</span>
										<span class="cancel">	취소		</span>
									</a>
								</div>
								<!-- // 보유 티켓 // -->
								<div class="hold_ticket">
									<span class="title">보유매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 사용 티켓 // -->           
								<div class="use_ticket">
									<span class="title">사용매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 할인 금액 // -->
								<div class="result">
									<span class="title">할인금액:</span>
									<span class="price">0</span><span class="won">원</span>
								</div>
							</div><!-- // 임직원 결제 // -->
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// 서포터즈 결제  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->
							<div class="row cgv_supporters" style="display: none;">
								<div class="divider"></div>
								<div class="title">	CGV 서포터즈 관람카드</div>
								<div class="msg">	정상 조회되었습니다. 아래 적용 버튼을 클릭해주세요.</div>
								<!-- // 카드번호 //-->            
								<div class="card_no">
									<div class="title">		<label for="cgv_supporters_no">카드번호</label></div>
									<div class="wrap_input"><input type="text" value="" id="cgv_supporters_no" maxlength="50" class="type-n nohan"><span></span></div>
									<a class="btn_toggle" href="#none">
										<span class="default">	조회/적용</span>
										<span class="cancel">	취소</span>
									</a>
								</div>
								<!-- // 보유 티켓 // -->
								<div class="hold_ticket">
									<span class="title">보유매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 사용 티켓 // -->           
								<div class="use_ticket">
									<span class="title">사용매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 할인 금액 // -->
								<div class="result">
									<span class="title">할인금액:</span>
									<span class="price">0</span><span class="won">원</span>
								</div>
							</div>
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// 미소지기 결제  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->	
							<div class="row cgv_smiling" style="display: none;">
								<div class="divider"></div>
								<div class="title">	CGV 미소지기</div>
								<div class="msg">	정상 조회되었습니다. 아래 적용 버튼을 클릭해주세요.</div>
								<!-- // 카드번호 //-->            
								<div class="card_no">
									<div class="title">		<label for="cgv_smiling_no">카드번호</label></div>
									<div class="wrap_input"><input type="text" value="" id="cgv_smiling_no" maxlength="50" class="type-n nohan"><span></span></div>
									<a class="btn_toggle" href="#none">
										<span class="default">	조회/적용</span>
										<span class="cancel">	취소</span>
									</a>
								</div>
								<!-- // 보유 티켓 // -->
								<div class="hold_ticket">
									<span class="title">보유매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 사용 티켓 // -->           
								<div class="use_ticket">
									<span class="title">사용매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 할인 금액 // -->
								<div class="result">
									<span class="title">할인금액:</span>
									<span class="price">0</span><span class="won">원</span>
								</div>
							</div>
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// 잡월드 결제  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->	
							
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// 프리패스 결제  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->	
							<div class="row cgv_freepass" style="display: none;">
								<div class="divider"></div>
								<div class="title">	CGV 프리패스카드</div>
								<div class="msg">	정상 조회되었습니다. 아래 적용 버튼을 클릭해주세요.</div>
								<!-- // 카드번호 //-->            
								<div class="card_no">
									<div class="title">		<label for="cgv_freepass_no">카드번호</label></div>
									<div class="wrap_input"><input type="text" value="" id="cgv_freepass_no" maxlength="50" class="type-n nohan"><span></span></div>
									<a class="btn_toggle" href="#none">
										<span class="default">	조회/적용</span>
										<span class="cancel">	취소</span>
									</a>
								</div>
								<!-- // 보유 티켓 // -->
								<div class="hold_ticket">
									<span class="title">보유매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 사용 티켓 // -->           
								<div class="use_ticket">
									<span class="title">사용매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 할인 금액 // -->
								<div class="result">
									<span class="title">할인금액:</span>
									<span class="price">0</span><span class="won">원</span>
								</div>
							</div>
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// VIP 결제  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->
							
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// CJ Ent. 결제  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->
							<div class="row cj_ent_employee" style="display: none;">
								<div class="divider"></div>
								<div class="title">	CJ Ent. 임직원 결제</div>
								<div class="msg">	정상 조회되었습니다. 아래 적용 버튼을 클릭해주세요.</div>
								<!-- // 카드번호 //-->            
								<div class="card_no">
									<div class="title">		<label for="cj_ent_employee_no">카드번호</label></div>
									<div class="wrap_input"><input type="text" value="" id="cj_ent_employee_no" maxlength="50" class="type-n nohan"><span></span></div>
									<a class="btn_toggle" href="#none">
										<span class="default">	조회/적용</span>
										<span class="cancel">	취소</span>
									</a>
								</div>
								<!-- // 보유 티켓 // -->
								<div class="hold_ticket">
									<span class="title">보유매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 사용 티켓 // -->           
								<div class="use_ticket">
									<span class="title">사용매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 할인 금액 // -->
								<div class="result">
									<span class="title">할인금액:</span>
									<span class="price">0</span><span class="won">원</span>
								</div>
							</div>	
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// VIP Partners 결제  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->
							<div class="row partners_vip" style="display: none;">
								<div class="divider"></div>
								<div class="title">	Partners(VIP)</div>
								<div class="msg">	정상 조회되었습니다. 아래 적용 버튼을 클릭해주세요.</div>
								<!-- // 카드번호 //-->            
								<div class="card_no">
									<div class="title">		<label for="partners_vip_no">카드번호</label></div>
									<div class="wrap_input"><input type="text" value="" id="partners_vip_no" maxlength="50" class="type-n nohan"><span></span></div>
									<a class="btn_toggle" href="#none">
										<span class="default">	조회/적용</span>
										<span class="cancel">	취소</span>
									</a>
								</div>
								<!-- // 보유 티켓 // -->
								<div class="hold_ticket">
									<span class="title">보유매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 사용 티켓 // -->           
								<div class="use_ticket">
									<span class="title">사용매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 할인 금액 // -->
								<div class="result">
									<span class="title">할인금액:</span>
									<span class="price">0</span><span class="won">원</span>
								</div>
							</div>
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// CJ 임원 결제  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->		
							<div class="row cj_vip_officer" style="display: none;">
								<div class="divider"></div>
								<div class="title">	CJ 임원결재</div>
								<div class="msg">	정상 조회되었습니다. 아래 적용 버튼을 클릭해주세요.</div>
								<!-- // 카드번호 //-->            
								<div class="card_no">
									<div class="title">		<label for="cj_vip_officer_no">카드번호</label></div>
									<div class="wrap_input"><input type="text" value="" id="cj_vip_officer_no" maxlength="50" class="type-n nohan"><span></span></div>
									<a class="btn_toggle" href="#none">
										<span class="default">	조회/적용</span>
										<span class="cancel">	취소</span>
									</a>
								</div>
								<!-- // 보유 티켓 // -->
								<div class="hold_ticket">
									<span class="title">보유매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 사용 티켓 // -->           
								<div class="use_ticket">
									<span class="title">사용매수</span>
									<div class="wrap_input"><input type="text" id="cj_vip_officer_use" value="2" maxlength="50" class="type-n nohan"></div>
									<span class="value">0매</span>
								</div>
								<!-- // 할인 금액 // -->
								<div class="result">
									<span class="title">할인금액:</span>
									<span class="price">0</span><span class="won">원</span>
									<a class="btn_toggle" href="#none">
										<span class="default">	적용</span>
										<span class="cancel">	취소</span>
									</a>
								</div>
							</div>
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// Prestige 결제  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->
							
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// E&M Master  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->
							<div class="row enmMaster" style="display: none;">
								<div class="divider"></div>
								<div class="title">	CJ E&amp;M Master<br>Power Creator</div>
								<div class="msg">	정상 조회되었습니다. 아래 적용 버튼을 클릭해주세요.</div>
								<!-- // 카드번호 //-->            
								<div class="card_no">
									<div class="title">		<label for="enmMaster_no">카드번호</label></div>
									<div class="wrap_input"><input type="text" value="" id="enmMaster_no" maxlength="50" class="type-n nohan"><span></span></div>
									<a class="btn_toggle" href="#none">
										<span class="default">	조회/적용</span>
										<span class="cancel">	취소</span>
									</a>
								</div>
								<!-- // 보유 티켓 // -->
								<div class="hold_ticket">
									<span class="title">보유매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 사용 티켓 // -->           
								<div class="use_ticket">
									<span class="title">사용매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 할인 금액 // -->
								<div class="result">
									<span class="title">할인금액:</span>
									<span class="price">0</span><span class="won">원</span>
								</div>
							</div>							
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// CJ Club 결제  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->
							<div class="row cjClub" style="display: none;">
								<div class="divider"></div>
								<div class="title">	CJ Club 카드 결제</div>
								<div class="msg">	정상 조회되었습니다. 아래 적용 버튼을 클릭해주세요.</div>
								<!-- // 할인 금액 // -->
								<div class="contents">
									<p class="title">정상 조회 되었습니다. 아래 적용 버튼을 클릭해 주세요.</p>
									<span class="payName">할인금액:</span>
									<span class="price">0</span><span class="won">원</span>
									<span class="btnCon"><a class="btn_toggle" href="#none"> <span class="default">	적용</span> </a></span>
								</div>
							</div>
					
							<div class="row cjClub2" style="display: none;">
								<div class="divider"></div>
								<div class="title">	CJ Club 카드 결제2</div>
								<div class="msg">	정상 조회되었습니다. 아래 적용 버튼을 클릭해주세요.</div>
								<!-- // 할인 금액 // -->
								<div class="contents">
									<p class="title">정상 조회 되었습니다. 아래 적용 버튼을 클릭해 주세요.</p>
									<span class="payName">할인금액:</span>
									<span class="price">0</span><span class="won">원</span>
									<span class="btnCon"><a class="btn_toggle" href="#none"> <span class="default">	적용</span> </a></span>
								</div>
							</div>
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// 4DX RED  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->
							<div class="row 4dxRed type2" style="display: none;">
								<div class="divider"></div>
								<div class="title">	CGV 4DX RED CARD</div>
								<!-- // 카드번호 //-->            
								<div class="card_no">
									<!-- <div class="title">		<label for="enmMaster_no">카드번호</label></div>
									<div class="wrap_input"><input type="text" value="" id="enmMaster_no" maxlength="50" class="type-n nohan"><span></span></div>
									<a class="btn_toggle" href="#none">
										<span class="default">	조회/적용</span>
										<span class="cancel">	취소</span>
									</a> -->
								</div>
								<!-- // 보유 티켓 // -->
								<div class="hold_ticket">
									<span class="title">사용 가능 매수</span>
									<span class="value">0매</span>
								</div>
								<!-- // 사용 티켓 // -->           
								<div class="use_ticket">
									<span class="title">적용매수</span>
									<select class="useNum">
										<option value="0">0</option>
										<option value="1">1</option>
										<option value="2">2</option>
									</select>
									<span class="exe">매</span>
								</div>
								<!-- // 할인 금액 // -->
								<div class="result">
									<span class="title">할인금액:</span>
									<span class="price">0</span><span class="won">원</span>
								</div>
								<div class="msg2">※ 일 1회 최대 2매 할인 적용가능 (청소년,어린이,우대 제외)</div>
							</div>	
					
					
						</div>	<!-- // special_body -->
					</div>		<!-- // tpm_special -->
					
					
					
					
					
					
					
					
					
					<div class="tpm_special tpm_special_vip" style="display: none;">
						<div class="special_header">
							<h3 class="title">VIP</h3>
							<span class="desc">  </span>
							<a class="tpmh_btn" href="#" onclick="return false;"><span>펼치기</span></a>
						</div>
						<div class="special_body vip">
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// VIP Coupon  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->    	
							<div class="row vip_coupon">
								<div class="divider"></div>
								<div class="title">VIP &nbsp; 쿠폰</div>
								<div class="table_header">
									<div class="coupon_name">	VIP &nbsp; 쿠폰</div>
									<div class="coupon_date">	유효기간</div>
									<div class="coupon_state">	사용여부</div>
								</div>
								<div class="table_body nano has-scrollbar">
									<ul class="content scroll-y" id="vip_coupon_list" tabindex="-1" style="right: -17px;"></ul>
								<div class="pane pane-y" style="display: none; opacity: 1; visibility: visible;"><div class="slider slider-y" style="height: 50px;"></div></div><div class="pane pane-x" style="display: none; opacity: 1; visibility: visible;"><div class="slider slider-x" style="width: 50px;"></div></div></div>
								<div class="result">
									<span class="title">할인금액:</span>
									<span class="price">0</span><span class="won">원</span>
								</div>
							</div>
					<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-// VIP half discount  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->    	
							<div class="row cgv_vip_half_discount">
								<div class="divider"></div>
								<div class="title">VIP &nbsp; 반값할인</div>
								<div class="body disabled">
									<div class="block avail_count">
										<span class="title">사용 가능 수량</span>
										<span class="value" id="cgv_vip_half_discount_point"><span class="num">0</span>매</span>
									</div>
									<div class="block avail_point">
										<span class="title point">가용 포인트</span>
										<span class="value" id="cgv_vip_half_discount_point">0P</span>
									</div>
									<div class="block apply_count">
										<span class="title">사용매수</span>
										<span class="ticket_type">
										<div class="type adult disabled">
												<span class="title">일반</span>
												<a href="#"><span class="sreader"> 일반 </span><span>0</span><span class="sreader"> 명 </span></a>
												<a href="#"><span class="sreader"> 일반 </span><span>1</span><span class="sreader"> 명 </span></a>
												<a href="#"><span class="sreader"> 일반 </span><span>2</span><span class="sreader"> 명 </span></a>
												<a href="#"><span class="sreader"> 일반 </span><span>3</span><span class="sreader"> 명 </span></a>
												<a href="#"><span class="sreader"> 일반 </span><span>4</span><span class="sreader"> 명 </span></a>
											</div>
											<div class="type youth disabled">
												<span class="title">청소년</span>
												<a href="#"><span class="sreader"> 청소년 </span><span>0</span><span class="sreader"> 명 </span></a>
												<a href="#"><span class="sreader"> 청소년 </span><span>1</span><span class="sreader"> 명 </span></a>
												<a href="#"><span class="sreader"> 청소년 </span><span>2</span><span class="sreader"> 명 </span></a>
												<a href="#"><span class="sreader"> 청소년 </span><span>3</span><span class="sreader"> 명 </span></a>
												<a href="#"><span class="sreader"> 청소년 </span><span>4</span><span class="sreader"> 명 </span></a>
											</div>
										</span>
									</div>
					
									<div class="block use_point">
										<span class="title">차감 포인트</span>
										<span class="value" id="cgv_vip_discount_point_use"><span class="num">0</span>P</span>
									</div>
					
									<div class="block remain_point">
										<span class="title">잔여 포인트</span>
										<span class="value" id="cgv_vip_discount_point_use"><span class="num">0</span>P</span>
									</div>
					
									<div class="result">
										<span class="title">할인금액:</span>
										<span class="price" id="cgv_vip_half_discount_price">0</span>
										<span class="won">원</span>
									</div>
									<div class="guide">
										
										- 적용 대상: 2017년 CGV VIP, RVIP, VVIP, SVIP
										<br>- 사용 한도: <span class="red">등급 기간 내 VIP 5매, RVIP 10매, VVIP 20매, SVIP 30매 / 일 한도 : 4매 (VIP 공통)</span>
										<br>- 사용 조건: 일반 / IMAX / 4DX (아트하우스 포함) 관에서 상영하는 일반 2D영화와 일반관에서 상영하는 3D 영화 중 일반, 청소년으로 예매 시 적용 가능
										<br>- 조조, 심야, 일부 특정 상영회차 이용 불가
										<br>- 컬쳐데이, 온라인 특별 요금제 중복할인 불가
										<br>- SWEETBOX / GOLD CLASS / CINE de CHEF / 프리미엄 / STARIUM / IMAX / 4DX / PRIVATE CINEMA 이용 불가
										<br>- 영화 기획전, 영화제 등 특별 편성 프로그램 및 라이트톡, 시네마톡 등 톡프로그램 이용 불가
										
									</div>
								</div>
							</div><!-- cgv_vip_half_discount_price" -->
					
					
						</div><!-- // special_body // -->
					</div><!-- // tpm_special // -->
						<h4 class="ts3_titlebar ts3_t1 non-special" style="margin-top: 40px;">
							<span class="header">STEP 1. </span>
							<span class="title">할인수단</span>
							<a href="#" onclick="ticketStep3Step1Reset(); return false;"><span>다시하기</span></a>
						</h4>
						<!-- tpm_wrap tpm_everyday -->
					
					<div class="tpm_wrap tpm_point">
						<div class="tpm_header">
							<h4 class="default">TickeLion 할인쿠폰<span class="divider">/</span>TickeLion 포인트</h4>
							<h4 class="only_cgvticket">TickeLion 할인쿠폰<span class="divider">/</span>TickeLion 포인트</h4>
							<a class="tpmh_btn" href="#" onclick="return false;"><span>펼치기</span></a>
						</div>
						<div class="tpm_body">
							<div class="tpm_row">
								<div class="tpm_box cgv_ticket_form">
									<div>
										<h5>TicketLion 할인쿠폰</h5>
										<div class="tpm_coupon_button">
										    <a class="brown" href="#" onclick=""><span>등록하기</span></a>
										    <a class="gray" href="#" onclick=""><span>전체 관람권</span></a>
										</div>
										<div class="form_list" style="display: block;">
						                    <div class="list_header">
						                        <span class="col col1">사용가능 관람권</span>
						                        <span class="col col2">관람권 번호</span>
						                        <span class="col col3">유효기간</span>
						                    </div>
						                    <div class="list_body nano has-scrollbar">
						                        <ul class="content" id="cgv_ticket_list" tabindex="-1" style="right: -17px; bottom: -17px;"></ul>
												
						                        <span class="message">사용 가능한 영화관람권이 없습니다.</span>
												
						                    <div class="pane pane-y" style="display: none; opacity: 1; visibility: visible;"><div class="slider slider-y" style="height: 50px;"></div></div><div class="pane pane-x" style="display: none; opacity: 1; visibility: visible;"><div class="slider slider-x" style="width: 50px;"></div></div></div>
						                </div>
						                <div class="form_result"><span class="title">할인금액:</span><span id="TicketLion_ticket_price" class="price">0</span><span class="won">원</span></div>
									</div>
									<div class="tpm_lookup">
										<p>
											
											<span>사용 가능한 쿠폰을 조회해주세요.</span><br>
											
											<a href="#" onclick=""><span>조회하기</span></a>
										</p>
									</div>
								<div class="dimmCon" style="display: none;">&nbsp;</div></div>
								<div class="tpm_box clear"></div>
							</div>
							<div class="tpm_row">
								<div class="tpm_box TicketLion_point"><div>
									<h5>TicketLion 포인트</h5>
									<div class="tpm_TicketLion_point">
										<div class="tpcop">
											<span class="title">현재 보유 포인트:</span>
											<span class="point point_have verdana"><span id="TicketLion_point_have"></span>P</span>
											<span class="title title2">사용할 포인트:</span>
											<span class="form_wrap">
												<label for="TicketLion_point_use">사용할 TicketLion 포인트 입력</label>
												<input id="TicketLion_point_use" type="text" value="0" maxlength="50" class="type-n nohan">
											</span>
											<span class="point point_use verdana">P</span>
											<span class="title title3">
												<label for="TicketLion_point_all">TicketLion 포인트 모두 사용</label>
												<input id="TicketLion_point_all" type="checkbox">
												모두사용
											</span>
											<div class="cop_block" onclick="askCJONEPointEnable(event);"></div>
										</div>
										<div class="tpcop explain">
											
											<span class="default">TicketLion 포인트는 <em>1,000P</em> 이상부터 <em>10P</em> 단위로 사용 가능합니다.</span>
											
											<span class="exception">
												<a href="#" onclick="CJOnePointGunjaGangdong();return false;"><img src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/step3/btn_info.png" alt="정보"></a>
											</span>
										</div>
									</div>
								</div></div>
							</div>
						</div>
					</div>
				
						
						<h4 class="ts3_titlebar ts3_t1" style="margin-top: 40px;">
						<span class="header">STEP 2. </span>
						<span class="title">최종결제 수단</span>
						</h4>
						<h4 class="ts3_titlebar_guest">
						<span class="title">비회원결제</span>
						<span class="desc">비회원 예매는 신용카드 결제만 가능합니다.</span>
						</h4>
						
					<div class="tpm_wrap tpm_last_pay">
						<div class="promotion_message" id="promotion_message" style="display: none;">
							<div class="msg"></div>
							<a href="#" onclick="showHidePromotionMessage();return false;">상세보기</a>
							<div class="msg_box" style="display: none;"></div>
						</div>
						<div class="tpm_body">
							<div>
								<div class="payment_select_guest">일반 신용카드</div><!-- 비회원 카드 결제 -->
								<div class="payment_select radio_group">
									<span>
										<input type="radio" id="last_pay_radio1" name="last_pay_radio" value="0" checked="checked">
										<label for="last_pay_radio1">신용카드 </label><span></span>
									</span>
									<span>
										<input type="radio" id="last_pay_radio2" name="last_pay_radio" value="1">
										<label for="last_pay_radio2">휴대폰 결제</label><span></span>
									</span>
									<span>
										<input type="radio" id="last_pay_radio3" name="last_pay_radio" value="2">
										<label for="last_pay_radio3">계좌이체</label><span></span>
									</span>
								</div>
								<div class="payment_form">
								    <!-- 휴대폰 -->
					<h5>휴대폰 정보 입력</h5>
					<div class="payment_input payment_phone" style="display: none;">
						<div class="table_wrap phone_wrap" id="phone_wrap">
							<table>
								<caption>휴대폰 번호, 주민등록번호, 결제금액 입력 및 약관 동의</caption>
									<thead></thead>
									<tbody>
										<tr>
											<th scope="row">상품명</th>
											<td>영화티켓예매</td>
										</tr>
										<tr id="input_phone_name">
											<th scope="row">이름</th>
											<td>
												<div>
													<div class="form_wrap text phone_no form_bg">
														<input id="lp_phone_name" type="text" class="type-n nohan">
													</div>
												</div>
											</td>
										</tr>
										<tr id="input_phone_pd">
											<th scope="row"><label for="lp_phone_pd">통신사</label></th>
											<td>
												<div>
													<div class="form_wrap select phone_pd form_bg">
														<label for="lp_phone_pd">통신사 선택</label>
															<select id="lp_card_type">
																<option selected="selected">통신사를 선택하세요</option>
																<option pd_code="SKT" >SKT</option>
																<option pd_code="KT" >KT</option>
																<option pd_code="LG" >LG</option>
															</select>
													</div>
												</div>
											</td>
										</tr>
										<tr id="input_phone_num">
										<th scope="row"><label for="lp_phone_no1">휴대폰 번호</label></th>
											<td>
												<div>
													<div class="form_wrap text phone_no form_bg">
														<label for="lp_phone_no1">폰번호 첫번째 숫자 입력</label>
														<input id="lp_phone_no1" type="text" maxlength="3" class="type-n nohan">
													</div>
													<span class="divider">-</span>
													<div class="form_wrap text phone_no form_bg">
														<label for="lp_phone_no2">폰번호 두번째 숫자 입력</label>
														<input id="lp_phone_no2" type="text" maxlength="4" class="type-n nohan">
													</div>
													<span class="divider">-</span>
													<div class="form_wrap text phone_no form_bg">
														<label for="lp_phone_no3">카드 번호 세번째 숫자 입력</label>
														<input id="lp_phone_no3" type="text" maxlength="4" class="type-n nohan">
													</div>
												</div>
											</td>
									</tr>
									<tr class="card_owner_jumin">
										<th scope="row"><span class="type_jumin">법정생년월일
					(6자리)</span><span class="type_coporate" style="display: none;"><label for="lp_coporate">법인공용카드<br>사업자등록번호</label></span></th>
										<td><div>
											
										<div class="form_wrap text card_ssn form_bg">
												<label for="lp_card_ssn">생년월일</label>
												<input id="lp_card_ssn" type="password" maxlength="6" class="type-n nohan">
											</div><span class="divider">-</span><span class="password">*******</span><div class="use_coporate_card">
												<input type="checkbox" id="lp_use_coporate_card"><label for="lp_use_coporate_card">법인공용카드 사용</label>
											</div></div></td>
									</tr>
									</tbody>
								</table>
							</div>
						</div>
					<!-- 휴대폰 -->
					<!-- 신용카드 -->
					<h5>신용카드 정보 입력</h5><!-- title -->
					<div class="payment_input payment_card" style="display: block;">
						<div class="payment_card_radio_wrap radio_group">
							<input type="radio" id="payment_card_radio1" name="payment_card_radio" value="0" checked="checked">
							<label for="payment_card_radio1">일반 신용카드(체크카드 포함)</label>
					    </div>
					
						<div class="table_wrap card_default" id="card_default">
							<table>
								<caption>신용카드의 종류, 카드번호, 비밀번호, 유효기간, 주민등록번호 입력</caption>
								<thead></thead>
								<tbody>
									<tr>
										<th scope="row"><label for="lp_card_type">카드종류</label></th>
										<td><div>
											<div class="form_wrap select card_type form_bg">
												<select id="lp_card_type"><option selected="selected">카드를 선택하세요</option><option card_code="BCC" card_type="1" card_digit="14" card_cd="N0002">BC카드</option><option card_code="CNB" card_type="1" card_digit="16" card_cd="N0004">국민카드</option><option card_code="WIN" card_type="1" card_digit="15" card_cd="N0023">삼성카드(올앳포함)</option><option card_code="SHB" card_type="1" card_digit="15" card_cd="N0021">신한카드</option><option card_code="DIN" card_type="1" card_digit="14" card_cd="N0005">현대카드</option><option card_code="KEB" card_type="1" card_digit="14" card_cd="N0012">KEB하나카드(구,외환)</option><option card_code="KKB" card_type="1" card_digit="16" card_cd="N0024">카카오뱅크카드</option><option card_code="PHB" card_type="1" card_digit="16" card_cd="N0018">우리(평화)카드</option><option card_code="AMX" card_type="1" card_digit="15" card_cd="N0001">롯데/아멕스카드</option><option card_code="CIT" card_type="1" card_digit="16" card_cd="N0003">시티카드(구,한미)</option><option card_code="SIN" card_type="1" card_digit="16" card_cd="N0022">신세계카드</option><option card_code="NLC" card_type="1" card_digit="16" card_cd="N0017">NH카드</option><option card_code="HNB" card_type="1" card_digit="14" card_cd="N0006">하나카드(구,하나SK)</option><option card_code="KJB" card_type="1" card_digit="16" card_cd="N0014">광주VISA카드</option><option card_code="SAN" card_type="1" card_digit="16" card_cd="N0019">산은캐피탈</option><option card_code="NFF" card_type="1" card_digit="16" card_cd="N0016">수협카드</option><option card_code="KDB" card_type="1" card_digit="16" card_cd="N0011">KDB산업은행카드</option><option card_code="JBB" card_type="1" card_digit="16" card_cd="N0009">전북은행카드</option><option card_code="JJB" card_type="1" card_digit="16" card_cd="N0010">제주은행카드</option><option card_code="KEP" card_type="1" card_digit="16" card_cd="N0013">우체국카드</option><option card_code="SCB" card_type="1" card_digit="16" card_cd="N0020">스탠다드차타드은행카드</option><option card_code="MGC" card_type="1" card_digit="16" card_cd="N0015">MG체크카드</option><option card_code="HSC" card_type="1" card_digit="16" card_cd="N0007">현대증권카드</option><option card_code="IBK" card_type="1" card_digit="16" card_cd="N0008">기업은행카드</option></select>
											</div>
											<div class="use_point" style="display: none;">
												<input type="checkbox" id="lp_use_point"><label for="lp_use_point">카드사 포인트 사용</label>
											</div>
											</div>
										</td>
									</tr>
									<tr id="input_card_num">
										<th scope="row"><label for="lp_card_no1">카드번호</label></th>
										<td><div>
											<div class="form_wrap text card_no form_bg">
												<label for="lp_card_no1">카드 번호 첫번째 숫자 입력</label>
												<input id="lp_card_no1" type="text" maxlength="4" class="type-n nohan">
											</div>
											<span class="divider">-</span>
											<div class="form_wrap text card_no form_bg">
												<label for="lp_card_no2">카드 번호 두번째 숫자 입력</label>
												<input id="lp_card_no2" type="password" maxlength="4" class="type-n nohan">
											</div>
											<span class="divider">-</span>
											<div class="form_wrap text card_no form_bg">
												<label for="lp_card_no3">카드 번호 세번째 숫자 입력</label>
												<input id="lp_card_no3" type="password" maxlength="4" class="type-n nohan">
											</div><span class="divider">-</span>
											<div class="form_wrap text card_no form_bg">
												<label for="lp_card_no4">카드 번호 네번째 숫자 입력</label>
												<input id="lp_card_no4" type="text" maxlength="4" class="type-n nohan">
											</div>
										</div></td>
									</tr>
									<tr id="input_card_pw">
										<th scope="row"><label for="lp_card_pw">비밀번호</label></th>
										<td><div>
											<div class="form_wrap text card_pw form_bg">
												<label for="lp_card_pw">카드 비밀번호 숫자 입력</label>
												<input id="lp_card_pw" type="password" maxlength="2" class="type-n nohan">
											</div><span class="password">**</span>
										</div></td>
									</tr>
					
									<tr id="input_card_Expire">
										<th scope="row"><label for="lp_card_month">유효기간</label></th>
										<td><div>
											<div class="form_wrap text card_date form_bg">
												<label for="lp_card_month">카드 유효기간 월 숫자 입력</label>
												<input id="lp_card_month" type="text" maxlength="2" class="type-n nohan">
											</div><span class="string">월</span>
											<div class="form_wrap text card_date form_bg">
												<label for="lp_card_year">카드 유효기간 년도 숫자 입력</label>
												<input id="lp_card_year" type="text" maxlength="2" class="type-n nohan">
											</div><span class="string">년</span>
											<div class="expire_ex">예) 2015년 9월 -&gt; 09월 15년</div>
										</div></td>
									</tr>
									<tr class="card_owner_jumin">
										<th scope="row"><span class="type_jumin">법정생년월일
					(6자리)</span><span class="type_coporate" style="display: none;"><label for="lp_coporate">법인공용카드<br>사업자등록번호</label></span></th>
										<td><div>
											
											
											<div class="form_wrap text coporate form_bg" style="display: none;">
					                            <label for="lp_coporate">법인공용카드 사업자등록번호 10자리 입력</label>
					                            <input id="lp_coporate" type="text" maxlength="10" class="type-n nohan">
					                        </div>
											
										<div class="form_wrap text card_ssn form_bg">
												<label for="lp_card_ssn">생년월일</label>
												<input id="lp_card_ssn" type="password" maxlength="6" class="type-n nohan">
											</div><span class="divider">-</span><span class="password">*******</span><div class="use_coporate_card">
												<input type="checkbox" id="lp_use_coporate_card"><label for="lp_use_coporate_card">법인공용카드 사용</label>
											</div></div></td>
									</tr>
								</tbody>
							</table>
							<div class="discount_result">
								<div class="result_reference promo" style="display: none;">
									<span class="left">＊카드번호와 유효기간을 입력하신 후 조회를 누르시면 할인 금액이 조회됩니다.</span>
									<span class="right"><a class="brown btn_verify btn_toggle" id="applyPromoBtn" href="#" onclick="return false;"><span class="default">조회/적용</span><span class="cancel">사용취소</span></a></span>
								</div>
								<div class="discount_price promo" style="display: none;">
									<div class="discount_price_inner">
										<span class="title">추가할인금액:</span><span class="price">0</span><span class="won">원</span>
									</div>
								</div>
							</div>
						<div class="discount_result"><div class="result_reference"><span class="left" style="font-weight: bold; position: absolute; width: 98%;">​</span></div></div></div>
					
						<div class="card_explain" style="width: 100%; min-height: 0px;">
							<ul>
							
								<li class="isp" style="display: none;">선택하신 카드로 결제하려면 ISP 프로그램이 필요합니다. 처음 결제하시는 경우 ISP 프로그램 설치가 진행 됩니다.</li>
								<li class="bc" style="display: none;"><strong>BC Top 포인트</strong> 보유 고객이라면 결제 시 포인트사용 네모 박스 체크 후 보유 포인트로 영화를 결제 할 수 있습니다.<br>(사용으로 인한 영화 할인 내역은 청구서에서 확인 할 수 있습니다.)</li>
								<li class="bc" style="display: none;"><strong>평일(월~금) 예매 시, 월 10회/일 1회 2매까지 장당 1천원 추가 할인</strong>
									<p>- 8,000원 이상 티켓에 한함</p>
									<p>- 법인/기프트 카드 제외, 우대/특별관 예매 시 적용 불가</p>
									<p>- 2017년 12월 31일까지 할인 가능</p>
								</li>
								<li class="yes" style="display: none;"><strong>KEB하나카드 즉시할인</strong>을 받으시려면, 선할인 신용카드 &gt; 외환카드할인을 선택하신 후 결제를 진행해주세요.</li>
								<li class="yes" style="display: none;"><strong>하나머니</strong> 보유 고객이라면 결제 시 포인트 사용 네모 박스 체크 후 보유 포인트로 영화를 결제 할 수 있습니다.<br>(사용으로 인한 영화 할인 내역은 청구서에서 확인 할 수 있습니다.)</li>
								<li class="lt" style="display: none;"><strong>CGV롯데포인트 플러스카드 할인 혜택</strong>을 받으시려면, 선할인 신용카드 &gt; 롯데카드 할인을 선택하신 후 결제를 진행해주세요.</li>
								<li class="ct" style="display: none;"><strong>CITI포인트</strong> 보유 고객이라면 결제 시 포인트 사용 네모 박스 체크 후 보유 포인트로 영화를 결제 할 수 있습니다.<br>(사용으로 인한 영화 할인 내역은 청구서에서 확인 할 수 있습니다.)</li>
								<li class="nh" style="display: none;"><strong>NH카드 할인혜택</strong>을 받으시려면, 즉시할인 신용카드 &gt; NH카드 할인을 선택하신 후 결제를 진행해주세요.<br><strong> (현재 페이지에서 결제 시 즉시할인 혜택이 제공되지 않습니다.)</strong> </li>
								<li class="nh" style="display: none;"><strong>NH 채움포인트</strong> 보유고객이라면 결제 시 포인트 사용 '네모박스' 체크 후 보유 포인트로 영화를 결제할 수 있습니다.<br>(사용으로 인한 영화 할인 내역은 청구서로 확인할 수 있습니다.)</li>
								<li class="nh" style="display: none;"><strong>NH 채움포인트</strong> 부족 시 '네모박스' 체크 해제 후 결제 부탁 드립니다</li>
					
								<li class="bc" style="display: none;">1,000원 할인 또는 즉시할인 혜택 적용여부는 고객님의 실적 및 할인혜택 사용여부에 따라 적용되지 않을 수 있습니다.</li>
								<li class="kb" style="display: none;"><strong>KB 포인트리</strong> 보유 고객이라면 결제 시 포인트사용 네모 박스 체크 후 보유 포인트로 영화를 결제 할 수 있습니다.<br>(사용으로 인한 영화 할인 내역은 청구서에서 확인 할 수 있습니다.)</li>
								<li class="ss" style="display: none;"><strong>CJ ONE 삼성카드 더블적립/할인 혜택</strong>을 받으시려면, 선할인 신용카드 &gt; CJ ONE 삼성카드 할인을 선택하신 후 결제를 진행해주세요.</li>
								<li class="ss" style="display: none;"><strong>삼성보너스포인트/S클래스포인트</strong> 보유 고객이라면, 결제 시 포인트 사용 네모 박스 체크 후 보유 포인트로 영화를 결제 할 수 있습니다.<br>(사용으로 인한 영화 할인 내역은 청구서에서 확인 할 수 있습니다.)</li>
								<li class="sh" style="display: none;"><strong>CJ ONE 신한카드 더블적립/할인 혜택</strong>을 받으시려면, 선할인 신용카드 &gt; CJ ONE 신한카드 할인을 선택하신 후 결제를 진행해주세요.</li>
								<li class="sh" style="display: none;"><strong>마이신한포인트</strong> 보유 고객이라면, 결제 시 포인트 사용 네모 박스 체크 후 보유 포인트로 영화를 결제 할 수 있습니다.<br>(사용으로 인한 영화 할인 내역은 청구서에서 확인 할 수 있습니다.)<br>단, 포인트 사용 후 기존 카드 할인 적용됩니다.</li>
								<li class="hd" style="display: none;"><strong>현대카드M포인트DAY</strong><br> 매주 금요일/토요일 5,000M포인트 사용.<br>그 외 요일은 2,000M포인트 사용.<p style="color: rgb(0, 104, 183); margin-top: 5px;">※ M포인트 사용고객은 위 현대카드M포인트 체크박스 먼저 체크해주세요~!</p></li>
								<!--<li class="hd"><strong>현대카드M포인트</strong> 사용 시 현대 카드 M포인트 팝업이 보여집니다.</li>-->
								<li class="sc" style="display: none;"><strong>360도 리워드포인트</strong> 보유 고객이라면 결제 시 포인트 사용 네모 박스 체크 후 보유 포인트로 영화를 결제 할 수 있습니다.<br>(사용으로 인한 영화 할인 내역은 청구서에서 확인 할 수 있습니다.)</li>
								<li class="hnb" style="display: none;"><strong>하나머니</strong> 보유고객이라면 결제 시 ‘하나머니 사용’ 네모박스 체크 후 보유 포인트로 영화를 결제할 수 있습니다.<br>(사용으로 인한 영화 할인 내역은 청구서로 확인할 수 있습니다.)</li>
								<li class="nhsale" style="display: none;">
									최종 결제 금액 <strong>8,000원 이상</strong> 시 1천원 할인 제공<br>
									( 최대 2매까지 적용, 일 1회, 월4회 限) 단, 조조, 청소년, 4DX, SoundX 등 특화관 제외 )</li>
								<li class="nhsale" style="display: none;"><strong>예매일 이후 취소</strong> 진행 시, 할인횟수 한도 복원에 <strong>2~3일 소요</strong>될 수 있습니다. (관련 문의 1588 - 1600)</li>
								<li class="nhsale" style="display: none;">일부카드(천·지·인, TAKE 5, 패밀리카드)에 한해 청구할인이 유지되며, 상세 이용기준은 NH농협카드 홈페이지 참조 요망</li>
								<li class="nhsale" style="display: none;"><strong>NH 채움포인트</strong> 보유고객이라면 결제 시 포인트 사용 '네모박스' 체크 후 보유 포인트로 영화를 결제할 수 있습니다.<br>(사용으로 인한 영화 할인 내역은 청구서로 확인할 수 있습니다.)</li>
								<li class="nhsale" style="display: none;"><strong>NH 채움포인트</strong> 부족 시 '네모박스' 체크 해제 후 결제 부탁 드립니다</li>
							
							</ul>
						</div>
						<div class="payment_input_exp">
							<span>※ 신용카드 결제 가능 최소 금액은 1,000원 이상입니다.</span>
							<span><span class="desc"><a href="#" onclick="return false;" class="btn_samsung_upoint">삼성U포인트 적립</a>&nbsp;&nbsp;<a href="#" onclick="return false;" class="btn_okcashbag">OK캐쉬백 적립</a><a class="btn_kiaRedPoint" onclick="return false;" href="#" style="margin-left: 10px;">KIA RED MEMBERS 적립</a></span>
							<span class="option">(삼성U포인트, OK캐쉬백, KIA RED MEMBERS 포인트는 포인트 중복 적립 불가)</span></span>
							<!--
							<div class="buttons">
								<a class="btn_okcashbag" href="#" onclick="return false;"><span>OK캐쉬백 번호 입력</span></a>
								<a class="btn_samsung_upoint" href="#" onclick="return false;"><span>삼성 U포인트 번호 입력</span></a>
							</div>
							-->
						</div>
					</div>
					<!-- 신용카드 --><!-- 계좌이체 -->
					
					<div class="payment_input payment_transfer" style="display: none;">
						<div class="table_wrap transfer_wrap" id="transfer_wrap">
								<table>
									<tr id="input_acount_num">
										<th scope="row"><label for="lp_card_no1">계좌번호</label></th>
										<td>
											<div>
												<div class="form_wrap text acount_no form_bg">
													<label for="lp_acount_no1">계좌번호입력</label>
													<input id="lp_acount_no1" type="text" class="type-n nohan" style="width:110px;">
												</div>
											</div>
										</td>
									</tr>
									<tr id="input_acount_pw">
										<th scope="row"><label for="lp_acount_pw">비밀번호</label></th>
										<td>
											<div>
												<div class="form_wrap text acount_pw form_bg">
													<label for="lp_acount_pw">계좌 비밀번호 숫자 입력</label>
													<input id="lp_acount_pw" type="password" maxlength="4" class="type-n nohan">
												</div>
											</div>
										</td>
									</tr>
									<tr class="card_owner_jumin">
										<th scope="row"><span class="type_jumin">법정생년월일
					(6자리)</span><span class="type_coporate" style="display: none;"><label for="lp_coporate">법인공용카드<br>사업자등록번호</label></span></th>
										<td>
											<div>
												<div class="form_wrap text card_ssn form_bg">
													<label for="lp_card_ssn">생년월일</label>
													<input id="lp_card_ssn" type="password" maxlength="6" class="type-n nohan">
												</div>
												<span class="divider">-</span><span class="password">*******</span>
												<div class="use_coporate_card">
													<input type="checkbox" id="lp_use_coporate_card"><label for="lp_use_coporate_card">법인공용카드 사용</label>
												</div>
											</div>
										</td>
									</tr>
							</table>
						</div>
						<div class="payment_input_exp">
							<span><span style="font-weight:bold; color: red;"></span>
						</div>
					</div>
					
					<!-- 계좌이체 --><!-- 계좌이체 -->
					
					
					<!-- 계좌이체 -->
								</div>
							</div>
						</div>
					</div>
					</div>
					
					
					<div class="ticket_payment_summary">
					    <div class="tps_wrap" style="top: 0px;">
						<!--<div class="tps_header"><div><span>10분</span> 안에<br/>예매를 완료해 주세요</div></div>-->
						<div class="tps_body">
							<div class="summary_box total_box">
								<div class="payment_header">결제하실 금액</div>
								<div class="payment_footer">
								    <div class="result">
								        <span class="num verdana" id="summary_total_amount"></span><span class="won">원</span>
							        </div>
							    </div>
							</div>
							<div class="summary_box discount_box" id="tps_discount_box">
								<div class="payment_header">할인내역</div>
								<div class="payment_body" id="summary_discount_list"></div>
								<div class="payment_footer">
								    <div class="label">
								        <span>총 할인금액</span>
								    </div>
								    <div class="result">
								        <span class="num verdana" id="summary_discount_total">0</span><span class="won">원</span>
								    </div>
							    </div>
							</div>
							<div class="summary_box payment_box" id="tps_payment_box">
								<div class="payment_header">결제내역</div>
								<div class="payment_body" id="summary_payment_list">
									<dl data-code="XXXX" class="code_XXXX" style="display: none;">
										<dt style="top: 11px;"> 0%할인</dt>
										<dd>
											<span class="num">0</span>
											<span class="won">원</span>
											<span>할인취소</span>
										</dd>
									</dl>
									<dl data-code="0010" class="code_0010">
										<dt style="top: 11px;">신용카드</dt>
										<dd>
											<span class="num"></span>
											<span class="won">원</span>
										</dd>
									</dl>
								</div>
								<div class="payment_footer">
								    <div class="label">
					                    <span>남은 결제금액</span>
					                </div>
					                <div class="result">
					                    <span class="num verdana" id="summary_payment_total"></span><span class="won">원</span>
					                </div>
					            </div>
							</div>
						</div>
						<div class="tps_footer no_english">
						</div>
					</div>
					</div>
					<div class="ticket_payment_clear"></div>
					</div>
				</div>
				<!-- //step3 -->
				<!-- step4 -->
				<div class="step step4" style="display:none;">
<!-- complement of payment 섹션 -->
<div class="section section-complement">
    <div class="col-head">
        <!--<img src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/title_complement.png" alt="예매 완료" />-->
    </div>
    
	<div class="col-body">
	
        <div class="article result">
        	
            <div class="text_complement"><img src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/step4/text_complement.png" alt="예매가 완료 되었습니다."> </div>
			
            <div class="ticket_summary_wrap">
                <div class="ticket_summary">
                    <div class="poster"><img src="" alt="" style="visibility: visible; display: inline;"></div>
                    <table>
                        <caption>예매정보</caption>
                        <thead></thead>
                        <tbody>
                            <tr class="ticket_no">
                                <th scope="row">예매번호</th> 
                                <td><span class="red"></span></td>
                            </tr>
                            <tr class="movie_name">
                                <th scope="row">영화</th>
                                <td><em></em></td>
                            </tr>
                            <tr class="theater">
                                <th scope="row">극장</th>
                                <td><em><span class="theater_name"></span> / <span class="theater_loc"></span></em></td>
                            </tr>
                            <tr class="movie_date">
                                <th scope="row">일시</th>
                                <td><em></em></td>
                            </tr>
                            <tr class="people">
                                <th scope="row">인원</th>
                                <td><em></em></td>
                            </tr>
                            <tr class="seat">
                                <th scope="row">좌석</th>
                                <td><em></em></td>
                            </tr>
                            <tr class="payment_price">
                                <th scope="row">결제금액</th>
                                <td><span class="price"></span> 원</td>
                            </tr>
                            <tr class="payment_method">
                                <th scope="row">결제수단</th>
                                <td>
                                    <!--
                                    <div class="row">
                                        <span class="title"><em>신용카드</em></span>
                                        <span class="content"><span class="price">5,000</span>원 (BC카드 할인 <span class="price">3,000</span>원)</span>
                                    </div>
                                    <div class="row">
                                        <span class="title"><em>휴대폰</em></span>
                                        <span class="content"><span class="price">5,000</span>원</span>
                                    </div>
                                    -->
                                <div class="row"><span class="title"><em></em></span><span class="content"><span class="price"></span>원</span></div></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="ticket_instructions">
                <dl>
                    <dt><img src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/step4/text_ticket_instructions.png" alt="예매 유의 사항"></dt>
                    <dd>
                        <ul>
                            <li>영화 상영 스케줄은 영화관사정에 의해 변경될 수 있습니다.</li>
                            <li>비회원 예매하신 경우는 예매내역이 이메일로  발송되지 않습니다.</li>
                        </ul>
					</dd>
                </dl>
            </div>
        </div>
    </div>
</div></div>
				</div>
				<!-- //step4 -->
				<noscript>
					<div class="noscript"><span>현재 사용중인 환경에서는 스크립트 동작이 활성화되지 않아 예매 서비스를 이용하실 수 없습니다.<br/>예매 서비스를 이용하기 위해서는 <a href='http://www.enable-javascript.com/ko/' rel='nofollow'>스크립트 동작을 활성화</a> 해주세요.</span></div>
				</noscript>
			</div>
			
			<!-- bottom bar -->
			<div class="tnb_area">
				<div class="tnb_container">
				<div class="tnb_reset_btn"><a href="#" onmousedown="javascript:logClick('옵션/예매다시하기');" onclick="ticketRestart();return false;">예매 다시하기</a></div>
				<div class="tnb step1">
					<!-- btn-left -->
				<a class="btn-left" href="#" onclick="OnTnbLeftClick(); return false;" title="영화선택">이전단계로 이동</a>
				
					<div class="info movie">
						<span class="movie_poster"><img src alt="영화 포스터"/></span>
						<div class="row movie_title colspan2">
							<span class="data letter-spacing-min ellipsis-line2"><a href="#" target="_blank" onmousedown="javascript:logClick('SUMMARY/영화상세보기');" title="새창열기">영화정보 상세보기</a></span>
						</div>
						<div id="test" class="row movie_type">
							<span class="data ellipsis-line1"></span>
						</div>
						<div class="row movie_rating">
							<span class="data"></span>
						</div>
						<div class="placeholder" title="영화선택"></div>
					</div>
					<div class="info theater">
						<div class="row name">
							<span class="header">극장</span>
							<span class="data letter-spacing-min ellipsis-line1"><a href="#" target="_blank" onmousedown="javascript:logClick('SUMMARY/극장상세보기');" title="새창열기">극장정보 상세보기</a></span>
						</div>
						<div class="row date">
							<span class="header">일시</span>
							<span class="data"></span>
						</div>
						<div class="row screen">
							<span class="header">상영관</span>
							<span class="data"></span>
						</div>
						<div class="row number">
							<span class="header">인원</span>
							<span class="data"></span>
						</div>
						<div class="placeholder" title="극장선택"></div>
					</div>
					<div class="info seat">
						<div class="row seat_name">
							<span class="header">좌석명</span>
							<span class="data">일반석</span>
						</div>
						<div class="row seat_no colspan3">
							<span class="header">좌석번호</span>
							<span class="data ellipsis-line3"></span>
						</div>
						<div class="placeholder" title="좌석선택"></div>
					</div>
					<div class="info payment-ticket">
						<div class="row payment-adult">
							<span class="header">일반</span>
							<span class="data"><span class="price"></span>원<span class="quantity"></span></span>
						</div>
						<div class="row payment-youth">
							<span class="header">청소년</span>
							<span class="data"><span class="price"></span>원<span class="quantity"></span></span>
						</div>
						<div class="row payment-child">
							<span class="header">어린이</span>
							<span class="data"><span class="price"></span>원<span class="quantity"></span></span>
						</div>						
						<div class="row payment-special">
							<span class="header">우대</span>
							<span class="data"><span class="price"></span>원<span class="quantity"></span></span>
						</div>
						<div class="row payment-final">
							<span class="header">총금액</span>
							<span class="data"><span class="price">0</span><span class='won'>원</span></span>
						</div>
					</div>
					<div class="info path">
						<div class="row colspan4">
							<span class="path-step2" title="좌석선택">&nbsp;</span>
							<span class="path-step3" title="결제">&nbsp;</span>
						</div>
					</div>
					<!-- btn-right -->
					<div class="tnb_step_btn_right_before" id="tnb_step_btn_right_before"></div>
					<a class="btn-right" id="tnb_step_btn_right" href="#" onclick="OnTnbRightClick(); return false;" title="">다음단계로 이동 - 레이어로 서비스 되기 때문에 가상커서를 해지(Ctrl+Shift+F12)한 후 사용합니다.</a>
				</div>
			</div>
			</div>
			<!-- 배너 -->
			<div class="banner" id="ticket_bottom_banner"><a  target="_blank" title="새창"><span style="sreader"></span></a></div>
			<!-- //배너 -->
			<!-- 팝업 -->
			<div class="popups">  
			
			
			
			
			              
				<!-- Popup - 로그인 --> 
				<div class="ft_layer_popup popup_login">
				    <!--<div class="hd">
				        <div class="title_area">
				            
				            <h4>CGV회원 로그인</h4>
							
							<span class="sreader">빠른예매는 레이어로 서비스 되기 때문에 가상커서를 해지(Ctrl+Shift+F12)한 후 사용합니다.</span>
				        </div>
				        <a href="#" onclick="return false;" class="layer_close">닫기</a>
				    </div>
				    <div class="bd">
				        <div class="login_form">
				            <div class="input_wrap id">
				                <label for="txtUserId" class="blind">아이디</label>
				                <input name="txtUserId" id="txtUserId" maxlength="25" type="text">
				            </div>
				            <div class="input_wrap password">
				                <label for="txtPassword" class="blind">비밀번호</label>
				                <input name="txtPassword" id="txtPassword" maxlength="25" type="password">
				            </div>
				            <button type="button" title="로그인" class="btn_login"><span>로그인</span></button>       
				        </div>
				        <div class="linkbar">
				        	
				            <a href="#" onclick="return false;" class="join_member">회원가입</a>
				            <a href="#" onclick="return false;" class="join_guest">비회원 예매</a>
				            <a href="#" onclick="return false;" class="id_find">아이디찾기</a>
				            <a href="#" onclick="return false;" class="pw_find">비밀번호찾기</a>    
							
				        </div>
				    </div>-->
				</div>
				<!-- //Popup -->

		<!-- Popup - 얼럿 --> 
		<div class="ft_layer_popup popup_alert original" style="">
		    <div class="hd">
		        <div class="title_area">
		            <h4 class="alert_title">얼럿타이틀</h4>
					<span class="sreader">빠른예매는 레이어로 서비스 되기 때문에 가상커서를 해지(Ctrl+Shift+F12)한 후 사용합니다.</span>
		        </div>
		        <a href="#" onclick="return false;" class="layer_close">닫기</a>
		    </div><!-- //hd -->
		    <div class="bd">
		        <p class="alert_msg">얼럿메세지</p>
		    </div><!-- //bd -->
		    <div class="ft">
		        <a title="확인" href="#" onclick="return false;" class="btn btn_ok"><span>확인</span></a>
		        <a title="취소" href="#" onclick="return false;" class="btn btn_white btn_close"><span>취소</span></a>
		    </div><!-- //ft -->     
		</div>
		<!-- //Popup -->
		
		<!-- Popup - guide --> 
		<div class="ft_layer_popup popup_guide" >
		    <div class="guide_hd">
		        <h4><span class="blind">CGV 예매가이드</span></h4>
		        <p><span class="blind">새롭게 바뀐 CGV 예매 서비스를 직접 확인해보세요!</span></p>
		    </div><!-- //hd -->
		    <div class="guide_bd">
		        <div class="tab_menu clfix">
		            <ul>
		                <li class="a first"><a href="#none" onclick="return false;" class="on" title="STEP 1 영화, 극장, 날짜, 시간 선택"><span><var><span class="blind_txt tab1">STEP 1 영화, 극장, 날짜, 시간 선택</span></var></span></a></li>
		                <li class="b"><a href="#none" onclick="return false;" title="STEP 2 인원, 좌석선택"><span><var><span class="blind_txt tab2">STEP 2 인원, 좌석선택</span></var></span></a></li>
		                <li class="c"><a href="#none" onclick="return false;" title="STEP 3 결제하기"><span><var><span class="blind_txt tab3">STEP 3 결제하기</span></var></span></a></li>
		            </ul>
		        </div>
		        <div class="content">
		            <div class="guide_step01">
		                <p class="notice"><span class="blind">원하시는 영화, 극장, 날짜, 시간 정보를 선택해주세요!</span></p>
		                <div class="guide_btn">
		                    <p><span class="question blind_txt">물음표</span><span class="info">를 오버시 해당 설명을 볼 수 있습니다.</span></p>
		                    <ul>
		                        <li class="btn01">
		                            <a href="#" onclick="return false;" class="btnVisInfo blind_txt">물음표-새롭게 바뀐 CGV 예매서비스안내</a>
		                            <p class="infoBx">
		                                <span class="top"></span>
		                                <span class="middle">전체 화면구성이 세로형으로 변경되어 더 빠르고 쉽게 정보 선택이 가능해졌어요!</span>
		                                <span class="bottom"></span>
		                            </p>
		                        </li>
		                        <li class="btn02">
		                            <a href="#" onclick="return false;" class="btnVisInfo blind_txt">물음표-영화분류안내</a>
		                            <p class="infoBx">
		                            <span class="top"></span>
		                            <span class="middle">무비꼴라쥬, 특별관 영화를 빠르고 편리하게 분류하여 확인할 수 있어요!</span>
		                            <span class="bottom"></span>
		                            </p>
		                        </li>
		                        <!--
		                        <li class="btn03">
		                            <a href="#" onclick="return false;" class="btnVisInfo blind_txt">물음표-선택할 수 없는 영화안내</a>
		                            <p class="infoBx">
		                            <span class="top"></span>
		                            <span class="middle">선택 불가능한 정보는 장애인 차별금지법에 따라 패턴 디자인을 적용하여 모든 사용자가 쉽게 구분할 수 있어요!</span>
		                            <span class="bottom"></span>
		                            </p>
		                        </li>
		                        -->
		                        <li class="btn04">
		                            <a href="#" onclick="return false;" class="btnVisInfo blind_txt">물음표-자주가는 CGV안내</a>
		                            <p class="infoBx">
		                            <span class="top"></span>
		                            <span class="middle">자주 가는 극장 설정 기능을 통해 보다 빠른 극장 선택이 가능해졌어요!</span>
		                            <span class="bottom"></span>
		                            </p>
		                        </li>
		                        <li class="btn05">
		                            <a href="#" onclick="return false;" class="btnVisInfo blind_txt">물음표-영문 빠른예매</a>
		                            <p class="infoBx">
		                            <span class="top"></span>
		                            <span class="middle">영문 버전 빠른예매를 통해 다국적 사용자들도 쉽게 예매 서비스를 이용할 수 있어요!</span>
		                            <span class="bottom"></span>
		                            </p>
		                        </li>
		                        <li class="btn06">
		                            <a href="#" onclick="return false;" class="btnVisInfo blind_txt">물음표-조조/심야구분안내</a>
		                            <p class="infoBx">
		                            <span class="top"></span>
		                            <span class="middle">조조/심야 영화 시간에 대해 쉽게 확인할 수 있어요!</span>
		                            <span class="bottom"></span>
		                            </p>
		                        </li>
		                        <li class="btn07">
		                            <a href="#" onclick="return false;" class="btnVisInfo blind_txt">물음표-새롭게 바뀐 CGV 예매서비스안내</a>
		                            <p class="infoBx">
		                            <span class="top"></span>
		                            <span class="middle">선택한 예매 정보 및 나의 예매 진행 단계를 한 눈에 파악할 수 있어요!</span>
		                            <span class="bottom"></span>
		                            </p>
		                        </li>
		                    </ul>
		                </div>
		            </div><!--//guide_step01-->
		            <div class="guide_step02">
		                <p class="notice"><span class="blind">예매 인원수에 맞게 원하시는 자리 를 선택해주세요!</span></p>
		                <div class="guide_btn">
		                    <p><span class="question blind_txt">물음표</span><span class="info">를 오버시 해당 설명을 볼 수 있습니다.</span></p>
		                    <ul>
		                        <li class="btn01">
		                            <a href="#" onclick="return false;" title="" class="btnVisInfo blind_txt">물음표-상영관/시간 확인 및 변경안내</a>
		                            <p class="infoBx">
		                                <span class="top"></span>
		                                <span class="middle">선택한 상영관/시간 확인 및 변경 기능이 보다 쉽고 눈에 띄게 변경되었어요!</span>
		                                <span class="bottom"></span>
		                            </p>
		                        </li>
		                        <li class="btn02">
		                            <a href="#" onclick="return false;" title="" class="btnVisInfo blind_txt">물음표-다양한 좌석도 보기안내</a>
		                            <p class="infoBx">
		                                <span class="top"></span>
		                                <span class="middle">좌석도 크게 보기 기능으로 시력이 좋지 않으신 분들도 쉽게 예매가 가능해졌어요!</span>
		                                <span class="bottom"></span>
		                            </p>
		                        </li>
		                    </ul>
		                </div>
		            </div><!--//guide_step02-->
		            <div class="guide_step03">
		                <p class="notice"><span class="blind">원하시는 할인 및 결제수단을 이용하여 예매를 완료해주세요!</span></p>
		                <div class="guide_btn">
		                    <p><span class="question blind_txt">물음표</span><span class="info">를 오버시 해당 설명을 볼 수 있습니다.</span></p>
		                    <ul>
		                        <li class="btn01">
		                            <a href="#" onclick="return false;" title="" class="btnVisInfo blind_txt">물음표-할인 및 결제수단안내</a>
		                            <p class="infoBx">
		                                <span class="top"></span>
		                                <span class="middle">전체 화면구성이 할인수단과 결제수단 영역으로 나뉘어 한 눈에 보기 편리해졌어요!</span>
		                                <span class="bottom"></span>
		                            </p>
		                        </li>
		                        <li class="btn02">
		                            <a href="#" onclick="return false;" title="" class="btnVisInfo blind_txt">물음표-CGV영화관람권,할인쿠폰, CJ ONE포인트 안내</a>
		                            <p class="infoBx">
		                                <span class="top"></span>
		                                <span class="middle">주요 할인수단인 CGV영화관람권, CGV할인쿠폰, CJ ONE 포인트의 바로 조회 기능을 통해 보다 빠른 예매가 가능해졌어요!</span>
		                                <span class="bottom"></span>
		                            </p>
		                        </li>
		                        <li class="btn03">
		                            <a href="#" onclick="return false;" title="" class="btnVisInfo blind_txt">물음표-할인수단별 선택안내</a>
		                            <p class="infoBx">
		                                <span class="top"></span>
		                                <span class="middle">다양한 CGV의 할인수단을 보기 쉽게 그룹화하여 원하는 할인수단만 선택해 이용하실 수 있어요!</span>
		                                <span class="bottom"></span>
		                            </p>
		                        </li>
		                        <li class="btn04">
		                            <a href="#" onclick="return false;" title="" class="btnVisInfo blind_txt">물음표-결제정보안내</a>
		                            <p class="infoBx">
		                                <span class="top"></span>
		                                <span class="middle">내가 적용한 할인 및 결제수단 내역을 한 눈에 쉽게 확인 가능해요!</span>
		                                <span class="bottom"></span>
		                            </p>
		                        </li>
		                        <li class="btn05">
		                            <a href="#" onclick="return false;" title="" class="btnVisInfo blind_txt">물음표-최신할인정보안내</a>
		                            <p class="infoBx">
		                                <span class="top"></span>
		                                <span class="middle">다양한 CGV결제수단의 최신 할인 정보를 쉽게 모아 볼 수 있어요!</span>
		                                <span class="bottom"></span>
		                            </p>
		                        </li>
		                    </ul>
		                </div>
		            </div><!--//guide_step03-->
		        </div>
		    </div><!-- //bd -->  
		    <div class="ft">
		        <a title="닫기" href="#" onclick="return false;" class="btn btn_white btn_close"><span>닫기</span></a>
		        <a title="닫기" href="#" onclick="return false;" class="layer_close">닫기</a>
		    </div><!-- //ft -->  
		</div>				
		<!-- 결제내역 확인 팝업 -->
		<div class="ft_layer_popup popup_reservation_check" style="position: absolute; top: 20px;" name="popup_reservation_check">
		    <div class="hd">
		        <div class="title_area">
		            
		            <h4>예매내역 확인</h4>
					                
		        </div>
		        <a title="닫기" href="#" onclick="return false;" class="layer_close"><span class="sreader">창 닫기</span></a>
		    </div><!-- //hd -->
		    <div class="bd">
		        <div class="article reservation_info">
		        	
		            <h5>예매정보<span class="desc">결제하시기 전 예매내역을 다시 한번 확인해 주세요.</span></h5>
					
		            <div class="content">
		                <div class="poster"><img src="http://img.cgv.co.kr/Movie/Thumbnail/Poster/000079/79744/79744_185.JPG" alt="" style="display: inline; visibility: visible;"></div>
		                <table>
		                    <caption>예매정보</caption>
		                    <thead></thead>
		                    <tbody>
		                        <tr class="movie_name">
		                            <th scope="row">영화명</th>
		                            <td></td>
		                        </tr>
		                        <tr class="theater">
		                            <th scope="row">극장</th>
		                            <td></td>
		                        </tr>
		                        <tr class="screen">
		                            <th scope="row">상영관</th>
		                            <td></td>
		                        </tr>
		                        <tr class="movie_date">
		                            <th scope="row">일시</th>
		                            <td></td>
		                        </tr>
		                        <tr class="people">
		                            <th scope="row">인원</th>
		                            <td></td>
		                        </tr>
		                        <tr class="seat">
		                            <th scope="row">좌석</th>
		                            <td></td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
		        </div>
		        <div class="article payment_info">
		        	
		            <h5>결제정보<span class="desc">결제하기 버튼을 클릭하시면 결제가 완료됩니다.</span></h5>
					
		            <table>
		                <caption>결제정보</caption>
		                <thead></thead>
		                <tbody>
		                    <tr class="payment_price">
		                        <th scope="row">결제금액</th>
		                        <td><span class="price"></span>원</td>
		                    </tr>
		                    <tr class="payment_method">
		                        <th scope="row">결제수단</th>
		                        <td>
		                        
		                            <div style="height:170px;overflow:auto;">
		                                <!--<div class="row credit_card">
		                                    <span class="title"></span>
		                                    <span class="content"><span class="price">5,000</span>원 (BC카드 할인 <span class="price">3,000</span>원)</span>
		                                </div>-->
		                                <div class="row phone" style="display: none;">
		                                    <span class="title">휴대폰</span>
		                                    <span class="content"><span class="price"></span>원</span>
		                                    <span class="desc">
		                                        <span class="left">소액결제 내역 &gt;</span>
		                                        <span class="right">상품명 : 영화티켓예매<br>휴대폰 결제금액 : <span class="price">8,000</span>(VAT포함)<br>제공기간 : 일반결제</span>
		                                    </span>
		                                </div>
		                                <div class="row sms_author" style="display: none;">
		                                    <span class="title"><label for="lp_sms_author">휴대폰 인증번호</label></span>
		                                    <span class="content"><div class="wrap_input"><input type="text" id="lp_sms_author" value="" maxlength="6"></div><a title="재전송" href="#" onclick="return false;" class="btn btn_white btn_resend"><span>재전송</span></a><br><span class="caution">휴대폰 결제 시 휴대폰 인증이 필요합니다.</span></span>
		                                </div>
		                                <div class="row sms_author_safe" style="display: none;">
		                                    <span class="title"><label for="lp_sms_author_safe">안심결제 비밀번호</label></span>
		                                    <span class="content"><div class="wrap_input"><input type="text" id="lp_sms_author_safe" value="" maxlength="4"></div></span>
		                                </div>
		                                <div class="payment_methods"><div class="row" pay-code="0010"><span class="title"></span><span class="content"><span class="price"></span>원</span></div></div>
		                            </div>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        <div class="article desc" style="border-bottom: none; background: none;">
		        	
		            <ul>
		                <li>인터넷 예매는 온라인상으로 영화상영 시간 20분 전 까지 취소 가능하며 20분 이후에는 현장에서 취소를 하셔야 합니다.</li>
		                <li>취소는 상영시간 전 까지 하실 수 있으며, 전화로 취소 요청을 하실 경우 취소가 되지 않습니다.</li>
		                <li>입장지연에 다른 관람 불편을 최소화하고자 본 영화는 약 10분 후에 시작됩니다. (일부 극장 제외)</li>
		            <li id="theaterDescCl" style="display: none;"></li></ul>
					
		        </div>
		        <div class="agreement" style="border-top: 1px solid rgb(204, 204, 204); padding-top: 15px; background: rgb(238, 238, 238); height: 80px; text-align: left; border-bottom: 1px solid rgb(204, 204, 204); padding-bottom: 15px; margin: 0px 0px 28px;">
		        <div id="paymentAgreement" style="float: left; width: 47%; height: 100%; padding-left: 3%; border-right: 1px solid rgb(204, 204, 204);">
		        <span class="inputModel" style=" width: 410px; min-height: 15px; margin: 0px 0px 10px;">
		        <input class="inputModel_input" type="checkbox" style="display: inline-block; vertical-align: top; margin-top: 1px;" id="agreementAll">
		        <label class="inputModel_label" style="width: 93%; display: inline-block; margin-left: 10px; font-weight: bold;" for="agreementAll">결제대행서비스 약관에 모두 동의</label></span>
		        <span class="inputModel" style="display: block; width: 99%; min-height: 15px; margin-bottom: 5px; margin-left: 10px;" id="agreeMent0"><input class="inputModel_input agreeMentChk" type="checkbox" style="display: inline-block; vertical-align: top; margin-top: 1px;" id="agreeMent0val"><label class="inputModel_label" style="width: 325px; display: inline-block; margin-left: 10px;" for="agreeMent0val">전자금융거래 이용약관</label>
		        <button class="detailView" style="background: none; text-decoration: underline; font-size: 1em; color: rgb(32, 124, 202); padding: 0px; height: 16px; vertical-align: top;">전문확인</button></span>
		        <span class="inputModel" style="display: block; width: 99%; min-height: 15px; margin-bottom: 5px; margin-left: 10px;" id="agreeMent1"><input class="inputModel_input agreeMentChk" type="checkbox" style="display: inline-block; vertical-align: top; margin-top: 1px;" id="agreeMent1val">
		        <label class="inputModel_label" style="width: 325px; display: inline-block; margin-left: 10px;" for="agreeMent1val">개인정보 수집 이용약관</label>
		        <button class="detailView" style="background: none; text-decoration: underline; font-size: 1em; color: rgb(32, 124, 202); padding: 0px; height: 16px; vertical-align: top;">전문확인</button></span>
		        <span class="inputModel" style="display: block; width: 99%; min-height: 15px; margin-bottom: 5px; margin-left: 10px;" id="agreeMent2"><input class="inputModel_input agreeMentChk" type="checkbox" style="display: inline-block; vertical-align: top; margin-top: 1px;" id="agreeMent2val">
		        <label class="inputModel_label" style="width: 325px; display: inline-block; margin-left: 10px;" for="agreeMent2val">개인정보 제공 및 위탁 안내 약관</label>
		        <button class="detailView" style="background: none; text-decoration: underline; font-size: 1em; color: rgb(32, 124, 202); padding: 0px; height: 16px; vertical-align: top;">전문확인</button></span></div>
		        <div id="paymentInfoConfirm" style="float: left; width: 45%; height: 100%;">
		        <span class="inputModel" style="display: none; width: 400px; min-height: 15px; margin: 0px 0px 7px 20px;"><input class="inputModel_input" type="checkbox" style="display: inline-block; vertical-align: top; margin-top: 1px;" id="resvPKGfirm">
		        <label class="inputModel_label" style="width: 93%; display: inline-block; margin-left: 10px; font-weight: bold;" for="resvPKGfirm">본 영화는 동시상영 영화로 부분환불이 불가한 영화입니다.</label></span>
		        <span class="inputModel" style="display: none; width: 400px; min-height: 15px; margin: 0px 0px 7px 20px;"><input class="inputModel_input" type="checkbox" style="display: inline-block; vertical-align: top; margin-top: 1px;" id="resvNoshowfirm">
		        <label class="inputModel_label" style="width: 93%; display: inline-block; margin-left: 10px; font-weight: bold;" for="resvNoshowfirm">취소 기한을 확인하였으며, 이에 동의합니다.</label></span>
		        <span class="inputModel" style="display: block; width: 420px; min-height: 15px; margin: 0px 0px 0px 20px; clear: both;"><input class="inputModel_input" type="checkbox" style="display: inline-block; vertical-align: top; margin-top: 1px;" id="resvConfirm">
		        <label class="inputModel_label" style="width: 93%; display: inline-block; margin-left: 10px; font-weight: bold;" for="resvConfirm">상기 결제 내역을 모두 확인 했습니다</label></span></div></div>
		    </div><!-- //bd -->
		    <div class="ft">
		        <a title="예매 결제하기" href="#" onclick="return false;" class="reservation"><span class="sreader">예매 결제하기</span></a>
		        <a title="예매 취소" href="#" onclick="return false;" class="cancel"><span class="sreader">예매 취소</span></a>
		    </div><!-- //ft -->
		</div>									
		<!-- //Popup -->

			</div>
			<!-- //팝업 -->
		</div>
		<!-- //빠른예매 -->
	</div>
	<!-- //컨텐츠 -->
	
	
	<!-- banner -->
	<div id="ticket_banner" class="ticket_banner">
		<div><div>
			<a class="left_link" target="_blank" alt="" title="새창"><span class="sreader">배너광고 영역</span></a>
			<a class="right_link" target="_blank" alt="" title="새창"><span class="sreader">배너광고 영역</span></a>
		</div></div>
	</div>
	<!-- banner -->
</div>
<div class="blackscreen" style="display:none;" id="blackscreen"></div>
<!-- loading -->
<div class="loading" id="ticket_loading">
	<div class="dimm"></div>
	<p class="loadWrap"><img src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/common/ajax-loader-w.gif" alt="로딩 애니메이션" /></p>
</div>

<!-- iframe -->
<!-- javascript 상위프레임에 있는 스크립트를 사용-->

<!--<script type="text/javascript" src="http://img.cgv.co.kr/common/js/insightIS.js"></script>-->



</body>
