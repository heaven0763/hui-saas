package com.chuangbang.base.entity.hotel;

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
 * 酒店餐饮菜单Entity
 * @author mabelxiao
 * @version 2016-11-16
 */
@Entity
@Table(name = "hui_hotelMenu")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HotelMenu extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 所属酒店编号
	 */
	private Long hotelId;  
	
	/**
	 * 所属酒店名称
	 */
	private String hotelName;  
	/**
	 * 菜单类型
	 */
	private String type;  
	/**
	 * 菜单名称
	 */
	private String name;  
	
	/**
	 * 价格
	 */
	private String price;  
	
	/**
	 * 介绍
	 */
	private String introduction;  
	
	/**
	 * 图片
	 */
	private String img;  
	
	/**
	 * 创建时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo;  
	
	private String state;
	
	List<HotelMenuDetail> hotelMenuDetails = Lists.newArrayList();
  
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
    public String getName(){  
      return name;  
    }  
    public void setName(String name){  
      this.name = name;  
    } 
    
    @Column(length=50)
    public String getPrice(){  
      return price;  
    }  
    public void setPrice(String price){  
      this.price = price;  
    } 
    
    @Column(columnDefinition="text")
    public String getIntroduction(){  
      return introduction;  
    }  
    public void setIntroduction(String introduction){  
      this.introduction = introduction;  
    }  
    
    @Column(columnDefinition="text")
    public String getImg(){  
      return img;  
    }  
    public void setImg(String img){  
      this.img = img;  
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
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	@Column(length=5)
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	@Transient
	public List<HotelMenuDetail> getHotelMenuDetails() {
		return hotelMenuDetails;
	}
	public void setHotelMenuDetails(List<HotelMenuDetail> hotelMenuDetails) {
		this.hotelMenuDetails = hotelMenuDetails;
	}  
    
}


