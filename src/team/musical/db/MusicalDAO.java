package team.musical.db;

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

import team.movie.db.MovieBean;
import team.musical.db.MusicalBean;

public class MusicalDAO {
	
	private Connection getConnection() throws Exception{
		Connection con=null;
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/team");
		con=ds.getConnection();
		return con;
	}
	public Vector<MusicalBean> playingMusicals(){ //���� ������ ��ȭ 
		Vector<MusicalBean> v= new Vector<MusicalBean>();
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		try{
			con=getConnection();
			sql="select m1.musical_num, m1.name, m2.image from musical m1,musical_detail m2 where m1.musical_num=m2.musical_num and curdate()<=m1.close_day and curdate()>=m1.open_day;";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MusicalBean mb= new MusicalBean();
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setName(rs.getString("name"));
				mb.setImage(rs.getString("image"));
				
				v.add(mb);
			}
		}catch(Exception e){
			System.out.println("playingMusicals에서 오류: "+e);
			
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		return v;
	}
	
	public List<MusicalBean> getAllMusicals(){ 
		List<MusicalBean> musicalList= new ArrayList<MusicalBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
	
		try{
			con=getConnection();
			sql="select m1.musical_num,m1.name,m1.age,m2.image,m2.grade from musical m1, musical_detail m2 "
					+ "where m1.musical_num=m2.musical_num order by 2";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				do{
					MusicalBean mb = new MusicalBean();
					mb.setMusical_num(rs.getString("musical_num"));
					mb.setName(rs.getString("name"));
					mb.setAge(rs.getString("age"));
					mb.setImage(rs.getString("image"));
					mb.setGrade(rs.getDouble("grade"));
					musicalList.add(mb);
				}while(rs.next());
				return musicalList;
			}else{
				return Collections.emptyList();
			}
			
		}catch(Exception e){
			System.out.println("getAllMusicals에서 오류: "+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}
		
		return Collections.emptyList();
	}
	public boolean insertMusical(MusicalBean mb){ //������ �߰�
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql="";
		int count=0;
		int result=0;
		try{
			con=getConnection();
			sql="select count(musical_num) from musical";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				count=rs.getInt(1)+1;
			}else count=1;
			
			sql="insert into musical(musical_num,g_code,name,director,open_day,close_day,actor,production,age)"
				+" values(?,?,?,?,?,?,?,?,?)";
				
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setString(2, mb.getG_code());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getDirector());
			pstmt.setString(5, mb.getOpen_day());
			pstmt.setString(6, mb.getClose_day());
			pstmt.setString(7, mb.getActor());
			pstmt.setString(8, mb.getProduction());
			pstmt.setString(9, mb.getAge());
			pstmt.executeUpdate();
			
			sql="insert into musical_detail(musical_num,g_code,contents,image,video)"
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
			System.out.println("insertMusical에서 오류 : "+e);
		}finally{
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return false;
	}
	
	public MusicalBean selectMusical(String musical_num){ //������ ��ü �ϳ��� ����
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		MusicalBean mb = null;
		String sql="";
		try{
			con=getConnection();
			sql="select * from musical m1,musical_detail m2, ganre g "
					+ "where m1.musical_num=m2.musical_num and m1.g_code=g.g_code and m1.musical_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, musical_num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				mb=new MusicalBean();
				mb.setAge(rs.getString("age"));
				mb.setActor(rs.getString("actor"));
				mb.setG_code(rs.getString("g_code"));
				mb.setMusical_num(rs.getString("musical_num"));
				mb.setDirector(rs.getString("director"));
				mb.setName(rs.getString("name"));
				mb.setOpen_day(rs.getString("open_day"));
				mb.setClose_day(rs.getString("close_day"));
				mb.setProduction(rs.getString("production"));
				mb.setGrade(rs.getDouble("grade"));
				mb.setContents(rs.getString("contents"));
				mb.setImage(rs.getString("image"));
				mb.setVideo(rs.getString("video"));
				mb.setGanre(rs.getString("ganre"));
			}
			
		}catch(Exception e){
			System.out.println("selectMusical에서 오류 : "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return mb;
	}
	
	public Vector<MusicalBean> searchMusical(String search){  //������ �˻�
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		Vector<MusicalBean> v= new Vector<MusicalBean>();
		String sql="";
		String musical_num;
		try{
			con=getConnection();
			sql="select musical_num from musical where name like '%"+search+"%'";
			pstmt=con.prepareStatement(sql);

			rs=pstmt.executeQuery();
			while(rs.next()){
				musical_num=rs.getString("musical_num");
				sql="select musical_num,name,open_day from musical where musical_num=? order by 3";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, musical_num);
				ResultSet rs2=pstmt.executeQuery();
				while(rs2.next()){
					MusicalBean mb=new MusicalBean();
					//mb.setAge(rs2.getString("age"));
					//mb.setActor(rs2.getString("actor"));
					//mb.setG_code(rs2.getString("g_code"));
					mb.setMusical_num(rs2.getString("musical_num"));
					//mb.setDirector(rs2.getString("director"));
					mb.setName(rs2.getString("name"));
					mb.setOpen_day(rs2.getString("open_day"));
					//mb.setClose_day(rs2.getString("close_day"));
					//mb.setProduction(rs2.getString("production"));
					//mb.setGrade(rs2.getDouble("grade"));
					//mb.setContents(rs2.getString("contents"));
					//mb.setImage(rs2.getString("image"));
					//mb.setVideo(rs2.getString("video"));
					//mb.setGanre(rs2.getString("ganre"));
					v.add(mb);
				}
			}
			
		}catch(Exception e){
			System.out.println("searchMusical에서 오류: "+e);
		}finally{
			if(pstmt!=null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(con!=null){try{con.close();}catch(Exception e){e.printStackTrace();}}
			if(rs!=null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		}	
		return v;
	}
	
}
