package team.common.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.omg.CORBA.Request;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;
import team.musical.db.MusicalDAO;

@WebServlet("/SearchAction.sc")
public class SearchAction extends HttpServlet{
	
	protected ActionForward doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		ActionForward forward =new ActionForward();
		String cate = req.getParameter("cate");
		String search = req.getParameter("search");
		System.out.println(cate);
		System.out.println(search);
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		if(cate.equals("mo")){  //영화검색
			MovieDAO dao = new MovieDAO();
			List movieList = dao.searchMovie(search);
			jsonObject.put("setFlag", "y");
		     jsonObject.put("movieList", jsona.fromObject(movieList));
		}else if(cate.equals("mu")){   //뮤지컬 검색
			MusicalDAO dao = new MusicalDAO();
			List musicalList = dao.searchMusical(search);
			jsonObject.put("setFlag", "y");
		     jsonObject.put("searchList", jsona.fromObject(musicalList));
			
		}else{    //모두 검색
			MovieDAO dao = new MovieDAO();
			List movieList = dao.searchMovie(search);
			MusicalDAO dao2 = new MusicalDAO();
			List musicalList= dao2.searchMusical(search);
			jsonObject.put("setFlag", "y");
		     jsonObject.put("searchList", jsona.fromObject(movieList));
		     jsonObject.put("searchList", jsona.fromObject(musicalList));
		     
		}
		
		 
	      
	      forward.setRedirect(false);
	      forward.setPath("index2.jsp?center=search.jsp");
	      
	      resp.setContentType("application/x-json; charset=utf-8");
	      resp.getWriter().print(jsonObject);
	      System.out.println(jsonObject);
		
		return forward;
	}
	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}
	
}
