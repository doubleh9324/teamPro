package team.movie.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MovieDAO {
	
	private Connection getConnection() throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/TicketLion");
		con=ds.getConnection();
		return con;
	}
	public Vector<MovieBean> playingMovies(){
		Vector<MovieBean> v= new Vector<MovieBean>();
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			sql="select m1.movie_num, m1.name, m1.open_day, m2.image from movie m1,movie_detail m2 where m1.movie_num=m2.movie_num and curdate()<=date_add(m1.open_day, interval 1 month) and curdate()>=m1.open_day;";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MovieBean mb= new MovieBean();
				mb.setMovie_num(rs.getString("movie_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				
				v.add(mb);
			}
		}catch(Exception e){
			System.out.println("playingMovies���� ����: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return v;
	}
	
	public boolean setPlaying(String nc_code){
		Connection con=null;
		PreparedStatement pstmt = null;
		String sql="";
		
		try{
			con=getConnection();
			
			sql = "update movie set playing = 1 where movie_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nc_code.substring(3));
			
			
			
		}catch(Exception e){
			System.out.println("setPlayingMovies : "+e);
			
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return false;
	}
	
	public Vector<MovieBean> splayingMovies(String s_cate, String s_movie){
		Vector<MovieBean> v= new Vector<MovieBean>();
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			
			if(s_cate.equals("name")){
				sql="select movie_num, name, director, production, open_day from movie "
						+ "where curdate()<=date_add(open_day, interval 1 month) and curdate()>=open_day and "
						+ "name like concat('%',?,'%') ";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, s_movie);
			}else if(s_cate.equals("director")){
				sql="select movie_num, name, director, production, open_day from movie "
						+ "where curdate()<=date_add(open_day, interval 1 month) and curdate()>=open_day and "
						+ "director like concat('%',?,'%') ";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, s_movie);
			}else if(s_cate.equals("production")){
				sql="select movie_num, name, director, production, open_day from movie "
						+ "where curdate()<=date_add(open_day, interval 1 month) and curdate()>=open_day and "
						+ "production like concat('%',?,'%') ";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, s_movie);
			}else if(s_cate.equals("all")){
				if(s_movie == null){
					sql="select movie_num, name, director, production, open_day from movie "
							+ "where curdate()<=date_add(open_day, interval 1 month) and curdate()>=open_day";
					pstmt=con.prepareStatement(sql);
				} else {
					sql="select movie_num, name, director, production, open_day from movie "
							+ "where curdate()<=date_add(open_day, interval 1 month) and curdate()>=open_day and "
							+ "(name like concat('%',?,'%') or director like concat('%',?,'%') or "
							+ "production like concat('%',?,'%') or actor like concat('%',?,'%'))";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, s_movie);
					pstmt.setString(2, s_movie);
					pstmt.setString(3, s_movie);
					pstmt.setString(4, s_movie);
				}
			}
			
			rs=pstmt.executeQuery();
			while(rs.next()){
				MovieBean mb= new MovieBean();
				mb.setMovie_num(rs.getString("movie_num"));
				mb.setName(rs.getString("name"));
				mb.setDirector(rs.getString("director"));
				mb.setProduction(rs.getString("production"));
				mb.setOpen_day(rs.getString("open_day"));
				v.add(mb);
			}
		}catch(Exception e){
			System.out.println("splayingMovies : "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return v;
	}
	
	public List<MovieBean> getAllMovies(){
		ArrayList<MovieBean> movieList= new ArrayList<MovieBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		
		try{
			con=getConnection();
			sql="select m1.movie_num,m1.name,m1.age, m2.image, m2.grade from movie m1,movie_detail m2 where m1.movie_num=m2.movie_num order by 2";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				do{
					MovieBean mb = new MovieBean();
					mb.setMovie_num(rs.getString("movie_num"));
					mb.setName(rs.getString("name"));
					mb.setAge(rs.getString("age"));
					mb.setImage(rs.getString("image"));
					mb.setGrade(rs.getDouble("grade"));
					movieList.add(mb);
				}while(rs.next());
				return movieList;
			}else{
				return Collections.emptyList();
			}
			
		}catch(Exception e){
			System.out.println("getAllMovies에서 오류: "+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		
		return Collections.emptyList();
	}
	
	public boolean insertMovie(MovieBean mb){
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		int count=0;
		int result=0;
		try{
			con=getConnection();
			sql="select count(movie_num) from movie";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				count=rs.getInt(1)+1;
			}else count=1;
			
			sql="insert into movie(movie_num,g_code,name,director,open_day,actor,production,age)"
				+" values(?,?,?,?,?,?,?,?)";
				
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setString(2, mb.getG_code());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getDirector());
			pstmt.setString(5, mb.getOpen_day());
			pstmt.setString(6, mb.getActor());
			pstmt.setString(7, mb.getProduction());
			pstmt.setString(8, mb.getAge());
			pstmt.executeUpdate();
			
			sql="insert into movie_detail(movie_num,g_code,contents,image,video)"
					+" values(?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setString(2, mb.getG_code());
			pstmt.setString(3, mb.getContents());
			pstmt.setString(4, mb.getImage());
			pstmt.setString(5, mb.getVideo());
			result=pstmt.executeUpdate();
			
			if(result!=0){
				return true;
			}
		}catch(Exception e){
			System.out.println("insertMovie���� ���� : "+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
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
			sql="select * from movie m1, movie_detail m2,ganre g "
					+ "where m1.g_code=g.g_code and m1.movie_num=m2.movie_num and m1.movie_num=?  order by 3";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, movie_num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				mb=new MovieBean();
				mb.setAge(rs.getString("age"));
				mb.setActor(rs.getString("actor"));
				mb.setG_code(rs.getString("g_code"));
				mb.setMovie_num(rs.getString("movie_num"));
				mb.setDirector(rs.getString("director"));
				mb.setName(rs.getString("name"));
				mb.setOpen_day(rs.getString("open_day"));
				mb.setProduction(rs.getString("production"));
				mb.setGrade(rs.getDouble("grade"));
				mb.setContents(rs.getString("contents"));
				mb.setImage(rs.getString("image"));
				mb.setVideo(rs.getString("video"));
				mb.setGanre(rs.getString("ganre"));
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
	
	public List searchMovie(String search){
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		ArrayList v= new ArrayList();
		String sql="";
		String movie_num;
		try{
			con=getConnection();
			sql="select movie_num from movie where name like '%"+search+"%'";
			pstmt=con.prepareStatement(sql);

			rs=pstmt.executeQuery();
			while(rs.next()){
				movie_num=rs.getString("movie_num");
				sql="select movie_num,name,open_day from movie where movie_num=? order by 3";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, movie_num);
				ResultSet rs2=pstmt.executeQuery();
				while(rs2.next()){
					MovieBean mb=new MovieBean();
					
					mb.setMovie_num(rs2.getString("movie_num"));
					
					mb.setName(rs2.getString("name"));
					mb.setOpen_day(rs2.getString("open_day"));
					
					v.add(mb);
				}
			}
			
		}catch(Exception e){
			System.out.println("searchMovie���� ���� : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return v;
	}
	
	
	
}
