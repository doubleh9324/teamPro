package team.reservation.db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team.movie.db.MovieBean;

public class ReservationDAO {
	//여러가지 테이블을 건드려서 따로 만들긴 했는데 원래 DAO로 돌려놔야할지 고려할 것
	private Connection getConnection() throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/TicketLion");
		con=ds.getConnection();
		return con;
	}
	
	public List<Map<String, Object>> getPlace(){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		List<Map<String, Object>> placeList = new ArrayList<>();
		try{
			con=getConnection();
			
			sql="select a.p_code, b.l_code , c.t_code, a.name from place a, location b, theater c "
					+ "where substring(p_code, 1, 2) = b.l_code and substring(a.p_code, 7,2) = c.t_code";
			pstmt=con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				do{
					Map<String, Object> resultMap = new HashMap<>();
					
					resultMap.put("p_code", rs.getString("p_code"));
					resultMap.put("l_code", rs.getString("l_code"));
					resultMap.put("t_code", rs.getString("t_code"));
					resultMap.put("name", rs.getString("name"));
					
					placeList.add(resultMap);
				}while(rs.next());
			}
			
			return placeList;
			
		}catch(Exception e){
			System.out.println("ReservDAO getplace error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return null;
	}
	
	//예매 화면에서 movie_num 넘겨줬을때 사용
	public List<Map<String, Object>> getPlace(String flag, String value ){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		List<Map<String, Object>> pcodeList = new ArrayList<>();
		
		System.out.println(flag+ value);
		try{
			con=getConnection();
			
			if(flag.equals("movie")){
				sql="select p_code from playing where nc_code = concat('mo',?) ";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, value);
				rs = pstmt.executeQuery();
				System.out.println(pstmt.toString());
				if(rs.next()){
					do{
						Map<String, Object> resultMap = new HashMap<>();
						
						resultMap.put("p_code", rs.getString("p_code"));
						pcodeList.add(resultMap);
					}while(rs.next());
				}
				
				return pcodeList;
			} else if(flag.equals("date")){
				System.out.println(value);
				String d = value.substring(0, 4)+"-"+value.substring(4,6)+"-"+value.substring(6);
				System.out.println(d);
				sql="select p_code from playing where start_day <= date_format(now(), '%Y%m%d') and end_day >= date_format(?,'%Y%m%d');";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, d);
				rs = pstmt.executeQuery();
				System.out.println(pstmt.toString());
				if(rs.next()){
					do{
						Map<String, Object> resultMap = new HashMap<>();
						
						resultMap.put("p_code", rs.getString("p_code"));
						pcodeList.add(resultMap);
					}while(rs.next());
				}
				
				return pcodeList;
			}
		}catch(Exception e){
			System.out.println("ReservDAO getplace(pcode) error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return null;
	}
	
	public MovieBean getMovieInfo(String mo_num){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		MovieBean mb = new MovieBean();
		
		try{
			con=getConnection();
			
			sql="select a.name, a.age, b.image from movie a, movie_detail b where a.movie_num= ? and a.movie_num = b.movie_num ";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mo_num);
			rs = pstmt.executeQuery();
			System.out.println(pstmt.toString());
			if(rs.next()){
				do{
					mb.setImage(rs.getString("image"));
					mb.setAge(rs.getString("age"));
					mb.setName(rs.getString("name"));
				}while(rs.next());
			}
			
			return mb;
			
		}catch(Exception e){
			System.out.println("ReservDAO getMovieInfo error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return null;
	}
	
	
	public List<Map<String, Object>> getLocation(){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		List<Map<String, Object>> locationList = new ArrayList<>();
		try{
			con=getConnection();
			
			sql="select a.l_code, a.location, count(*) as count, a.idx from location a, place b "
					+ "where substring(b.p_code, 1,2) = a.l_code group by substring(b.p_code , 1, 2) order by a.idx";
			
			
			for(int i=1; i<=9 ; i++){
				sql = "select group_concat(a.l_code separator '_') as l_code , group_concat(a.location separator '/') as location, sum(a.count) as count, a.idx " 
						+ "from ( select a.l_code, a.location, count(*) as count, a.idx from location a, place b " 
						+ "where substring(b.p_code, 1,2) = a.l_code group by a.l_code order by a.idx ) a where idx = ?" ;
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, i);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					do{
						Map<String, Object> resultMap = new HashMap<>();
						
						resultMap.put("l_code", rs.getString("l_code"));
						resultMap.put("location", rs.getString("location"));
						resultMap.put("count", rs.getString("count"));
						resultMap.put("index", rs.getInt("idx"));
						
						locationList.add(resultMap);
					}while(rs.next());
				}
			}

			for(int j=0; j<9; j++){
				System.out.println(locationList.get(j).get("location"));
			}
			
			return locationList;
			
		}catch(Exception e){
			System.out.println("ReservDAO getlocation error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return null;
	}
	
	public List<Map<String, Object>> getPlayDay() throws Exception{
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		List<Map<String, Object>> playdayList = new ArrayList<>();
		try{
			con=getConnection();
			
			sql="select distinct date_format(play_day, '%Y%m%d') as pday, year(play_day) as year, month(play_day) as month, dayofmonth(play_day) as day, dayname(play_day) as dayname "
					+ "from playtime where play_day >= date_format(now(), '%Y%m%d')";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if(rs.next()){
				do{
					Map<String, Object> playday = new HashMap<>();
					playday.put("pday",rs.getString("pday"));
					playday.put("year", rs.getString("year"));
					playday.put("month", rs.getString("month"));
					playday.put("day", rs.getString("day"));
					playday.put("dayname", rs.getString("dayname"));
					playdayList.add(playday);
				}while(rs.next());
			}
			return playdayList;
					
		}catch(Exception e){
			System.out.println("ReserDAO selectPlayday error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
	return null;
	}
}
