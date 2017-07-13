package team.musical.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.common.action.Action;
import team.common.action.ActionForward;
import team.musical.db.MusicalBean;
import team.musical.db.MusicalDAO;

public class MusicalListAction implements Action{


	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MusicalDAO dao= new MusicalDAO();
		List<MusicalBean> musicalList = dao.getAllMusicals();
		
	
	    
	    request.setAttribute("musicalList", musicalList);
		//request.setAttribute("movieList", movieList);
	    ActionForward forward=new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("index2.jsp?center=musical/allmusical.jsp"); 
		
		return forward;
	}

	
}
