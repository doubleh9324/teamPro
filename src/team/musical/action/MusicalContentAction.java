package team.musical.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.common.action.Action;
import team.common.action.ActionForward;
import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;
import team.musical.db.MusicalBean;
import team.musical.db.MusicalDAO;

public class MusicalContentAction implements Action{

	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward=new ActionForward();
		String musical_num= request.getParameter("num");
		MusicalDAO  dao =new MusicalDAO();
		MusicalBean mb=dao.selectMusical(musical_num);
		request.setAttribute("bean", mb);
		forward.setRedirect(false);
		forward.setPath("index2.jsp?center=musical/content.jsp");
		return forward;
	
	}

}
