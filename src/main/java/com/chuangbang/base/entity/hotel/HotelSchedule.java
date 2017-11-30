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
 * 场地档期Entity
 * @author mabelxiao
 * @version 2016-11-16
 */
@Entity
@Table(name = "hui_hotelSchedule")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HotelSchedule extends IdEntity implements Serializable {
	
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
	 * 场地日期
	 */
	private String placeDate;  
	
	/**
	 * 场地状态  0:初始状态；1 标示已预订档期；2标示已交订金销售档期；3	不可预订
	 */
	private String state;  
	
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
	 * 城市
	 */
	private Integer city; 
	
	/**
	 * 锁定数量
	 */
	private Integer num; 
    public HotelSchedule() {
		super();
		// TODO Auto-generated constructor stub
	}

	public HotelSchedule(Long hotelId, String hotelName, String placeType, Long placeId, String placeName,
			String placeSchedule, String placeDate, String state, String createUserId, String createUserName,
			Date createDate, String memo) {
		super();
		this.hotelId = hotelId;
		this.hotelName = hotelName;
		this.placeType = placeType;
		this.placeId = placeId;
		this.placeName = placeName;
		this.placeSchedule = placeSchedule;
		this.placeDate = placeDate;
		this.state = state;
		this.createUserId = createUserId;
		this.createUserName = createUserName;
		this.createDate = createDate;
		this.memo = memo;
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
    @Column(length=50)
    public String getPlaceDate(){  
      return placeDate;  
    }  
    
    public void setPlaceDate(String placeDate){  
      this.placeDate = placeDate;  
    }  
    @Column(length=50)
    public String getState(){  
      return state;  
    }  
    
    public void setState(String state){  
      this.state = state;  
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

    @Transient
	public Integer getCity() {
		return city;
	}
	public void setCity(Integer city) {
		this.city = city;
	}
	
	@Transient
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}  
	
	
}


