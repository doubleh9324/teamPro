package team.reservation.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;
import team.reservation.db.ReservationDAO;

public class ReserSeatMapSelectAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//pcode 가져오기
		String pcode = request.getParameter("pcode");
		
		//해당하는 번호 영화검색
		ReservationDAO resDao = new ReservationDAO();
		
		Map<String, Object> seatMap = new HashMap<>();
		
		seatMap = resDao.getSeatMap(pcode);
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		jsonObject.put("seatMap", seatMap);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./reservation/reservation.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;	
	
		//ActionForward forward=new ActionForward();
	//	forward.setRedirect(false);
	//	forward.setPath("./index.jsp");
		
	}
}
