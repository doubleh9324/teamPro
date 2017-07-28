package team.reservation.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;
import team.reservation.db.ReservationBean;
import team.reservation.db.ReservationDAO;

public class ReservationInsertAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//member_num, rseat_num, screen_name는 바로 받아와서 사용
		//pcode, movie_num으로 playing table에서 ping_num 가져오기
		//view_date는 String으로 받아와서 포맷 맞게 고쳐주기
		//price 콤마제거 후 형변환
		
		//멤버번호 임의 지정
		int member_num = 1;
		String mo_num = request.getParameter("mo_num");
		String pcode = request.getParameter("pcode");
		String screen_name = request.getParameter("screen_name");
		int price = Integer.parseInt(request.getParameter("price").replace(",", ""));
		String viewdate = request.getParameter("viewdate");
		String seat_no = request.getParameter("seat_no");
		String seat = request.getParameter("seat");
		String time = request.getParameter("time");
		
		ReservationBean rsb = new ReservationBean();
		ReservationDAO resDao = new ReservationDAO();
		
		int pingnum = resDao.getPingnum(pcode, mo_num);
		
		rsb.setMember_num(member_num);
		rsb.setPing_num(pingnum);
		rsb.setReseat_num(seat_no);
		rsb.setScreen_name(screen_name);
		rsb.setSeat(seat);
		rsb.setPrice(price);
		rsb.setView_date(viewdate+time+"00");
		rsb.setMPoint((int) Math.round(price*0.05));
		
		//예매 정보 테이블 받아와서 필요한 정보 변환 후 내보내기
		//굳이 이렇게 해야하는걸까
		ReservationBean resultRsb = resDao.insertReservation(rsb);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("resultRsb", resultRsb);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./reservation/reservation.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;	
		
	}

	

}
