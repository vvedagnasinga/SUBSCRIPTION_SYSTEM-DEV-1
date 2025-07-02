package com.hcl.bss.dto;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

public class UserDetails {
	private String userProfile;
	@NotEmpty @Email
	private String userId;
	//@NotEmpty
	private String userFirstName;
	private String userMiddleName;
	private String userLastName;
	private String isLocked;
	private boolean isLoggedIn;
	private String message;
	private String attribute;
	private String newAttribute;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserFirstName() {
		return userFirstName;
	}
	public void setUserFirstName(String userFirstName) {
		this.userFirstName = userFirstName;
	}
	public String getUserMiddleName() {
		return userMiddleName;
	}
	public void setUserMiddleName(String userMiddleName) {
		this.userMiddleName = userMiddleName;
	}
	public String getUserLastName() {
		return userLastName;
	}
	public void setUserLastName(String userLastName) {
		this.userLastName = userLastName;
	}
	public String getUserProfile() {
		return userProfile;
	}
	public void setUserProfile(String userProfile) {
		this.userProfile = userProfile;
	}
	public boolean isLoggedIn() {
		return isLoggedIn;
	}
	public void setLoggedIn(boolean isLoggedIn) {
		this.isLoggedIn = isLoggedIn;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getIsLocked() {
		return isLocked;
	}
	public void setIsLocked(String isLocked) {
		this.isLocked = isLocked;
	}
	public String getAttribute() {
		return attribute;
	}
	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}
	public String getNewAttribute() {
		return newAttribute;
	}
	public void setNewAttribute(String newAttribute) {
		this.newAttribute = newAttribute;
	}
	
}
