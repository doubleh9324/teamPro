package team.movie.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.common.action.Action;
import team.common.action.ActionForward;
import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;
import team.place.db.PlaceDAO;
import team.place.db.V_plcaeBean;

public class PlayingMovieListAction implements Action{


	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MovieDAO dao= new MovieDAO();
		List<MovieBean> movieList = dao.playingMovies();
		
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		jsonObject.put("total", movieList.size());
		jsonObject.put("movieList", jsona.fromObject(movieList));
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./reservation.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;	
	}

	
	

}
