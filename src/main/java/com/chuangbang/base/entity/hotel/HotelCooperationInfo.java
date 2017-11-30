package com.chuangbang.base.entity.hotel;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 场地合作信息Entity
 * @author mabelxiao
 * @version 2016-11-16
 */
@Entity
@Table(name = "hui_hotelCooperationInfo")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HotelCooperationInfo extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 酒店类型
	 */
	private String hoteType;
	
	/**
	 * 所属酒店编号
	 */
	private Long hotelId;  
	
	/**
	 * 酒店名称
	 */
	private String hotelName;  
	
	/**
	 * 返佣权限归属
	 */
	private String commissionRights;  
	
	/**
	 * 酒店开拓人员编号
	 */
	private String reclaimUserId;  
	
	/**
	 * 酒店开拓人员姓名
	 */
	private String reclaimUserName;  
	
	/**
	 * 酒店开拓人员姓名
	 */
	private String reclaimUserMobile;  
	
	/**
	 * 联系人
	 */
	private String linkman;  
	
	/**
	 * 联系固话
	 */
	private String linkPhone;  
	
	/**
	 * 联系手机
	 */
	private String linkMobile;  
	
	/**
	 * 协议有效日期
	 */
	private String agreementSDate;  
	
	/**
	 * 协议有效日期
	 */
	private String agreementEDate;  
	
	/**
	 * 返佣归属
	 */
	private String commissionBelong;  
	
	/**
	 * 返佣类型   1：全单返；2：分项返；
	 */
	private String commissionType;
	
	/**
	 * 全单返佣
	 */
	private Double allCommission;
	
	/**
	 * 住房返佣
	 */
	private Double housingCommission;  
	
	/**
	 * 餐饮返佣
	 */
	private Double dinnerCommission;  
	
	/**
	 * 会议室返佣
	 */
	private Double mettingRoomCommission;  
	
	/**
	 * 其他返佣
	 */
	private Double ortherCommission;  
	
	/**
	 * 录入人员编号
	 */
	private String createUserId;  
	
	/**
	 * 录入人员
	 */
	private String createUserName;  
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo; 
	
	/**
	 * 积分计算比例
	 */
	private Double pointsRate;
	/**
	 * 是否计算积分 1:是；0：否；
	 */
	private String isPoints;
	/**
	 * 酒店性质
	 */
	private String hotelNature;
	
	private String area;
	
	
	@Column(length=50)
    public String getHoteType(){  
      return hoteType;  
    }  
    
    public void setHoteType(String hoteType){  
      this.hoteType = hoteType;  
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
    public String getCommissionRights(){  
      return commissionRights;  
    }  
    
    public void setCommissionRights(String commissionRights){  
      this.commissionRights = commissionRights;  
    }  
    @Column(length=50)
    public String getReclaimUserId(){  
      return reclaimUserId;  
    }  
    
    public void setReclaimUserId(String reclaimUserId){  
      this.reclaimUserId = reclaimUserId;  
    }  
    @Column(length=50)
    public String getReclaimUserName(){  
      return reclaimUserName;  
    }  
    
    public void setReclaimUserName(String reclaimUserName){  
      this.reclaimUserName = reclaimUserName;  
    }  
    @Column(length=50)
    public String getLinkman(){  
      return linkman;  
    }  
    
    public void setLinkman(String linkman){  
      this.linkman = linkman;  
    }  
    @Column(length=50)
    public String getLinkPhone(){  
      return linkPhone;  
    }  
    
    public void setLinkPhone(String linkPhone){  
      this.linkPhone = linkPhone;  
    }  
    @Column(length=50)
    public String getLinkMobile(){  
      return linkMobile;  
    }  
    
    public void setLinkMobile(String linkMobile){  
      this.linkMobile = linkMobile;  
    }  
    @Column(length=50)
    public String getAgreementSDate(){  
      return agreementSDate;  
    }  
    
    public void setAgreementSDate(String agreementSDate){  
      this.agreementSDate = agreementSDate;  
    }  
    @Column(length=50)
    public String getAgreementEDate() {
		return agreementEDate;
	}

	public void setAgreementEDate(String agreementEDate) {
		this.agreementEDate = agreementEDate;
	}

	@Column(length=50)
    public String getCommissionBelong(){  
      return commissionBelong;  
    }  
    
    public void setCommissionBelong(String commissionBelong){  
      this.commissionBelong = commissionBelong;  
    }  
  
    public Double getHousingCommission(){  
      return housingCommission;  
    }  
    
    public void setHousingCommission(Double housingCommission){  
      this.housingCommission = housingCommission;  
    }  
  
    public Double getDinnerCommission(){  
      return dinnerCommission;  
    }  
    
    public void setDinnerCommission(Double dinnerCommission){  
      this.dinnerCommission = dinnerCommission;  
    }  
  
    public Double getMettingRoomCommission(){  
      return mettingRoomCommission;  
    }  
    
    public void setMettingRoomCommission(Double mettingRoomCommission){  
      this.mettingRoomCommission = mettingRoomCommission;  
    }  
  
    public Double getOrtherCommission(){  
      return ortherCommission;  
    }  
    
    public void setOrtherCommission(Double ortherCommission){  
      this.ortherCommission = ortherCommission;  
    }  
    @Column(length=50)
    public String getCreateUserId(){  
      return createUserId;  
    }  
    
    public void setCreateUserId(String createUserId){  
      this.createUserId = createUserId;  
    }  
    @Column(length=50)
    public String getCreateUserName(){  
      return createUserName;  
    }  
    
    public void setCreateUserName(String createUserName){  
      this.createUserName = createUserName;  
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
    
    @Column(length=5)
	public String getCommissionType() {
		return commissionType;
	}
	public void setCommissionType(String commissionType) {
		this.commissionType = commissionType;
	}

	public Double getAllCommission() {
		return allCommission;
	}
	public void setAllCommission(Double allCommission) {
		this.allCommission = allCommission;
	}

	public Double getPointsRate() {
		return pointsRate;
	}
	public void setPointsRate(Double pointsRate) {
		this.pointsRate = pointsRate;
	}

	public String getIsPoints() {
		return isPoints;
	}
	public void setIsPoints(String isPoints) {
		this.isPoints = isPoints;
	}
	
	@Column(length=50)
	public String getHotelNature() {
		return hotelNature;
	}
	public void setHotelNature(String hotelNature) {
		this.hotelNature = hotelNature;
	}
	
	@Column(length=50)
	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	@Transient
	public String getReclaimUserMobile() {
		return reclaimUserMobile;
	}
	public void setReclaimUserMobile(String reclaimUserMobile) {
		this.reclaimUserMobile = reclaimUserMobile;
	}  
	
	
}


