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
import com.fasterxml.jackson.annotation.JsonFormat;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 场地图片Entity
 * @author heaven
 * @version 2016-11-21
 */
@Entity
@Table(name = "hui_SiteImg")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SiteImg extends IdEntity implements Serializable{
	
	private static final long serialVersionUID = 1L;

	/**
	 * 所属酒店
	 */
	private Long hotelId;  
	/**
	 *  所属酒店名称
	 */
	private String hotelName;
	/**
	 * 场地类型	
	 */
	private String siteType;  
	
	/**
	 * 场地编号
	 */
	private Long siteId;  
	
	/**
	 * 图片类型
	 */
	private String picType;  
	
	/**
	 * 原图
	 */
	private String originalImg;  
	
	/**
	 * 缩略图
	 */
	private String thumbImg;  
	
	/**
	 * 小图
	 */
	private String littleImg;
	
	/**
	 * 排序编号
	 */
	private Integer sortOrder;  
	
	/**
	 * 上传时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date uploadTime;  
	
	/**
	 * 来源
	 */
	private String origin;
    
	private String siteName;
	
    public Long getHotelId(){  
      return hotelId;  
    }  
    public void setHotelId(Long hotelId){  
      this.hotelId = hotelId;  
    }  
    
    @Column(length=50)
    public String getSiteType(){  
      return siteType;  
    }  
    public void setSiteType(String siteType){  
      this.siteType = siteType;  
    }  
  
    public Long getSiteId(){  
      return siteId;  
    }  
    public void setSiteId(Long siteId){  
      this.siteId = siteId;  
    }  
    
    @Column(length=50)
    public String getPicType(){  
      return picType;  
    }  
    public void setPicType(String picType){  
      this.picType = picType;  
    }  
  
    @Column(length=500)
    public String getOriginalImg(){  
      return originalImg;  
    }  
    public void setOriginalImg(String originalImg){  
      this.originalImg = originalImg;  
    }  
    
    @Column(length=500)
    public String getThumbImg(){  
      return thumbImg;  
    }  
    public void setThumbImg(String thumbImg){  
      this.thumbImg = thumbImg;  
    }  
  
    public Integer getSortOrder(){  
      return sortOrder;  
    }  
    public void setSortOrder(Integer sortOrder){  
      this.sortOrder = sortOrder;  
    }  
  
    public Date getUploadTime(){  
      return uploadTime;  
    }  
    public void setUploadTime(Date uploadTime){  
      this.uploadTime = uploadTime;  
    }
    
    @Column(length=500)
	public String getLittleImg() {
		return littleImg;
	}
	public void setLittleImg(String littleImg) {
		this.littleImg = littleImg;
	}
	
	@Column(length=50)
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public SiteImg() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SiteImg(Long hotelId, String siteType, Long siteId, String picType, String originalImg, String thumbImg,
			String littleImg, Integer sortOrder, Date uploadTime, String origin) {
		super();
		this.hotelId = hotelId;
		this.siteType = siteType;
		this.siteId = siteId;
		this.picType = picType;
		this.originalImg = originalImg;
		this.thumbImg = thumbImg;
		this.littleImg = littleImg;
		this.sortOrder = sortOrder;
		this.uploadTime = uploadTime;
		this.origin = origin;
	}
	@Transient
	public String getHotelName() {
		return hotelName;
	}
	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}
	
	@Transient
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}  
	
	
	
}


