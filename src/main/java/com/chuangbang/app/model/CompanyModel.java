package com.chuangbang.app.model;

import java.util.Date;

import javax.persistence.Transient;

import com.chuangbang.framework.entity.IdEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
public class CompanyModel extends IdEntity {
	
	/**
	 * 公司名称
	 */
	private String companyName;  
	
	/**
	 * 公司地址
	 */
	private String companyArea;  
	
	/**
	 * 详细地址
	 */
	private String companyAddress;  
	
	/**
	 * 营业执照编号
	 */
	private String businessLicenseNumber;  
	
	/**
	 * 税务登记证编号
	 */
	private String taxNumber;  
	
	/**
	 * 组织机构编号
	 */
	private String organizationNumber;  
	
	/**
	 * 营业执照副本
	 */
	private String businessLicenseImg;  
	
	/**
	 * 联系人姓名
	 */
	private String linkmen;  
	
	/**
	 * 联系人电话
	 */
	private String linkMobile;  
	/**
	 * 提交人编号
	 */
	private String applyUserId; 
	/**
	 * 提交时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date applyDate;  
	
	/**
	 * 认证时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date authDate;  
	
	/**
	 * 认证类型   酒店：HOTEL;接口应用：API;合伙人：PARTNER
	 */
	private String authType;  
	
	/**
	 * 状态 0/1   待/已认证
	 */
	private String state;  
	
	/**
	 * 认证人员编号
	 */
	private String authUserId;  
	
	/**
	 * 认证人员姓名
	 */
	private String authUserName;  
	
	/**
	 * 认证备注
	 */
	private String authReason;  
	
	/**
	 * 报名时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date createDate;  
	
	/**
	 * 备注	
	 */
	private String memo;  
	/**
	 * 所属省份
	 */
	private Integer province;
	
	/**
	 * 所属城市
	 */
	private Integer city;  
	
	/**
	 * 所属区域
	 */
	private Integer district;  
	
	/**
	 * 起始有效日期
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date seffectiveDate; 
	
	/**
	 * 截止有效日期
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date eeffectiveDate; 
  
	/**
	 * 所属省份
	 */
	private String provinceTxt;
	/**
	 * 所属城市
	 */
	private String cityTxt;  
	/**
	 * 所属区域
	 */
	private String districtTxt; 
	
	private Double annualAmount;
	private Double allAmount;
	private Long hotelQuantity;
	
	private String rname;
	private String mobile;
	private String email;
	
    public String getCompanyName(){  
      return companyName;  
    }  
    
    public void setCompanyName(String companyName){  
      this.companyName = companyName;  
    }  
  
    public String getCompanyArea(){  
      return companyArea;  
    }  
    
    public void setCompanyArea(String companyArea){  
      this.companyArea = companyArea;  
    }  
  
    public String getCompanyAddress(){  
      return companyAddress;  
    }  
    
    public void setCompanyAddress(String companyAddress){  
      this.companyAddress = companyAddress;  
    }  
  
    public String getBusinessLicenseNumber(){  
      return businessLicenseNumber;  
    }  
    
    public void setBusinessLicenseNumber(String businessLicenseNumber){  
      this.businessLicenseNumber = businessLicenseNumber;  
    }  
  
    public String getTaxNumber(){  
      return taxNumber;  
    }  
    
    public void setTaxNumber(String taxNumber){  
      this.taxNumber = taxNumber;  
    }  
  
    public String getOrganizationNumber(){  
      return organizationNumber;  
    }  
    
    public void setOrganizationNumber(String organizationNumber){  
      this.organizationNumber = organizationNumber;  
    }  
  
    public String getBusinessLicenseImg(){  
      return businessLicenseImg;  
    }  
    
    public void setBusinessLicenseImg(String businessLicenseImg){  
      this.businessLicenseImg = businessLicenseImg;  
    }  
  
    public String getLinkmen(){  
      return linkmen;  
    }  
    
    public void setLinkmen(String linkmen){  
      this.linkmen = linkmen;  
    }  
  
    public String getLinkMobile(){  
      return linkMobile;  
    }  
    
    public void setLinkMobile(String linkMobile){  
      this.linkMobile = linkMobile;  
    }  
  
    public Date getApplyDate(){  
      return applyDate;  
    }  
    
    public void setApplyDate(Date applyDate){  
      this.applyDate = applyDate;  
    }  
  
    public Date getAuthDate(){  
      return authDate;  
    }  
    
    public void setAuthDate(Date authDate){  
      this.authDate = authDate;  
    }  
  
    public String getState(){  
      return state;  
    }  
    
    public void setState(String state){  
      this.state = state;  
    }  
  
    public String getAuthUserId(){  
      return authUserId;  
    }  
    
    public void setAuthUserId(String authUserId){  
      this.authUserId = authUserId;  
    }  
  
    public String getAuthUserName(){  
      return authUserName;  
    }  
    
    public void setAuthUserName(String authUserName){  
      this.authUserName = authUserName;  
    }  
  
    public String getAuthReason(){  
      return authReason;  
    }  
    
    public void setAuthReason(String authReason){  
      this.authReason = authReason;  
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
    
	public String getAuthType() {
		return authType;
	}

	public void setAuthType(String authType) {
		this.authType = authType;
	}
	
	public String getApplyUserId() {
		return applyUserId;
	}

	public void setApplyUserId(String applyUserId) {
		this.applyUserId = applyUserId;
	}

	public Integer getProvince() {
		return province;
	}

	public void setProvince(Integer province) {
		this.province = province;
	}

	public Integer getCity() {
		return city;
	}

	public void setCity(Integer city) {
		this.city = city;
	}

	public Integer getDistrict() {
		return district;
	}
	public void setDistrict(Integer district) {
		this.district = district;
	}

	public Date getSeffectiveDate() {
		return seffectiveDate;
	}
	public void setSeffectiveDate(Date seffectiveDate) {
		this.seffectiveDate = seffectiveDate;
	}

	public Date getEeffectiveDate() {
		return eeffectiveDate;
	}
	public void setEeffectiveDate(Date eeffectiveDate) {
		this.eeffectiveDate = eeffectiveDate;
	}

	public String getProvinceTxt() {
		return provinceTxt;
	}
	public void setProvinceTxt(String provinceTxt) {
		this.provinceTxt = provinceTxt;
	}
	
	public String getCityTxt() {
		return cityTxt;
	}
	public void setCityTxt(String cityTxt) {
		this.cityTxt = cityTxt;
	}
	
	public String getDistrictTxt() {
		return districtTxt;
	}
	public void setDistrictTxt(String districtTxt) {
		this.districtTxt = districtTxt;
	}
	
	public Double getAnnualAmount() {
		return annualAmount;
	}
	public void setAnnualAmount(Double annualAmount) {
		this.annualAmount = annualAmount;
	}
	
	public Double getAllAmount() {
		return allAmount;
	}
	public void setAllAmount(Double allAmount) {
		this.allAmount = allAmount;
	}
	
	public Long getHotelQuantity() {
		return hotelQuantity;
	}
	public void setHotelQuantity(Long hotelQuantity) {
		this.hotelQuantity = hotelQuantity;
	}

	public String getRname() {
		return rname;
	}

	public void setRname(String rname) {
		this.rname = rname;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
}


