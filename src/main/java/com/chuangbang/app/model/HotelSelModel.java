package com.chuangbang.app.model;

public class HotelSelModel{
	/**
	 * 酒店编号
	 */
	private Long id;  
	/**
	 * 所属集团编号
	 */
	private Long pid;  
	
	/**
	 * 所属集团名称
	 */
	private String pName;  
	
	/**
	 * 酒店名称
	 */
	private String hotelName;  
	/**1
	 * 酒店开拓人员编号
	 */
	private String reclaimUserId;  
	
	/**
	 * 酒店开拓人员姓名
	 */
	private String reclaimUserName;  
    public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public Long getPid(){  
      return pid;  
    }  
    public void setPid(Long pid){  
      this.pid = pid;  
    }  
    public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getHotelName(){  
      return hotelName;  
    }  
    public void setHotelName(String hotelName){  
      this.hotelName = hotelName;  
    }
	public String getReclaimUserId() {
		return reclaimUserId;
	}
	public void setReclaimUserId(String reclaimUserId) {
		this.reclaimUserId = reclaimUserId;
	}
	public String getReclaimUserName() {
		return reclaimUserName;
	}
	public void setReclaimUserName(String reclaimUserName) {
		this.reclaimUserName = reclaimUserName;
	}  
}


