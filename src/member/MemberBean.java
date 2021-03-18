package member;


public class MemberBean {
	// 받아온 파라미터를 멤버변수 id,pass,name,date 저장
	//멤버변수 : 아주 중요한데이터 아무나 접근못하게 데이터 은닉
	private String id;
	private String pass;
	private String name;
	private String email;
	private String address;
	private String subAddress;
	private String postCode;
	private String phone;
	
	
	
	public String getSubAddress() {
		return subAddress;
	}
	public void setSubAddress(String subAddress) {
		this.subAddress = subAddress;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	//메서드() : 접근할수 있는 통로 준비 set() get()
	// alt shfit s -> r
	public String getId() {
		return id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	
	
}
