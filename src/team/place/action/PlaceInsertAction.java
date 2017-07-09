package team.place.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.place.db.PlaceBean;
import team.place.db.PlaceDAO;
import team.place.db.Place_detailBean;

public class PlaceInsertAction implements Action{

		@Override
		public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			request.setCharacterEncoding("utf-8");
			
			PlaceBean pb = new PlaceBean();
			pb.setP_code(request.getParameter("p_code"));
			pb.setName(request.getParameter("name"));
			pb.setAddress(request.getParameter("address"));
			pb.setContact_num(request.getParameter("contact_num"));
			pb.setHomepage(request.getParameter("homepage"));
			
			Place_detailBean pbb = new Place_detailBean();
			pbb.setP_code(request.getParameter("p_code"));
			pbb.setScreen_name(request.getParameter("screen_name"));
			pbb.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			
			boolean pbRe=false;
			boolean pbbRe = false;
			
			PlaceDAO placeDao = new PlaceDAO();
			pbRe = placeDao.insertPlace(pb);
			pbbRe = placeDao.insertPlace_detail(pbb);
			
			if(!pbRe&&pbbRe){
				System.out.println("입력 에러");
				return null;
		}


			ActionForward forward = new ActionForward();
			
			forward.setRedirect(true);
			
			forward.setPath("index.jsp");
			return forward;
		}

}
