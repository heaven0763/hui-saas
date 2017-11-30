package com.chuangbang.js.entity.account;

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

import com.chuangbang.base.entity.user.UserPermission;
import com.chuangbang.framework.entity.UuIdEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 用户.
 * 
 * 使用JPA annotation定义ORM关系. 使用Hibernate annotation定义JPA未覆盖的部分.
 * 
 * @author heaven
 */
@Entity
// 表名与类名不相同时重新定义表名.
@Table(name = "hui_user")
@DynamicInsert
@DynamicUpdate
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class User extends UuIdEntity implements Serializable {

	private static final long serialVersionUID = 1L;
	/**
	 * 用户名
	 */
	private String username;
	/**
	 * 用户姓名
	 */
	private String rname;
	/**
	 * 电话
	 */
	private String mobile;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 
	 */
	private String wechat;
	/**
	 * 所属用户角色id
	 */
	private Long groupId;
	
	/**
	 * 密码
	 */
	private String password;
	/**
	 * 头像
	 */
	private String avatar;
	/**
	 * 简介
	 */
	private String description;
	/**
	 * 性别
	 */
	@JsonIgnore
	private String sex;
	
	/**
	 * 是否锁定 0:未锁定；1：已锁定
	 */
	private String locked;
	
	/**
	 * 备注
	 */
	private String memo;
	
	/**
	 * 逻辑删除标志
	 */
	@JsonIgnore
	private String isdel;
	/**
	 * 角色名称
	 */
	private String groupName;
	
	/**
	 * 创建日期
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date createDate;
	
	/**
	 * 所属酒店编号；用户类型为userType时必填
	 */
	private String hotelId;
	/**
	 * 用户类型
	 */
	private String userType;
	/**
	 * 职务
	 */
	private String position;
	
	/**
	 * 单位性质
	 */
	private String companyNature;
	
	/**
	 * 单位名称
	 */
	private String companyName;
	/**
	 * 公司规模
	 */
	private String companyScale;
	/**
	 * 行业
	 */
	private String industry;
	/**
	 * 姓名首字母
	 */
	private  String zimu;

	/**
	 * 非持久化属性，用户权限列表
	 */
	List<UserPermission> userPermissions;
	
	/**
	 * 初评星级
	 */
	private Integer star ;
	
	/**
	 * 1:在职；0：离职
	 */
	private String state;
	/**
	 * 离职日期
	 */
	private Date quitDate;
	
	private Integer city;
	
	private Long deptId;
	
	private Long companyId;
	/**
	 * 酒店集团编号
	 */
	private Long phtlid;
	
	private Group group;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date applyDate;
	
	private Long recordId;
	
	private String isvalid;
	
	@Transient
	public List<UserPermission> getUserPermissions() {
		return userPermissions;
	}

	public void setUserPermissions(List<UserPermission> userPermissions) {
		this.userPermissions = userPermissions;
	}

	public User() {
		super();
		// TODO Auto-generated constructor stub
	}


	@Column(length=50)
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	@Column(length=50)
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}

	@Column(length=20)
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column(length=50)
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}


	public Long getGroupId() {
		return groupId;
	}
	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}

	@Column(length=200)
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	@Column(length=500)
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	@Column(length=500)
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

	@Column(length=5)
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}

	@Column(length=5)
	public String getLocked() {
		return locked;
	}
	public void setLocked(String locked) {
		this.locked = locked;
	}

	@Column(length=500)
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}

	@Column(length=5)
	public String getIsdel() {
		return isdel;
	}
	public void setIsdel(String isdel) {
		this.isdel = isdel;
	}

	@Transient
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	@Column(length=50)
	public String getWechat() {
		return wechat;
	}
	public void setWechat(String wechat) {
		this.wechat = wechat;
	}

	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}


	public String getHotelId() {
		return hotelId;
	}
	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}


	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}


	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}


	public String getCompanyNature() {
		return companyNature;
	}
	public void setCompanyNature(String companyNature) {
		this.companyNature = companyNature;
	}


	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}


	public String getCompanyScale() {
		return companyScale;
	}
	public void setCompanyScale(String companyScale) {
		this.companyScale = companyScale;
	}


	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	
	@Column(length=5)
	public String getZimu() {
		return zimu;
	}
	public void setZimu(String zimu) {
		this.zimu = zimu;
	}

	public Integer getStar() {
		return star;
	}

	public void setStar(Integer star) {
		this.star = star;
	}
	
	@Column(length=5)
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

	public Date getQuitDate() {
		return quitDate;
	}

	public void setQuitDate(Date quitDate) {
		this.quitDate = quitDate;
	}
	
	public Integer getCity() {
		return city;
	}
	public void setCity(Integer city) {
		this.city = city;
	}

	public Long getDeptId() {
		return deptId;
	}
	public void setDeptId(Long deptId) {
		this.deptId = deptId;
	}
	
	public Long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}
	
	public Long getPhtlid() {
		return phtlid;
	}
	public void setPhtlid(Long phtlid) {
		this.phtlid = phtlid;
	}
	
	
	
	
	public Long getRecordId() {
		return recordId;
	}

	public void setRecordId(Long recordId) {
		this.recordId = recordId;
	}

	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	@Transient
	public Group getGroup() {
		return group;
	}
	public void setGroup(Group group) {
		this.group = group;
	}

	public String getIsvalid() {
		return isvalid;
	}
	public void setIsvalid(String isvalid) {
		this.isvalid = isvalid;
	}

	public User(String username, String rname, String mobile, String email, Long groupId, String password,
			String avatar, String description, String locked, String isdel, Date createDate, String hotelId,
			String userType, String position, String zimu) {
		super();
		this.username = username;
		this.rname = rname;
		this.mobile = mobile;
		this.email = email;
		this.groupId = groupId;
		this.password = password;
		this.avatar = avatar;
		this.description = description;
		this.locked = locked;
		this.isdel = isdel;
		this.createDate = createDate;
		this.hotelId = hotelId;
		this.userType = userType;
		this.position = position;
		this.zimu = zimu;
	}

	public void setUser(String rname, String mobile, String email, Long groupId, String password,String description, String position, String zimu,Integer star) {
		this.rname = rname;
		this.mobile = mobile;
		this.email = email;
		this.groupId = groupId;
		this.password = password;
		this.description = description;
		this.position = position;
		this.zimu = zimu;
		this.star = star;
	}

	@Override
	public String toString() {
		return "User [username=" + username + ", rname=" + rname + ", mobile=" + mobile + ", email=" + email
				+ ", wechat=" + wechat + ", groupId=" + groupId + ", password=" + password + ", avatar=" + avatar
				+ ", description=" + description + ", sex=" + sex + ", locked=" + locked + ", memo=" + memo + ", isdel="
				+ isdel + ", groupName=" + groupName + ", createDate=" + createDate + ", hotelId=" + hotelId
				+ ", userType=" + userType + ", position=" + position + ", companyNature=" + companyNature
				+ ", companyName=" + companyName + ", companyScale=" + companyScale + ", industry=" + industry
				+ ", zimu=" + zimu + ", userPermissions=" + userPermissions + ", star=" + star + ", state=" + state
				+ ", quitDate=" + quitDate + ", city=" + city + ", deptId=" + deptId + ", companyId=" + companyId
				+ ", phtlid=" + phtlid + ", applyDate=" + applyDate + ", recordId=" + recordId
				+ ", isvalid=" + isvalid + "]";
	}
}