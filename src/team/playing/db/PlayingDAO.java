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
	
	public boolean insertPlaying(PlayingBean pb){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		int re = 0;
		
		try{
			con=getConnection();
			
			sql="insert into playing (ping_num, p_code, nc_code, start_day, end_day)"
					+ " values (?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pb.getPing_num());
			pstmt.setString(2, pb.getP_code());
			pstmt.setString(3, pb.getNc_code());
			pstmt.setString(4, pb.getStart_day());
			pstmt.setString(5, pb.getEnd_day());
			re = pstmt.executeUpdate();
			
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
		
		try{
			con=getConnection();
			
			//상영 기간동안
			for(int i=0; i<ptbList.size(); i++){
				
				//하루 3회차 추가
				for(int j=0; j<3; j++ ){
					sql="insert into playtime (ping_num, play_day, time)"
							+ " values (?,?,?)";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, ptbList.get(i).getPing_num());
					pstmt.setString(2, ptbList.get(i).getPlay_day());
					String time[] = ptbList.get(i).getPlaytime();
					pstmt.setDate(3, java.sql.Date.valueOf(formatter.format(time[j])));
					
					re = pstmt.executeUpdate();
					System.out.println(time[j]);
					if(re==0)
						return false;
				}
			}
		}catch(Exception e){
			System.out.println("insertPlaying error : "+e);
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
