package com.chuangbang.base.entity.hotel;

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
 * 线下活动Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_offlineParty")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OfflineParty extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 酒店编号
	 */
	private Long hotelId;  
	
	/**
	 * 酒店名称
	 */
	private String hotelName;  
	
	/**
	 * 活动场地
	 */
	private String partyPlace;  
	
	/**
	 * 客房标双
	 */
	private Integer standardTRoomNum;  
	
	/**
	 * 客房豪双
	 */
	private Integer deluxeTRoomNum;  
	
	/**
	 * 餐饮
	 */
	private String restaurant;  
	
	/**
	 * 餐饮人数
	 */
	private Integer restaurantNum;  
	
	/**
	 * 酒店销售人员编号
	 */
	private String hotelSaleId;  
	
	/**
	 * 酒店销售人员姓名
	 */
	private String hotelSaleName;  
	
	/**
	 * 公司销售人员编号
	 */
	private String companySaleId;  
	
	/**
	 * 公司销售人员姓名
	 */
	private String companySaleName;  
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo;  
	
  
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
    public String getPartyPlace(){  
      return partyPlace;  
    }  
    
    public void setPartyPlace(String partyPlace){  
      this.partyPlace = partyPlace;  
    }  
  
    public Integer getStandardTRoomNum(){  
      return standardTRoomNum;  
    }  
    
    public void setStandardTRoomNum(Integer standardTRoomNum){  
      this.standardTRoomNum = standardTRoomNum;  
    }  
  
    public Integer getDeluxeTRoomNum(){  
      return deluxeTRoomNum;  
    }  
    
    public void setDeluxeTRoomNum(Integer deluxeTRoomNum){  
      this.deluxeTRoomNum = deluxeTRoomNum;  
    }  
    @Column(length=50)
    public String getRestaurant(){  
      return restaurant;  
    }  
    
    public void setRestaurant(String restaurant){  
      this.restaurant = restaurant;  
    }  
  
    public Integer getRestaurantNum(){  
      return restaurantNum;  
    }  
    
    public void setRestaurantNum(Integer restaurantNum){  
      this.restaurantNum = restaurantNum;  
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


