package com.iot1.sql.user.dto;

public class UserInfo {
	private String userId;
	private String userName;
	private String address;
	private String hp1;
	private String hp2;
	private String hp3;
	private String userPwd;
	private String gender;
	private String userRoleLevel;
	
	private int userNum;
	@Override
	public String toString() {
		return "UserInfo [userId=" + userId + ", userName=" + userName + ", address=" + address + ", hp1=" + hp1
				+ ", hp2=" + hp2 + ", hp3=" + hp3 + ", userPwd=" + userPwd + ", gender=" + gender + ", userRoleLevel="
				+ userRoleLevel + ", userNum=" + userNum + ", age=" + age + ", departNum=" + departNum + "]";
	}
	private int age;
	private int departNum;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getHp1() {
		return hp1;
	}
	public void setHp1(String hp1) {
		this.hp1 = hp1;
	}
	public String getHp2() {
		return hp2;
	}
	public void setHp2(String hp2) {
		this.hp2 = hp2;
	}
	public String getHp3() {
		return hp3;
	}
	public void setHp3(String hp3) {
		this.hp3 = hp3;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getUserRoleLevel() {
		return userRoleLevel;
	}
	public void setUserRoleLevel(String userRoleLevel) {
		this.userRoleLevel = userRoleLevel;
	}
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public int getDepartNum() {
		return departNum;
	}
	public void setDepartNum(int departNum) {
		this.departNum = departNum;
	}

}
