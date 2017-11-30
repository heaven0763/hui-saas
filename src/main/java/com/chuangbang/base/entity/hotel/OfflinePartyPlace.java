package com.chuangbang.base.entity.hotel;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 线下活动场地Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_offlinePartyPlace")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OfflinePartyPlace extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 线下活动
	 */
	private Long partyId;  
	
	/**
	 * 场地编号
	 */
	private Long placeId;  
	
	/**
	 * 场地名称
	 */
	private String placeName;  
	
	/**
	 * 活动日期
	 */
	private String partyDate;  
	
	/**
	 * 活动时间
	 */
	private String partyTime;  
	
  
    public Long getPartyId(){  
      return partyId;  
    }  
    
    public void setPartyId(Long partyId){  
      this.partyId = partyId;  
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
  
    public String getPartyDate(){  
      return partyDate;  
    }  
    
    public void setPartyDate(String partyDate){  
      this.partyDate = partyDate;  
    }  
    @Column(length=50)
    public String getPartyTime(){  
      return partyTime;  
    }  
    
    public void setPartyTime(String partyTime){  
      this.partyTime = partyTime;  
    }  
}


