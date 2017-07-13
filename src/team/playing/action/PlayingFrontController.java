package team.playing.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.movie.action.passMOcodeAction;



public class PlayingFrontController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request, response);
	}


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		//request에서 url가져오기
		String RequestURI=request.getRequestURI();
		System.out.println("요청 : "+RequestURI);
		
		//현재 위치 경로 가져오기
		String contextPath=request.getContextPath();
		System.out.println("현재 : "+contextPath);
		
		//요청 경로 분리하기
		String command=RequestURI.substring(contextPath.length());
		System.out.println("목표: "+command);
		
		ActionForward forward = null;
		Action action = null;
		
		if(command.equals("/getIndexSetInfo.pg")){
				action = new IndexSetInfoSelecAction();
			try {
				forward= action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/PlayingInsertAction.pg")){
			//상영 영화 추가
			action = new PlayingInsertAction();
			try {
				forward= action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/passPcode.pg")){
				action = new passPcodeAction();
			try {
				forward= action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/passMOcode.pg")){
			action = new passMOcodeAction();
		try {
			forward= action.execute(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		
		if(forward!=null){//new ActionForward()��ü�� �����ϰ�...
			if(forward.isRedirect()){//true->sendRedirect()���
				response.sendRedirect(forward.getPath());
			}else{ //false ->forward()���
				RequestDispatcher view = request.getRequestDispatcher(forward.getPath());
				view.forward(request, response);
			}
		
		}
	}

}
