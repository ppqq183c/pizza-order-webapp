package model;

public class Customer {
	private int custId;
	private String custName;
	private String accountName;
	private String password;
	private String kana;
	private String tel;
	private String address;
	private String birthDay;
	private String joinDay;
	private String cancelDay;
	public Customer() {
		
	}
	public Customer(int custId,String accountName, String custName,String password, String kana, String tel, String address, String birthDay, String joinDay,String cancelDay) {
		setCustId(custId);
		setAccountName(accountName);
		setPassword(password);
		setCustName(custName);
		setKana(kana);
		setTel(tel);
		setAddress(address);
		setBirthDay(birthDay);
		setJoinDay(joinDay);
		setCancelDay(cancelDay);
		
	}
	public void setCustId(int custId) {
		this.custId=custId;
	}
	public int getCustId() {
		return custId;
	}
	public void setAccountName(String accountName) {
		this.accountName=accountName;
	}
	public String getAccountName() {
		return accountName;
	}
	public void setPassword(String password) {
		this.password=password;
	}
	public String getPassword() {
		return password;
	}
	public void setCustName(String custName) {
		this.custName=custName;
	}
	public String getCustName() {
		return custName;
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
	public void setBirthDay(String birthDay) {
		this.birthDay=birthDay;
	}
	public String getBirthDay() {
		return birthDay;
	}
	public void setJoinDay(String joinDay) {
		this.joinDay=joinDay;
	}
	public String getJoinDay() {
		return joinDay;
	}
	public void setCancelDay(String cancelDay) {
		this.cancelDay=cancelDay;
	}
	public String getCancelDay() {
		return cancelDay;
	}
	
}
