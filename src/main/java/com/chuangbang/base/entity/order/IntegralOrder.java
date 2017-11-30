package com.chuangbang.base.entity.order;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

@Entity
@Table(name = "hui_integral_order")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class IntegralOrder extends IdEntity implements Serializable{
	/**
	 * 
	 */
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
	 * 兑换积分
	 */
	private Double points;  
	
	/**
	 * 掌柜价格
	 */
	private Double zgamount;
	/**
	 * 酒店价格
	 */
	private Double jdamount;
	
	/**
	 * 客户编号
	 */
	private String clientId;  
	
	/**
	 * 客户姓名
	 */
	private String clientName; 
	
	/**
	 * 客户电话
	 */
	private String clientMobile; 
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 状态 01：待消费；02：已消费；...
	 */
	private String state; 
	
	/**
	 *  对账状态
	 *  0	未对账；1  酒店已对账；2 会掌柜已对账
	 */
	private String settlementStatus;
	/**
	 * 结算对账时间
	 */
	private Date settlementDate;  
	/**
	 * 结算对账人员
	 */
	private String settlementUid;  
	
	/**
	 * 结算对账时间
	 */
	private Date hotelSettlementDate;  
	/**
	 * 结算对账人员
	 */
	private String hotelSettlementUid;  
	
	private Date consumptionDate;
	
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

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

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

	public String getOrderSource() {
		return orderSource;
	}

	public void setOrderSource(String orderSource) {
		this.orderSource = orderSource;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public Long getHotelId() {
		return hotelId;
	}

	public void setHotelId(Long hotelId) {
		this.hotelId = hotelId;
	}

	public String getHotelName() {
		return hotelName;
	}

	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

	public Double getPoints() {
		return points;
	}

	public void setPoints(Double points) {
		this.points = points;
	}

	public Double getZgamount() {
		return zgamount;
	}

	public void setZgamount(Double zgamount) {
		this.zgamount = zgamount;
	}

	public Double getJdamount() {
		return jdamount;
	}

	public void setJdamount(Double jdamount) {
		this.jdamount = jdamount;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getClientMobile() {
		return clientMobile;
	}

	public void setClientMobile(String clientMobile) {
		this.clientMobile = clientMobile;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getSettlementStatus() {
		return settlementStatus;
	}

	public void setSettlementStatus(String settlementStatus) {
		this.settlementStatus = settlementStatus;
	}

	public Date getSettlementDate() {
		return settlementDate;
	}

	public void setSettlementDate(Date settlementDate) {
		this.settlementDate = settlementDate;
	}

	public String getSettlementUid() {
		return settlementUid;
	}

	public void setSettlementUid(String settlementUid) {
		this.settlementUid = settlementUid;
	}

	public Date getConsumptionDate() {
		return consumptionDate;
	}

	public void setConsumptionDate(Date consumptionDate) {
		this.consumptionDate = consumptionDate;
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

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	public Date getHotelSettlementDate() {
		return hotelSettlementDate;
	}

	public void setHotelSettlementDate(Date hotelSettlementDate) {
		this.hotelSettlementDate = hotelSettlementDate;
	}

	public String getHotelSettlementUid() {
		return hotelSettlementUid;
	}

	public void setHotelSettlementUid(String hotelSettlementUid) {
		this.hotelSettlementUid = hotelSettlementUid;
	}

	public IntegralOrder(String orderNo, String orderType, Long sourceAppId, String orderSource, String area,
			Long hotelId, String hotelName, Double points, Double zgamount, Double jdamount, String clientId,
			String clientName, String clientMobile, Date createDate, String state) {
		super();
		this.orderNo = orderNo;
		this.orderType = orderType;
		this.sourceAppId = sourceAppId;
		this.orderSource = orderSource;
		this.area = area;
		this.hotelId = hotelId;
		this.hotelName = hotelName;
		this.points = points;
		this.zgamount = zgamount;
		this.jdamount = jdamount;
		this.clientId = clientId;
		this.clientName = clientName;
		this.clientMobile = clientMobile;
		this.createDate = createDate;
		this.state = state;
	}

	public IntegralOrder() {
		super();
	} 
	
}
