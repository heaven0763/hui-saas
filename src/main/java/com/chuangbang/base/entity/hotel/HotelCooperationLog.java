package com.chuangbang.base.entity.hotel;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 场地返佣比例修改记录Entity
 * @author heaven
 * @version 2017-03-14
 */
@Entity
@Table(name = "hui_HotelCooperationLog")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HotelCooperationLog extends IdEntity {

	/**
	 * 所属酒店
	 */
	private Long hotelId;  
	
	/**
	 * 订单编号
	 */
	private Long cpId;  
	
	/**
	 * 返佣类型
	 */
	private String type;  
	
	/**
	 * 积分计算类型
	 */
	private String pointsRateType;  
	
	/**
	 * 原住房返佣比例
	 */
	private Double bfhousingCommissionRate;  
	
	/**
	 * 原餐饮返佣比例
	 */
	private Double bfdinnerCommissionRate;  
	
	/**
	 * 原会议室返佣比例
	 */
	private Double bfmettingRoomCommissionRate;  
	
	/**
	 * 原其他返佣比例
	 */
	private Double bfortherCommissionRate;  
	
	/**
	 * 原全单返佣比例
	 */
	private Double bfallCommissionRate;  
	
	/**
	 * 原积分计算比例
	 */
	private Double bfpointsRate;  
	
	/**
	 * 修改后住房返佣比例
	 */
	private Double afhousingCommissionRate;  
	
	/**
	 * 修改后餐饮返佣比例
	 */
	private Double afdinnerCommissionRate;  
	
	/**
	 * 修改后会议室返佣比例
	 */
	private Double afmettingRoomCommissionRate;  
	
	/**
	 * 修改后其他返佣比例
	 */
	private Double afortherCommissionRate;  
	
	/**
	 * 修改后全单返佣比例
	 */
	private Double afallCommissionRate;  
	
	/**
	 * 修改后积分计算比例
	 */
	private Double afpointsRate;  
	
	/**
	 * 状态
	 */
	private String state;  
	
	/**
	 * 审核日期
	 */
	private Date checkDate;  
	
	/**
	 * 审核备注
	 */
	private String checkMemo;  
	
	/**
	 * 创建日期
	 */
	private String checkUserId;  
	
	/**
	 * 创建日期
	 */
	private String checkUserName;  
	
	/**
	 * 审核备注
	 */
	private String applyReason;  
	
	/**
	 * 创建日期
	 */
	private Date applyDate;  
	
	/**
	 * 创建日期
	 */
	private String applyUserId;  
	
	/**
	 * 创建日期
	 */
	private String applyUserName;  
	
	/**
	 * 备注
	 */
	private String memo;  
	
	private String hotelName;
	private String star;
	
  
    public Long getHotelId(){  
      return hotelId;  
    }  
    
    public void setHotelId(Long hotelId){  
      this.hotelId = hotelId;  
    }  
  
    public Long getCpId(){  
      return cpId;  
    }  
    
    public void setCpId(Long cpId){  
      this.cpId = cpId;  
    }  
  
    public String getType(){  
      return type;  
    }  
    
    public void setType(String type){  
      this.type = type;  
    }  
  
    public String getPointsRateType(){  
      return pointsRateType;  
    }  
    
    public void setPointsRateType(String pointsRateType){  
      this.pointsRateType = pointsRateType;  
    }  
  
    public Double getBfhousingCommissionRate(){  
      return bfhousingCommissionRate;  
    }  
    
    public void setBfhousingCommissionRate(Double bfhousingCommissionRate){  
      this.bfhousingCommissionRate = bfhousingCommissionRate;  
    }  
  
    public Double getBfdinnerCommissionRate(){  
      return bfdinnerCommissionRate;  
    }  
    
    public void setBfdinnerCommissionRate(Double bfdinnerCommissionRate){  
      this.bfdinnerCommissionRate = bfdinnerCommissionRate;  
    }  
  
    public Double getBfmettingRoomCommissionRate(){  
      return bfmettingRoomCommissionRate;  
    }  
    
    public void setBfmettingRoomCommissionRate(Double bfmettingRoomCommissionRate){  
      this.bfmettingRoomCommissionRate = bfmettingRoomCommissionRate;  
    }  
  
    public Double getBfortherCommissionRate(){  
      return bfortherCommissionRate;  
    }  
    
    public void setBfortherCommissionRate(Double bfortherCommissionRate){  
      this.bfortherCommissionRate = bfortherCommissionRate;  
    }  
  
    public Double getBfallCommissionRate(){  
      return bfallCommissionRate;  
    }  
    
    public void setBfallCommissionRate(Double bfallCommissionRate){  
      this.bfallCommissionRate = bfallCommissionRate;  
    }  
  
    public Double getBfpointsRate(){  
      return bfpointsRate;  
    }  
    
    public void setBfpointsRate(Double bfpointsRate){  
      this.bfpointsRate = bfpointsRate;  
    }  
  
    public Double getAfhousingCommissionRate(){  
      return afhousingCommissionRate;  
    }  
    
    public void setAfhousingCommissionRate(Double afhousingCommissionRate){  
      this.afhousingCommissionRate = afhousingCommissionRate;  
    }  
  
    public Double getAfdinnerCommissionRate(){  
      return afdinnerCommissionRate;  
    }  
    
    public void setAfdinnerCommissionRate(Double afdinnerCommissionRate){  
      this.afdinnerCommissionRate = afdinnerCommissionRate;  
    }  
  
    public Double getAfmettingRoomCommissionRate(){  
      return afmettingRoomCommissionRate;  
    }  
    
    public void setAfmettingRoomCommissionRate(Double afmettingRoomCommissionRate){  
      this.afmettingRoomCommissionRate = afmettingRoomCommissionRate;  
    }  
  
    public Double getAfortherCommissionRate(){  
      return afortherCommissionRate;  
    }  
    
    public void setAfortherCommissionRate(Double afortherCommissionRate){  
      this.afortherCommissionRate = afortherCommissionRate;  
    }  
  
    public Double getAfallCommissionRate(){  
      return afallCommissionRate;  
    }  
    
    public void setAfallCommissionRate(Double afallCommissionRate){  
      this.afallCommissionRate = afallCommissionRate;  
    }  
  
    public Double getAfpointsRate(){  
      return afpointsRate;  
    }  
    
    public void setAfpointsRate(Double afpointsRate){  
      this.afpointsRate = afpointsRate;  
    }  
  
    public String getState(){  
      return state;  
    }  
    
    public void setState(String state){  
      this.state = state;  
    }  
  
    public Date getCheckDate(){  
      return checkDate;  
    }  
    
    public void setCheckDate(Date checkDate){  
      this.checkDate = checkDate;  
    }  
  
    public String getCheckMemo(){  
      return checkMemo;  
    }  
    
    public void setCheckMemo(String checkMemo){  
      this.checkMemo = checkMemo;  
    }  
  
    public String getCheckUserId(){  
      return checkUserId;  
    }  
    
    public void setCheckUserId(String checkUserId){  
      this.checkUserId = checkUserId;  
    }  
  
    public String getCheckUserName(){  
      return checkUserName;  
    }  
    
    public void setCheckUserName(String checkUserName){  
      this.checkUserName = checkUserName;  
    }  
  
    public String getApplyReason(){  
      return applyReason;  
    }  
    
    public void setApplyReason(String applyReason){  
      this.applyReason = applyReason;  
    }  
  
    public Date getApplyDate(){  
      return applyDate;  
    }  
    
    public void setApplyDate(Date applyDate){  
      this.applyDate = applyDate;  
    }  
  
    public String getApplyUserId(){  
      return applyUserId;  
    }  
    
    public void setApplyUserId(String applyUserId){  
      this.applyUserId = applyUserId;  
    }  
  
    public String getApplyUserName(){  
      return applyUserName;  
    }  
    
    public void setApplyUserName(String applyUserName){  
      this.applyUserName = applyUserName;  
    }  
  
    public String getMemo(){  
      return memo;  
    }  
    
    public void setMemo(String memo){  
      this.memo = memo;  
    }

	public HotelCooperationLog() {
		super();
		// TODO Auto-generated constructor stub
	}

	public HotelCooperationLog(Long hotelId, Long cpId, String type, String pointsRateType,
			Double bfhousingCommissionRate, Double bfdinnerCommissionRate, Double bfmettingRoomCommissionRate,
			Double bfortherCommissionRate, Double bfallCommissionRate, Double bfpointsRate,
			Double afhousingCommissionRate, Double afdinnerCommissionRate, Double afmettingRoomCommissionRate,
			Double afortherCommissionRate, Double afallCommissionRate, Double afpointsRate, String state,
			String applyReason, Date applyDate, String applyUserId, String applyUserName, String memo) {
		super();
		this.hotelId = hotelId;
		this.cpId = cpId;
		this.type = type;
		this.pointsRateType = pointsRateType;
		this.bfhousingCommissionRate = bfhousingCommissionRate;
		this.bfdinnerCommissionRate = bfdinnerCommissionRate;
		this.bfmettingRoomCommissionRate = bfmettingRoomCommissionRate;
		this.bfortherCommissionRate = bfortherCommissionRate;
		this.bfallCommissionRate = bfallCommissionRate;
		this.bfpointsRate = bfpointsRate;
		this.afhousingCommissionRate = afhousingCommissionRate;
		this.afdinnerCommissionRate = afdinnerCommissionRate;
		this.afmettingRoomCommissionRate = afmettingRoomCommissionRate;
		this.afortherCommissionRate = afortherCommissionRate;
		this.afallCommissionRate = afallCommissionRate;
		this.afpointsRate = afpointsRate;
		this.state = state;
		this.applyReason = applyReason;
		this.applyDate = applyDate;
		this.applyUserId = applyUserId;
		this.applyUserName = applyUserName;
		this.memo = memo;
	}

	@Transient
	public String getStar() {
		return star;
	}
	public void setStar(String star) {
		this.star = star;
	}

	@Transient
	public String getHotelName() {
		return hotelName;
	}
	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

}


