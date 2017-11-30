package com.chuangbang.base.entity.hotel;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 场地风格Entity
 * @author heaven
 * @version 2016-11-21
 */
@Entity
@Table(name = "hui_Category")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Category extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 父编号
	 */
	private Long parentId;  
	
	/**
	 * 类型
	 */
	private String kind;  
	
	/**
	 * 名称
	 */
	private String name;  
	
	/**
	 * 详细值
	 */
	private String val;  
	
	/**
	 * 排序编号
	 */
	private Integer sortOrder;  
	
	/**
	 * 打开
	 */
	private Integer isOpen;  
	
	/**
	 * 推荐
	 */
	private Integer isTui;  
	
	/**
	 * 添加时间
	 */
	private String addTime;  
	
	/**
	 * 
	 */
	private String ishave;
	
    public Long getParentId(){  
      return parentId;  
    }  
    
    public void setParentId(Long parentId){  
      this.parentId = parentId;  
    }  
  
    public String getKind(){  
      return kind;  
    }  
    
    public void setKind(String kind){  
      this.kind = kind;  
    }  
  
    public String getName(){  
      return name;  
    }  
    
    public void setName(String name){  
      this.name = name;  
    }  
  
    public String getVal(){  
      return val;  
    }  
    
    public void setVal(String val){  
      this.val = val;  
    }  
  
    public Integer getSortOrder(){  
      return sortOrder;  
    }  
    
    public void setSortOrder(Integer sortOrder){  
      this.sortOrder = sortOrder;  
    }  
  
    public Integer getIsOpen(){  
      return isOpen;  
    }  
    
    public void setIsOpen(Integer isOpen){  
      this.isOpen = isOpen;  
    }  
  
    public Integer getIsTui(){  
      return isTui;  
    }  
    
    public void setIsTui(Integer isTui){  
      this.isTui = isTui;  
    }  
  
    public String getAddTime(){  
      return addTime;  
    }  
    
    public void setAddTime(String addTime){  
      this.addTime = addTime;  
    }

    @Transient
	public String getIshave() {
		return ishave;
	}
	public void setIshave(String ishave) {
		this.ishave = ishave;
	}  
    
    
}


