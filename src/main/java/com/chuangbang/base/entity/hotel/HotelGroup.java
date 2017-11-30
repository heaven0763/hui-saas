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
import com.fasterxml.jackson.annotation.JsonFormat;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 酒店集团Entity
 * @author heaven
 * @version 2017-10-12
 */
@Entity
@Table(name = "hui_HotelGroup")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HotelGroup extends IdEntity implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 集团名称
	 */
	private String name;  
	
	/**
	 * 集团logo
	 */
	private String logo;  
	
	/**
	 * 集团介绍
	 */
	private String introduction;  
	
	/**
	 * 联系人
	 */
	private String linkman;  
	
	/**
	 * 联系电话
	 */
	private String tel;  
	
	/**
	 * 邮箱
	 */
	private String email;  
	
	/**
	 * 创建人员
	 */
	private String createUserId;  
	
	/**
	 * 创建日期
	 */
	private Date createDate;  
	/**
	 * 状态
	 */
	private String state;
	/**
	 * 备注
	 */
	private String memo;  
	/**
	 * 拓源公司
	 */
	private Long companyId; 
	/**
	 * 拓源公司
	 */
	private Integer city; 
    public String getName(){  
      return name;  
    }  
    
    public void setName(String name){  
      this.name = name;  
    }  
  
    public String getLogo(){  
      return logo;  
    }  
    
    public void setLogo(String logo){  
      this.logo = logo;  
    }  
  
    @Column(columnDefinition="text")
    public String getIntroduction(){  
      return introduction;  
    }  
    public void setIntroduction(String introduction){  
      this.introduction = introduction;  
    }  
  
    public String getLinkman(){  
      return linkman;  
    }  
    
    public void setLinkman(String linkman){  
      this.linkman = linkman;  
    }  
  
    public String getTel(){  
      return tel;  
    }  
    
    public void setTel(String tel){  
      this.tel = tel;  
    }  
  
    public String getEmail(){  
      return email;  
    }  
    
    public void setEmail(String email){  
      this.email = email;  
    }  
  
    public String getCreateUserId(){  
      return createUserId;  
    }  
    
    public void setCreateUserId(String createUserId){  
      this.createUserId = createUserId;  
    }  
  
    public Date getCreateDate(){  
      return createDate;  
    }  
    
    public void setCreateDate(Date createDate){  
      this.createDate = createDate;  
    }  
  
    public String getMemo(){  
      return memo;  
    }  
    public void setMemo(String memo){  
      this.memo = memo;  
    }

	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

	public Long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public Integer getCity() {
		return city;
	}
	public void setCity(Integer city) {
		this.city = city;
	}  
	
	
}


