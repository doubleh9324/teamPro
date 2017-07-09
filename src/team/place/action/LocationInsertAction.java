package team.place.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.place.db.LocationBean;
import team.place.db.PlaceDAO;

public class LocationInsertAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		LocationBean lb = new LocationBean();
		lb.setL_code(request.getParameter("l_code"));
		lb.setLocation(request.getParameter("location"));
		
		boolean lbRe=false;
		
		PlaceDAO placeDao = new PlaceDAO();
		lbRe = placeDao.insertLocation(lb);
		
		if(!lbRe){
			System.out.println("Location 입력 에러");
			return null;
	}


		ActionForward forward = new ActionForward();
		
		forward.setRedirect(true);
		forward.setPath("index.jsp");
		
		return forward;
	}

}
