package team.movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*Action관련 클래스들이..
 * Action인터페이스의 추상메서드를 오버라이딩함으로써 클라이언트의 요청처리 형태를 규격화시킴*/
public interface Action  {
	//특정 클라이언트의 요청을 수행하고 그 결과 값을 ActionForward클래스 타입으로 반환
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response)  throws Exception;
}
