package com.chuangbang.js.service.account;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.Tree;
import com.chuangbang.js.dao.account.GroupDao;
import com.chuangbang.js.dao.account.MenuDao;
import com.chuangbang.js.dao.account.UserDao;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.Menu;
import com.google.common.collect.Lists;

@Component

@Transactional(readOnly = true)
public class MenuService extends BaseService<Menu, MenuDao>{

	@Autowired
	private MenuDao menuDao;
	
	@Autowired
	private GroupDao groupDao;
	
	@Autowired
	private UserDao userDao;

	public Menu getMenu(Long id) {
		return menuDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveMenu(Menu entity) {
		menuDao.save(entity);
	}

	@Transactional(readOnly = false)
	public void deleteMenu(Long id) throws SQLException {
		menuDao.delete(id);
	}
	
	public List<Menu> getAllMenu() {
		return menuDao.findAll(new Sort(Direction.ASC, "parentId","orderId"));
	}
	
	public Page<Menu> getMenuByPage(PageRequest pr) {
		return  menuDao.findAll(pr);
	}

	public List<Menu> getRootMenuByUserId(String userid){
		return menuDao.findRootMenuByUserId(userid, new Sort(Direction.ASC,"orderId"));
	}
	
	public List<Menu> getRootMenuByUserLoginName(String loginName){
		return getRootMenuByUserId(userDao.findByUsername(loginName).getId());
	}
	
	public List<Menu> getByGroupId(Long groupId){
		return groupDao.findOne(groupId).getMenuList();
	}
	public List<Menu> getByParentId(Long parentId){
		return menuDao.findByparentId(parentId,new Sort(Direction.ASC,"orderId"));
	}

	@Override
	@Transactional(readOnly = false)
	public void batchDelete(Long[] ids) {
		menuDao.batchDelete(ids);
	}
	
	/**
	 * 获取当前用户已授权的菜单
	 * @return
	 */
	public List<Menu> getAuthRootMenus(){
		Group group = groupDao.findOne(AccountUtils.getCurrentUser().getGroupId());
		List<Menu> authRootMenus = Lists.newArrayList();
		for(Menu menu:group.getMenuList()){
			if(menu.getParentId() == 0){
				authRootMenus.add(menu);
				setMenus(group,menu);
			}
		}
		return authRootMenus;
	}
	
	public List<Menu> getSysAuthRootMenus(Long id){
		List<Menu> authRootMenus = Lists.newArrayList();
		if(id == null || AccountUtils.getCurrentUser().getGroupId() == null){	////为了注册用户在未分配角色时能登录
			return authRootMenus;
		}
		Group group =  groupDao.findOne(AccountUtils.getCurrentUser().getGroupId());
		List<Menu> menus = group.getMenuList();
		System.out.println(authRootMenus.size());
		for(Menu menu:menus){
			if(menu.getParentId().equals(id)){
				authRootMenus.add(menu);
				setMenus(group,menu);
			}
		}
		return authRootMenus;
	}
	
	
	public List<Menu> getSysAuthRootMenus(String isweixin,Long id,List<Long> menuIds){
		List<Menu> authRootMenus = Lists.newArrayList();
		if(id == null || AccountUtils.getCurrentUser().getGroupId() == null){	////为了注册用户在未分配角色时能登录
			return authRootMenus;
		}
		Group group =  groupDao.findOne(AccountUtils.getCurrentUser().getGroupId());
		List<Menu> menus = group.getMenuList();
		
		for (Long mid : menuIds) {
			Menu menu = this.getEntity(mid);
			System.out.println(">>>>>"+menu.getId()+">>>>>"+menu.getParentId()+">>>>>"+menu.getName());
			if(menu.getParentId().equals(id)){
				if(("1".equals(isweixin) &&"1".equals(menu.getIsweixin())) || ("0".equals(isweixin)  &&"0".equals(menu.getIsweixin()))){
					if(menu.getParentId()!=null){
						Menu pmenu = this.getEntity(menu.getParentId());
						if(pmenu.getParentId()!=null){
							Menu gpmenu = this.getEntity(pmenu.getParentId());
							if(gpmenu!=null&&!menus.contains(gpmenu)){
								menus.add(gpmenu);
							}
						}
						if(pmenu!=null&&!menus.contains(pmenu)){
							menus.add(pmenu);
						}
					}
					if(menu!=null&&!menus.contains(menu)){
						menus.add(menu);
					}
				}else if("1".equals(isweixin)  &&"0".equals(menu.getIsweixin())){
					if(menu.getParallelismmenuId()!=null){
						Menu jmenu = this.getEntity(menu.getParallelismmenuId());
						if(jmenu.getParentId()!=null){
							Menu pmenu = this.getEntity(jmenu.getParentId());
							if(pmenu.getParentId()!=null){
								Menu gpmenu = this.getEntity(pmenu.getParentId());
								if(gpmenu!=null&&!menus.contains(gpmenu)){
									menus.add(gpmenu);
								}
							}
							if(pmenu!=null&&!menus.contains(pmenu)){
								menus.add(pmenu);
							}
						}
						if(menu!=null&&!menus.contains(jmenu)){
							menus.add(jmenu);
						}
					}
				}else if("0".equals(isweixin)  && "1".equals(menu.getIsweixin())){
					if(menu.getParallelismmenuId()!=null){
						Menu jmenu = this.getEntity(menu.getParallelismmenuId());
						if(jmenu.getParentId()!=null){
							Menu pmenu = this.getEntity(jmenu.getParentId());
							if(pmenu.getParentId()!=null){
								Menu gpmenu = this.getEntity(pmenu.getParentId());
								if(gpmenu!=null&&!menus.contains(gpmenu)){
									menus.add(gpmenu);
								}
							}
							if(pmenu!=null&&!menus.contains(pmenu)){
								menus.add(pmenu);
							}
						}
						if(menu!=null&&!menus.contains(jmenu)){
							menus.add(jmenu);
						}
					}
				}else{
				}
			}
		}
		
		System.out.println(authRootMenus.size());
		for(Menu menu:menus){
			System.out.println(">>>>>"+menu.getId()+">>>>>"+menu.getName());
			if(menu.getParentId().equals(id)){
				authRootMenus.add(menu);
				setMenus(group,menu);
			}
		}
		return authRootMenus;
	}
	
	
	public List<Menu> getSysAuthRootMenus(Long id,List<Long> menuIds){
		List<Menu> authRootMenus = Lists.newArrayList();
		if(id == null || AccountUtils.getCurrentUser().getGroupId() == null){	////为了注册用户在未分配角色时能登录
			return authRootMenus;
		}
		Group group =  groupDao.findOne(AccountUtils.getCurrentUser().getGroupId());
		List<Menu> menus = group.getMenuList();
		if(menuIds!=null){
			for (Long mid : menuIds) {
				Menu menu = this.getEntity(mid);
				if((id==7 &&"1".equals(menu.getIsweixin())) || (id==6 &&"0".equals(menu.getIsweixin()))){
					if(menu.getParentId()!=null){
						Menu pmenu = this.getEntity(menu.getParentId());
						if(pmenu.getParentId()!=null){
							Menu gpmenu = this.getEntity(pmenu.getParentId());
							if(gpmenu!=null&&!menus.contains(gpmenu)){
								menus.add(gpmenu);
							}
						}
						if(pmenu!=null&&!menus.contains(pmenu)){
							menus.add(pmenu);
						}
					}
					if(menu!=null&&!menus.contains(menu)){
						menus.add(menu);
					}
				}else if(id==7 &&"0".equals(menu.getIsweixin())){
					if(menu.getParallelismmenuId()!=null){
						Menu jmenu = this.getEntity(menu.getParallelismmenuId());
						if(jmenu.getParentId()!=null){
							Menu pmenu = this.getEntity(jmenu.getParentId());
							if(pmenu.getParentId()!=null){
								Menu gpmenu = this.getEntity(pmenu.getParentId());
								if(gpmenu!=null&&!menus.contains(gpmenu)){
									menus.add(gpmenu);
								}
							}
							if(pmenu!=null&&!menus.contains(pmenu)){
								menus.add(pmenu);
							}
						}
						if(menu!=null&&!menus.contains(jmenu)){
							menus.add(jmenu);
						}
					}
				}else if(id==6 && "1".equals(menu.getIsweixin())){
					if(menu.getParallelismmenuId()!=null){
						Menu jmenu = this.getEntity(menu.getParallelismmenuId());
						if(jmenu.getParentId()!=null){
							Menu pmenu = this.getEntity(jmenu.getParentId());
							if(pmenu.getParentId()!=null){
								Menu gpmenu = this.getEntity(pmenu.getParentId());
								if(gpmenu!=null&&!menus.contains(gpmenu)){
									menus.add(gpmenu);
								}
							}
							if(pmenu!=null&&!menus.contains(pmenu)){
								menus.add(pmenu);
							}
						}
						if(menu!=null&&!menus.contains(jmenu)){
							menus.add(jmenu);
						}
					}
				}else{
				}
			}
		}
		for(Menu menu:menus){
			System.out.println(">>>>>"+menu.getId()+">>>>>"+menu.getName());
			if(menu.getParentId().equals(id)){
				authRootMenus.add(menu);
				setMenus(menus,menu);
			}
		}
		
		return authRootMenus;
	}
	
	public List<Menu> getWebChatAuthRootMenus(Long id){
		Group group = groupDao.findOne(AccountUtils.getCurrentUser().getGroupId());
		List<Menu> authRootMenus = Lists.newArrayList();
		for(Menu menu:group.getMenuList()){
			if(menu.getParentId() == id){
				authRootMenus.add(menu);
				setMenus(group,menu);
			}
		}
		return authRootMenus;
	}
	
	
	
	/**
	 * 供getAuthRootMenus()调用
	 * @param group
	 * @param pMenu
	 */
	public void setMenus(Group group,Menu pMenu){
		pMenu.getAuthorizedChildrenMenuList().clear();
		for(Menu menu:group.getMenuList()){
			if(menu.getParentId().equals(pMenu.getId())){
				pMenu.getAuthorizedChildrenMenuList().add(menu);
				setMenus(group,menu);
			}
		}
	}
	/**
	 * 供getAuthRootMenus()调用
	 * @param group
	 * @param pMenu
	 */
	public void setMenus(List<Menu> menus,Menu pMenu){
		pMenu.getAuthorizedChildrenMenuList().clear();
		for(Menu menu:menus){
			if(menu.getParentId().equals(pMenu.getId())){
				pMenu.getAuthorizedChildrenMenuList().add(menu);
				setMenus(menus,menu);
			}
		}
	}
	
	/**
	 * 获取菜单的easyui树形结构
	 * @param groupId
	 * @return
	 */
	public List<Tree> tree(Long groupId){
		List<Menu> menus = Lists.newArrayList();
		if(SecurityUtils.getSubject().hasRole("administrator")){
			menus =this.getAllMenu();
		}else{
			System.out.println("curt gid>>>"+AccountUtils.getCurrentUser().getGroupId());
			menus = this.getByGroupId(AccountUtils.getCurrentUser().getGroupId());
			System.out.println(menus.size());
		}	
		
		List<Menu> gmenus = Lists.newArrayList();
		List<Long> mids = Lists.newArrayList();
		if(groupId!=null&&groupId!=0){
			gmenus=this.getByGroupId(groupId);
			for (Menu gm : gmenus) {
				mids.add(gm.getId());
			}
		}
		List<Tree> lt = new ArrayList<Tree>();
		
		if (menus != null && menus.size() > 0) {
			for (Menu m : menus) {
				if(m.getParentId()==0){
					
					Tree tree = new Tree();
					BeanUtils.copyProperties(m, tree);
					tree.setText(m.getName());
					tree.setIconCls("");
					Map<String, Object> attr = new HashMap<String, Object>();
					attr.put("url", m.getUrl());
					tree.setAttributes(attr);
					
					List<Tree> cht = new ArrayList<Tree>();
					List<Menu> childrenmenus = new ArrayList<Menu>();
					childrenmenus=this.getByParentId(menus,m.getId());
					if(childrenmenus.size()>0){
						for (Menu chm : childrenmenus) {
							Tree chtree = new Tree();
							BeanUtils.copyProperties(chm, chtree);
							chtree.setPid(chm.getParentId().toString());
							chtree.setText(chm.getName());
							chtree.setIconCls("");
							chtree.setState(null);
							Map<String, Object> chattr = new HashMap<String, Object>();
							chattr.put("url", chm.getUrl());
							chtree.setAttributes(chattr);
							if(mids.size()>0 && mids.contains(chm.getId())){
								chtree.setChecked(true);
							}
							List<Tree> gcht = new ArrayList<Tree>();
							List<Menu> gchrmenus = new ArrayList<Menu>();
							gchrmenus=this.getByParentId(menus,chm.getId());
							if(gchrmenus.size()>0){
								chtree.setChecked(false);
								for (Menu gchm : gchrmenus) {
									Tree gchtree = new Tree();
									BeanUtils.copyProperties(gchm, gchtree);
									gchtree.setPid(gchm.getParentId().toString());
									gchtree.setText(gchm.getName());
									gchtree.setIconCls("");
									gchtree.setState(null);
									Map<String, Object> gchattr = new HashMap<String, Object>();
									gchattr.put("url", gchm.getUrl());
									gchtree.setAttributes(gchattr);
									if(mids.size()>0 && mids.contains(gchm.getId())){
										gchtree.setChecked(true);
									}
									
									List<Tree> ggcht = new ArrayList<Tree>();
									List<Menu> ggchrmenus = new ArrayList<Menu>();
									ggchrmenus=this.getByParentId(menus,gchm.getId());
									if(ggchrmenus.size()>0){
										gchtree.setChecked(false);
										for (Menu ggchm : ggchrmenus) {
											Tree ggchtree = new Tree();
											BeanUtils.copyProperties(ggchm, ggchtree);
											ggchtree.setPid(ggchm.getParentId().toString());
											ggchtree.setText(ggchm.getName());
											ggchtree.setIconCls("");
											ggchtree.setState(null);
											Map<String, Object> ggchattr = new HashMap<String, Object>();
											ggchattr.put("url", gchm.getUrl());
											ggchtree.setAttributes(ggchattr);
											if(mids.size()>0 && mids.contains(ggchm.getId())){
												ggchtree.setChecked(true);
											}
											ggcht.add(ggchtree);
										}
									}
									gchtree.setChildren(ggcht);
									gcht.add(gchtree);
								}
							}
							
							chtree.setChildren(gcht);
							cht.add(chtree);
						}
					}
					
					tree.setChildren(cht);
					lt.add(tree);
				}
				
			}
		}
		return lt;
	}

	public List<Menu> getByParentId(List<Menu> menus, Long id) {
		List<Menu> result = Lists.newArrayList();
		for (Menu menu : menus) {
			if(menu.getParentId().equals(id)){
				result.add(menu);
			}
		}
		return result;
	}
}