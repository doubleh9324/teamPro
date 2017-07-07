package team.movie.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MovieDAO {
	
	private Connection getConnection() throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/team");
		con=ds.getConnection();
		return con;
	}
	
	public boolean insertMovie(MovieBean mb){
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql="";
		int result=0;
		try{
			con=getConnection();
			
			sql="insert into movie(movie_num,g_code,name,director,playing_day,actor,production,age)"
					+ " values (?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mb.getMovie_num());
			pstmt.setString(2, mb.getG_code());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getDirector());
			pstmt.setString(5, mb.getPlaying_day());
			pstmt.setString(6, mb.getActor());
			pstmt.setString(7, mb.getProduction());
			pstmt.setString(8, mb.getAge());
			result = pstmt.executeUpdate();
			
			if(result!=0){
				return true;
			}
		}catch(Exception e){
			System.out.println("insertMovie���� ���� : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return false;
	}
	
	public MovieBean selectMovie(String movie_num){
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		MovieBean mb = null;
		String sql="";
		try{
			con=getConnection();
			sql="select * from movie where movie_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, movie_num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				mb=new MovieBean();
				mb.setAge(rs.getString("age"));
				mb.setDirector(rs.getString("director"));
				mb.setName(rs.getString("name"));
				mb.setPlaying_day(rs.getString("open_day"));
				mb.setProduction(rs.getString("production"));
			}
			
		}catch(Exception e){
			System.out.println("selectMovie���� ���� : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return mb;
	}
	
	
}
