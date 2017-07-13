package team.movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team.playing.action.Action;
import team.playing.action.ActionForward;

public class passMOcodeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//관 번호(순서대로 정렬했을 때)를 뒤에 붙인 p_code 전달 완료. 해당하는 p_code에 영화 상영
		String mocode[] = request.getParameterValues("mocode");
		
		
		for(int i=0; i<mocode.length; i++){
		System.out.println(mocode[i]);
		mocode[i] = "mo"+mocode[i];
		}
		
		request.setAttribute("mocode", mocode);
		request.setAttribute("mosize", mocode.length);
		request.setAttribute("isGetMOcode", "y");
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./searchmv.jsp");
		
		return null;
	}

}
