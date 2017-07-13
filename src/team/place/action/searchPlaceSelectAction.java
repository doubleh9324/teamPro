package team.place.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import team.place.db.PlaceDAO;
import team.place.db.V_plcaeBean;

public class searchPlaceSelectAction implements Action{
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String s_cate = request.getParameter("s_cate");
		String s_place = request.getParameter("s_place");
		
		PlaceDAO placeDao = new PlaceDAO();
		List<V_plcaeBean> placeList = placeDao.searchPlace(s_cate, s_place);
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsona = new JSONArray();
		
		jsonObject.put("total", placeList.size());
		jsonObject.put("placeList", jsona.fromObject(placeList));
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./searchplace.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;		
	}
	

}
