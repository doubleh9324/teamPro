package team.reservation.db;

public class ReservationBean {
	private int r_num;
	private int member_num;
	private int ping_num;
	private String reseat_num;
	private String seat;
	private String view_date;
	private String reser_day;
	private String pay_day;
	private String screen_name;
	private int mPoint;
	private int price;
	
	
	public int getR_num() {
		return r_num;
	}
	public void setR_num(int r_num) {
		this.r_num = r_num;
	}
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public int getPing_num() {
		return ping_num;
	}
	public void setPing_num(int ping_num) {
		this.ping_num = ping_num;
	}
	public String getReseat_num() {
		return reseat_num;
	}
	public void setReseat_num(String reseat_num) {
		this.reseat_num = reseat_num;
	}
	public String getView_date() {
		return view_date;
	}
	public void setView_date(String view_date) {
		this.view_date = view_date;
	}
	public String getReser_day() {
		return reser_day;
	}
	public void setReser_day(String reser_day) {
		this.reser_day = reser_day;
	}
	public String getPay_day() {
		return pay_day;
	}
	public void setPay_day(String pay_day) {
		this.pay_day = pay_day;
	}
	public String getScreen_name() {
		return screen_name;
	}
	public void setScreen_name(String screen_name) {
		this.screen_name = screen_name;
	}
	public int getMPoint() {
		return mPoint;
	}
	public void setMPoint(int mPoint) {
		this.mPoint = mPoint;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getSeat() {
		return seat;
	}
	public void setSeat(String seat) {
		this.seat = seat;
	}
}
