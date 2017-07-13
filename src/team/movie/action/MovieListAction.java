package team.movie.action;

import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.common.action.Action;
import team.common.action.ActionForward;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;

public class MovieListAction implements Action{


	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MovieDAO dao= new MovieDAO();
		List<MovieBean> movieList = dao.getAllMovies();
		
	
	    
	    request.setAttribute("movieList", movieList);
		//request.setAttribute("movieList", movieList);
	    ActionForward forward=new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("index2.jsp?center=movie/allmovie.jsp");
	   
	    
		
		return forward;
	}

	
}
