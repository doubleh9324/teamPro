package team.movie.action;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;
import team.place.action.ActionForward;

public class searchPlayingMvSelectAction implements team.common.action.Action{
	//import한 action이 달라서 일단은 이렇게 해놓을게요...
	public team.common.action.ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		System.out.println("action");
		String s_cate = request.getParameter("s_cate");
		String s_movie = request.getParameter("s_movie");
		
		MovieDAO dao= new MovieDAO();
		List<MovieBean> movieList = dao.splayingMovies(s_cate, s_movie);
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		jsonObject.put("total", movieList.size());
		jsonObject.put("movieList", jsona.fromObject(movieList));
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./searchmv.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;		
		}
}