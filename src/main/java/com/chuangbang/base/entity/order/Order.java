package com.chuangbang.base.entity.order;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

/**
 * 订单Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_order")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Order extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 订单流水号
	 */
	private String orderNo;  
	
	/**
	 * 订单类型
	 */
	private String orderType;  
	
	/**
	 * 订单来源应用编号0:saas系统内部
	 */
	private Long sourceAppId;
	/**
	 * 订单来源
	 */
	private String orderSource;  
	
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
	 * 酒店所属集团
	 */
	private String ownedGroup;  
	
	/**
	 * 返佣权限归属
	 */
	private String commissionRights;  
	
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
	 * 酒店获取积分
	 */
	private Double hotelPoints;  
	
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
	 * 场地服务费率
	 */
	private Double siteCommissionFeeRate;
	/**
	 * 住房金额
	 */
	private Double roomAmount;
	/**
	 * 用餐金额
	 */
	private Double diningAmount;
	
	/**
	 * 用餐服务费金额
	 */
	private Double mealServiceFee;
	
	/**
	 * 用餐服务费率
	 */
	private Double mealServiceFeeRate;
	/**
	 * 其他金额
	 */
	private Double otherAmount;
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
	 * 联系电话
	 */
	private String email; 
	
	/**
	 * 客户获取积分
	 */
	private Double clientPoints;  
	
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
	 * 订单状态
	 * 01	预订；02	处理中；03	无处理；04	进行中；05	失败；06	确认完成；07	客户评价；09：待退款;10	已取消；11	退款中；12	已退款；13	已关闭
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
	 * 结算人员
	 */
	private Double settlementAmount;
	/**
	 * 返佣状态 ：00 未返佣； 01	；02	确认返佣；03	公司财务审核，开票；04 销售领取发票；05酒店收到发票，06：酒店确认转账；07公司财务确认收账
	 */
	private String commissionStatus;  
	
	/**
	 * 返佣时间
	 */
	private Date commissionDate;  
	
	/**
	 * 提佣比例
	 */
	private Double commissionRate;  
	
	/**
	 * 提佣金额
	 */
	private Double commissionAmount;  
	
	/**
	 * 签约时间
	 */
	private Date signDate;  
	
	/**
	 * 签约业务员编号
	 */
	private String signUid;  
	
	/**
	 * 签约业务员姓名
	 */
	private String signUname;  
	
	/**
	 * 是否上传水单
	 */
	private String isupload;  
	
	/**
	 * 开始提醒客户时间
	 */
	private Date remindDate;  
	
	/**
	 * 已提醒次数
	 */
	private Long remindTimes;  
	
	/**
	 * 是否已开票	
	 */
	private String isinvoice;  
	
	/**
	 * 开票人
	 */
	private String invoiceUname;  
	
	/**
	 * 开具发票号码
	 */
	private String invoiceNo;  
	
	/**
	 * 开具日期
	 */
	private Date invoiceDate;  
	
	/**
	 * 领取日期
	 */
	private Date receiveDate;  
	
	
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
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
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
	 * 退款金额
	 */
	private Double refundAmount; 
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
	 * 备注
	 */
	private String memo; 
	
	private Date confirmDate;
	
	/**
	 * 线下活动审核状态 0:未审核；1：通过；2：未通过；
	 */
	private String offlineState;
	
	private String offlineMemo;
	
	private List<OrderDetail> orderDetail = Lists.newArrayList();
	
	private String notifyUrl;
	
	private String stateTxt;  
	private String settlementStatusTxt;
	private String commissionStatusTxt;
	
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
	
	private Date confirmQuotationDate;
	
	private String confirmQuotationUser;
	
	/**
	 * 
	 */
	private String iscommissionupdate;
	
	
	/**
	 * 原酒店销售
	 */
	private String originalHotelSale;
	/**
	 * 原公司销售
	 */
	private String originalCompanySale;
	
	@Column(length=50)
    public String getOrderNo(){  
      return orderNo;  
    }  
    public void setOrderNo(String orderNo){  
      this.orderNo = orderNo;  
    }  
  
    @Column(length=50)
    public String getOrderSource(){  
      return orderSource;  
    }  
    public void setOrderSource(String orderSource){  
      this.orderSource = orderSource;  
    }  
  
    @Column(length=50)
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
  
    @Column(length=50)
    public String getHotelName(){  
      return hotelName;  
    }  
    public void setHotelName(String hotelName){  
      this.hotelName = hotelName;  
    }  
  
    @Column(length=50)
    public String getOwnedGroup(){  
      return ownedGroup;  
    }  
    public void setOwnedGroup(String ownedGroup){  
      this.ownedGroup = ownedGroup;  
    }  
  
    @Column(length=50)
    public String getCommissionRights(){  
      return commissionRights;  
    }  
    public void setCommissionRights(String commissionRights){  
      this.commissionRights = commissionRights;  
    }  
  
    @Column(length=50)
    public String getHotelSaleId(){  
      return hotelSaleId;  
    }  
    public void setHotelSaleId(String hotelSaleId){  
      this.hotelSaleId = hotelSaleId;  
    }  
  
    @Column(length=50)
    public String getHotelSaleName(){  
      return hotelSaleName;  
    }  
    public void setHotelSaleName(String hotelSaleName){  
      this.hotelSaleName = hotelSaleName;  
    }  
  
    @Column(length=50)
    public String getHotelSaleMobile(){  
      return hotelSaleMobile;  
    }  
    public void setHotelSaleMobile(String hotelSaleMobile){  
      this.hotelSaleMobile = hotelSaleMobile;  
    }  
  
    @Column(length=50)
    public Double getHotelPoints(){  
      return hotelPoints;  
    }  
    public void setHotelPoints(Double hotelPoints){  
      this.hotelPoints = hotelPoints;  
    }  
  
    @Column(length=50)
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
    
    @Column(length=50)
    public String getClientId(){  
      return clientId;  
    }  
    public void setClientId(String clientId){  
      this.clientId = clientId;  
    }  
  
    @Column(length=50)
    public String getOrganizer(){  
      return organizer;  
    }  
    public void setOrganizer(String organizer){  
      this.organizer = organizer;  
    }  
  
    @Column(length=50)
    public String getLinkman(){  
      return linkman;  
    }  
    public void setLinkman(String linkman){  
      this.linkman = linkman;  
    }  
  
    @Column(length=50)
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
  
    @Column(length=50)
    public String getState(){  
      return state;  
    }  
    public void setState(String state){  
      this.state = state;  
    }  
  
    @Column(length=50)
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
    
    @Column(length=50)
    public String getSettlementUid(){  
      return settlementUid;  
    }  
    public void setSettlementUid(String settlementUid){  
      this.settlementUid = settlementUid;  
    }  
    
    @Column(length=50)
    public String getCommissionStatus(){  
      return commissionStatus;  
    }  
    public void setCommissionStatus(String commissionStatus){  
      this.commissionStatus = commissionStatus;  
    }  
  
    public Date getCommissionDate(){  
      return commissionDate;  
    }  
    public void setCommissionDate(Date commissionDate){  
      this.commissionDate = commissionDate;  
    }  
  
    public Double getCommissionRate(){  
      return commissionRate;  
    }  
    public void setCommissionRate(Double commissionRate){  
      this.commissionRate = commissionRate;  
    }  
  
    public Double getCommissionAmount(){  
      return commissionAmount;  
    }  
    public void setCommissionAmount(Double commissionAmount){  
      this.commissionAmount = commissionAmount;  
    }  
  
    public Date getSignDate(){  
      return signDate;  
    }  
    public void setSignDate(Date signDate){  
      this.signDate = signDate;  
    }  
  
    @Column(length=50)
    public String getSignUid(){  
      return signUid;  
    }  
    public void setSignUid(String signUid){  
      this.signUid = signUid;  
    }  
  
    @Column(length=50)
    public String getSignUname(){  
      return signUname;  
    }  
    public void setSignUname(String signUname){  
      this.signUname = signUname;  
    }  
  
    @Column(length=50)
    public String getIsupload(){  
      return isupload;  
    }  
    public void setIsupload(String isupload){  
      this.isupload = isupload;  
    }  
  
    public Date getRemindDate(){  
      return remindDate;  
    }  
    public void setRemindDate(Date remindDate){  
      this.remindDate = remindDate;  
    }  
  
    public Long getRemindTimes(){  
      return remindTimes;  
    }  
    public void setRemindTimes(Long remindTimes){  
      this.remindTimes = remindTimes;  
    }  
  
    @Column(length=50)
    public String getIsinvoice(){  
      return isinvoice;  
    }  
    public void setIsinvoice(String isinvoice){  
      this.isinvoice = isinvoice;  
    }  
  
    @Column(length=50)
    public String getInvoiceUname(){  
      return invoiceUname;  
    }  
    public void setInvoiceUname(String invoiceUname){  
      this.invoiceUname = invoiceUname;  
    }  
  
    @Column(length=50)
    public String getInvoiceNo(){  
      return invoiceNo;  
    }  
    public void setInvoiceNo(String invoiceNo){  
      this.invoiceNo = invoiceNo;  
    }  
  
    public Date getInvoiceDate(){  
      return invoiceDate;  
    }  
    public void setInvoiceDate(Date invoiceDate){  
      this.invoiceDate = invoiceDate;  
    }  
  
    public Date getReceiveDate(){  
      return receiveDate;  
    }  
    public void setReceiveDate(Date receiveDate){  
      this.receiveDate = receiveDate;  
    }  
  
    @Column(length=50)
    public String getCompanySaleId(){  
      return companySaleId;  
    }  
    public void setCompanySaleId(String companySaleId){  
      this.companySaleId = companySaleId;  
    }  
  
    @Column(length=50)
    public String getCompanySaleName(){  
      return companySaleName;  
    }  
    public void setCompanySaleName(String companySaleName){  
      this.companySaleName = companySaleName;  
    }  
    
    @Column(length=50)
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
    
    @Column(length=500)
    public String getMemo(){  
      return memo;  
    }  
    public void setMemo(String memo){  
      this.memo = memo;  
    }
    
    @Column(length=50)
	public String getCompanyFollowSaleId() {
		return companyFollowSaleId;
	}
	public void setCompanyFollowSaleId(String companyFollowSaleId) {
		this.companyFollowSaleId = companyFollowSaleId;
	}
	
	@Column(length=50)
	public String getCompanyFollowSaleName() {
		return companyFollowSaleName;
	}
	public void setCompanyFollowSaleName(String companyFollowSaleName) {
		this.companyFollowSaleName = companyFollowSaleName;
	}
	
	@Column(length=50)
	public String getActivityTitle() {
		return activityTitle;
	}
	public void setActivityTitle(String activityTitle) {
		this.activityTitle = activityTitle;
	}
	
	@Column(length=50)
	public String getOrderType() {
		return orderType;
	}
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	
	public Long getSourceAppId() {
		return sourceAppId;
	}
	public void setSourceAppId(Long sourceAppId) {
		this.sourceAppId = sourceAppId;
	}
	
	@Transient
	public List<OrderDetail> getOrderDetail() {
		return orderDetail;
	}
	public void setOrderDetail(List<OrderDetail> orderDetail) {
		this.orderDetail = orderDetail;
	}
	
	public Date getRefundDate() {
		return refundDate;
	}
	public void setRefundDate(Date refundDate) {
		this.refundDate = refundDate;
	}
	
	@Column(length=500)
	public String getRefundReason() {
		return refundReason;
	}
	public void setRefundReason(String refundReason) {
		this.refundReason = refundReason;
	}
	@Column(length=500)
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
	
	@Column(length=500)
	public String getCancelReason() {
		return cancelReason;
	}
	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}
	
	@Column(length=500)
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
	
	@Column(length=5)
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	
	public Date getCompanyFollowTime() {
		return companyFollowTime;
	}
	public void setCompanyFollowTime(Date companyFollowTime) {
		this.companyFollowTime = companyFollowTime;
	}
	@Column(length=200)
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
	
	public Order() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Order(String orderNo, String orderType, Long sourceAppId, String orderSource, String area, Long hotelId,
			String hotelName, String ownedGroup, String commissionRights, String hotelSaleId, String hotelSaleName,
			String hotelSaleMobile, Double hotelPoints, Double amount, Double zgamount, Double prepaid,
			Double finalPayment, Double siteAmount, Double siteCommissionFee, Double roomAmount, Double diningAmount,Double otherAmount,
			String clientId, String activityDate, String activityTitle, String organizer, String linkman,
			String contactNumber, String state, String commissionStatus, Date createDate, String memo) {
		super();
		this.orderNo = orderNo;
		this.orderType = orderType;
		this.sourceAppId = sourceAppId;
		this.orderSource = orderSource;
		this.area = area;
		this.hotelId = hotelId;
		this.hotelName = hotelName;
		this.ownedGroup = ownedGroup;
		this.commissionRights = commissionRights;
		this.hotelSaleId = hotelSaleId;
		this.hotelSaleName = hotelSaleName;
		this.hotelSaleMobile = hotelSaleMobile;
		this.hotelPoints = hotelPoints;
		this.amount = amount;
		this.zgamount = zgamount;
		this.prepaid = prepaid;
		this.finalPayment = finalPayment;
		this.siteAmount = siteAmount;
		this.siteCommissionFee = siteCommissionFee;
		this.roomAmount = roomAmount;
		this.diningAmount = diningAmount;
		this.clientId = clientId;
		this.activityDate = activityDate;
		this.activityTitle = activityTitle;
		this.organizer = organizer;
		this.linkman = linkman;
		this.contactNumber = contactNumber;
		this.state = state;
		this.commissionStatus = commissionStatus;
		this.createDate = createDate;
		this.memo = memo;
		this.otherAmount = otherAmount;
	}
	
	@Transient
	public String getStateTxt() {
		return stateTxt;
	}
	public void setStateTxt(String stateTxt) {
		this.stateTxt = stateTxt;
	}
	@Transient
	public String getSettlementStatusTxt() {
		return settlementStatusTxt;
	}
	public void setSettlementStatusTxt(String settlementStatusTxt) {
		this.settlementStatusTxt = settlementStatusTxt;
	}
	@Transient
	public String getCommissionStatusTxt() {
		return commissionStatusTxt;
	}
	public void setCommissionStatusTxt(String commissionStatusTxt) {
		this.commissionStatusTxt = commissionStatusTxt;
	}
	
	@Column(length=5)
	public String getOfflineState() {
		return offlineState;
	}
	public void setOfflineState(String offlineState) {
		this.offlineState = offlineState;
	}
	
	@Column(length=500)
	public String getOfflineMemo() {
		return offlineMemo;
	}
	public void setOfflineMemo(String offlineMemo) {
		this.offlineMemo = offlineMemo;
	}
	
	public Date getConfirmDate() {
		return confirmDate;
	}
	public void setConfirmDate(Date confirmDate) {
		this.confirmDate = confirmDate;
	}
	
	public String getNotifyUrl() {
		return notifyUrl;
	}
	public void setNotifyUrl(String notifyUrl) {
		this.notifyUrl = notifyUrl;
	}
	
	public Double getOtherAmount() {
		return otherAmount;
	}
	public void setOtherAmount(Double otherAmount) {
		this.otherAmount = otherAmount;
	}
	
	@Column(length=50)
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Double getRefundAmount() {
		return refundAmount;
	}
	public void setRefundAmount(Double refundAmount) {
		this.refundAmount = refundAmount;
	}
	
	@Column(columnDefinition="DECIMAL(18,2)")
	public Double getSettlementAmount() {
		return settlementAmount;
	}
	public void setSettlementAmount(Double settlementAmount) {
		this.settlementAmount = settlementAmount;
	}
	
	@Column(columnDefinition="text")
	public String getMeetingRemark() {
		return meetingRemark;
	}
	public void setMeetingRemark(String meetingRemark) {
		this.meetingRemark = meetingRemark;
	}
	
	@Column(columnDefinition="text")
	public String getHouseRemark() {
		return houseRemark;
	}
	public void setHouseRemark(String houseRemark) {
		this.houseRemark = houseRemark;
	}
	
	@Column(columnDefinition="text")
	public String getDinnerRemark() {
		return dinnerRemark;
	}
	public void setDinnerRemark(String dinnerRemark) {
		this.dinnerRemark = dinnerRemark;
	}
	public Date getConfirmQuotationDate() {
		return confirmQuotationDate;
	}
	public void setConfirmQuotationDate(Date confirmQuotationDate) {
		this.confirmQuotationDate = confirmQuotationDate;
	}
	
	@Column(length=50)
	public String getConfirmQuotationUser() {
		return confirmQuotationUser;
	}
	public void setConfirmQuotationUser(String confirmQuotationUser) {
		this.confirmQuotationUser = confirmQuotationUser;
	}
	
	@Column(length=5)
	public String getIscommissionupdate() {
		return iscommissionupdate;
	}
	public void setIscommissionupdate(String iscommissionupdate) {
		this.iscommissionupdate = iscommissionupdate;
	}
	public Double getSiteCommissionFeeRate() {
		return siteCommissionFeeRate;
	}
	public void setSiteCommissionFeeRate(Double siteCommissionFeeRate) {
		this.siteCommissionFeeRate = siteCommissionFeeRate;
	}
	public Double getMealServiceFee() {
		return mealServiceFee;
	}
	public void setMealServiceFee(Double mealServiceFee) {
		this.mealServiceFee = mealServiceFee;
	}
	public Double getMealServiceFeeRate() {
		return mealServiceFeeRate;
	}
	public void setMealServiceFeeRate(Double mealServiceFeeRate) {
		this.mealServiceFeeRate = mealServiceFeeRate;
	}
	
	public String getOriginalHotelSale() {
		return originalHotelSale;
	}
	public void setOriginalHotelSale(String originalHotelSale) {
		this.originalHotelSale = originalHotelSale;
	}
	
	public String getOriginalCompanySale() {
		return originalCompanySale;
	}
	public void setOriginalCompanySale(String originalCompanySale) {
		this.originalCompanySale = originalCompanySale;
	}
}


