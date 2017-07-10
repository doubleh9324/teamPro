package team.place.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.place.db.PlaceDAO;
import team.place.db.V_plcaeBean;

public class searchPlaceSelectAction implements Action{
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		PlaceDAO placeDao = new PlaceDAO();
		List<V_plcaeBean> placeList = placeDao.selectPlaceList();
		
		request.setAttribute("placeList", placeList);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./searchplace.jsp");
		
		return forward;
	}
	

}
