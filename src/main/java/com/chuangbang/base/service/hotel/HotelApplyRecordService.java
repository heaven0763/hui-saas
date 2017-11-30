package com.chuangbang.base.service.hotel;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.ApplyHotelRecordModel;
import com.chuangbang.app.model.HotelModel;
import com.chuangbang.base.dao.hotel.HotelApplyRecordDao;
import com.chuangbang.base.dao.hotel.HotelCooperationInfoDao;
import com.chuangbang.base.dao.user.CompanyDao;
import com.chuangbang.base.dao.user.UserPermissionDao;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelApplyRecord;
import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import com.chuangbang.base.entity.hotel.HotelGroup;
import com.chuangbang.base.entity.user.UserPermission;
import com.chuangbang.base.service.user.UserPermissionService;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.generatecode.util.DateUtils;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.js.dao.account.GroupDao;
import com.chuangbang.js.dao.account.UserDao;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.Permission;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.ShiroDbRealm;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 申请加入酒店记录Service
 * @author xtp
 * @version 2017-08-09
 */
@Component
@Transactional(readOnly = true)
public class HotelApplyRecordService extends BaseService<HotelApplyRecord,HotelApplyRecordDao>{
	
	@Autowired
	HotelApplyRecordDao hotelApplyRecordDao;
	@Autowired
	private CustomPageService customPageService;
	@Autowired
	private UserDao userDao;
	@Autowired
	private GroupDao groupDao;
	@Autowired
	private UserPermissionDao userPermissionDao;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private HotelGroupService hotelGroupService;
	
	@Transactional(readOnly=false)
	public void saveRecord(HotelApplyRecord record) {
		hotelApplyRecordDao.save(record);
	}

	//酒店加入申请记录
	public List<ApplyHotelRecordModel> getRecordPageList(PageBean<ApplyHotelRecordModel> pageBean) {
		// TODO Auto-generated method stub
		String columstr = "h.name as hotelName, r.apply_date as applyDate, r.check_date as checkDate, r.id as recordId, r.state as state, r.hotel_id as hotelId";
		String fromWhere = " from hui_apply_record as r left join hui_team_view as h on h.id = r.hotel_id and h.type = r.type where r.user_id = '"+AccountUtils.getCurrentUserId()+"'";
		pageBean.setSort("r.apply_date,r.state");
		pageBean.setOrder("desc,asc");
		return customPageService.page(pageBean, columstr, fromWhere, ApplyHotelRecordModel.class);
	}


	//需审核用户
	public List<User> getCheckPageList(PageBean<User> pageBean,String hotelIds) {
		// TODO Auto-generated method stub
		String columstr = "u.rname as rname, u.mobile as mobile, u.email as email, r.apply_date as applyDate, r.id as recordId";
		String fromWhere = " from hui_apply_record as r left join hui_user as u on u.id = r.user_id where r.state = 0 ";//and r.hotel_id in ("+hotelIds+")
		pageBean.setSort("r.id");
		return customPageService.page(pageBean, columstr, fromWhere, User.class,null);
	}

	@Transactional(readOnly=false)
	public void cancel(Long id) {
		HotelApplyRecord record = this.getEntity(id);
		if(AccountUtils.getCurrentUserId().equals(record.getUserId())){
			record.setState("3");
			this.hotelApplyRecordDao.save(record);
		}
	}

	public int isExist(String userId, Long hotelId,String type) {
		String columstr = "user_id as userId, hotel_id as hotelId, state as state";
		String fromWhere = " from hui_apply_record where user_id = '"+userId+"' and hotel_Id = "+hotelId+" and state = '0' and type='"+type+"'";
		HotelApplyRecord num = customPageService.getOne(columstr, fromWhere, HotelApplyRecord.class);
		if(num != null){
			return 1;
		}else{
			return 0;
		}
	}
	
	@Transactional(readOnly=false)
	public Json check(HotelApplyRecord record, int state,Long groupId) {
		Json j = new Json();
		groupId = groupId==null?13L:groupId;
		try{
			//1审核通过
			if(state==1){
				User user = userDao.findOne(record.getUserId());
				if("CLIENT".equals(user.getUserType())){
					record.setState("1");
					//改变用户类型
					System.out.println("用户"+user.getUserType());
					if("HUI".equals(record.getType())){
						Group group=groupDao.findOne(groupId);
						user.setUserType("HUI");
						user.setGroupId(group.getId());
						user.setPosition(group.getName());
						user.setState("1");
						user.setCity(76);//默认广州
						user.setCompanyId(1L);
						user.setPhtlid(null);
						user.setDeptId(group.getDeptId());
						
						List<Permission> permissions = group.getPermissionEntityList();
						for (Permission permission : permissions) {
							UserPermission up = new UserPermission(user.getId(), user.getRname(), permission.getId()+"", permission.getDisplayname()
									, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
									,permission.getPermission(),permission.getType());
							this.userPermissionDao.save(up);
						}
						
						
					}else if("HOTEL".equals(record.getType())){
						Group group=groupDao.findOne(groupId);
						Hotel hotel = this.hotelService.getEntity(record.getHotelID());
						user.setUserType("HOTEL");
						user.setHotelId(hotel.getId()+"");
						user.setGroupId(group.getId());
						user.setPosition(group.getName());
						user.setState("1");
						user.setCity(hotel.getCity());
						user.setCompanyId(hotel.getCompanyId());
						
						List<Permission> permissions = group.getPermissionEntityList();
						for (Permission permission : permissions) {
							UserPermission up = new UserPermission(user.getId(), user.getRname(), permission.getId()+"", permission.getDisplayname()
									, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
									,permission.getPermission(),permission.getType());
							this.userPermissionDao.save(up);
						}
					}else if("GROUP".equals(record.getType())){
						Group group=groupDao.findOne(groupId);
						HotelGroup hotelGroup = this.hotelGroupService.getEntity(record.getHotelID());
						user.setUserType("HOTEL");
						user.setGroupId(group.getId());
						user.setPosition(group.getName());
						user.setState("1");
						user.setCity(hotelGroup.getCity());
						user.setCompanyId(hotelGroup.getCompanyId());
						user.setPhtlid(hotelGroup.getId());
						
						List<Permission> permissions = group.getPermissionEntityList();
						for (Permission permission : permissions) {
							UserPermission up = new UserPermission(user.getId(), user.getRname(), permission.getId()+"", permission.getDisplayname()
									, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
									,permission.getPermission(),permission.getType());
							this.userPermissionDao.save(up);
						}
					}
					userDao.save(user);
				}
				
			}else if(state==2){
				record.setState("2");
			}
			record.setCheckDate(new Date());
			this.saveEntity(record);
			
			j.setJson(true, "申请审核成功！");
			return j;
		}catch(Exception ex){
			j.setJson(false, "申请审核失败！");
			return j;
		}
	}

	public List<Map<String, Object>> getTeams(String name) {
		String sql ="";
		if("TOP".equals(name)){
			sql ="SELECT id,name,type,times,desction FROM hzg_saas.hui_team_view order by times desc limit 10";
		}else{
			sql ="SELECT id,name,type,times,desction FROM hzg_saas.hui_team_view where name like '%"+name+"%' order by times desc";
		}
		List<Map<String, Object>> res = Lists.newArrayList();
		List<Object> list = this.userDao.executeNativeQuery(sql, null);
		if(null!=list&&list.size()>0){
			for (int i = 0; i < list.size(); i++) {
				Object o[] = (Object[]) list.get(i);
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", o[0]);
				map.put("name", o[1]);
				map.put("type", o[2]);
				map.put("times", o[3]);
				map.put("desction", o[4]);
				res.add(map);
			}
		}
		return res;
	}
	
	
	
}
