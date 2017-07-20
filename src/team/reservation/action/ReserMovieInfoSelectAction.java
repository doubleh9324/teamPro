package team.reservation.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;
import team.reservation.db.ReservationDAO;

public class ReserMovieInfoSelectAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		//flag 가져와서 date면 날짜 기준으로 영화 theater면 상영관 기준으로 영화
		String flag = request.getParameter("flag");
		String value = request.getParameter("val");
		
		//해당하는 번호로 p_code 검색
		ReservationDAO resDao = new ReservationDAO();
		List<Map<String, Object>> monumList = resDao.getMovie(flag, value);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("monumList", monumList);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./reservation/reservation.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;	
	
		
	}
}
