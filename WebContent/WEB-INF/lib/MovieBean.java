package team.movie.db;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class MovieBean {
	private String movie_num; //영화고유번호
	private String g_code; //장르코드
	private String name; //영화제목
	private String director; //감독
	private String open_day; //개봉일
	private String actor; //배우
	private String production; //제작사
	private String age; //이용가
	private String contents; //영화내용
	private String image; //영화이미지파일이름
	private String ganre; //장르
	private String video; //비디오링크 
	private double grade; //평점
	
	
	
	public String setDateFormat(String d){
		 SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
	     return formatter.format(d);
	}
	
	public String getGanre() {
		return ganre;
	}

	public void setGanre(String ganre) {
		this.ganre = ganre;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}


	
    public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	public double getGrade() {
		return grade;
	}

	public void setGrade(double grade) {
		this.grade = grade;
	}


	public String getMovie_num() {
		return movie_num;
	}
	public void setMovie_num(String movie_num) {
		this.movie_num = movie_num;
	}
	public String getG_code() {
		return g_code;
	}
	public void setG_code(String g_code) {
		this.g_code = g_code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	
	public String getOpen_day() {
		return this.open_day;
	}

	public void setOpen_day(String open_day) {
		this.open_day = open_day;
	}
	
	public String getActor() {
		return actor;
	}
	public void setActor(String actor) {
		this.actor = actor;
	}
	public String getProduction() {
		return production;
	}
	public void setProduction(String production) {
		this.production = production;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	
	
}
