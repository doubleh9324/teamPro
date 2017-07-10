package team.playing.db;

import java.text.SimpleDateFormat;
import java.util.Date;

public class V_playingseatBean {
	
	private int ping_num;
	private String p_cocde;
	private String nc_code;
	private String start_day;
	private String end_day;
	private String screen_name;
	private String seatclass;
	public int getPing_num() {
		return ping_num;
	}
	public void setPing_num(int ping_num) {
		this.ping_num = ping_num;
	}
	public String getP_cocde() {
		return p_cocde;
	}
	public void setP_cocde(String p_cocde) {
		this.p_cocde = p_cocde;
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
	public void setStart_day(Date sday){
		this.start_day = setDateFormat(sday);
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
	public String getScreen_name() {
		return screen_name;
	}
	public void setScreen_name(String screen_name) {
		this.screen_name = screen_name;
	}
	public String getSeatclass() {
		return seatclass;
	}
	public void setSeatclass(String seatclass) {
		this.seatclass = seatclass;
	}
	
	public String setDateFormat(Date d){
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
	    return formatter.format(d);
	}
}
