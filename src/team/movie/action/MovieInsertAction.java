package team.movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;

public class MovieInsertAction implements Action{

	
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		MovieBean mb = new MovieBean();
		mb.setMovie_num(request.getParameter("movie_num"));
		mb.setG_code(request.getParameter("g_code"));
		mb.setName(request.getParameter("name"));
		mb.setDirector(request.getParameter("director"));
		mb.setPlaying_day(request.getParameter("playing_day"));
		mb.setActor(request.getParameter("actor"));
		mb.setProduction(request.getParameter("production"));
		mb.setAge(request.getParameter("age"));
		
		boolean result=false;
		MovieDAO dao = new MovieDAO();
		result = dao.insertMovie(mb);
		
		if(result==false){
			System.out.println("영화 추가 실패");
			return null;
		}
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(true);
		
		forward.setPath("index.jsp");
		
		return forward;
	}

}
