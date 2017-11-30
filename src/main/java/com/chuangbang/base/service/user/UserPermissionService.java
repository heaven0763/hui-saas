package com.chuangbang.base.service.user;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.base.dao.user.UserPermissionDao;
import com.chuangbang.base.entity.user.UserPermission;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.generatecode.util.DateUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.js.dao.account.UserDao;
import com.chuangbang.js.entity.account.Permission;
import com.chuangbang.js.entity.account.User;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 权限Service
 * @author liaotingyao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class UserPermissionService extends BaseService<UserPermission,UserPermissionDao> {

	@Autowired
	private UserPermissionDao userPermissionDao;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private CusQueryService cusQueryService;
	@Autowired
	private CustomPageService customPageService;
	
	public UserPermission getEntity(Long id) {
		return userPermissionDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveUserPermission(UserPermission UserPermission) {
		userPermissionDao.save(UserPermission);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		userPermissionDao.delete(id);
	}
	
	public List<UserPermission> getUserPermissionPageList(PageBean<UserPermission> pageBean) {
		String columstr =" p.id as id, p.user_id as userId, p.user_name as userName, p.permission_id as permissionId, p.permissions as permissions"
				+ ", p.permission_name as permissionName, p.start_time as startTime, p.end_time as endTime, p.create_date as createDate"
				+ ", p.memo as memo, p.type as type, p.adjust_date as adjustDate, p.adjust_uid as adjustUid, p.isweixin as isweixin";
		String fromWhere = " from hui_user_permission p left join hui_user u on u.id = p.user_id where 1=1";
		return customPageService.page(pageBean, columstr, fromWhere, UserPermission.class,null);
	} 

	public List<UserPermission> getAllUserPermission(PageBean<UserPermission> pageBean) {
		String columstr =" p.id as id, p.user_id as userId, p.user_name as userName, p.permission_id as permissionId, p.permissions as permissions"
				+ ", p.permission_name as permissionName, p.start_time as startTime, p.end_time as endTime, p.create_date as createDate"
				+ ", p.memo as memo, p.type as type, p.adjust_date as adjustDate, p.adjust_uid as adjustUid, p.isweixin as isweixin";
		String fromWhere = " from hui_user_permission p left join hui_user u on u.id = p.user_id where 1=1";
		return customPageService.getAll(pageBean, columstr, fromWhere, UserPermission.class, null);
	}
	
	public UserPermission getUserPermission(Long id) {
		String columstr =" p.id as id, p.user_id as userId, p.user_name as userName, p.permission_id as permissionId, p.permissions as permissions"
				+ ", p.permission_name as permissionName, p.start_time as startTime, p.end_time as endTime, p.create_date as createDate"
				+ ", p.memo as memo, p.type as type, p.adjust_date as adjustDate, p.adjust_uid as adjustUid, p.isweixin as isweixin";
		String fromWhere = " from hui_user_permission p where 1=1 and p.id="+id;
		return customPageService.getOne(columstr, fromWhere, UserPermission.class);
	}
	
	public List<UserPermission> findByUserId(String userId,String type){
		Map<String,Object> map = Maps.newHashMap();
		map.put("EQ_userId", userId);
		map.put("EQ_type", type);
		//map.put("EQ_isweixin", "1");
		if(type.equals("0")){
			map.put("LTE_startTime", DateTimeUtils.getCurrentDate());
			map.put("GTE_endTime", DateTimeUtils.getCurrentDate());
		}
		return getEntities(map);
	}
	
	@Transactional(readOnly = false)
	public void updatePermission(String user_id,String permission_ids){
		List<Object> params = Lists.newArrayList();
		params.add(user_id);
		User user = userDao.findOne(user_id);
		userPermissionDao.executeNativeSQL("delete from hui_user_permission where user_id = ? ",params);//and type=1 
		if(StringUtils.isNotBlank(permission_ids)){
			String sql = "select id,displayname,permission from hui_permission where id in ("+permission_ids+")";
			List<Object> paras = Lists.newArrayList();
			List<Permission> permissons = cusQueryService.getAll(new PageBean(), sql, Permission.class, paras);
			for(Permission p:permissons){
				UserPermission userPermission = new UserPermission(user.getId(), user.getRname(), p.getId() + "", p.getDisplayname()
						, new Date(), DateUtils.addDays(new Date(), 10*365), new Date(), "", "1", AccountUtils.getCurrentUserId(), new Date()
						, p.getPermission(),p.getType());
				this.saveEntity(userPermission);
			}	
		}
	}
	
	@Transactional(readOnly = false)
	public JsonVo saveUserPermission(String userId, String pmsids, String rname, String email, String mobile,
			String sdate, String edate) {
		try{
			if(StringUtils.isNotBlank(pmsids)){
				String sql = "select id,displayname,permission from hui_permission where id in ("+pmsids+")";
				List<Object> paras = Lists.newArrayList();
				List<Permission> permissons = cusQueryService.getAll(new PageBean(), sql, Permission.class, paras);
				if(StringUtils.isBlank(rname)){
					User user = this.userDao.findOne(userId);
					rname = user.getRname();
				}
				for(Permission p:permissons){
					UserPermission userPermission = new UserPermission(userId, rname, p.getId() + "", p.getDisplayname()
							, DateTimeUtils.string2Date(sdate+" 00:00:00", DateTimeUtils.PATTERN_TO_SECOND)
							, DateTimeUtils.string2Date(edate+" 23:59:59", DateTimeUtils.PATTERN_TO_SECOND)
							, new Date(), "临时权限", "0",AccountUtils.getCurrentUserId(), new Date(), p.getPermission(),p.getType());
					this.userPermissionDao.save(userPermission);
				}	
				return JsonUtils.success("提交授权成功！");
			}else{
				return JsonUtils.error("权限信息有误，请确认已选择权限！");
			}
		}catch(Exception e){
			return JsonUtils.error("提交失败！");
		}
	}
	
}
