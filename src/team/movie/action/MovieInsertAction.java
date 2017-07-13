package team.movie.action;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import team.common.action.Action;
import team.common.action.ActionForward;
import team.movie.db.MovieBean;
import team.movie.db.MovieDAO;

public class MovieInsertAction implements Action{

	
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String postername=new String();
		int max = 10*1024*1024;
		String path="D:\\TeamWorkspace\\TeamProject\\WebContent\\MovieImage";
		MultipartRequest multi = new MultipartRequest(request,path ,max,"utf-8", new DefaultFileRenamePolicy());
		

		Enumeration e = multi.getFileNames();
		while(e.hasMoreElements()){
		    String filename=(String)e.nextElement();
		    String saveFiles=multi.getFilesystemName(filename);//������ ���ε�� ������ �̸�
		    postername=saveFiles;
		}
		
		MovieBean mb = new MovieBean();
		mb.setMovie_num(multi.getParameter("movie_num"));
		mb.setG_code(multi.getParameter("g_code"));
		mb.setName(multi.getParameter("name"));
		mb.setDirector(multi.getParameter("director"));
		mb.setOpen_day(multi.getParameter("open_day"));
		mb.setActor(multi.getParameter("actor"));
		mb.setProduction(multi.getParameter("production"));
		mb.setAge(multi.getParameter("age"));
		mb.setContents(multi.getParameter("contents"));
		mb.setImage(postername);
		mb.setVideo(multi.getParameter("video"));
		
		
		boolean result=false;
		MovieDAO dao = new MovieDAO();
		result = dao.insertMovie(mb);
		
		if(result==false){
			System.out.println("��ȭ �߰� ����");
			return null;
		}
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(true);
		
		forward.setPath("./index2.jsp");
		
		return forward;
	}

}
