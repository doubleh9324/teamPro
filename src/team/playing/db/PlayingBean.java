package team.playing.db;

import java.text.SimpleDateFormat;
import java.util.Date;

public class PlayingBean {
	private int ping_num;
	private String p_code;
	private String nc_code;
	private String start_day;
	private String end_day;
	
	public int getPing_num() {
		return ping_num;
	}
	public void setPing_num(int ping_num) {
		this.ping_num = ping_num;
	}
	public String getP_code() {
		return p_code;
	}
	public void setP_code(String p_code) {
		this.p_code = p_code;
	}
	public String getNc_code() {
		return nc_code;
	}
	public void setNc_code(String nc_code) {
		this.nc_code = nc_code;
	}
	public String getStart_day() {
		return start_day;
	}
	public void setStart_day(String start_day) {
		this.start_day = start_day;
	}
	
	public void setStart_day(Date eday){
	    this.end_day = setDateFormat(eday);
	}
	
	public String getEnd_day() {
		return end_day;
	}
	public void setEnd_day(String end_day) {
		this.end_day = end_day;
	}
	
	public void setEnd_day(Date eday){
	    this.end_day = setDateFormat(eday);
	}
	
    public String setDateFormat(Date d){
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
	    return formatter.format(d);
	}
}
