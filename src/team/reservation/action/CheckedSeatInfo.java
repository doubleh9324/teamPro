package team.reservation.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.sf.json.JSONObject;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;

public class CheckedSeatInfo implements Action{
	@Override
	public ActionForward execute( HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pcode = request.getParameter("pcode");
		String mo_num = request.getParameter("mo_num");
		String screen_name = request.getParameter("screen_name");
		String viewdate = request.getParameter("viewdate");
		String[] seats = request.getParameter("seat").split(" ");
		String flag = "n";
		ServletContext application = request.getServletContext();
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> checked = (List<Map<String, Object>>)application.getAttribute("checked");
		
		JSONObject jsonObject = new JSONObject();
		
			
		
		//저장된 checked seat이 없으면
		if(checked==null){

			List<Map<String, Object>> newcheckedlist = new ArrayList<>();
			Map<String, Object> checkedmap = new HashMap<>();
			System.out.println("없어");
			checkedmap.put("pcode", pcode);
			checkedmap.put("mo_num", mo_num);
			checkedmap.put("screen_name", screen_name);
			checkedmap.put("viewdate", viewdate);
			checkedmap.put("seats", seats);
			System.out.println(pcode+ " "+mo_num +" " +screen_name+ " "+viewdate);
			newcheckedlist.add(checkedmap);
			application.setAttribute("checked", newcheckedlist);
			
			jsonObject.put("checkedFlag", "n");
		}else{
			//저장된 checked seat이 있으면 해당 좌석표에 해당하는 좌석만 조회 한 후 
			//현재 선택한 값과 비교해서 flag 리턴하기
			
			if(seats[0].equals("0")){
				List<Map<String, Object>> checkedSeats = new ArrayList<>();
				//좌석을 선택해서 넘어온게 아니라 첫 조회창이므로 있는 정보들만 넘겨주기(reserved
				jsonObject.put("checkedSeats", checked);
				System.out.println("리스트 크기 : " +checked.size());
				for(int i=0; i<checked.size(); i++){
					//해당 날짜시간, pcode, 영화번호, 스크린 이릅이 모두 같으면
						
						String[] appSeats = (String[]) checked.get(i).get("seats");
						for(int s=0; s<appSeats.length; s++){
							Map<String, Object> map = new HashMap<>();
							map.put("seat_fl", appSeats[s].substring(0, 1));
							map.put("seat_no", appSeats[s].substring(1));
							checkedSeats.add(map);
						}
						jsonObject.put("checkedSeats", checkedSeats);
				}
			}else{
				
				System.out.println("리스트 크기 : " +checked.size());
				
				List<Map<String, Object>> checkedSeats = new ArrayList<>();
				exit_for : for(int i=0; i<checked.size(); i++){
					
					boolean isdate = (viewdate.equals((String) checked.get(i).get("viewdate"))? true : false );
					boolean ispcode = (pcode.equals((String) checked.get(i).get("pcode"))? true : false );
					boolean ismo_num = (mo_num.equals((String) checked.get(i).get("mo_num"))? true : false );
					boolean isscreen = (screen_name.equals((String) checked.get(i).get("screen_name"))? true : false );
					System.out.println(checked.get(i).get("viewdate") +" "+ checked.get(i).get("pcode") +" "+ checked.get(i).get("mo_num") + " "+checked.get(i).get("screen_name"));
					
					//해당 날짜시간, pcode, 영화번호, 스크린 이릅이 모두 같으면
					if(isdate && ispcode && ismo_num && isscreen){
						String[] appSeats = (String[]) checked.get(i).get("seats");
						for(int s=0; s<seats.length; s++){
							for(int ss=0; ss<appSeats.length; ss++){
								if(seats[s].equals(appSeats[ss])){
									flag = "y";
									Map<String, Object> map = new HashMap<>();
									map.put("seat_fl", seats[s].substring(0, 1));
									map.put("seat_no", seats[s].substring(1));
									checkedSeats.add(map);
									System.out.println("있음");
									System.out.println( seats[s] + " " + appSeats[ss]);
									break exit_for;
								}
							}
						}
					}
	
				}
				if(flag == "n"){
					//조회를 마쳤으나 일치하는 정보가 없으므로 새로운 선택 목록에 추가
					Map<String, Object> addmap = new HashMap<>();
					addmap.put("pcode", pcode);
					addmap.put("mo_num", mo_num);
					addmap.put("screen_name", screen_name);
					addmap.put("viewdate", viewdate);
					addmap.put("seats", seats);
					checked.add(addmap);
					application.setAttribute("checked", checked);
					
					for(int i=0; i<checked.size(); i++){
						//해당 날짜시간, pcode, 영화번호, 스크린 이릅이 모두 같으면
							String[] appSeats = (String[]) checked.get(i).get("seats");
							for(int s=0; s<appSeats.length; s++){
								Map<String, Object> map = new HashMap<>();
								map.put("seat_fl", appSeats[s].substring(0, 1));
								map.put("seat_no", appSeats[s].substring(1));
								checkedSeats.add(map);
							}
							jsonObject.put("checkedSeats", checkedSeats);
					}
					
					jsonObject.put("checkedFlag", "n");
				}else{
					jsonObject.put("checkedFlag", "y");
				}
				
				jsonObject.put("checkedSeats", checkedSeats);
			}
		}
		
		

	//	jsonObject.put("duration", duration);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./reservation/reservation.jsp");
		
		response.setContentType("application/x-json; charset=utf-8");
		response.getWriter().print(jsonObject);
		
		return null;	
	
		
	}
}
