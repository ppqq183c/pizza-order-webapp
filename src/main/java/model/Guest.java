package model;

public class Guest {
	private String guestId;
	private String guestName;
	private String kana;
	private String tel;
	private String address;
	public Guest() {
		
	}
	public Guest(String guestId,String guestName, String kana, String tel, String address) {
		setGuestId(guestId);
		setGuestName(guestName);
		setKana(kana);
		setTel(tel);
		setAddress(address);
	}
	public void setGuestId(String guestId) {
		this.guestId=guestId;
	}
	public String getGuestId() {
		return guestId;
	}
	public void setGuestName(String guestName) {
		this.guestName=guestName;
	}
	public String getGuestName() {
		return guestName;
	}
	public void setKana(String kana) {
		this.kana=kana;
	}
	public String getKana() {
		return kana;
	}
	public void setTel(String tel) {
		this.tel=tel;
	}
	public String getTel() {
		return tel;
	}
	public void setAddress(String address) {
		this.address=address;
	}
	public String getAddress() {
		return address;
	}
	
}
