package team.movie.db;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class MovieBean {
	private String movie_num;
	private String g_code;
	private String name;
	private String director;
	private String playing_day;
	private String actor;
	private String production;
	private String age;
	
    public String setDateFormat(Date playing_day){
			 SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
		     return formatter.format(playing_day);
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
	
	public String getPlaying_day() {
		return this.playing_day;
	}
	public void setPlaying_day(Date playing_day) {
		this.playing_day = setDateFormat(playing_day);
	}
	public void setPlaying_day(String playing_day) {
		this.playing_day = playing_day;
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
