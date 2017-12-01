package com.chuangbang.wechat.hui.service.user;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springside.modules.web.Servlets;

import com.chuangbang.base.dao.hotel.HotelDao;
import com.chuangbang.base.dao.order.OrderDao;
import com.chuangbang.base.dao.user.ChatRecordDao;
import com.chuangbang.base.dao.user.UserPermissionDao;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelGroup;
import com.chuangbang.base.entity.order.Order;
import com.chuangbang.base.entity.user.ChatRecord;
import com.chuangbang.base.entity.user.Company;
import com.chuangbang.base.entity.user.UserPermission;
import com.chuangbang.base.service.hotel.HotelGroupService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.order.OrderService;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.base.service.user.CompanyService;
import com.chuangbang.base.service.user.UserPermissionService;
import com.chuangbang.framework.util.CipherUtil;
import com.chuangbang.framework.util.HttpUtils;
import com.chuangbang.framework.util.RandomStringUtil;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.generatecode.util.DateUtils;
import com.chuangbang.framework.util.hibernate.DynamicSqlHelper;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.js.dao.account.GroupDao;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.Permission;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.UserService;
import com.chuangbang.plugins.mail.service.EmailService;
import com.chuangbang.plugins.sms.util.CallUtil;
import com.google.common.collect.Maps;

@Component
@Transactional(readOnly = true)
public class WxUserService{

	private static final Logger LOGGER = LoggerFactory.getLogger(WxUserService.class);

	@Autowired
	private UserService userService;
	@Autowired
	private GroupDao groupDao;
	@Autowired
	private UserPermissionService userPermissionService;
	@Autowired
	private EmailService emailService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private ChatRecordDao chatRecordDao;
	@Autowired
	private UserPermissionDao userPermissionDao;
	@Autowired
	private ChatRecordService chatRecordService;
	@Autowired
	private HotelGroupService hotelGroupService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private HotelDao hotelDao;
	@Autowired
	private CompanyService companyService;
	
	
	public String buildQuerySql(){
		String colSql = DynamicSqlHelper.getMappingColumnStr("e.", User.class);
		StringBuilder sbd = new StringBuilder();
		sbd.append("select " + colSql + " from hui_evaluate e "
				+ " left join hui_hotel h ");
	
		sbd.append(" on e.hotel_id = h.id where 1=1 " );
		return sbd.toString();
	}
	
	public Page<User> page(PageBean pageBean,HttpServletRequest request,Model model){
		Map<String, Object> searchparas = Servlets.getParametersStartingWith(request, "search_");
		pageBean.set_filterParams(searchparas);
		
		Page<User> page = userService.getEntities(pageBean);
		for(User user : page){
			user.setUserPermissions(userPermissionService.findByUserId(user.getId(),"1"));
		}
		
		return page;
	}
	
	@Transactional(readOnly = false)
	public JsonVo saveresetpwd(String userid,String mobile,String password){
		User user = null;
		System.out.println("userid>>>>"+userid);
		if(StringUtils.isNotBlank(userid)){
			user = userService.getEntity(userid);
		}
		System.out.println(StringUtils.isNotBlank(mobile));
		System.out.println(mobile);
		if(StringUtils.isNotBlank(mobile)){
			user = userService.findUserByMobile(mobile);
		}
		
		if(user == null){
			return JsonUtils.error("用户不存在！");
		}
		System.out.println(">>>>>"+user.getGroupId());
		user.setPassword(password);
		userService.saveUser(user, true);
		return JsonUtils.success("重置成功！");
	}
	
	@Transactional(readOnly = false)
	public JsonVo saveresetpwd(String mobile,String password){
		User user = null;
		
		if(StringUtils.isNotBlank(mobile)){
			user = userService.findUserByMobile(mobile);
		}
		if(user == null){
			return JsonUtils.error("用户不存在！");
		}
		System.out.println(">>>>>"+user.getGroupId());
		user.setPassword(password);
		userService.saveUser(user, true);
		return JsonUtils.success("重置成功！");
	}
	
	@Transactional(readOnly = false)
	public JsonVo invitationSend(String userIds, Long gid,Long hotelId,String flag,Long hgId,String type) {
		String title = "职位邀请确认";
		String p1 = "";
		String p4 = "";
		String p6 = "";
		Long srcId = 0L;
		if("HOTEL".equals(AccountUtils.getHotelUserType())){
			Hotel hotel = this.hotelService.getEntity(Long.valueOf(AccountUtils.getCurrentUserHotelId()));
			p1 = hotel.getHotelName();
			title = p1+title;
			p4 = CipherUtil.encrypt(hotel.getId()+"");
			srcId = hotel.getId();
			p6 = "HOTEL";
		}else  if("GROUP".equals(AccountUtils.getHotelUserType())){
			HotelGroup hotelGroup = this.hotelGroupService.getEntity(hgId);
			p1 = hotelGroup.getName();
			title = p1+title;
			p4 = CipherUtil.encrypt(hotelGroup.getId()+"");
			srcId = hotelGroup.getId();
			p6 = "GROUP";
		}else if("PARTNER".equalsIgnoreCase(AccountUtils.getHotelUserType())){
			Company company = this.companyService.getEntity(hgId);
			p1 = company.getCompanyName();
			title = p1+title;
			p4 = CipherUtil.encrypt(company.getId()+"");
			srcId = company.getId();
			p6 = "PARTNER";
		}else{
			if(null!=hotelId){
				Hotel hotel = this.hotelService.getEntity(hotelId);
				p1 = hotel.getHotelName();
				title = p1+title;
				p4 = CipherUtil.encrypt(hotel.getId()+"");
				srcId = hotel.getId();
				p6 = "HOTEL";
			}else if(null!= hgId){
				if("PARTNER".equals(type)){
					Company company = this.companyService.getEntity(hgId);
					p1 = company.getCompanyName();
					title = p1+title;
					p4 = CipherUtil.encrypt(company.getId()+"");
					srcId = company.getId();
					p6 = "PARTNER";
				}else{
					HotelGroup hotelGroup = this.hotelGroupService.getEntity(hgId);
					p1 = hotelGroup.getName();
					title = p1+title;
					p4 = CipherUtil.encrypt(hotelGroup.getId()+"");
					srcId = hotelGroup.getId();
					p6 = "GROUP";
				}
				
			}else{
				p1 = "会掌柜";
				title = p1+title;
				p6 = "HUI";
			}
		}
		Group group = this.groupDao.findOne(gid);
		p1 = CipherUtil.encrypt(p1);
		String p2 = CipherUtil.encrypt(gid+"");
	
		Long time = new Date().getTime();
		String uids[] = userIds.split(",");
		for (String id : uids) {
			User user = this.userService.getEntity(id);
			String invitationCode =time+RandomStringUtil.nextString(8);
			String p3 = CipherUtil.encrypt(id);
			//http://192.168.199.166:8081/hui
			String url = "http://saas.hui-china.com/hui/confirm/verification/email/"+time+"?p1="+p1+"&p2="+p2+"&p3="+p3+"&p4="+p4+"&p5="+CipherUtil.encrypt(invitationCode)+"&p6="+CipherUtil.encrypt(p6);
			String tinyurl = HttpUtils.getC7ggDWZ(url);
			String content = "<div style=\"width:100%\">您好，"+user.getRname()+";"+title+"点击这里<a href=\""+url+"\" target=\"_blank\">前去确认</a>！";
			content+="<br/>如果不能打开页面，请复制下面地址到浏览器打开";
			content+="<br/><div style=\"word-wrap: break-word;word-break: break-all\">"+url+"</div></div>";
			Json json = emailService.sendeMail(user.getEmail(), title, content);
			if(json.isSuccess()){
				String batchId = RandomStringUtil.getWthdrwNo(8);
				ChatRecord chatRecord = new ChatRecord(AccountUtils.getCurrentUserId(), "", user.getId(), user.getRname(), "USERINVITATION", title, content, new Date(), "0", srcId, "", type, invitationCode, "人员邀请记录",batchId);
				chatRecord.setItemDesc(group.getName());
				chatRecordDao.save(chatRecord);
				
				ChatRecord mchatRecord = new ChatRecord(AccountUtils.getCurrentUserId(), "", user.getId(), user.getRname(), "SYSTEMMSG", title, content, new Date(), "0", srcId, "", type, invitationCode, "人员邀请记录",batchId);
				mchatRecord.setItemDesc(group.getName());
				chatRecordDao.save(mchatRecord);
			}
			if(StringUtils.isNotBlank(tinyurl)){
				CallUtil.sendmsg("您好，"+user.getRname()+";"+title+";前去确认请点击"+tinyurl+"。", user.getMobile());
			}
		}
		return JsonUtils.success("发送成功！");
	}
	
	@Transactional(readOnly = false)
	public JsonVo transferSave(String fromuserId, String userId, String email, String mobile, Long gid,String crtusrty,String transferType) {
		User user = this.userService.getEntity(userId);
		try{
			if(StringUtils.isNotBlank(fromuserId)){
				Group group = this.groupDao.findOne(gid);
				User fuser = this.userService.getEntity(fromuserId);
				if("COVER".equals(transferType)){
					List<UserPermission> userPermissions = this.userPermissionService.findByUserId(userId,"1");
					for (UserPermission userPermission : userPermissions) {
						this.userPermissionDao.delete(userPermission);
					}
					List<UserPermission> tuserPermissions = this.userPermissionService.findByUserId(userId,"0");
					for (UserPermission userPermission : tuserPermissions) {
						this.userPermissionDao.delete(userPermission);
					}
					//临时权限
					List<UserPermission> tfuserPermissions = this.userPermissionService.findByUserId(fromuserId,"0");
					for (UserPermission userPermission : tfuserPermissions) {
						UserPermission up = new UserPermission(userId, user.getRname(), userPermission.getPermissionId(), userPermission.getPermissionName()
								, userPermission.getStartTime(), userPermission.getEndTime(), new Date(), "","0",AccountUtils.getCurrentUserId(), new Date()
								,userPermission.getPermissions(),userPermission.getIsweixin());
						this.userPermissionDao.save(up);
						this.userPermissionDao.delete(userPermission);
					}
					
					//永久权限
					List<UserPermission> fuserPermissions = this.userPermissionService.findByUserId(fromuserId,"1");
					for (UserPermission userPermission : fuserPermissions) {
						UserPermission up = new UserPermission(userId, user.getRname(), userPermission.getPermissionId(), userPermission.getPermissionName()
								, userPermission.getStartTime(), userPermission.getEndTime(), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
								,userPermission.getPermissions(),userPermission.getIsweixin());
						this.userPermissionDao.save(up);
						this.userPermissionDao.delete(userPermission);
					}
					user.setPosition(fuser.getPosition());
					user.setState("1");
					user.setDeptId(fuser.getDeptId());
					user.setGroupId(gid);
					user.setUserType(fuser.getUserType());
					this.userService.save(user);
				}else {
					
					//临时权限
					List<UserPermission> tfuserPermissions = this.userPermissionService.findByUserId(fromuserId,"0");
					for (UserPermission userPermission : tfuserPermissions) {
						UserPermission up = this.userPermissionDao.findByUserIdAndPermissionIdAndTypeAndStartTimeAndEndTime(userId, userPermission.getPermissionId(),"0", userPermission.getStartTime(), userPermission.getEndTime());
						if(up==null){
							up = new UserPermission(userId, user.getRname(), userPermission.getPermissionId(), userPermission.getPermissionName()
									, userPermission.getStartTime(), userPermission.getEndTime(), new Date(), "","0",AccountUtils.getCurrentUserId(), new Date()
									,userPermission.getPermissions(),userPermission.getIsweixin());
							this.userPermissionDao.save(up);
						}		
						this.userPermissionDao.delete(userPermission);
					}
					
					//永久权限
					List<UserPermission> fuserPermissions = this.userPermissionService.findByUserId(fromuserId,"1");
					for (UserPermission userPermission : fuserPermissions) {
						UserPermission up = this.userPermissionDao.findByUserIdAndPermissionIdAndType(userId, userPermission.getPermissionId(),"1");
						if(up==null){
							up = new UserPermission(userId, user.getRname(), userPermission.getPermissionId(), userPermission.getPermissionName()
									, userPermission.getStartTime(), userPermission.getEndTime(), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
									,userPermission.getPermissions(),userPermission.getIsweixin());
							this.userPermissionDao.save(up);
						}	
						this.userPermissionDao.delete(userPermission);
					}
					/*user.setPosition(fuser.getPosition());
					user.setState("1");
					user.setDeptId(fuser.getDeptId());
					user.setGroupId(gid);
					user.setUserType(fuser.getUserType());
					this.userService.save(user);*/
					
						/*List<UserPermission> userPermissions = this.userPermissionService.findByUserId(userId,"1");
					for (UserPermission userPermission : userPermissions) {
						this.userPermissionDao.delete(userPermission);
					}
					List<UserPermission> tuserPermissions = this.userPermissionService.findByUserId(userId,"0");
					for (UserPermission userPermission : tuserPermissions) {
						this.userPermissionDao.delete(userPermission);
					}*/
				}
				
				
				
				System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>1");
				
				/*  订单数据转移  */
				if(user.getUserType().equals("HOTEL")&&group.getGroupId().startsWith("hotel")){
					System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>2");
					if(group.getGroupId().equals("hotel_sales")||group.getGroupId().equals("hotel_sales_director")){
						Map<String, Object> filterParams = Maps.newHashMap();
						filterParams.put("EQ_hotelSaleId", fuser.getId());
						filterParams.put("OR_EQ;state", "01,02,,021,04");
						List<Order> orders = this.orderService.getEntities(filterParams);
						System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>3:"+orders.size());
						for (Order order : orders) {
							order.setOriginalHotelSale(order.getHotelSaleId());
							order.setHotelSaleId(user.getId());
							this.orderDao.save(order);
						}
					}
					//20171128153923392291
					/*fuser.setGroupId(23L);
					fuser.setPosition("场地职员");*/
				}else if(user.getUserType().equals("HOTEL")&&group.getGroupId().startsWith("group")){
					/*fuser.setGroupId(24L);
					fuser.setPosition("集团职员");*/
				}else if(user.getUserType().equals("HUI")&&group.getGroupId().startsWith("company")){
					/*fuser.setGroupId(22L);
					fuser.setPosition("会掌柜职员");*/
					if(group.getGroupId().equals("company_sales")||group.getGroupId().equals("company_sales_director")){
						Map<String, Object> filterParams = Maps.newHashMap();
						filterParams.put("EQ_companySaleId", fuser.getId());
						List<Order> orders = this.orderService.getEntities(filterParams);
						for (Order order : orders) {
							order.setOriginalCompanySale(order.getCompanySaleId());
							order.setCompanySaleId(user.getId());
							this.orderDao.save(order);
						}
						
						List<Hotel> hotels =  this.hotelService.findByReclaimUserId(fuser.getId());
						for (Hotel hotel : hotels) {
							hotel.setReclaimUserId(user.getId());
							hotel.setReclaimUserName(user.getRname());
							this.hotelDao.save(hotel);
						}
					}
				}
				

				fuser.setHotelId(null);
				fuser.setDeptId(null);
				fuser.setPhtlid(null);
				fuser.setCompanyId(null);
				fuser.setUserType("CLIENT");
				fuser.setState("1");
				fuser.setGroupId(13L);
				fuser.setPosition("普通用户");
				
				this.userService.save(fuser);
			}else{
				Group group = this.groupDao.findOne(gid);
				
				if("HOTEL".equals(AccountUtils.getCurrentUserType())){
					Hotel hotel = this.hotelService.getEntity(Long.valueOf(AccountUtils.getCurrentUserHotelId()));
					user.setUserType("HOTEL");
					user.setHotelId(hotel.getId()+"");
					user.setGroupId(Long.valueOf(gid));
					user.setPosition(group.getName());
					user.setState("1");
					user.setCity(hotel.getCity());
					user.setCompanyId(hotel.getCompanyId());
					user.setPhtlid(hotel.getPid());
					user.setDeptId(group.getDeptId());
				}else{
					if(StringUtils.isNotBlank(crtusrty)&&crtusrty.equals("SITE")){
						Group tgroup = this.groupDao.findOne(user.getGroupId());
						if(tgroup.getGroupId().startsWith("group")&&group.getGroupId().startsWith("group")){
							user.setGroupId(Long.valueOf(gid));
							user.setPosition(group.getName());
						}else if(tgroup.getGroupId().startsWith("hotel")&&group.getGroupId().startsWith("hotel")){
							user.setGroupId(Long.valueOf(gid));
							user.setPosition(group.getName());
						}else{
							String msg ="集团角色不可以转换成场地角色！";
							if(tgroup.getGroupId().startsWith("hotel")){
								msg ="场地角色不可以转换成集团角色！";
							}
							return JsonUtils.error(msg);
						}
						
					}else{
						user.setUserType("HUI");
						user.setGroupId(Long.valueOf(gid));
						user.setPosition(group.getName());
						user.setState("1");
						user.setCity(76);//默认广州
						user.setCompanyId(1L);
						user.setPhtlid(null);
						user.setDeptId(group.getDeptId());
					}
					
				}
				this.userService.save(user);
				List<UserPermission> userPermissions = this.userPermissionService.findByUserId(userId,"1");
				for (UserPermission userPermission : userPermissions) {
					this.userPermissionDao.delete(userPermission);
				}
				List<Permission> permissions = group.getPermissionEntityList();
				for (Permission permission : permissions) {
					UserPermission up = new UserPermission(userId, user.getRname(), permission.getId()+"", permission.getDisplayname()
							, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
							,permission.getPermission(),permission.getType());
					up.setPermissions(permission.getPermission());
					up.setIsweixin(permission.getType());
					this.userPermissionDao.save(up);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("转移失败");
		}
		
		///**************************************<<<<<<<<<<<<<记录日志>>>>>>>>>>>>>>*******************************************************************************
		try{
			String content = "";
			Group group = this.groupDao.findOne(gid);
			if(StringUtils.isNotBlank(fromuserId)){
				User fuser = this.userService.getEntity(fromuserId);
				content =DateTimeUtils.toZHDay(new Date())+"，"+AccountUtils.getCurrentUser().getGroupName()+"【"+AccountUtils.getCurrentRName()+"】把【"+fuser.getRname()+"】的角色权限【"+group.getName()
				+"】转移给了【"+user.getRname()+"】！";
			}else{
				content =DateTimeUtils.toZHDay(new Date())+"，"+AccountUtils.getCurrentUser().getGroupName()+"【"+AccountUtils.getCurrentRName()+"】赋予了【"+user.getRname()+"】新的的角色权限【"+group.getName()+"】！";
			}
			if("HOTEL".equals(AccountUtils.getCurrentUserType())){
				Hotel hotel = this.hotelService.getEntity(Long.valueOf(AccountUtils.getCurrentUserHotelId()));
				chatRecordService.log("AUTHORTRANSFER", "权限转移操作", content,  hotel.getId(),  hotel.getHotelName(), "", "", "");
			}else{
				chatRecordService.log("AUTHORTRANSFER", "权限转移操作", content, 0L, "会掌柜", "", "", "");
			}
		}catch(Exception e){
		}
		return JsonUtils.success("转移成功");
	}
	
	@Transactional(readOnly = false)
	public JsonVo authorHR(String fromuserId, String userId, String email, String mobile, Long gid) {
		try{
			User user = this.userService.getEntity(userId);
			if(StringUtils.isNotBlank(fromuserId)){
				Group group = this.groupDao.findOne(gid);
				User fuser = this.userService.getEntity(fromuserId);
				List<UserPermission> tuserPermissions = this.userPermissionService.findByUserId(userId,"0");
				for (UserPermission userPermission : tuserPermissions) {
					this.userPermissionDao.delete(userPermission);
				}
				List<UserPermission> userPermissions = this.userPermissionService.findByUserId(userId,"1");
				for (UserPermission userPermission : userPermissions) {
					this.userPermissionDao.delete(userPermission);
				}
				
				
				List<UserPermission> tfuserPermissions = this.userPermissionService.findByUserId(fromuserId,"0");
				for (UserPermission userPermission : tfuserPermissions) {
					UserPermission up = new UserPermission(userId, user.getRname(), userPermission.getPermissionId(), userPermission.getPermissionName()
							, userPermission.getStartTime(), userPermission.getEndTime(), new Date(), "0",userPermission.getType(),AccountUtils.getCurrentUserId(), new Date()
							, userPermission.getPermissions(),userPermission.getIsweixin());
					this.userPermissionDao.save(up);
					this.userPermissionDao.delete(userPermission);
				}
				List<UserPermission> fuserPermissions = this.userPermissionService.findByUserId(fromuserId,"1");
				for (UserPermission userPermission : fuserPermissions) {
					UserPermission up = new UserPermission(userId, user.getRname(), userPermission.getPermissionId(), userPermission.getPermissionName()
							, userPermission.getStartTime(), userPermission.getEndTime(), new Date(), "1",userPermission.getType(),AccountUtils.getCurrentUserId(), new Date()
							, userPermission.getPermissions(),userPermission.getIsweixin());
					this.userPermissionDao.save(up);
					this.userPermissionDao.delete(userPermission);
				}
				
				user.setPosition(fuser.getPosition());
				user.setState("1");
				user.setDeptId(fuser.getDeptId());
				user.setGroupId(gid);
				this.userService.save(user);
				
				
				/*if(user.getUserType().equals("HOTEL")&&group.getGroupId().startsWith("hotel")){
					fuser.setGroupId(23L);
					fuser.setPosition("场地职员");
				}else if(user.getUserType().equals("HOTEL")&&group.getGroupId().startsWith("group")){
					fuser.setGroupId(24L);
					fuser.setPosition("集团职员");
				}else if(user.getUserType().equals("HUI")&&group.getGroupId().startsWith("company")){
					fuser.setGroupId(22L);
					fuser.setPosition("会掌柜职员");
				}*/
				
				
				fuser.setHotelId(null);
				fuser.setDeptId(null);
				fuser.setPhtlid(null);
				fuser.setCompanyId(null);
				fuser.setUserType("CLIENT");
				fuser.setState("1");
				fuser.setGroupId(13L);
				fuser.setPosition("普通用户");
				this.userService.save(fuser);
			}else{
				Group group = this.groupDao.findOne(gid);
				List<UserPermission> userPermissions = this.userPermissionService.findByUserId(userId,"1");
				for (UserPermission userPermission : userPermissions) {
					this.userPermissionDao.delete(userPermission);
				}
				List<Permission> permissions = group.getPermissionEntityList();
				for (Permission permission : permissions) {
					UserPermission up = new UserPermission(userId, user.getRname(), permission.getId()+"", permission.getDisplayname()
							, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date()
							, permission.getPermission(),permission.getType());
					up.setPermissions(permission.getPermission());
					up.setIsweixin(permission.getType());
					this.userPermissionDao.save(up);
				}
				if("HOTEL".equals(AccountUtils.getHotelUserType())){
					Hotel hotel = this.hotelService.getEntity(Long.valueOf(AccountUtils.getCurrentUserHotelId()));
					user.setUserType("HOTEL");
					user.setHotelId(hotel.getId()+"");
					user.setGroupId(Long.valueOf(gid));
					user.setPosition(group.getName());
					user.setState("1");
					user.setCity(hotel.getCity());
					user.setCompanyId(hotel.getCompanyId());
					//user.setPhtlid(hotel.getPid());
					//user.setDeptId(group.getDeptId());
				}else if("GROUP".equals(AccountUtils.getHotelUserType())){
					HotelGroup hotelGroup = this.hotelGroupService.getEntity(AccountUtils.getCurrentUserhotelPId());
					user.setUserType("HOTEL");
					//user.setHotelId(hotel.getId()+"");
					user.setGroupId(Long.valueOf(gid));
					user.setPosition(group.getName());
					user.setState("1");
					user.setCity(hotelGroup.getCity());
					user.setCompanyId(hotelGroup.getCompanyId());
					user.setPhtlid(hotelGroup.getId());
					//user.setDeptId(group.getDeptId());
				}else{
					user.setUserType("HUI");
					user.setGroupId(Long.valueOf(gid));
					user.setPosition(group.getName());
					user.setState("1");
					user.setCity(76);//默认广州
					user.setCompanyId(1L);
					user.setPhtlid(null);
					user.setDeptId(group.getDeptId());
				}
				this.userService.save(user);
			}
		}catch(Exception e){
			return JsonUtils.error("HR授权失败");
		}
		return JsonUtils.success("HR授权成功");
	}
	
	
}