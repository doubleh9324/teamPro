package team.playing.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class PlayingDAO {
	
	private Connection getConnection() throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/team");
		con=ds.getConnection();
		return con;
	}
	
	public String getPcode(String pcode){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		
		try{
			con=getConnection();
			
			sql="select p_code from place where p_code like concat(?,'%')";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pcode);
			
			rs = pstmt.executeQuery();
			rs.next();
			
			System.out.println(rs.getString(1));
			
			return rs.getString(1);
			
		}catch(Exception e){
			System.out.println("insertPlaying error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return null;
	}
	
	public String getScreenName(String pcode, int scrNum){
		Connection con= null;
		PreparedStatement pstmt = null;
		PreparedStatement ppstmt = null;
		String sql="";
		String presql="set @num=0";
		ResultSet rs = null;
		//뒤에 영화관 자른 pcode 가져올 것
		try{
			con=getConnection();
			
			
			//num=0
			ppstmt = con.prepareStatement(presql);
			ppstmt.executeQuery();
			
			
			sql="select b.screen_name from "
					+ "(select @num:=@num+1 as num , screen_name, p_code from v_place where p_code=? order by screen_name) a "
					+ "join v_place b where a.p_code = b.p_code and a.screen_name=b.screen_name and a.num = ? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pcode);
			pstmt.setInt(2, scrNum);
			
			rs = pstmt.executeQuery();
			rs.next();
			System.out.println(pstmt.toString());

			return rs.getString(1);
			
		}catch(Exception e){
			System.out.println("getScreenName error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return null;
	}
	
	public int getCapacity(String pcode){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		//뒤에 영화관 자른 pcode 가져올 것
		try{
			con=getConnection();
			
			sql="select capacity from place_detail where p_code = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pcode);
			
			rs = pstmt.executeQuery();
			rs.next();
			
			System.out.println(rs.getString(1));
			
			return rs.getInt(1);
			
		}catch(Exception e){
			System.out.println("getCapacity error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return 0;
	}
	
	public boolean insertPlaying(List<PlayingBean> playList){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		int re = 0;
		
		try{
			con=getConnection();
			
			for(int i=0; i<playList.size(); i++){
				pstmt = null;
				sql="insert into playing (ping_num, p_code, nc_code, start_day, end_day)"
						+ " values (?,?,?,?,?) ";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, playList.get(i).getPing_num());
				pstmt.setString(2, playList.get(i).getP_code());
				pstmt.setString(3, playList.get(i).getNc_code());
				pstmt.setString(4, playList.get(i).getStart_day());
				pstmt.setString(5, playList.get(i).getEnd_day());
				
				System.out.println(pstmt.toString());
				//총 re개의 insert 실행
				re += pstmt.executeUpdate();
			}
			
			if(re!=0){
				return true;
			}
			

		}catch(Exception e){
			System.out.println("insertPlaying error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return false;
	}
	
	public boolean insertSeatInfo(List<SeatInfoBean> siList){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		int re = 0;
		
		try{
			con=getConnection();
			
			for(int i=0; i<siList.size(); i++){
				pstmt = null;
				sql="insert into seatinfo(ping_num, p_code, screen_name, seatclass, price, seat_num, event_code) "
						+ " values (?,?,?,?,?,?,?) ";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, siList.get(i).getPing_num());
				pstmt.setString(2, siList.get(i).getP_code());
				pstmt.setString(3, siList.get(i).getScreen_name());
				pstmt.setString(4, siList.get(i).getSeatclass());
				pstmt.setInt(5, siList.get(i).getPrice());
				pstmt.setInt(6, siList.get(i).getSeat_num());
				pstmt.setString(7, siList.get(i).getEvent_code());
				
				System.out.println(pstmt.toString());
				//총 re개의 insert 실행
				re += pstmt.executeUpdate();
			}
			
			if(re!=0){
				return true;
			}
			

		}catch(Exception e){
			System.out.println("insertPlaying error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return false;
	}
	
	public boolean insertPlaytime(List<PlayTimeBean> ptbList){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		int re = -1;
		SimpleDateFormat formatter = new SimpleDateFormat("kk:mm:ss");
		
		
		System.out.println(ptbList.get(0).getPlaytime()+"/"+ptbList.get(1).getPlaytime());
		try{
			con=getConnection();
			
			//상영 기간동안
			for(int i=0; i<ptbList.size(); i++){
				pstmt = null;
				sql="insert into playtime (ping_num, play_day, ptime) values (?,?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, ptbList.get(i).getPing_num());
				pstmt.setString(2, ptbList.get(i).getPlay_day());
				String time = ptbList.get(i).getPlaytime();
				System.out.println(time);
				pstmt.setString(3, time);
				//총 re개의 insert실행
				
				System.out.println(pstmt.toString());
				re += pstmt.executeUpdate();
			}
			
			if(re!=0){
				return true;
			}
		}catch(Exception e){
			System.out.println("insertPlayingtime error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return false;
	}
	
	public int selectMaxPnum(){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		
		try{
			con=getConnection();
			
			sql="select Max(ping_num) from playing";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			rs.next();
			return rs.getInt(1);
					
		}catch(Exception e){
			System.out.println("PlayingDAO selectMaxPnum error : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return 0;
	}

}
