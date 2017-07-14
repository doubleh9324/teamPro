package team.playing.db;

import java.text.SimpleDateFormat;
import java.util.Date;

public class PlayTimeBean {
	
	private int ping_num;
	private String play_day;
	private String playtime;
	
	public int getPing_num() {
		return ping_num;
	}
	public void setPing_num(int ping_num) {
		this.ping_num = ping_num;
	}
	public String getPlay_day() {
		return play_day;
	}
	public void setPlay_day(String play_day) {
		this.play_day = play_day;
	}

	public void setPlay_day(Date pday){
		this.play_day = setDateFormat(pday);
	}
	
	public String getPlaytime() {
		return playtime;
	}

	public void setPlaytime(Date ptime) {
			this.playtime = setTimeFormat(ptime);
	}
	
	public void setPlaytime(String ptime) {
			this.playtime = ptime;
	}
	
	
	public String setDateFormat(Date d){
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
	    return formatter.format(d);
	}
	
	public String setTimeFormat(Date d){
	    SimpleDateFormat formatter = new SimpleDateFormat("kk:mm");
	    return formatter.format(d);
	}

}
