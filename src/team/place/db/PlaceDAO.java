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
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/team");
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
		pb.setName(rs.getString("name"));
		pb.setScreen_name(rs.getString("screen_name"));
		pb.setAddress(rs.getString("capacity"));
		pb.setContact_num(rs.getString("contact_num"));
		pb.setHomepage(rs.getString("homepage"));
		
		return pb;
	}
	
}
