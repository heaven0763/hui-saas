package com.chuangbang.app.model;

public class SupportingModel{
	
	private Long id;
	
	/**
	 * 服务类型
	 */
	private String kind;  
	
	/**
	 * 服务名称
	 */
	private String name;  
	
	/**
	 * 服务	logo
	 */
	private String logo;  
	
	/**
	 * 是否拥有
	 */
	private Long flag; 
	/**
	 * 服务值
	 */
	private String spval; 
  
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
  
    public String getLogo(){  
      return logo;  
    }  
    
    public void setLogo(String logo){  
      this.logo = logo;  
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	public Long getFlag() {
		return flag;
	}

	public void setFlag(Long flag) {
		this.flag = flag;
	}

	public SupportingModel(Long id, String kind, String name, String logo, Long flag) {
		super();
		this.id = id;
		this.kind = kind;
		this.name = name;
		this.logo = logo;
		this.flag = flag;
	}

	public SupportingModel() {
		super();
	}

	public String getSpval() {
		return spval;
	}
	public void setSpval(String spval) {
		this.spval = spval;
	}
	
}


