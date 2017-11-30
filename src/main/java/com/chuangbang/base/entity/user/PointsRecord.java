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
 * 积分记录Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_pointsRecord")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class PointsRecord extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 订单流水号
	 */
	private String orderNo;  
	
	/**
	 * 客户类型
	 */
	private String clientType;  
	
	/**
	 * 客户编号
	 */
	private String clientId;  
	
	/**
	 * 所属区域
	 */
	private String clientArea;  
	
	/**
	 * 消费金额
	 */
	private Double amount;  
	
	/**
	 * 获得积分
	 */
	private Double points;  
	
	/**
	 * 获得日期
	 */
	private Date pointsDate;  
	
	/**
	 * 动作类型
	 */
	private String actionType;  
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo;  
	
  
	@Column(length=50)
    public String getOrderNo(){  
      return orderNo;  
    }  
    public void setOrderNo(String orderNo){  
      this.orderNo = orderNo;  
    }  
  
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
    public String getClientArea(){  
      return clientArea;  
    }  
    public void setClientArea(String clientArea){  
      this.clientArea = clientArea;  
    }  
  
    public Double getAmount(){  
      return amount;  
    }  
    public void setAmount(Double amount){  
      this.amount = amount;  
    }  
  
    public Double getPoints(){  
      return points;  
    }  
    public void setPoints(Double points){  
      this.points = points;  
    }  
  
    public Date getPointsDate(){  
      return pointsDate;  
    }  
    public void setPointsDate(Date pointsDate){  
      this.pointsDate = pointsDate;  
    }  
  
    @Column(length=50)
    public String getActionType(){  
      return actionType;  
    }  
    public void setActionType(String actionType){  
      this.actionType = actionType;  
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
}


