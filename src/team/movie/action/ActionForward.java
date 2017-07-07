package team.movie.action;
/*
 	ActionForward클래스는 Action인터페이스에서 명령을 수행하고..
 	결과 값을 가지고 페이지를 포워딩(이동)할 때 사용되는 클래스임.
 	하는일 1. 페이지 이동 방식 여부 값 저장 후 리턴해주는 역할.
 	       	페이지 이동 방식 여부값 true일 때--->Response.sendRedirect() 방식
 	       	페이지 이동 방식 여부값 false일 때---> forward()방식
 	하는일 2. 이동페이지 경로 값 저장하여 리턴해주는 역할.
 	
 */
public class ActionForward {
	//페이지 이동 방식 값을 저장할 변수 선언
	private boolean isRedirect = false;
	//true sendRedirect() <-- 이 방식은 이동할 페이지 주소 경로 노출함.
	//false forward() <-- 이 방식은 이동할 페이지 주소 경로 노출 안함.
	
	//이동 페이지 경로 주소값 저장 변수
	private String path= null;
	
	//페이지 이동 방식 여부 값 저장하는 메소드
	public void setRedirect(boolean isRedirect){
		this.isRedirect = isRedirect;
	}
	//페이지 이동 방식 여부값 리턴 메소드
	public boolean isRedirect(){
		return isRedirect;
	}
	
	//이동할 페이지 경로 주소값 저장할 메소드
	public void setPath(String path){
		this.path = path;
	}
	//이동할 페이지 경로 주소값을 리턴하는 메소드
	public String getPath(){
		return path;
	}
}
