package com.chuangbang.js.entity.account;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.ForeignKey;

import com.chuangbang.framework.entity.IdEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;




@Entity
//
@Table(name = "hui_menu")
//
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
//实现Comparable接口是为了排序
public class Menu extends IdEntity implements Comparable<Menu> , Serializable{

	private static final long serialVersionUID = 1L;
	
	/** 父菜单ID */
	private Long parentId;
	
	/** 名称 */
	private String name;
	
	/** URL(#表示展开) */
	private String url;
	
	/** 排序标识 */
	private Long orderId;
	/**
	 * 菜单类型
	 */
	private String type;
	/**
	 * 菜单图标
	 */
	private String icon;
	/**
	 * 菜单目标
	 */
	private String tab;
	
	/**
	 * 父菜单名称
	 */
	private String pname;
	
	/**
	 * 菜单英文名
	 */
	private String enName;
	
	/**
	 * 是否常用
	 */
	private String iscommon;
	
	/**
	 * 菜单 对应菜单Id
	 */
	private Long parallelismmenuId;
	private String isweixin;
	
	//子菜单
	@JsonIgnore
	private List<Menu> childrenMenuList = Lists.newArrayList();
	
	//授权的子菜单
	@JsonIgnore
	private List<Menu> authorizedChildrenMenuList = Lists.newArrayList();
	
	public String getEnName() {
		return enName;
	}

	public void setEnName(String enName) {
		this.enName = enName;
	}

	public Menu() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Menu(Long parentId, String name, String url, Long orderId,
			String type, String icon, String tab) {
		super();
		this.parentId = parentId;
		this.name = name;
		this.url = url;
		this.orderId = orderId;
		this.type = type;
		this.icon = icon;
		this.tab = tab;
	}

	public void setParentId(java.lang.Long value) {
		this.parentId = value;
	}

	public java.lang.Long getParentId() {
		return this.parentId;
	}
	public void setName(java.lang.String value) {
		this.name = value;
	}

	@Column(length=255)
	public java.lang.String getName() {
		return this.name;
	}
	public void setUrl(java.lang.String value) {
		this.url = value;
	}

	@Column(length=4000)
	public java.lang.String getUrl() {
		return this.url;
	}
	public void setOrderId(java.lang.Long value) {
		this.orderId = value;
	}

	public java.lang.Long getOrderId() {
		return this.orderId;
	}


	@OneToMany (targetEntity=Menu.class,mappedBy="parentId",fetch=FetchType.EAGER,cascade={CascadeType.MERGE,CascadeType.REMOVE})
	//@JoinColumn(name="parentId")
	//Fecth策略定义
	@Fetch(FetchMode.SUBSELECT)
	@ForeignKey(name = "none")
	//集合按orderId排序.
	@OrderBy("orderId")
	//集合中对象id的缓存.
	@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
	public List<Menu> getChildrenMenuList() {
		return childrenMenuList;
	}

	public void setChildrenMenuList(List<Menu> childrenMenuList) {
		this.childrenMenuList = childrenMenuList;
	}
	
	@Transient
	public List<Menu> getAuthorizedChildrenMenuList() {
		return authorizedChildrenMenuList;
	}

	public void setAuthorizedChildrenMenuList(List<Menu> authorizedChildrenMenuList) {
		this.authorizedChildrenMenuList = authorizedChildrenMenuList;
	}
	
	@Override
	public int compareTo(Menu o) {
		return this.getOrderId().compareTo(o.getOrderId());
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getTab() {
		return tab;
	}

	public void setTab(String tab) {
		this.tab = tab;
	}

	@Transient
	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getIscommon() {
		return iscommon;
	}
	public void setIscommon(String iscommon) {
		this.iscommon = iscommon;
	}

	public Long getParallelismmenuId() {
		return parallelismmenuId;
	}
	public void setParallelismmenuId(Long parallelismmenuId) {
		this.parallelismmenuId = parallelismmenuId;
	}

	public String getIsweixin() {
		return isweixin;
	}
	public void setIsweixin(String isweixin) {
		this.isweixin = isweixin;
	}
	
}

