package com.chuangbang.framework.util.account;

import org.apache.commons.lang3.StringUtils;

/**
 * @author denggeng
 *
 */
public enum AdminLevel {
	COUNTRY,
	PROVINCE,
	CITY,
	DISTRICT,
	TOWN,
	VILLAGE;
	
	public static final int ADMIN_LEVEL_TOTAL_LENGTH = 15;
	/**
	 * 获得行政级别长度
	 * @param adminLevel
	 * @return int 行政级别长度
	 */
	public static int getAdminLevelLength(AdminLevel adminLevel){
		int length = 2;
		switch (adminLevel){
			case PROVINCE:length =2;break;
			case CITY:length =4;break;
			case DISTRICT:length =6;break;
			case TOWN:length =9;break;
			case VILLAGE:length =12;break;
			default:length = 2;
		}
		
		return length;
	}
	
	public static AdminLevel getAdminLevel(String deptCode){
		AdminLevel level = null;
		if(StringUtils.repeat("0", ADMIN_LEVEL_TOTAL_LENGTH - AdminLevel.getAdminLevelLength(AdminLevel.PROVINCE)).equals(deptCode.substring(AdminLevel.getAdminLevelLength(AdminLevel.PROVINCE), ADMIN_LEVEL_TOTAL_LENGTH))){
			level = AdminLevel.PROVINCE;
		}else if(StringUtils.repeat("0", ADMIN_LEVEL_TOTAL_LENGTH - AdminLevel.getAdminLevelLength(AdminLevel.CITY)).equals(deptCode.substring(AdminLevel.getAdminLevelLength(AdminLevel.CITY), ADMIN_LEVEL_TOTAL_LENGTH))){
			level = AdminLevel.CITY;
		}else if(StringUtils.repeat("0", ADMIN_LEVEL_TOTAL_LENGTH - AdminLevel.getAdminLevelLength(AdminLevel.DISTRICT)).equals(deptCode.substring(AdminLevel.getAdminLevelLength(AdminLevel.DISTRICT), ADMIN_LEVEL_TOTAL_LENGTH))){
			level = AdminLevel.DISTRICT;
		}else if(StringUtils.repeat("0", ADMIN_LEVEL_TOTAL_LENGTH - AdminLevel.getAdminLevelLength(AdminLevel.TOWN)).equals(deptCode.substring(AdminLevel.getAdminLevelLength(AdminLevel.TOWN), ADMIN_LEVEL_TOTAL_LENGTH))){
			level = AdminLevel.TOWN;
		}else if(StringUtils.repeat("0", ADMIN_LEVEL_TOTAL_LENGTH - AdminLevel.getAdminLevelLength(AdminLevel.VILLAGE)).equals(deptCode.substring(AdminLevel.getAdminLevelLength(AdminLevel.VILLAGE), ADMIN_LEVEL_TOTAL_LENGTH))){
			level = AdminLevel.VILLAGE;
		}
		return level;
	}
	
	/**
	 * 返回父行政级别
	 * @param adminLevel
	 * @return
	 */
	public static AdminLevel getSuperAdminLevel(AdminLevel adminLevel){
		AdminLevel superLevel = null;
		switch (adminLevel){
			case PROVINCE:superLevel = PROVINCE;break;
			case CITY:superLevel =PROVINCE;break;
			case DISTRICT:superLevel =CITY;break;
			case TOWN:superLevel =DISTRICT;break;
			case VILLAGE:superLevel =TOWN;break;
			default:superLevel = PROVINCE;
		}
		
		return superLevel;
	}
	
	public static String getSuperAdminLevelCode(String deptCode){
		if(deptCode == null || deptCode.length() != 15){
			throw new IllegalArgumentException("传入的行政级别参数不是15位！");
		}
		AdminLevel superLevel = getSuperAdminLevel(AdminLevel.getAdminLevel(deptCode));
		int superLevelLength = AdminLevel.getAdminLevelLength(superLevel);
		String superLevelCode = deptCode.substring(0, superLevelLength);
		
		superLevelCode = superLevelCode + StringUtils.repeat("0", ADMIN_LEVEL_TOTAL_LENGTH - superLevelLength);
		
		return superLevelCode;
	}
}
