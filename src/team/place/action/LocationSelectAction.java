package team.place.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.place.db.LocationBean;
import team.place.db.PlaceDAO;

public class LocationSelectAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		PlaceDAO placeDao = new PlaceDAO();
		List<LocationBean> l_codeList = placeDao.selectL_codeList();
		
		//리퀘스트로 값 넘기지 말고 json으로 보내기
	//	request.setAttribute("l_codeList",l_codeList);
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		jsonObject.put("setFlag", "y");
		jsonObject.put("l_codeList", jsona.fromObject(l_codeList));
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./index.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;
	}

}
