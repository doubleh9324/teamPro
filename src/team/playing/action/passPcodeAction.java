package team.playing.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class passPcodeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//관 번호(순서대로 정렬했을 때)를 뒤에 붙인 p_code 전달 완료. 해당하는 p_code에 영화 상영
		String pcode[] = request.getParameterValues("pcode");
		
		/*
		for(int i=0; i<pcode.length; i++){
		System.out.println(pcode[i]);
		}
		*/
		
		request.setAttribute("pcode", pcode);
		request.setAttribute("psize", pcode.length);
		request.setAttribute("isGetPcode", "y");
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./index.jsp");
		
		
		return forward;
	}
	
	
}
