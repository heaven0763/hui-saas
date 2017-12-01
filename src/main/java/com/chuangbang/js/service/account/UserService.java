package com.chuangbang.js.service.account;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.SalerModel;
import com.chuangbang.base.dao.user.CompanyDao;
import com.chuangbang.base.dao.user.UserPermissionDao;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelGroup;
import com.chuangbang.base.entity.order.Order;
import com.chuangbang.base.entity.user.Company;
import com.chuangbang.base.entity.user.UserPermission;
import com.chuangbang.base.service.hotel.HotelGroupService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.user.CompanyService;
import com.chuangbang.base.service.user.UserPermissionService;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.CipherUtil;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.generatecode.util.DateUtils;
import com.chuangbang.framework.util.hibernate.DynamicSqlHelper;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.util.pingyin4j.Pinyin4jUtil;
import com.chuangbang.js.dao.account.GroupDao;
import com.chuangbang.js.dao.account.UserDao;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.Permission;
import com.chuangbang.js.entity.account.User;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import jodd.util.StringUtil;

/**
 * 安全相关实体的管理类,包括用户和权限组.
 * 
 * @author Heaven
 */
//Spring Bean的标识.
@Component
//默认将类中的所有public函数纳入事务管理.
@Transactional(readOnly = true)
public class UserService extends BaseService<User,UserDao>{

	private static final Logger LOGGER = LoggerFactory.getLogger(UserService.class);

	@Autowired
	private UserDao userDao;
	@Autowired
	private GroupDao groupDao;
	@Autowired
	private ShiroDbRealm shiroRealm;
	@Autowired
	private CustomPageService customPageService;
	@Autowired
	private UserPermissionDao userPermissionDao;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private HotelGroupService hotelGroupService;
	@Autowired
	private CompanyDao companyDao;
	@Autowired
	private UserPermissionService userPermissionService;
	@Autowired
	private CusQueryService cusQueryService;
	@Autowired
	private CompanyService companyService;
	//-- User Manager --//
	public User getUser(String id) {
		return userDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveUser(User entity) {
		//对密码问题做相应处理
		//如果id为空，说明是新增，新增则对密码加密
		if(StringUtil.isBlank(entity.getId())){
			entity.setPassword(CipherUtil.generatePassword(entity.getPassword()));
			//entity.setMemberType("99");
			entity.setIsdel("0");
			entity.setLocked("0");
			entity.setCreateDate(new Date());
			entity.setUserType("CLIENT");
			entity.setGroupId(13L);
			entity.setPosition("普通用户");
			entity.setState("1");
			entity.setIsvalid("0");
		}
		
		/*if(entity.getHotelId()!=null){
			entity.setUserType("HOTEL");
		}else{
			entity.setUserType("HUI");
		}*/
		if(StringUtil.isNotBlank(entity.getRname())){
			entity.setZimu(Pinyin4jUtil.getFirstLetter(entity.getRname()));
		}
		this.userDao.save(entity);
		shiroRealm.clearCachedAuthorizationInfo(entity.getUsername());	
	}
	@Transactional(readOnly = false)
	public void userRegister(User user) {
		user.setIsdel("0");
		user.setCreateDate(new Date());
		this.userDao.save(user);
		shiroRealm.clearCachedAuthorizationInfo(user.getUsername());	
	}
	
	@Transactional(readOnly = false)
	public void save(User entity) {
		this.userDao.save(entity);
		shiroRealm.clearCachedAuthorizationInfo(entity.getUsername());
	}
	
	/**
	 * 修改密码时候用到
	 * */
	@Transactional(readOnly = false)
	public void saveUser(User entity ,boolean isEncodePwd){
		if(isEncodePwd){
			entity.setPassword(CipherUtil.generatePassword(entity.getPassword()));
		}
		userDao.save(entity);
		shiroRealm.clearCachedAuthorizationInfo(entity.getUsername());
	}
	
	/**
	 * 删除用户,如果尝试删除超级管理员将抛出异常.
	 */
	@Transactional(readOnly = false)
	public void deleteUser(String id) {
		if (isSupervisor(id)) {
			logger.warn("操作员{}尝试删除超级管理员用户", SecurityUtils.getSubject().getPrincipal());
			throw new RuntimeException("不能删除超级管理员用户");
		}
		userDao.delete(id);
	}
	
	/**
	 * 判断是否超级管理员.
	 */
	private boolean isSupervisor(String id) {
		return "1".equals(id);
	}

	
	public User findUserByUsername(String username) {
		return userDao.findByUsername(username);
	}
	
	@Transactional(readOnly = false)
	public void batchUpdateStatus(String[] ids,String locked){
		for (int i = 0; i < ids.length; i++) {
			User user = getUser(ids[i]);
			if("1".equals(user.getId())){
				throw new RuntimeException("不能修改超级管理员的状态");
			}
			if(!locked.equals(user.getLocked())){
				user.setLocked(locked);
			}
			saveUser(user);
		}
	}
	
	//-- Group Manager --//
	public Group getGroup(Long id) {
		return groupDao.findOne(id);
	}
	
	public Group getGroupByGroupId(String groupId) {
		return groupDao.findByGroupId(groupId);
	}
	
	@Transactional(readOnly = false)
	public void saveGroup(Group entity) {
		groupDao.save(entity);
		shiroRealm.clearAllCachedAuthorizationInfo();
	}

	@Transactional(readOnly = false)
	public void deleteGroup(Long id) {
		groupDao.delete(id);
		shiroRealm.clearAllCachedAuthorizationInfo();
	}

	public User findUserByMobile(String mobile) {
		return userDao.findByMobile(mobile);
	}
	
	
	
	public List<SalerModel> getSalerPageList(PageBean<SalerModel> pageBean) {
		String columstr =" u.id as id, u.username as username, u.rname as rname, u.mobile as mobile, u.email as email, u.wechat as wechat, u.avatar as avatar"
				+ ", u.description as description, u.sex as sex, u.memo as memo, u.create_date as createDate, u.hotel_id as hotelId, u.user_type as userType"
				+ ", u.position as position, u.company_nature as companyNature, u.company_name as companyName, u.company_scale as companyScale, u.industry as industry";
		String fromWhere = " from hui_user u  where 1=1 and u.locked = '0' and u.isdel = '0'";
		return customPageService.page(pageBean, columstr, fromWhere, SalerModel.class,null);
	} 

	public List<SalerModel> getAllSaler(PageBean<SalerModel> pageBean) {
		String columstr =" u.id as id, u.username as username, u.rname as rname, u.mobile as mobile, u.email as email, u.wechat as wechat, u.avatar as avatar"
				+ ", u.description as description, u.sex as sex, u.memo as memo, u.create_date as createDate, u.hotel_id as hotelId, u.user_type as userType"
				+ ", u.position as position, u.company_nature as companyNature, u.company_name as companyName, u.company_scale as companyScale, u.industry as industry";
		String fromWhere = " from hui_user u  where 1=1 and u.locked = '0' and u.isdel = '0'";
		return customPageService.getAll(pageBean, columstr, fromWhere, SalerModel.class, null);
	}
	
	public SalerModel getSaler(String id) {
		String columstr =" u.id as id, u.username as username, u.rname as rname, u.mobile as mobile, u.email as email, u.wechat as wechat, u.avatar as avatar"
				+ ", u.description as description, u.sex as sex, u.memo as memo, u.create_date as createDate, u.hotel_id as hotelId, u.user_type as userType"
				+ ", u.position as position, u.company_nature as companyNature, u.company_name as companyName, u.company_scale as companyScale, u.industry as industry";
		String fromWhere = " from hui_user u  where 1=1 and u.locked = '0' and u.isdel = '0' and u.id='"+id+"'";
		return customPageService.getOne(columstr, fromWhere, SalerModel.class);
	}

	@Transactional(readOnly=false)
	public Json batchSave(List<Map<String, Object>> res,Long groupId,String userType,String hotelId) {
		Json json = new Json();
		int errNum = 0;
		String repeatUser = "";
		Hotel hotel = null;
		if(StringUtils.isNotBlank(hotelId)){
			hotel = this.hotelService.getEntity(Long.valueOf(hotelId));
		}
		
		for (Map<String, Object> map : res) {
			Group group = this.groupDao.findByName(map.get(1+"")+"");
			if("新增".equals(map.get(8+""))){
				String  zimu = Pinyin4jUtil.getFirstLetter(map.get(0+"")+"");
				String username = map.get(4+"")+"";
				User euser = this.findUserByUsername(username);
				if(euser!=null){
					if(errNum==0){
						repeatUser = username;
					}else{
						repeatUser +=","+ username;
					}
					errNum +=1; 
				}else{
					
					User user = new User(username, map.get(0+"")+"", map.get(2+"")+"", map.get(3+"")+"", group.getId(), map.get(5+"")+"", "", map.get(6+"")+""
							, "0", "0", new Date(), hotelId, userType, map.get(1+"")+"", zimu);
					user.setDeptId(group.getDeptId());
					
					if(null!=hotel){
						user.setCompanyId(hotel.getCompanyId());
						user.setPhtlid(hotel.getPid());
					}
					user.setStar(Integer.valueOf(map.get(7+"")+""));
					this.saveUser(user, true);
					List<Permission> permissions = group.getPermissionEntityList();
					for (Permission permission : permissions) {
						UserPermission up = new UserPermission(user.getId(), user.getRname(), permission.getId()+"", permission.getDisplayname()
								, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
								,permission.getPermission(),permission.getType());
						this.userPermissionDao.save(up);
					}
				}
			}else if("更新".equals(map.get(8+""))){
				User user = this.findUserByUsername(map.get(4+"")+"");
				String zimu = Pinyin4jUtil.getFirstLetter(map.get(0+"")+"");
				if(user==null){
					user = new User(map.get(4+"")+"", map.get(0+"")+"", map.get(2+"")+"", map.get(3+"")+"", group.getId(), map.get(5+"")+"", "", map.get(6+"")+""
								, "0", "0", new Date(), hotelId, userType, map.get(1+"")+"", zimu);
					user.setStar(Integer.valueOf(map.get(7+"")+""));
					user.setDeptId(group.getDeptId());
					if(null!=hotel){
						user.setCompanyId(hotel.getCompanyId());
						user.setPhtlid(hotel.getPid());
					}
				}else{
					user.setUser(map.get(0+"")+"", map.get(2+"")+"", map.get(3+"")+"", groupId, map.get(5+"")+"", map.get(6+"")+"" ,map.get(1+"")+"", zimu,Integer.valueOf(map.get(7+"")+""));
				}
				this.saveUser(user, true);
				List<Permission> permissions = group.getPermissionEntityList();
				for (Permission permission : permissions) {
					UserPermission up = new UserPermission(user.getId(), user.getRname(), permission.getId()+"", permission.getDisplayname()
							, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
							,permission.getPermission(),permission.getType());
					this.userPermissionDao.save(up);
				}
			}else if("删除".equals(map.get(8+""))){
				User user = this.findUserByUsername(map.get(4+"")+"");
				List<Object> params = Lists.newArrayList();
				params.add(user.getId());
				userPermissionDao.executeNativeSQL("delete from hui_user_permission where user_id = ? ",params);
				this.deleteUser(user.getId());
			}
		}
		if(errNum==0){
			json.setJson(true, "导入成功！");
		}else{
			json.setJson(true, "导入完成，存在重复用户名情况，重复名单为"+repeatUser, errNum, repeatUser);
		}
		return json;
	}

	public User findByHotelIdAndGroupIdAndPosition(Long hotelId,Long groupId,String position) {
		return userDao.findByHotelIdAndGroupIdAndPosition(hotelId+"",groupId,position);
	}

	/**
	 * 员工离职
	 * @param id
	 * @return
	 */
	@Transactional(readOnly=false)
	public JsonVo quit(String id) {
		User user = this.getEntity(id);
		user.setState("1");//离职状态
		user.setGroupId(13L);
		user.setCompanyId(null);
		user.setPhtlid(null);
		user.setHotelId(null);
		user.setDeptId(null);
		user.setQuitDate(new Date());
		user.setUserType("CLIENT");
		this.userDao.save(user);
		List<Object> params = Lists.newArrayList();
		params.add(id);
		userPermissionDao.executeNativeSQL("delete from hui_user_permission where user_id = ? ",params);
		return JsonUtils.success("OK");
		// TODO Auto-generated method stub
	}
	
	@Transactional(readOnly=false)
	public Json verificationComplete(String userId, String gid, String hotelId,String type) {
		Json json = new Json();
		System.out.println("gid>>>>>>>>>>>>"+gid);
		System.out.println("userId>>>>>>>>>>>>"+userId);
		System.out.println("hotelId>>>>>>>>>>>>"+hotelId);
		System.out.println("type>>>>>>>>>>>>"+type);
		try{
			Group group=groupDao.findOne(Long.valueOf(gid));
			User user = this.getEntity(userId);
			if("HUI".equals(type)){
				user.setUserType("HUI");
				user.setGroupId(Long.valueOf(gid));
				user.setPosition(group.getName());
				user.setState("1");
				user.setCity(76);//默认广州
				user.setCompanyId(1L);
				user.setPhtlid(null);
				user.setDeptId(group.getDeptId());
			}else if("HOTEL".equals(type)){
				Hotel hotel = this.hotelService.getEntity(Long.valueOf(hotelId));
				user.setUserType("HOTEL");
				user.setHotelId(hotelId);
				user.setGroupId(Long.valueOf(gid));
				user.setPosition(group.getName());
				user.setState("1");
				user.setCity(hotel.getCity());
				user.setCompanyId(hotel.getCompanyId());
				user.setDeptId(group.getDeptId());
			}else if("GROUP".equals(type)){
				HotelGroup hotelGroup = this.hotelGroupService.getEntity(Long.valueOf(hotelId));
				user.setUserType("HOTEL");
				user.setGroupId(Long.valueOf(gid));
				user.setPosition(group.getName());
				user.setState("1");
				user.setCity(hotelGroup.getCity());
				user.setCompanyId(hotelGroup.getCompanyId());
				user.setPhtlid(hotelGroup.getId());
				user.setDeptId(group.getDeptId());
			}else if("PARTNER".equals(type)){
				Company company = this.companyService.getEntity(Long.valueOf(hotelId));
				user.setUserType("PARTNER");
				user.setGroupId(Long.valueOf(gid));
				user.setPosition(group.getName());
				user.setState("1");
				user.setCity(company.getCity());
				user.setCompanyId(company.getId());
				user.setPhtlid(null);
				user.setDeptId(group.getDeptId());
			}else{
				
			}
			
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			this.userDao.save(user);
			List<Permission> permissions = group.getPermissionEntityList();
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>2222222222222222");
			for (Permission permission : permissions) {
				UserPermission up = new UserPermission(userId, user.getRname(), permission.getId()+"", permission.getDisplayname()
						, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
						,permission.getPermission(),permission.getType());
				this.userPermissionDao.save(up);
			}
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>3333333333333333");
		}catch(Exception e){
			json.setJson(false, "确认失败！");
		}
		json.setJson(true, "确认成功！");
		return json;
	}

	public List<User> findByCompanyId(Long companyId) {
		
		return userDao.findByCompanyId(companyId);
	}

	public SalerModel getRamdomSale(Long hotelId) {
		PageBean<SalerModel> pageBean = new PageBean<>();
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_u.hotel_id", hotelId);
		filterParams.put("EQ_u.group_id", 9);
		filterParams.put("EQ_u.state", "1");
		filterParams.put("EQ_u.user_type", "HOTEL");
		pageBean.set_filterParams(filterParams);
		List<SalerModel> salerModels = this.getAllSaler(pageBean);
		 Random random = new Random();
		 if(salerModels!=null&&salerModels.size()>0){
			 int n =   random.nextInt(salerModels.size());
			 SalerModel salerModel = salerModels.get(n);
			 return salerModel;
		 }
		 
		 return null;
	}
	public SalerModel getRamdomCompanySale() {
		PageBean<SalerModel> pageBean = new PageBean<>();
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_u.group_id", 3);
		filterParams.put("EQ_u.state", "1");
		filterParams.put("EQ_u.user_type", "HUI");
		pageBean.set_filterParams(filterParams);
		List<SalerModel> salerModels = this.getAllSaler(pageBean);
		 Random random = new Random();
		int n =   random.nextInt(salerModels.size());
		SalerModel salerModel = salerModels.get(n);
		return salerModel;
	}

	
	@Transactional(readOnly=false)
	public void savePartner(String rname, String username, String mobile, String email, String password,
			String cfpassword, String companyName, Integer province, Integer city) {
		Company company = new Company(companyName, "", "", "","", "", "", rname, mobile, new Date(), "0", "PARTNER");
		company.setCity(city);
		company.setProvince(province);
		company.setEeffectiveDate(new Date());
		company.setSeffectiveDate(new Date());
		company.setCreateDate(new Date());
		company = this.companyDao.save(company);
		Group group = this.getGroup(2L);
		User user = new User(username, rname, mobile, email, 2L, cfpassword, "", "", "0", "0", new Date(), null, "PARTNER", "", Pinyin4jUtil.getFirstLetter(rname));
		user.setCompanyId(company.getId());
		user.setCity(city);
		user.setPassword(CipherUtil.generatePassword(password));
		user.setStar(5);
		user.setState("1");
		user.setPosition(group.getName());
		user.setGroupId(group.getId());
		user.setCompanyName(companyName);
		user.setIsvalid("1");
		user = this.userDao.save(user);
		List<Permission> permissions = group.getPermissionEntityList();
		for (Permission permission : permissions) {
			UserPermission up = new UserPermission(user.getId(), user.getRname(), permission.getId()+"", permission.getDisplayname()
					, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
					,permission.getPermission(),permission.getType());
			this.userPermissionDao.save(up);
		}
		company.setApplyUserId(user.getId());
		this.companyDao.save(company);
	}
	
	@Transactional(readOnly=false)
	public void relieve(Long hotelId, String userId) {
		
		User user = this.userDao.findOne(userId);
		user.setHotelId(null);
		user.setDeptId(null);
		user.setPhtlid(null);
		user.setCompanyId(null);
		user.setPosition("普通用户");
		user.setUserType("CLIENT");
		user.setState("1");
		user.setGroupId(13L);
		this.userDao.save(user);
		List<Object> params = Lists.newArrayList();
		params.add(userId);
		userPermissionDao.executeNativeSQL("delete from hui_user_permission where user_id = ? ",params);
	}
	@Transactional(readOnly=false)
	public void recovery(Long hotelId, String userId) {
		User user = this.getEntity(userId);
		if(hotelId!=null&&hotelId>0){
			user.setUserType("HOTEL");
			user.setHotelId(hotelId+"");
		}else{
			user.setUserType("HUI");
		}
		user.setState("1");//在职状态
		user.setQuitDate(null);
		this.userDao.save(user);
		Group group = this.groupDao.findOne(user.getGroupId());
		List<Permission> permissions = group.getPermissionEntityList();
		for (Permission permission : permissions) {
			UserPermission up = new UserPermission(userId, user.getRname(), permission.getId()+"", permission.getDisplayname()
					, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
					,permission.getPermission(),permission.getType());
			this.userPermissionDao.save(up);
		}
		
	}
	@Transactional(readOnly=false)
	public void updatePermission(User user) {
		Group group = this.groupDao.findOne(user.getGroupId());
		List<UserPermission> userPermissions = this.userPermissionService.findByUserId(user.getId(),"1");
		for (UserPermission userPermission : userPermissions) {
			this.userPermissionDao.delete(userPermission);
		}
		List<Permission> permissions = group.getPermissionEntityList();
		for (Permission permission : permissions) {
			UserPermission up = new UserPermission(user.getId(), user.getRname(), permission.getId()+"", permission.getDisplayname()
					, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
					,permission.getPermission(),permission.getType());
			this.userPermissionDao.save(up);
		}
		
	}

	public List<User> findByHotelIdAndGroupId(Long hotelId, Long groupId) {
		return this.userDao.findByHotelIdAndGroupId(hotelId+"", groupId);
	}

	public List<User> findByPhtlidAndGroupId(Long pid, Long groupId) {
		// TODO Auto-generated method stub
		return this.userDao.findByPhtlidAndGroupId(pid, groupId);
	}

	public User findUserByEmail(String email) {
		return userDao.findByEmail(email);
	}

	public void dojoin(User user, User teamuser) {
		if(teamuser.getUserType().equals("HOTEL")){
			Group group=groupDao.findOne(Long.valueOf(9L));
			Hotel hotel = this.hotelService.getEntity(Long.valueOf(teamuser.getHotelId()));
			user.setUserType("HOTEL");
			user.setHotelId(hotel.getId()+"");
			user.setGroupId(group.getId());
			user.setPosition(group.getName());
			user.setState("1");
			user.setCity(hotel.getCity());
			user.setCompanyId(hotel.getCompanyId());
			user.setPhtlid(hotel.getPid());
			user.setDeptId(group.getDeptId());
			
			List<Permission> permissions = group.getPermissionEntityList();
			for (Permission permission : permissions) {
				UserPermission up = new UserPermission(user.getId(), user.getRname(), permission.getId()+"", permission.getDisplayname()
						, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
						,permission.getPermission(),permission.getType());
				this.userPermissionDao.save(up);
			}
		}else{
			Group group=groupDao.findOne(Long.valueOf(3L));
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
		}
		this.userDao.save(user);
	}

	@Transactional(readOnly=false)
	public void register(User user ) {
		if(StringUtil.isBlank(user.getId())){
			user.setPassword(CipherUtil.generatePassword(user.getPassword()));
			//entity.setMemberType("99");
			user.setIsdel("0");
			user.setLocked("0");
			user.setCreateDate(new Date());
			user.setState("1");
			user.setIsvalid("1");
		}//
		String zimu = Pinyin4jUtil.getFirstLetter(user.getRname());
		user.setZimu(zimu);
		Group group = groupDao.findOne(user.getGroupId());;
		user.setPosition(group.getName());
		user.setStar(5);
		if("HOTEL".equals(user.getUserType())){
			if(StringUtils.isNotBlank(user.getHotelId())){
				Hotel hotel = this.hotelService.getEntity(Long.valueOf(user.getHotelId()));
				user.setCompanyId(hotel.getCompanyId());
				user.setCity(hotel.getCity());
				user.setPhtlid(hotel.getPid());
			}
		}else if("GROUP".equals(user.getUserType())){
			HotelGroup hotelGroup = this.hotelGroupService.getEntity(user.getPhtlid());
			user.setCompanyId(hotelGroup.getCompanyId());
			user.setCity(hotelGroup.getCity());
			user.setUserType("HOTEL");
		}else if("HUI".equals(user.getUserType())){
			user.setCompanyId(1L);
			user.setDeptId(group.getDeptId());
			user.setCity(76);
		}else if("PARTNER".equals(user.getUserType())){
			
		}else{
			user.setPosition("普通用户");
		}
		
		user = this.userDao.save(user);
		if(group!=null){
			List<Permission> permissions = group.getPermissionEntityList();
			System.out.println(">>>>>>"+permissions.size());
			for (Permission permission : permissions) {
				UserPermission up = new UserPermission(user.getId(), user.getRname(), permission.getId()+"", permission.getDisplayname()
						, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
						,permission.getPermission(),permission.getType());
				this.userPermissionDao.save(up);
			}
		}
		
		shiroRealm.clearCachedAuthorizationInfo(user.getUsername());	
	}
	
	public List<User> getPageList(PageBean<User> pageBean) {
		
		String columstr =DynamicSqlHelper.getMappingColumnStr("u.", User.class);
		System.out.println(columstr.contains("groupName"));
		//columstr = columstr.replace(",u.group_name groupName", ",g.name groupName");
		columstr += "g.name groupName,";
		String fromWhere = " from hui_user u left join hui_group g on g.id=u.group_id where 1=1 ";
		return cusQueryService.page(pageBean, columstr+fromWhere, User.class,null);
	} 
	
	public List<User> getAllList(PageBean<User> pageBean) {
		
		String columstr =DynamicSqlHelper.getMappingColumnStr("u.", User.class);
		//columstr = columstr.replace(",o.hotel_name hotelName", ",h.hotel_name hotelName");
		columstr = columstr.replace(",u.group_name groupName", ",g.name groupName");
		String fromWhere = " from hui_user u left join hui_group g on g.id=u.group_id where 1=1 ";
		return cusQueryService.getAll(pageBean, columstr, fromWhere, User.class, null);
	} 
}