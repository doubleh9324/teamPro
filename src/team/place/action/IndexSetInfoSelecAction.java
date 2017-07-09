package team.place.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.place.db.LocationBean;
import team.place.db.PlaceDAO;

public class IndexSetInfoSelecAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//지역코드 리스트 select
		PlaceDAO placeDao = new PlaceDAO();
		List<LocationBean> l_codeList = placeDao.selectL_codeList();
		
		//가장 큰 영화관 숫자 가져오기
		int placeMax = placeDao.getPlaceMaxCount();
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		jsonObject.put("setFlag", "y");
		jsonObject.put("l_codeList", jsona.fromObject(l_codeList));
		jsonObject.put("placeMax", placeMax);
	
		//ActionForward forward=new ActionForward();
	//	forward.setRedirect(false);
	//	forward.setPath("./index.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;
	}
}
