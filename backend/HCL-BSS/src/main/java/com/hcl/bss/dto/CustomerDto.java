package com.hcl.bss.dto;

public class CustomerDto {
	
	private String firstName;
	private String lastName;
	private String emailAddress;
	private AddressDto billingAdress;
	private AddressDto shippingAdress;
	private String companyName;
	private String phoneNo;;
	private SubscriptionDetailDto subscriptionDto;

	
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmailAddress() {
		return emailAddress;
	}
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}
	public AddressDto getBillingAdress() {
		return billingAdress;
	}
	public void setBillingAdress(AddressDto billingAdress) {
		this.billingAdress = billingAdress;
	}
	public AddressDto getShippingAdress() {
		return shippingAdress;
	}
	public void setShippingAdress(AddressDto shippingAdress) {
		this.shippingAdress = shippingAdress;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public SubscriptionDetailDto getSubscriptionDto() {
		return subscriptionDto;
	}
	public void setSubscriptionDto(SubscriptionDetailDto subscriptionDto) {
		this.subscriptionDto = subscriptionDto;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}	
	
}
