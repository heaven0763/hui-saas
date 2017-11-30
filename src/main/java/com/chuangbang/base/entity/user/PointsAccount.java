package com.chuangbang.base.entity.user;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 积分账户Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_pointsAccount")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class PointsAccount extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 客户类型
	 */
	private String clientType;  
	
	/**
	 * 客户编号
	 */
	private String clientId;  
	
	/**
	 * 客户名称
	 */
	private String clientName;  
	
	/**
	 * 所属区域
	 */
	private String clientArea;  
	
	/**
	 * 累计消费金额
	 */
	private Double totalAmount;  
	
	/**
	 * 累计积分
	 */
	private Double totalPoints;  
	
	/**
	 * 已兑现积分
	 */
	private Double cashPoints;  
	
	/**
	 * 结余积分
	 */
	private Double balancePoints;  
	
	/**
	 * 积分计算标准
	 */
	private String pointStandard;  
	
	/**
	 * 积分计算比例
	 */
	private Double pointsRate;  
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo;  
	
	@Column(length=50)
    public String getClientType(){  
      return clientType;  
    }  
    public void setClientType(String clientType){  
      this.clientType = clientType;  
    }  
  
    @Column(length=50)
    public String getClientId(){  
      return clientId;  
    }  
    public void setClientId(String clientId){  
      this.clientId = clientId;  
    }  
  
    @Column(length=50)
    public String getClientName(){  
      return clientName;  
    }  
    public void setClientName(String clientName){  
      this.clientName = clientName;  
    }  
  
    @Column(length=50)
    public String getClientArea(){  
      return clientArea;  
    }  
    public void setClientArea(String clientArea){  
      this.clientArea = clientArea;  
    }  
  
    public Double getTotalAmount(){  
      return totalAmount;  
    }  
    public void setTotalAmount(Double totalAmount){  
      this.totalAmount = totalAmount;  
    }  
  
    public Double getTotalPoints(){  
      return totalPoints;  
    }  
    public void setTotalPoints(Double totalPoints){  
      this.totalPoints = totalPoints;  
    }  
  
    public Double getCashPoints(){  
      return cashPoints;  
    }  
    public void setCashPoints(Double cashPoints){  
      this.cashPoints = cashPoints;  
    }  
  
    public Double getBalancePoints(){  
      return balancePoints;  
    }  
    public void setBalancePoints(Double balancePoints){  
      this.balancePoints = balancePoints;  
    }  
  
    @Column(length=50)
    public String getPointStandard(){  
      return pointStandard;  
    }  
    public void setPointStandard(String pointStandard){  
      this.pointStandard = pointStandard;  
    }  
  
    @Column(length=50)
    public Double getPointsRate(){  
      return pointsRate;  
    }  
    public void setPointsRate(Double pointsRate){  
      this.pointsRate = pointsRate;  
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
	public PointsAccount(String clientType, String clientId, String clientName, String clientArea, Double totalAmount,
			Double totalPoints, Double cashPoints, Double balancePoints, String pointStandard, Double pointsRate,
			Date createDate, String memo) {
		super();
		this.clientType = clientType;
		this.clientId = clientId;
		this.clientName = clientName;
		this.clientArea = clientArea;
		this.totalAmount = totalAmount;
		this.totalPoints = totalPoints;
		this.cashPoints = cashPoints;
		this.balancePoints = balancePoints;
		this.pointStandard = pointStandard;
		this.pointsRate = pointsRate;
		this.createDate = createDate;
		this.memo = memo;
	}
	public PointsAccount() {
		super();
	}  
    
}


