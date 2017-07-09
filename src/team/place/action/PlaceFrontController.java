package team.place.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class PlaceFrontController extends HttpServlet{
	
	//이게 굳이 필요한건가 그럼
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
		
		if(command.equals("/getIndexSetInfo.pl")){
		//	action = new LocationSelectAction();
			action = new IndexSetInfoSelecAction();
			//request.setAttribute("setFlag", "y");
			try {
				forward= action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/PlaceInsertAction.pl")){
			//영화관 추가
			action = new PlaceInsertAction();
			try {
				forward= action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/LocationInsertAction.pl")){
			//지역코드 추가
			action = new LocationInsertAction();
			try {
				forward= action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/PlaceListSelectAction.pl")){
			action = new PlaceListSelectAction();
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
		/*
		//주소값에 따라서 실행
		if(command.equals("/PlaceInsertAction.pl")){
			
			forward = new ActionForward();
			//페이지 이동 방식 여부 값 false로 저장-> RequestDispatcher  forward() 방식
			forward.setRedirect(false);
			//이동할 페이지 경로(회원가입 페이지) 주소값 저장
		//	forward.setPath("./CarMain.jsp?center=member/join.jsp");
			forward.setPath("./placelist.jsp?value=ok");	
		//join.jsp에서...회원가입 처리요청이 들어 왔을떄...	
		}else if(command.equals("/MemberJoinAction.me")){
	
			//회원가입 처리를 위한 Action객체 생성
			
			try {
				//josin.jsp에서 입력한 회원가입 내용을 담고 있는
				//request영역을 execute메소드의 매개변수로 전달하여..
				//회원가입 DB 작업후 회원가입에 성공하면..
				// 페이지 이동 방식 여부 값 true와...
				// 이동할페이지 주소 (./member/login.jsp)를 담고 있는..
				//new ActionForward()객체를 리턴 받는다.
				forward=action.execute(request, response);
						
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		//top.jsp에서 ..login링크를 클릭하여 로그인화면으로 이동하라 라는 요청이 들어 왔을때...	
		//또는 회원가입후!.. 로그인화면으로 이동하라 라는 요청이 들어 왔을떄...
		}
		*/
	}
}
