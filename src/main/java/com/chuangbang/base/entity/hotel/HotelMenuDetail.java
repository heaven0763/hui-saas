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
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 酒店餐饮菜单明细Entity
 * @author mabelxiao
 * @version 2016-11-16
 */
@Entity
@Table(name = "hui_hotelMenuDetail")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HotelMenuDetail extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 菜单编号
	 */
	private Long menuId;  
	
	/**
	 * 菜名
	 */
	private String name;  
	
	/**
	 * 价格
	 */
	private Double price;  
	
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
	
  
    public Long getMenuId(){  
      return menuId;  
    }  
    
    public void setMenuId(Long menuId){  
      this.menuId = menuId;  
    }  
    @Column(length=50)
    public String getName(){  
      return name;  
    }  
    
    public void setName(String name){  
      this.name = name;  
    }  
  
    public Double getPrice(){  
      return price;  
    }  
    
    public void setPrice(Double price){  
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
}


