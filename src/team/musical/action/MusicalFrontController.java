package team.musical.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.common.action.Action;
import team.common.action.ActionForward;
import team.movie.action.MovieInsertAction;



public class MusicalFrontController extends HttpServlet{
	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String RequestURI=req.getRequestURI();
		System.out.println(RequestURI);
		
		String contextPath=req.getContextPath();
		System.out.println(contextPath.length());
		
		String command = RequestURI.substring(contextPath.length());
		System.out.println(command);
		
		ActionForward forward = null;
		Action action= null;
		
		if(command.equals("/MusicalInsertAction.mu")){
			action = new MusicalInsertAction();
			try {
				forward= action.excute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MusicalContentAction.mu")){
			action = new MusicalContentAction();
			try {
				forward= action.excute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MusicalInsert.mu")){
			forward= new ActionForward();
			forward.setRedirect(false);
			forward.setPath("index2.jsp?center=musical/musicalInsert.jsp");
		
		}else if(command.equals("/MusicalListAction.mu")){
			action = new MusicalListAction();
			try {
				forward= action.excute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
	
		if(forward!=null){
			if(forward.isRedirect()){
				resp.sendRedirect(forward.getPath());
			}else{ 
				RequestDispatcher view = req.getRequestDispatcher(forward.getPath());
				view.forward(req, resp);
			}
		
		}
	}
		
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}

}
