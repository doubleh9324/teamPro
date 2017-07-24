package team.reservation.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;
import team.reservation.db.ReservationDAO;

public class ReserTimeInfoSelectAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		//flag 가져와서 date면 날짜 기준으로 상영관 movie면 영화 기준으로 상영관
		String pcode = request.getParameter("pcode");
		String mo_num = request.getParameter("mo_num");
		String playday = request.getParameter("playday");
		
		//해당하는 번호로 p_code 검색
		ReservationDAO resDao = new ReservationDAO();
		List<Map<String, Object>> TimeInfoList = resDao.getTime(mo_num, pcode, playday);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("TimeInfoList", TimeInfoList);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./reservation/reservation.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;	
		
	}

}
