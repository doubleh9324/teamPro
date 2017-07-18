package team.reservation.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReservationDAO {
	
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
	public List<Map<String, Object>> getPlace(String mo_num){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		List<Map<String, Object>> pcodeList = new ArrayList<>();
		try{
			con=getConnection();
			
			sql="select p_code from playing where nc_code = concat('mo',?) ";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mo_num);
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
			
		}catch(Exception e){
			System.out.println("ReservDAO getplace(pcode) error : "+e);
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
}
