package team.reservation.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;
import team.place.db.PlaceDAO;
import team.playing.db.PlayingDAO;
import team.reservation.db.Action;
import team.reservation.db.ActionForward;

public class ReservationAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//예매화면 띄우기
		//상영하는 영화, 영화관, 상영시간
		MovieDAO movieDao = new MovieDAO();
		PlaceDAO placeDao = new PlaceDAO();
		PlayingDAO playingDao = new PlayingDAO();
		ReservationDAO reserDao = new ReservationDAO();
		
		//한영화가 상영하는 극장과 관, 상영시간
		List<MovieBean> movieList = movieDao.playingMovies();
		List<Map<String, Object>> placeList = reserDao.getPlace();
		List<Map<String, Object>> locationList = reserDao.getLocation();
		Map<String, Object> locMap = new HashMap<>();
		
	    
	    request.setAttribute("movieList", movieList);
	    request.setAttribute("placeList", placeList);
	    request.setAttribute("locationList", locationList);
	    
	    ActionForward forward=new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("/reservation/reservation.jsp");
	   
		return forward;
	}
	

}
