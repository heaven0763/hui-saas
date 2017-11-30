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
 * 场地价格Entity
 * @author mabelxiao
 * @version 2016-11-16
 */
@Entity
@Table(name = "hui_placePrice")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class PlacePrice extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 所属酒店编号
	 */
	private Long hotelId;  
	
	/**
	 * 酒店名称
	 */
	private String hotelName;  
	
	/**
	 * 场地类型
	 */
	private String placeType;  
	
	/**
	 * 场地编号
	 */
	private Long placeId;  
	
	/**
	 * 场地名称
	 */
	private String placeName;  
	
	/**
	 * 场地档期
	 */
	private String placeSchedule;  
	
	/**
	 * 线上价格
	 */
	private Double onlinePrice;  
	
	/**
	 * 线下价格
	 */
	private Double offlinePrice;  
	
	/**
	 * 调整日期
	 */
	private Date updateDate;  
	
	/**
	 * 调整前线上价格
	 */
	private Double beforeOnlinePrice;  
	
	/**
	 * 调整前线下价格
	 */
	private Double beforeOfflinePrice;  
	
	/**
	 * 价格修改人员编号
	 */
	private String updateUserId;  
	
	/**
	 * 价格修改人员姓名
	 */
	private String updateUserName;  
	
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
    public String getPlaceType(){  
      return placeType;  
    }  
    public void setPlaceType(String placeType){  
      this.placeType = placeType;  
    }  
  
    public Long getPlaceId(){  
      return placeId;  
    }  
    public void setPlaceId(Long placeId){  
      this.placeId = placeId;  
    }  
  
    @Column(length=50)
    public String getPlaceName(){  
      return placeName;  
    }  
    
    public void setPlaceName(String placeName){  
      this.placeName = placeName;  
    }  
    @Column(length=50)
    public String getPlaceSchedule(){  
      return placeSchedule;  
    }  
    
    public void setPlaceSchedule(String placeSchedule){  
      this.placeSchedule = placeSchedule;  
    }  
  
    public Double getOnlinePrice(){  
      return onlinePrice;  
    }  
    
    public void setOnlinePrice(Double onlinePrice){  
      this.onlinePrice = onlinePrice;  
    }  
  
    public Double getOfflinePrice(){  
      return offlinePrice;  
    }  
    
    public void setOfflinePrice(Double offlinePrice){  
      this.offlinePrice = offlinePrice;  
    }  
  
    public Date getUpdateDate(){  
      return updateDate;  
    }  
    
    public void setUpdateDate(Date updateDate){  
      this.updateDate = updateDate;  
    }  
  
    public Double getBeforeOnlinePrice(){  
      return beforeOnlinePrice;  
    }  
    
    public void setBeforeOnlinePrice(Double beforeOnlinePrice){  
      this.beforeOnlinePrice = beforeOnlinePrice;  
    }  
  
    public Double getBeforeOfflinePrice(){  
      return beforeOfflinePrice;  
    }  
    
    public void setBeforeOfflinePrice(Double beforeOfflinePrice){  
      this.beforeOfflinePrice = beforeOfflinePrice;  
    }  
    @Column(length=50)
    public String getUpdateUserId(){  
      return updateUserId;  
    }  
    
    public void setUpdateUserId(String updateUserId){  
      this.updateUserId = updateUserId;  
    }  
    @Column(length=50)
    public String getUpdateUserName(){  
      return updateUserName;  
    }  
    public void setUpdateUserName(String updateUserName){  
      this.updateUserName = updateUserName;  
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

	public PlacePrice() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PlacePrice(Long hotelId, String hotelName, String placeType, Long placeId, String placeName,
			String placeSchedule, Double onlinePrice, Double offlinePrice, String createUserId, String createUserName,
			Date createDate, String memo) {
		super();
		this.hotelId = hotelId;
		this.hotelName = hotelName;
		this.placeType = placeType;
		this.placeId = placeId;
		this.placeName = placeName;
		this.placeSchedule = placeSchedule;
		this.onlinePrice = onlinePrice;
		this.offlinePrice = offlinePrice;
		this.createUserId = createUserId;
		this.createUserName = createUserName;
		this.createDate = createDate;
		this.memo = memo;
	}  
    
    
}


