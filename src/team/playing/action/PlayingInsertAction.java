package team.playing.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import team.playing.db.PlayTimeBean;
import team.playing.db.PlayingBean;
import team.playing.db.PlayingDAO;
import team.playing.db.SeatInfoBean;


public class PlayingInsertAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		PlayingDAO playingDao = new PlayingDAO();
		
		//pcode 배열로 받아와서 뒤에붙은 숫자 떼고 순서 정해서 넣어야하고 뒤에 영화관 넣어줘야한당 8ㅅ8
		String sday = request.getParameter("start_day");
		String eday = request.getParameter("end_day");
		int ping_num = Integer.parseInt(request.getParameter("ping_num"));
		String nc_code = request.getParameter("nc_code");
		
		
		//해당하는 play 정보들을 리스트로 만들어서 dao로 넘겨주기
		//공연장 순서 배열은 seatinfo에 들어가야함
		List<PlayingBean> playList = new ArrayList<>();

		
		String[] p_coden = request.getParameterValues("p_codeList");
		int psize = p_coden.length;
		String[] p_code = new String[psize];
		int[] p_num = new int[psize];
		
		//playtime
		//time 배열 지정
		String[] time = request.getParameterValues("time");
		
		//상영 날짜 수 계산
		SimpleDateFormat dayformat = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat timeformat = new SimpleDateFormat("kk:mm");
		Date sd = dayformat.parse(sday);
		Date ed = dayformat.parse(eday);
		Date pt = null;
		int days = (int)(ed.getTime() - sd.getTime());
		days = days/(24*60*60*1000) + 1;
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(sd);
		
		List<PlayTimeBean> ptList = new ArrayList<>();
		List<SeatInfoBean> siList = new ArrayList<>();

		for(int f=0; f<psize; f++){

			p_num[f] = Integer.parseInt(p_coden[f].substring(6, 7));
			System.out.println(p_num[f]);
		}
		
		int pcNum = 0;
		int scNum = 0;
		//하나의 ping_num에 해당하는 루트를 
		//psize만큼 playlist에 추가하기 (p_code 값만 다름)
		//하나의 p_code에 3개의 time값 * 상영하는 날짜만큼
		for(int i=0; i<psize; i++){

			/**
			 * playing table
			 */
			PlayingBean pb = new PlayingBean();
			//해당하는 영화가 상영될 p_code + 상영관 순서 리스트를 String 배열로 받아와서 저장
			//지금 잘라온 pcode가 이전에 저장한 pcode와 다르면 배열에 추가
			//pcode 종류만큼만 추가되어야함
			String p = playingDao.getPcode(p_coden[i].substring(0, 6));
			
			if(pcNum==0){
				System.out.println(">>>>>>>>>>ping_num : "+ping_num);
				//제일 처음엔 잘라온 값 그대로 넣기
				p_code[pcNum] = p;			
				pb.setPing_num(ping_num);
				pb.setP_code(p_code[pcNum]);
				pb.setNc_code(nc_code);
				pb.setStart_day(sday);
				pb.setEnd_day(eday);
				System.out.println("pcNum=0 :"+p);
				System.out.println("playList 추가 : "+ping_num + " / " + p_code[pcNum] + " / " + nc_code + " / " + sday+ " / " + eday);
				playList.add(pb);
				

				System.out.println(p_coden[pcNum].substring(6, 7));
				
				//하나의 pcode에 3개의 등급
				for(int q=0; q<3; q++){
					SeatInfoBean sib = new SeatInfoBean();
					System.out.println(">>>>>>>>>>ping_num : "+ping_num);
					//제일 처음엔 값 그대로 넣기
					sib.setPing_num(ping_num);
					sib.setP_code(p_code[pcNum]);
					System.out.println( p_num[scNum]);
					String scrName = playingDao.getScreenName(p_code[pcNum].substring(0,6), p_num[scNum]);
					sib.setScreen_name(scrName);
					
					String[] sClass = {"VIP", "R", "S"};
					int[] sPrice = {11000, 9000, 8000};
					sib.setSeatclass(sClass[q]);
					sib.setPrice(sPrice[q]);
					int cap = playingDao.getCapacity(p_code[pcNum]);
					
					//등급에 따라 가격 정하기
					if(q==0){
						//vip 10%
						sib.setSeat_num((int)(cap*0.1));
					}else if(q==1){
						//R 30%
						sib.setSeat_num((int)(cap*0.3));
					}else if(q==2){
						//S 60%
						sib.setSeat_num((int)(cap*0.6));
					}
					
					sib.setEvent_code("n");
					
					siList.add(sib);
					System.out.println("siList 추가 : "+ping_num + " / " + p_code[pcNum] + " / " + scrName + " / " + 
										sClass[q]+ " / " + sPrice[q]);

				}
				scNum++;
				pcNum++;
			}else if(!(p_code[pcNum-1].equals(p)) && (pcNum>0)){
				//pcode가 새로운 값일 때
				ping_num++;
				
				System.out.println(">>>>>>>>>>ping_num : "+ping_num);
				pb.setPing_num(ping_num);
				p_code[pcNum] = p;
				pb.setP_code(p_code[pcNum]);
				pb.setNc_code(nc_code);
				pb.setStart_day(sday);
				pb.setEnd_day(eday);
				System.out.println("pcNum>0 :"+p+" / " +p_code[pcNum-1]);
				playList.add(pb);
				System.out.println("playList 추가 : "+ping_num + " / " + p_code[pcNum] + " / " + nc_code + " / " + sday+ " / " + eday);
				

				
					for(int q=0; q<3; q++){
						SeatInfoBean sib = new SeatInfoBean();
						System.out.println(">>>>>>>>>>ping_num : "+ping_num);
						//제일 처음엔 값 그대로 넣기
						sib.setPing_num(ping_num);
						sib.setP_code(p_code[pcNum]);
						String scrName = playingDao.getScreenName(p_code[pcNum].substring(0,6), p_num[scNum]);
						sib.setScreen_name(scrName);
						
						String[] sClass = {"VIP", "R", "S"};
						int[] sPrice = {11000, 9000, 8000};
						sib.setSeatclass(sClass[q]);
						sib.setPrice(sPrice[q]);
						int cap = playingDao.getCapacity(p_code[pcNum]);
						
						//등급에 따라 가격 정하기
						if(q==0){
							//vip 10%
							sib.setSeat_num((int)(cap*0.1));
						}else if(q==1){
							//R 30%
							sib.setSeat_num((int)(cap*0.3));
						}else if(q==2){
							//S 60%
							sib.setSeat_num((int)(cap*0.6));
						}
						
						sib.setEvent_code("n");
						
						siList.add(sib);
						System.out.println("siList 추가 : "+ping_num + " / " + p_code[pcNum] + " / " + scrName + " / " + 
											sClass[q]+ " / " + sPrice[q]);
					}
				
				
				
				pcNum++;

			}
			
			/**
			* playtime table
			* 해당하는 ping_num 하나에 상영날짜만큼 play_day 
			* play_day 하나에 ptime 3개
			*/
			//하나의 ping_num에 (= 하나의 p_code에)
			//상영 날짜만큼
			for(int j=0; j<days; j++){
				//3개의 time반복
				for(int k=0; k<3; k++){
					System.out.println(">>>>>>>>>>ping_num : "+ping_num);
					PlayTimeBean ptb = new PlayTimeBean();
					ptb.setPlay_day(cal.getTime());
					ptb.setPlaytime(time[k]);
					ptb.setPing_num(ping_num);
					ptList.add(ptb);
					System.out.println("ptList 추가 : "+ping_num + " / " + cal.getTime() + " / " + time[k] );
				}
				cal.add(Calendar.DATE, 1);
				
		}

			
			/**
			 * seatInfo table
			
			
			//상영관 순서 리스트 seatInfo
			p_num[i] = Integer.parseInt(p_coden[i].substring(6, 7));
			System.out.println(p_coden[i].substring(6, 7));
			int scrNum = 0;
			
			//하나의 ping_num에(현재 반복문에 ping_num제어 완료) 관 갯수만큼(p_num만큼)
				
			SeatInfoBean sib = new SeatInfoBean();
			
			if(scrNum==0){
				//등급 3개
				for(int q=0; q<3; q++){
					
					System.out.println(">>>>>>>>>>ping_num : "+ping_num);
					//제일 처음엔 값 그대로 넣기
					sib.setPing_num(ping_num);
					sib.setP_code(p_code[pcNum]);
					String scrName = playingDao.getScreenName(p_code[pcNum].substring(0,6), p_num[scrNum]);
					sib.setScreen_name(scrName);
					
					String[] sClass = {"VIP", "R", "S"};
					int[] sPrice = {11000, 9000, 8000};
					sib.setSeatclass(sClass[q]);
					sib.setPrice(sPrice[q]);
					int cap = playingDao.getCapacity(p_code[pcNum]);
					
					//등급에 따라 가격 정하기
					if(q==0){
						//vip 10%
						sib.setSeat_num((int)(cap*0.1));
					}else if(q==1){
						//R 30%
						sib.setSeat_num((int)(cap*0.3));
					}else if(q==2){
						//S 60%
						sib.setSeat_num((int)(cap*0.6));
					}
					
					sib.setEvent_code("n");
					
					System.out.println("siList 추가 : "+ping_num + " / " + p_code[pcNum] + " / " + scrName + " / " + 
										sClass[q]+ " / " + sPrice[q]);
					
				}
			}else if((p_num[scrNum] > p_num[scrNum-1]) && scrNum>0){
				//이전 숫자보다 현재 숫자가 클 때만 같은 p_code 넣기
			}
					
				//관 갯수만큼 클래스 3개 (가격지정 같이)
			
			*/
			 

			

	}

		
	//	for(int s=0; s<playList.size(); s++)
	//	System.out.println(playList.get(s).getPing_num());
		
		//dao 실행 후 결과값으로 성공 여부 조회
		boolean pbRe=false;
		boolean ptbRe = false;
		boolean siRe = false;
		
		pbRe = playingDao.insertPlaying(playList);
		ptbRe = playingDao.insertPlaytime(ptList);
		siRe = playingDao.insertSeatInfo(siList);
		
		if(!pbRe&&ptbRe&&siRe){
			System.out.println("Playing & time & seatinfo 입력 에러");
			return null;
	}


		ActionForward forward = new ActionForward();
		
		forward.setRedirect(true);
		forward.setPath("index.jsp");
		
		return forward;
	}
}
