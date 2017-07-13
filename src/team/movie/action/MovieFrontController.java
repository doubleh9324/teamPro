package team.movie.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.common.action.Action;
import team.common.action.ActionForward;
import team.place.action.searchPlaceSelectAction;

public class MovieFrontController extends HttpServlet {
	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String RequestURI=req.getRequestURI();
		System.out.println(RequestURI);
		
		String contextPath=req.getContextPath();
		System.out.println(contextPath.length());
		
		String command = RequestURI.substring(contextPath.length());
		System.out.println(command);
		
		ActionForward forward = null;
		Action action= null;
		
		
		if(command.equals("/MovieInsert.mo")){
			forward= new ActionForward();
			forward.setRedirect(false);
			forward.setPath("index2.jsp?center=movie/movieInsert.jsp");
			
		}else if(command.equals("/MovieInsertAction.mo")){
			action = new MovieInsertAction();
			try {
				forward= action.excute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/MovieContentAction.mo")){
			action = new MovieContentAction();
			try {
				forward= action.excute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MovieListAction.mo")){
			action = new MovieListAction();
			try {
				forward= action.excute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/searchMovie.mo")){
			try {
				forward = new ActionForward();
				forward.setPath("./searchmv.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/searchPlayingMvSelectAction.mo")){
			action = new searchPlayingMvSelectAction();
			try {
				forward= action.excute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//(���� �ּҷ� �̵�)
		if(forward!=null){//new ActionForward()��ü�� �����ϰ�...
			if(forward.isRedirect()){//true->sendRedirect()���
				resp.sendRedirect(forward.getPath());
			}else{ //false ->forward()���
				RequestDispatcher view = req.getRequestDispatcher(forward.getPath());
				view.forward(req, resp);
			}
		
		}
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

}
