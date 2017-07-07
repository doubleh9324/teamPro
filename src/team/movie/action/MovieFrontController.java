package team.movie.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		}else if(command.equals("/MovieInsertAction.mo")){
			action = new MovieInsertAction();
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
