package team.reservation.action;

import java.util.HashMap;
import java.util.List;
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
		
		//pcode, mo_num, screenname 가져오기
		String pcode = request.getParameter("pcode");
		String mo_num = request.getParameter("mo_num");
		String screen_name = request.getParameter("screen_name");
		String view_date = request.getParameter("viewdate")+"00";
		
		//pcode 관 검색(현재 모든 관이 인원수가 같아서 같은 좌석표 제공)
		ReservationDAO resDao = new ReservationDAO();
		Map<String, Object> seatMap = resDao.getSeatMap(pcode);
		
		//이미 예약되거나 남이 선택한 좌석 가져오기
		
		//ping_num 가져와서 예약된 좌석 목록 가져오기
		int pingnum = resDao.getPingnum(pcode, mo_num);
		List<Map<String, Object>> reserved = resDao.getReservedSeats(pingnum, screen_name, view_date);
		
		//선택된 좌석 가져오기
		List<Map<String, Object>> checked = resDao.getCheckedSeats(pingnum, screen_name, view_date);
		
		JSONObject jsonObject = new JSONObject();
		
		jsonObject.put("seatMap", seatMap);
		jsonObject.put("reservedSeats", reserved);
		jsonObject.put("checkedSeats", checked);
		
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
