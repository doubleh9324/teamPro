package team.common.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/addPlaying.do")
public class PlayingInfoInsertAction extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		requestpro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		requestpro(request, response);
	}
	
	// doGet,doPost 방식으로 데이터가 넘어오던 모두 requestpro메소드에서 처리
		private void requestpro(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {

			
			//데이터베이스에 연결하여 하나의 자동차 정보를 읽어 드림
			
			//실제 데이터 베이스에 접근하여 하나의 자동차 정보를 모두 읽어서.... 
			//하나의 컬럼정보를 저장해주는 빈객체 리턴
			//단 호출시! 자동차번호를 메소드의 매개변수로 전달 ! 
			
			//리퀘스트 객체를 이용하여 데이터를 저장
			
			//CarMain.jsp페이지로 이동하면서 request영역 전달
			//전환

		}
}
