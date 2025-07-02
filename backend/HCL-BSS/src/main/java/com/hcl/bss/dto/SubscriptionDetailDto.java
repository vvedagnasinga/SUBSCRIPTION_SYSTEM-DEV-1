package com.hcl.bss.dto;

import java.math.BigDecimal;
import java.util.List;

public class SubscriptionDetailDto {
	
	private String subscriptionId;
	private String status;
	private String lastBillDate;
	private String nextBillDate;
	private String cancelDate;// this will be used after cancellation flow
	private Boolean renewsForever;
	private BigDecimal remainingCycles;
	private String expireOn;
	private String totalAmount; // it will be used after total amount will be incorporated in subscription table
	private List<SubscriptionRatePlanDto> productPlanList;
	private String subscriptionDuration;
	private String createdOn;
	private String activationDate;
	public Boolean getRenewsForever() {
		return renewsForever;
	}
	public void setRenewsForever(Boolean renewsForever) {
		this.renewsForever = renewsForever;
	}
	public BigDecimal getRemainingCycles() {
		return remainingCycles;
	}
	public void setRemainingCycles(BigDecimal remainingCycles) {
		this.remainingCycles = remainingCycles;
	}
	public String getExpireOn() {
		return expireOn;
	}
	public void setExpireOn(String expireOn) {
		this.expireOn = expireOn;
	}
	public List<SubscriptionRatePlanDto> getProductPlanList() {
		return productPlanList;
	}
	public void setProductPlanList(List<SubscriptionRatePlanDto> productPlanList) {
		this.productPlanList = productPlanList;
	}
	public String getSubscriptionId() {
		return subscriptionId;
	}
	public void setSubscriptionId(String subscriptionId) {
		this.subscriptionId = subscriptionId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getLastBillDate() {
		return lastBillDate;
	}
	public void setLastBillDate(String lastBillDate) {
		this.lastBillDate = lastBillDate;
	}
	public String getNextBillDate() {
		return nextBillDate;
	}
	public void setNextBillDate(String nextBillDate) {
		this.nextBillDate = nextBillDate;
	}
	
	public String getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getCancelDate() {
		return cancelDate;
	}
	public void setCancelDate(String cancelDate) {
		this.cancelDate = cancelDate;
	}
	public String getSubscriptionDuration() {
		return subscriptionDuration;
	}
	public void setSubscriptionDuration(String subscriptionDuration) {
		this.subscriptionDuration = subscriptionDuration;
	}
	public String getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}
	public String getActivationDate() {
		return activationDate;
	}
	public void setActivationDate(String activationDate) {
		this.activationDate = activationDate;
	}
	
	
}
