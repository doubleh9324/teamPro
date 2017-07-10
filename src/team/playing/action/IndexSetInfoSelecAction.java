package team.playing.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.playing.db.PlayingDAO;

public class IndexSetInfoSelecAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//ping_num 가져오기
		PlayingDAO playingDao = new PlayingDAO();
		int maxpnum = playingDao.selectMaxPnum();
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		jsonObject.put("setFlag", "y");
		jsonObject.put("pnumMax", maxpnum+1);
	
		//ActionForward forward=new ActionForward();
	//	forward.setRedirect(false);
	//	forward.setPath("./index.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;
	}
}
