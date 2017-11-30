package com.chuangbang.framework.util.account;

import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.AuthorizationException;

import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.User;


public class AccountUtils {

	/***
	 * 获取用户实体
	 * */
	public static User getCurrentUser(){
		User user = (User)SecurityUtils.getSubject().getPrincipal();
		return user;
	}
	
	/***
	 * 获取用户id
	 * */
	public static String getCurrentUserId(){
		return null==getCurrentUser()?"":getCurrentUser().getId();
	}
	
	/***
	 * 获取用户id
	 * */
	public static String getCurrentUserGroupId(){
		return null==getCurrentUser()?"":getCurrentUser().getGroup().getGroupId();
	}
	
	/***
	 * 获取用户id
	 * */
	public static String getHotelUserType(){
		if(getCurrentUserType().equals("HOTEL")){
			return getCurrentUser().getGroup().getGroupId().startsWith("hotel")?"HOTEL":"GROUP";
		}else{
			return getCurrentUserType();
		}
	}
	
	/**
	 * 
	 * @return
	 */
	public static String getCurrentUserPwd(){
		return null==getCurrentUser()?"":getCurrentUser().getPassword();
	}
	
	/***
	 * 获取用户登录名
	 * */
	public static String getCurrentUserLoginName(){
		return getCurrentUser().getUsername();
	}
	
	/***
	 * 获取用户姓名
	 * */
	public static String getCurrentRName(){
		return getCurrentUser().getRname();
	}
	
	/**
	 * 获取用户类型
	 * @return
	 */
	public static String getCurrentUserType(){
		return getCurrentUser().getUserType();
	}
	
	/***
	 * 获取用户头像
	 * */
	public static String getCurrentUserPhoto(){
		return getCurrentUser().getAvatar();
	}
	/***
	 * 获取商家id
	 * */
	public static String getCurrentUserHotelId(){
		return getCurrentUser().getHotelId();
	}
	/***
	 * 获取商家id
	 * */
	public static Long getCurrentUserCompanyId(){
		return getCurrentUser().getCompanyId();
	}
	/***
	 * 获取商家id
	 * */
	public static Long getCurrentUserhotelPId(){
		return getCurrentUser().getPhtlid();
	}
	/***
	 * 获取用户头像
	 * */
	/*public static String getCurrentUserBakImg(){
		return getCurrentUser().getBgimg();
	}*/
	
	/**
	 *获取当前时间timestamp
	 */
	public static java.sql.Timestamp getCurrentTimestamp(){
		return new java.sql.Timestamp(new Date().getTime());
	}
	
	public static java.util.Date getCurrentDate(){
		return new Date();
	}
	
	public static String getHost(){
		String host = SecurityUtils.getSubject().getSession().getHost();
		return host;
	}

	public static boolean hasRoles(List<Group> groups) {
		for (Group group : groups) {
			if(SecurityUtils.getSubject().hasRole(group.getGroupId())){
				return true;
			}
		}
		return false;
	}
	
	public static boolean getRoles(String roleid) {
		try{
			SecurityUtils.getSubject().checkRole(roleid);
		}catch(AuthorizationException e){
			return false;
		}
		return true;
	}
	public static boolean isAuthenticated() {
		return SecurityUtils.getSubject().isAuthenticated();
	}

	public static boolean isRole(String groupId) {
		return SecurityUtils.getSubject().hasRole(groupId);
	}
}
