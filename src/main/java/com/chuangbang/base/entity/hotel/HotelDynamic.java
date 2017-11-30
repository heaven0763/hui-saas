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
 * 酒店动态Entity
 * @author heaven
 * @version 2016-12-07
 */
@Entity
@Table(name = "hui_hotel_dynamic")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HotelDynamic extends IdEntity implements Serializable{
	
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
	 * 酒店照片
	 */
	private String hoteLogo;  
	
	/**
	 * 大厅编号
	 */
	private Long hallId;  
	
	/**
	 * 大厅名称
	 */
	private String hallName;  
	
	/**
	 * 活动
	 */
	private String party;  
	
	/**
	 * 场地
	 */
	private String site;  
	
	/**
	 * 时间
	 */
	private String partyTime;  
	
	/**
	 * 地点
	 */
	private String area;  
	
	/**
	 * 参考预算
	 */
	private String budget;  
	
	/**
	 * 动态内容
	 */
	private String pcontent;  
	
	/**
	 * 动态图片
	 */
	private String imgs;  
	/**
	 * 动态缩略图片
	 */
	private String thmimgs;  
	/**
	 * 发布日期
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date createDate;  
	
	/**
	 * 是否案列
	 */
	private String iscase;  
	
	/**
	 * 转发
	 */
	private Integer forward;  
	
	/**
	 * 分享
	 */
	private Integer share;  
	
	/**
	 * 评论
	 */
	private Integer comments;  
	
	/**
	 * 备注
	 */
	private String memo;  
	
	private String createUserId;
  
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
    
    @Column(length=500)
    public String getHoteLogo(){  
      return hoteLogo;  
    }  
    
    public void setHoteLogo(String hoteLogo){  
      this.hoteLogo = hoteLogo;  
    }  
  
    public Long getHallId(){  
      return hallId;  
    }  
    
    public void setHallId(Long hallId){  
      this.hallId = hallId;  
    }  
    @Column(length=50)
    public String getHallName(){  
      return hallName;  
    }  
    
    public void setHallName(String hallName){  
      this.hallName = hallName;  
    }  
    @Column(length=50)
    public String getParty(){  
      return party;  
    }  
    
    public void setParty(String party){  
      this.party = party;  
    }  
    @Column(length=50)
    public String getSite(){  
      return site;  
    }  
    
    public void setSite(String site){  
      this.site = site;  
    }  
    @Column(length=50)
    public String getPartyTime(){  
      return partyTime;  
    }  
    
    public void setPartyTime(String partyTime){  
      this.partyTime = partyTime;  
    }  
    @Column(length=50)
    public String getArea(){  
      return area;  
    }  
    
    public void setArea(String area){  
      this.area = area;  
    }  
    @Column(length=50)
    public String getBudget(){  
      return budget;  
    }  
    
    public void setBudget(String budget){  
      this.budget = budget;  
    }  
    @Column(length=500)
    public String getPcontent(){  
      return pcontent;  
    }  
    
    public void setPcontent(String pcontent){  
      this.pcontent = pcontent;  
    }  
    @Column(columnDefinition="text")
    public String getImgs(){  
      return imgs;  
    }  
    public void setImgs(String imgs){  
      this.imgs = imgs;  
    }  
  
    public Date getCreateDate(){  
      return createDate;  
    }  
    
    public void setCreateDate(Date createDate){  
      this.createDate = createDate;  
    }  
    
    @Column(length=5)
    public String getIscase(){  
      return iscase;  
    }  
    public void setIscase(String iscase){  
      this.iscase = iscase;  
    }  
  
    public Integer getForward(){  
      return forward;  
    }  
    
    public void setForward(Integer forward){  
      this.forward = forward;  
    }  
  
    public Integer getShare(){  
      return share;  
    }  
    public void setShare(Integer share){  
      this.share = share;  
    }  
  
    public Integer getComments(){  
      return comments;  
    }  
    public void setComments(Integer comments){  
      this.comments = comments;  
    }  
    
    @Column(length=500)
    public String getMemo(){  
      return memo;  
    }  
    public void setMemo(String memo){  
      this.memo = memo;  
    }
    
    @Column(length=50)
	public String getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}

	
	@Column(columnDefinition="text")
	public String getThmimgs() {
		return thmimgs;
	}
	public void setThmimgs(String thmimgs) {
		this.thmimgs = thmimgs;
	}  
    
    
}


