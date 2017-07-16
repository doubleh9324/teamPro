package team.place.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PlaceDAO {

	private Connection getConnection() throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/TicketLion");
		con=ds.getConnection();
		return con;
	}
	
	public boolean insertPlace(PlaceBean pb){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		int result=0;
		try{
			con=getConnection();
			
			sql="insert into place (p_code,name,address ,contact_num,homepage)"
					+ " values (?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pb.getP_code());
			pstmt.setString(2, pb.getName());
			pstmt.setString(3, pb.getAddress());
			pstmt.setString(4, pb.getContact_num());
			pstmt.setString(5, pb.getHomepage());
			result = pstmt.executeUpdate();
			
			if(result!=0){
				return true;
			}
		}catch(Exception e){
			System.out.println("insertPlace error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return false;
	}
	
	public boolean insertPlace_detail(Place_detailBean pbb){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		int result=0;
		try{
			con=getConnection();
			
			sql="insert into place_detail (p_code,screen_name, capacity)"
					+ " values (?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pbb.getP_code());
			pstmt.setString(2, pbb.getScreen_name());
			pstmt.setInt(3, pbb.getCapacity());
			result = pstmt.executeUpdate();
			
			if(result!=0){
				return true;
			}
		}catch(Exception e){
			System.out.println("insertPlace_detail error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return false;
	}
	
	public List<V_plcaeBean> selectPlaceList(){
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		
		try{
			con=getConnection();
			
			sql="select * from v_place";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				List<V_plcaeBean> placeList = new ArrayList<V_plcaeBean>();
				do{
					placeList.add(this.makePlaceFromResultSet(rs));
				}while (rs.next());
				
				return placeList;
			} else {
				return Collections.emptyList();
			}
		}catch(Exception e){
			System.out.println("selectPlaceList error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		
		return Collections.emptyList();
	}
	
	protected V_plcaeBean makePlaceFromResultSet(ResultSet rs)throws SQLException{
		V_plcaeBean pb = new V_plcaeBean();
		pb.setP_code(rs.getString("p_code"));
		pb.setType(rs.getString("type"));
		pb.setName(rs.getString("name"));
		pb.setScreen_name(rs.getString("screen_name"));
		pb.setCapacity(rs.getShort("capacity"));
		pb.setAddress(rs.getString("address"));
		pb.setContact_num(rs.getString("contact_num"));
		pb.setHomepage(rs.getString("homepage"));
		return pb;
	}
	
	public boolean insertLocation(LocationBean lb){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		int result=0;
		try{
			con=getConnection();
			
			sql="insert into Location values (?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, lb.getL_code());
			pstmt.setString(2, lb.getLocation());
			result = pstmt.executeUpdate();
			
			if(result!=0){
				return true;
			}
		}catch(Exception e){
			System.out.println("insertLocation error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return false;
	}
	
	public List<LocationBean> selectL_codeList(){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		try{
			con=getConnection();
			
			sql="select * from Location";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				List<LocationBean> l_codeList = new ArrayList<>();

				do{
					LocationBean lb = new LocationBean();
					
					lb.setL_code(rs.getString("l_code"));
					lb.setLocation(rs.getString("location"));
					l_codeList.add(lb);
				}while(rs.next());
				
				return l_codeList;
			}else {
			return Collections.emptyList();
			}
		}catch(Exception e){
			System.out.println("PlaceDAO selectL_codeList error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		
	return Collections.emptyList();
	}
	
	public int getPlaceMaxCount() throws Exception{
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		
		try{
			con=getConnection();
			
			sql="select max(substring(p_code, 3, 4)*1) from place";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
				return rs.getInt(1);
			
		}catch(Exception e){
			System.out.println("PlaceDAO selectPlaceMax error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		
		return 0;
	}
	
	public List<V_plcaeBean> searchPlace(String s_cate, String s_place) throws Exception{
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		List<V_plcaeBean> vplaceList = new ArrayList<>();
		try{
			con=getConnection();
			//영화관 이름(마지막코드)와 지점이름(name) 둘 다 검색
			if(s_cate.equals("name")){
				sql="select p_code, type, name, screen_name, address, capacity from v_place "
						+ "where type = (select theater_en from theater where theater_en like concat('%',?,'%') or theater_ko like concat('%',?,'%')) "
						+ "order by substring(p_code, 3,4) , screen_name";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, s_place);
				pstmt.setString(2, s_place);
			} else if(s_cate.equals("address")){
				sql="select substring(p_code,1,6) as p_code, type, name, screen_name, address, capacity "
						+ "from v_place where address like concat('%',?,'%')";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, s_place);
			} else if(s_cate.equals("all")){
				//전체검색 수정해야함
				if(s_place == null){
					sql="select substring(p_code,1,6) as p_code, type, name, screen_name, address, capacity " 
							+ "from v_place";
					pstmt=con.prepareStatement(sql);
				} else {
					sql="select substring(p_code,1,6) as p_code, type, name, screen_name, address, capacity " 
							+ "from v_place where (name like concat('%',?,'%') or screen_name like concat('%',?,'%') or address like concat('%',?,'%'))";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, s_place);
					pstmt.setString(2, s_place);
					pstmt.setString(3, s_place);
				}
			}
			
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				System.out.println("검색작업");
				do{
					vplaceList.add(makevPlaceFromResultSet(rs));
				}while(rs.next());
				
				System.out.println("입력완료 :" + vplaceList.size());
				return vplaceList;
			}else{
				return Collections.emptyList();
			}
		}catch(Exception e){
			System.out.println("PlaceDAO searchPlace error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return Collections.emptyList();		
	}
	
	protected V_plcaeBean makevPlaceFromResultSet(ResultSet rs)throws SQLException{
		V_plcaeBean pb = new V_plcaeBean();
		pb.setP_code(rs.getString("p_code"));
		pb.setType(rs.getString("type"));
		pb.setName(rs.getString("name"));
		pb.setScreen_name(rs.getString("screen_name"));
		pb.setCapacity(rs.getShort("capacity"));
		pb.setAddress(rs.getString("address"));
		return pb;
	}
	
	
}
