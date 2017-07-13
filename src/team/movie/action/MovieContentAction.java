package team.movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.common.action.Action;
import team.common.action.ActionForward;
import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;

public class MovieContentAction implements Action{

	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward=new ActionForward();
		String movie_num= request.getParameter("num");
		MovieDAO  dao =new MovieDAO();
		MovieBean mb=dao.selectMovie(movie_num);
		request.setAttribute("bean", mb);
		forward.setRedirect(false);
		forward.setPath("index2.jsp?center=movie/content.jsp");
		return forward;
	}

}
