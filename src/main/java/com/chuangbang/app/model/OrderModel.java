package com.chuangbang.app.model;

import java.util.Date;
import java.util.List;

import com.google.common.collect.Lists;

public class OrderModel{


	/**
	 * 编号
	 */
	private Long id;
	/**
	 * 订单流水号
	 */
	private String orderNo;  

	/**
	 * 订单类型
	 */
	private String orderType;  

	/**
	 * 所属区域
	 */
	private String area;  

	/**
	 * 酒店编号
	 */
	private Long hotelId;  

	/**
	 * 酒店名称
	 */
	private String hotelName;  


	/**
	 * 酒店跟进销售编号
	 */
	private String hotelSaleId;  

	/**
	 * 酒店跟进销售姓名
	 */
	private String hotelSaleName;  

	/**
	 * 酒店跟进销售电话
	 */
	private String hotelSaleMobile;  

	/**
	 * 金额
	 */
	private Double amount;  
	/**
	 * 掌柜折扣
	 */
	private Double zgdiscount;
	/**
	 * 掌柜预算金额
	 */
	private Double zgamount;
	/**
	 * 预付金额
	 */
	private Double prepaid;  

	/**
	 * 尾款
	 */
	private Double finalPayment;  

	/**
	 * 场地金额
	 */
	private Double siteAmount;
	/**
	 * 场地服务费金额
	 */
	private Double siteCommissionFee;
	/**
	 * 住房金额
	 */
	private Double roomAmount;
	/**
	 * 用餐金额
	 */
	private Double diningAmount;

	/**
	 * 客户编号
	 */
	private String clientId;  

	/**
	 * 活动日期
	 */
	private String activityDate; 
	/**
	 * 活动名称
	 */
	private String  activityTitle; 
	/**
	 * 活动主办单位
	 */
	private String organizer;  
	/**
	 * 联系人
	 */
	private String linkman;  

	/**
	 * 联系电话
	 */
	private String contactNumber;  

	/**
	 * 客户获取积分
	 */
	private Double clientPoints;  


	/**
	 * 订单状态
	 * 01	预订；02	处理中；03	无处理；04	进行中；05	失败；06	进行中；07	确认完成；08	客户评价；10	已取消；11	退款中；12	已退款；13	已关闭
	 */
	private String state;  

	/**
	 * 结算状态
	 *  01	未付款；02	已支付订金；03	待结算；04	已结算；05	挂帐
	 */
	private String settlementStatus;  

	/**
	 * 结算时间
	 */
	private Date settlementDate;  

	/**
	 * 结算人员
	 */
	private String settlementUid;  

	/**
	 * 公司销售编号	
	 */
	private String companySaleId;  

	/**
	 * 公司销售姓名
	 */
	private String companySaleName;  

	/**
	 * 公司销售电话	
	 */
	private String companySaleMobile;  

	/**
	 * 创建时间
	 */
	private Date createDate;  

	/**
	 * 支付类型
	 */
	private String payType;  
	/**
	 * 支付时间
	 */
	private Date payDate;

	/**
	 * 退款时间
	 */
	private Date refundDate;  
	/**
	 * 退款原因
	 */
	private String refundReason; 
	/**
	 * 退款备注
	 */
	private String refundMemo; 
	/**
	 * 取消时间
	 */
	private Date cancelDate;

	/**
	 * 取消原因
	 */
	private String cancelReason;  

	/**
	 * 取消备注
	 */
	private String cancelMemo; 
	
	/**
	 * 公司客服编号
	 */
	private String companyFollowSaleId;  
	
	/**
	 * 公司客服姓名
	 */
	private String companyFollowSaleName;  
	
	/**
	 * 公司客服介入时间
	 */
	private Date companyFollowTime;
	
	/**
	 * 公司客服介入反馈
	 */
	private String companyFollowMemo;

	/**
	 * 备注
	 */
	private String memo; 
	
	private String email;
	/**
	 * 活动场地
	 */
	List<HallOrderDetailModel> sites = Lists.newArrayList();
	/**
	 * 住房
	 */
	List<RoomOrderDetailModel> rooms = Lists.newArrayList();
	/**
	 * 用餐
	 */
	List<MealOrderDetailModel> meals = Lists.newArrayList();
	
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
	
	public String getOrderNo(){  
		return orderNo;  
	}  
	public void setOrderNo(String orderNo){  
		this.orderNo = orderNo;  
	}  


	public String getArea(){  
		return area;  
	}  
	public void setArea(String area){  
		this.area = area;  
	}  

	public Long getHotelId(){  
		return hotelId;  
	}  
	public void setHotelId(Long hotelId){  
		this.hotelId = hotelId;  
	}  

	public String getHotelName(){  
		return hotelName;  
	}  
	public void setHotelName(String hotelName){  
		this.hotelName = hotelName;  
	}  

	public String getHotelSaleId(){  
		return hotelSaleId;  
	}  
	public void setHotelSaleId(String hotelSaleId){  
		this.hotelSaleId = hotelSaleId;  
	}  

	public String getHotelSaleName(){  
		return hotelSaleName;  
	}  
	public void setHotelSaleName(String hotelSaleName){  
		this.hotelSaleName = hotelSaleName;  
	}  

	public String getHotelSaleMobile(){  
		return hotelSaleMobile;  
	}  
	public void setHotelSaleMobile(String hotelSaleMobile){  
		this.hotelSaleMobile = hotelSaleMobile;  
	}  


	public String getActivityDate() {
		return activityDate;
	}
	public void setActivityDate(String activityDate) {
		this.activityDate = activityDate;
	}

	public Double getAmount(){  
		return amount;  
	}  
	public void setAmount(Double amount){  
		this.amount = amount;  
	}  

	public Double getPrepaid(){  
		return prepaid;  
	}  
	public void setPrepaid(Double prepaid){  
		this.prepaid = prepaid;  
	}  

	public Double getFinalPayment(){  
		return finalPayment;  
	}  
	public void setFinalPayment(Double finalPayment){  
		this.finalPayment = finalPayment;  
	}  

	public String getClientId(){  
		return clientId;  
	}  
	public void setClientId(String clientId){  
		this.clientId = clientId;  
	}  

	public String getOrganizer(){  
		return organizer;  
	}  
	public void setOrganizer(String organizer){  
		this.organizer = organizer;  
	}  

	public String getLinkman(){  
		return linkman;  
	}  
	public void setLinkman(String linkman){  
		this.linkman = linkman;  
	}  

	public String getContactNumber(){  
		return contactNumber;  
	}  
	public void setContactNumber(String contactNumber){  
		this.contactNumber = contactNumber;  
	}  

	public Double getClientPoints(){  
		return clientPoints;  
	}  
	public void setClientPoints(Double clientPoints){  
		this.clientPoints = clientPoints;  
	}  

	public String getState(){  
		return state;  
	}  
	public void setState(String state){  
		this.state = state;  
	}  

	public String getSettlementStatus(){  
		return settlementStatus;  
	}  
	public void setSettlementStatus(String settlementStatus){  
		this.settlementStatus = settlementStatus;  
	}  


	public Date getSettlementDate(){  
		return settlementDate;  
	}  
	public void setSettlementDate(Date settlementDate){  
		this.settlementDate = settlementDate;  
	}  

	public String getSettlementUid(){  
		return settlementUid;  
	}  
	public void setSettlementUid(String settlementUid){  
		this.settlementUid = settlementUid;  
	}  


	public String getCompanySaleId(){  
		return companySaleId;  
	}  
	public void setCompanySaleId(String companySaleId){  
		this.companySaleId = companySaleId;  
	}  

	public String getCompanySaleName(){  
		return companySaleName;  
	}  
	public void setCompanySaleName(String companySaleName){  
		this.companySaleName = companySaleName;  
	}  

	public String getCompanySaleMobile(){  
		return companySaleMobile;  
	}  
	public void setCompanySaleMobile(String companySaleMobile){  
		this.companySaleMobile = companySaleMobile;  
	}  

	public Date getCreateDate(){  
		return createDate;  
	}  
	public void setCreateDate(Date createDate){  
		this.createDate = createDate;  
	}  

	public String getMemo(){  
		return memo;  
	}  
	public void setMemo(String memo){  
		this.memo = memo;  
	}

	public String getActivityTitle() {
		return activityTitle;
	}
	public void setActivityTitle(String activityTitle) {
		this.activityTitle = activityTitle;
	}

	public String getOrderType() {
		return orderType;
	}
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public Date getRefundDate() {
		return refundDate;
	}
	public void setRefundDate(Date refundDate) {
		this.refundDate = refundDate;
	}

	public String getRefundReason() {
		return refundReason;
	}
	public void setRefundReason(String refundReason) {
		this.refundReason = refundReason;
	}

	public String getRefundMemo() {
		return refundMemo;
	}
	public void setRefundMemo(String refundMemo) {
		this.refundMemo = refundMemo;
	}

	public Date getCancelDate() {
		return cancelDate;
	}
	public void setCancelDate(Date cancelDate) {
		this.cancelDate = cancelDate;
	}

	public String getCancelReason() {
		return cancelReason;
	}
	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}

	public String getCancelMemo() {
		return cancelMemo;
	}
	public void setCancelMemo(String cancelMemo) {
		this.cancelMemo = cancelMemo;
	}

	public Date getPayDate() {
		return payDate;
	}
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}

	public Double getZgamount() {
		return zgamount;
	}
	public void setZgamount(Double zgamount) {
		this.zgamount = zgamount;
	}
	public Double getSiteAmount() {
		return siteAmount;
	}
	public void setSiteAmount(Double siteAmount) {
		this.siteAmount = siteAmount;
	}
	public Double getSiteCommissionFee() {
		return siteCommissionFee;
	}
	public void setSiteCommissionFee(Double siteCommissionFee) {
		this.siteCommissionFee = siteCommissionFee;
	}
	public Double getRoomAmount() {
		return roomAmount;
	}
	public void setRoomAmount(Double roomAmount) {
		this.roomAmount = roomAmount;
	}
	public Double getDiningAmount() {
		return diningAmount;
	}
	public void setDiningAmount(Double diningAmount) {
		this.diningAmount = diningAmount;
	}

	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}

	public List<HallOrderDetailModel> getSites() {
		return sites;
	}
	public void setSites(List<HallOrderDetailModel> sites) {
		this.sites = sites;
	}
	
	public List<RoomOrderDetailModel> getRooms() {
		return rooms;
	}
	public void setRooms(List<RoomOrderDetailModel> rooms) {
		this.rooms = rooms;
	}
	
	public List<MealOrderDetailModel> getMeals() {
		return meals;
	}
	public void setMeals(List<MealOrderDetailModel> meals) {
		this.meals = meals;
	}
	
	public String getCompanyFollowSaleId() {
		return companyFollowSaleId;
	}
	public void setCompanyFollowSaleId(String companyFollowSaleId) {
		this.companyFollowSaleId = companyFollowSaleId;
	}
	public String getCompanyFollowSaleName() {
		return companyFollowSaleName;
	}
	public void setCompanyFollowSaleName(String companyFollowSaleName) {
		this.companyFollowSaleName = companyFollowSaleName;
	}
	public Date getCompanyFollowTime() {
		return companyFollowTime;
	}
	public void setCompanyFollowTime(Date companyFollowTime) {
		this.companyFollowTime = companyFollowTime;
	}
	public String getCompanyFollowMemo() {
		return companyFollowMemo;
	}
	public void setCompanyFollowMemo(String companyFollowMemo) {
		this.companyFollowMemo = companyFollowMemo;
	}
	
	public Double getZgdiscount() {
		return zgdiscount;
	}
	public void setZgdiscount(Double zgdiscount) {
		this.zgdiscount = zgdiscount;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	
	@Override
	public String toString() {
		return "o.order_no as orderNo, o.source_app_id as sourceAppId, o.order_source as orderSource, o.area as area, o.hotel_id as hotelId"
				+ ", o.hotel_name as hotelName, o.hotel_sale_id as hotelSaleId, o.hotel_sale_name as hotelSaleName, o.hotel_sale_mobile as hotelSaleMobile"
				+ ", o.amount as amount, o.zgamount as zgamount, o.prepaid as prepaid, o.final_payment as finalPayment, o.site_amount as siteAmount"
				+ ", o.site_commissionFee as siteCommissionFee, o.room_amount as roomAmount, o.dining_amount as diningAmount, o.client_id as clientId"
				+ ", o.activity_date as activityDate, o.activity_title as activityTitle, o.organizer as organizer, o.linkman as linkman, o.contact_number as contactNumber"
				+ ", o.client_points as clientPoints, o.state as state, o.settlement_status as settlementStatus, o.settlement_date as settlementDate"
				+ ", o.settlement_uid as settlementUid, o.company_sale_id as companySaleId, o.company_sale_name as companySaleName, o.company_sale_mobile as companySaleMobile"
				+ ", o.create_date as createDate, o.pay_type as payType, o.pay_date as payDate, o.refund_date as refundDate, o.refund_reason as refundReason"
				+ ", o.refund_memo as refundMemo, o.cancel_date as cancelDate, o.cancel_reason as cancelReason, o.cancel_memo as cancelMemo, o.memo as memo";
	}
	
}


