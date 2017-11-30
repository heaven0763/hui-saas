package com.chuangbang.wechat.hui.model;

import org.apache.commons.lang3.StringUtils;

public class OrderParam {
	private Long id; 
	private String orderNo; 
	private String ismain; 
	private String hallIds; 
	private Double hallAmount; 
	private Double hallAllAmount; 
	private Double commissionFeeRate; 
	private String roomIds; 
	private Double roomAmount; 
	private Double roomAllAmount; 
	private String mealIds; 
	private Double mealAmount; 
	private Double mealAllAmount; 
	private String otherdetail; 
	private String otherprice; 
	private String email;
	private String linkman; 
	private String contactNumber; 
	private String organizer; 
	private String activityDate; 
	private String activityTitle; 
	private String memo;
	private Double mealServiceFeeRate;
	private String oprice; 
	private String oquantity;
	/**
	 * 会场预定备注
	 */
	private String meetingRemark;
	/**
	 * 住房预定备注
	 */
	private String houseRemark;
	/**
	 * 用餐预定备注
	 */
	private String dinnerRemark;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getIsmain() {
		return ismain;
	}
	public void setIsmain(String ismain) {
		this.ismain = ismain;
	}
	public String getHallIds() {
		return hallIds;
	}
	public void setHallIds(String hallIds) {
		this.hallIds = hallIds;
	}
	public Double getHallAmount() {
		return hallAmount;
	}
	public void setHallAmount(Double hallAmount) {
		this.hallAmount = hallAmount;
	}
	public Double getHallAllAmount() {
		return hallAllAmount;
	}
	public void setHallAllAmount(Double hallAllAmount) {
		this.hallAllAmount = hallAllAmount;
	}
	public Double getCommissionFeeRate() {
		return commissionFeeRate;
	}
	public void setCommissionFeeRate(Double commissionFeeRate) {
		this.commissionFeeRate = commissionFeeRate;
	}
	public String getRoomIds() {
		return roomIds;
	}
	public void setRoomIds(String roomIds) {
		this.roomIds = roomIds;
	}
	public Double getRoomAmount() {
		return roomAmount;
	}
	public void setRoomAmount(Double roomAmount) {
		this.roomAmount = roomAmount;
	}
	public Double getRoomAllAmount() {
		return roomAllAmount;
	}
	public void setRoomAllAmount(Double roomAllAmount) {
		this.roomAllAmount = roomAllAmount;
	}
	public String getMealIds() {
		return mealIds;
	}
	public void setMealIds(String mealIds) {
		this.mealIds = mealIds;
	}
	public Double getMealAmount() {
		return mealAmount;
	}
	public void setMealAmount(Double mealAmount) {
		this.mealAmount = mealAmount;
	}
	public Double getMealAllAmount() {
		return mealAllAmount;
	}
	public void setMealAllAmount(Double mealAllAmount) {
		this.mealAllAmount = mealAllAmount;
	}
	public String getOtherdetail() {
		return otherdetail;
	}
	public void setOtherdetail(String otherdetail) {
		this.otherdetail = otherdetail;
	}
	public String getOtherprice() {
		return otherprice;
	}
	public void setOtherprice(String otherprice) {
		this.otherprice = otherprice;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getLinkman() {
		return linkman;
	}
	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}
	public String getContactNumber() {
		return contactNumber;
	}
	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}
	public String getOrganizer() {
		return organizer;
	}
	public void setOrganizer(String organizer) {
		this.organizer = organizer;
	}
	public String getActivityDate() {
		return activityDate;
	}
	public void setActivityDate(String activityDate) {
		this.activityDate = activityDate;
	}
	public String getActivityTitle() {
		return activityTitle;
	}
	public void setActivityTitle(String activityTitle) {
		this.activityTitle = activityTitle;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getOprice() {
		return oprice;
	}
	public void setOprice(String oprice) {
		this.oprice = oprice;
	}
	public String getOquantity() {
		return oquantity;
	}
	public void setOquantity(String oquantity) {
		this.oquantity = oquantity;
	}
	public String getMeetingRemark() {
		return meetingRemark;
	}
	public void setMeetingRemark(String meetingRemark) {
		this.meetingRemark = meetingRemark;
	}
	public String getHouseRemark() {
		return houseRemark;
	}
	public void setHouseRemark(String houseRemark) {
		this.houseRemark = houseRemark;
	}
	public String getDinnerRemark() {
		return dinnerRemark;
	}
	public void setDinnerRemark(String dinnerRemark) {
		this.dinnerRemark = dinnerRemark;
	}
	
	public Double[] getOtherPrice(){
		if(StringUtils.isNotBlank(otherprice)){
			String [] otherprices = otherprice.split(",");
			if(otherprices!=null&&otherprices.length>0){
				Double[] othrPrices = new Double[otherprices.length];
				for (int i = 0; i < otherprices.length; i++) {
					othrPrices[i] = Double.valueOf(otherprices[i]);
					System.out.println("otherprice>>>>>>>>>>>>>>>>>>>>>>>>>>>"+othrPrices[i]);
				}
				return othrPrices;
			}
		}
		return null;
	}
	
	public Long[] getOQuantity(){
		if(StringUtils.isNotBlank(oquantity)){
			String [] oquantitys = oquantity.split(",");
			if(oquantitys!=null&&oquantitys.length>0){
				Long[] oqnttys = new Long[oquantitys.length];
				for (int i = 0; i < oquantitys.length; i++) {
					oqnttys[i] = Long.valueOf(oquantitys[i]);
				}
				return oqnttys;
			}
		}
		return null;
	}

	public Double[] getOUnitPrice(){
		if(StringUtils.isNotBlank(oprice)){
			String [] oprices = oprice.split(",");
			if(oprices!=null&&oprices.length>0){
				Double[] ouPrices = new Double[oprices.length];
				for (int i = 0; i < oprices.length; i++) {
					ouPrices[i] = Double.valueOf(oprices[i]);
				}
				return ouPrices;
			}
		}
		return null;
	}
	@Override
	public String toString() {
		return "OrderParam [id=" + id + ", orderNo=" + orderNo + ", ismain=" + ismain + ", hallIds=" + hallIds
				+ ", hallAmount=" + hallAmount + ", hallAllAmount=" + hallAllAmount + ", commissionFeeRate="
				+ commissionFeeRate + ", roomIds=" + roomIds + ", roomAmount=" + roomAmount + ", roomAllAmount="
				+ roomAllAmount + ", mealIds=" + mealIds + ", mealAmount=" + mealAmount + ", mealAllAmount="
				+ mealAllAmount + ", otherdetail=" + otherdetail + ", otherprice=" + otherprice + ", email=" + email
				+ ", linkman=" + linkman + ", contactNumber=" + contactNumber + ", organizer=" + organizer
				+ ", activityDate=" + activityDate + ", activityTitle=" + activityTitle + ", memo=" + memo + ", oprice="
				+ oprice + ", oquantity=" + oquantity + ", meetingRemark=" + meetingRemark + ", houseRemark="
				+ houseRemark + ", dinnerRemark=" + dinnerRemark + "]";
	}
	public String[] getOtherDetail() {
		if(StringUtils.isNotBlank(otherdetail)){
			String [] otherdetails = otherdetail.split(",");
			return otherdetails;
		}
		return null;
	}
	public Double getMealServiceFeeRate() {
		return mealServiceFeeRate;
	}
	public void setMealServiceFeeRate(Double mealServiceFeeRate) {
		this.mealServiceFeeRate = mealServiceFeeRate;
	}
	
}
