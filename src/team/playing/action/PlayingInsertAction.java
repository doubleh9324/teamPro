package team.playing.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.SystemUtils;

import team.playing.db.PlayTimeBean;
import team.playing.db.PlayingBean;
import team.playing.db.PlayingDAO;


public class PlayingInsertAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		//pcode 배열로 받아와서 뒤에붙은 숫자 떼고 순서 정해서 넣어야하고 뒤에 영화관 넣어줘야한당 8ㅅ8
		String sday = request.getParameter("start_day");
		String eday = request.getParameter("end_day");
		int ping_num = Integer.parseInt(request.getParameter("ping_num"));
		
		PlayingBean pb = new PlayingBean();
		pb.setPing_num(ping_num);
		
		
		
		pb.setNc_code(request.getParameter("nc_code"));
		pb.setStart_day(sday);
		pb.setEnd_day(eday);

		//time 배열 지정
		String[] time = request.getParameterValues("time");
		
		//상영 날짜 수 계산
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
		Date sd = formatter.parse(sday);
		Date ed = formatter.parse(eday);
		int days = (int)(ed.getTime() - sd.getTime());
		days = days/(24*60*60*1000) + 1;
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(sd);
		
		List<PlayTimeBean> ptList = new ArrayList<>();
		
		for(int i=0; i<days; i++){
				PlayTimeBean ptb = new PlayTimeBean();
				ptb.setPlay_day(cal.getTime());
				cal.add(Calendar.DATE, 1);
				ptb.setPing_num(ping_num);
				ptb.setPlaytime(time);
				
				ptList.add(ptb);
		}
		
		boolean pbRe=false;
		boolean ptbRe = false;
		
		PlayingDAO playingDao = new PlayingDAO();
		
		String p_code = playingDao.getPcode(request.getParameter("p_code"));
		pb.setP_code(p_code);
		pbRe = playingDao.insertPlaying(pb);
		ptbRe = playingDao.insertPlaytime(ptList);
		
		if(!pbRe&&ptbRe){
			System.out.println("Playing & time 입력 에러");
			return null;
	}


		ActionForward forward = new ActionForward();
		
		forward.setRedirect(true);
		forward.setPath("index.jsp");
		
		return forward;
	}
}
