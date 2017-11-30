package com.chuangbang.wechat.hui.model;

import java.util.List;

public class HotelUserModel {

	
	private Long id;
	
	private String hotelName;
	
	private List<UserEvaluateModel> userEvaluateModels;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getHotelName() {
		return hotelName;
	}

	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

	public List<UserEvaluateModel> getUserEvaluateModels() {
		return userEvaluateModels;
	}

	public void setUserEvaluateModels(List<UserEvaluateModel> userEvaluateModels) {
		this.userEvaluateModels = userEvaluateModels;
	}

	
}
