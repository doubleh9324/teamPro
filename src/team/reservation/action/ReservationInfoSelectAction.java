package team.reservation.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;

public class ReservationInfoSelectAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//movie_num 가져오기
		String mo_num = request.getParameter("mo_num");
		
		//해당하는 번호로 p_code 검색
		ReservationDAO resDao = new ReservationDAO();
		List<Map<String, Object>> pcodeList = resDao.getPlace(mo_num);
		System.out.println(pcodeList.get(0).get("p_code"));
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		jsonObject.put("pcodeList", pcodeList);
		
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
