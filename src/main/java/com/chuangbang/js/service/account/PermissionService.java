package com.chuangbang.js.service.account;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.chuangbang.js.dao.account.PermissionDao;
import com.chuangbang.js.entity.account.Menu;
import com.chuangbang.js.entity.account.Permission;
import com.google.common.collect.Lists;

/**
 * 安全相关实体的管理类,包括用户和权限组.
 * 
 * @author Heaven
 */
//Spring Bean的标识.
@Component
//默认将类中的所有public函数纳入事务管理.
@Transactional(readOnly = true)
public class PermissionService extends BaseService<Permission, PermissionDao>{

	private static Logger logger = LoggerFactory.getLogger(PermissionService.class);

	@Autowired
	private PermissionDao permissionDao;

	@Autowired
	private GroupService groupService;
	
	@Autowired
	private GroupDao groupDao;
	@Autowired
	private MenuService menuService;
	
	//-- User Manager --//
	public Permission getPermission(Long id) {
		return permissionDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void savePermission(Permission entity) {
		permissionDao.save(entity);
	}

	@Transactional(readOnly = false)
	public void deletePermission(Long id) {
		permissionDao.delete(id);
	}

	public List<Permission> getAllPermission() {
		return permissionDao.findAll(new Sort(Direction.ASC, "id"));
	}

	public Page<Permission> getPermissionByPage(PageRequest pageRequest) {
		return permissionDao.findAll(pageRequest);
	}

	@Override
	@Transactional(readOnly = false)
	public void batchDelete(Long[] ids) {
		permissionDao.batchDelete(ids);
	}
	
	/**
	 * 返回权限的树形结构，供eaysui的tree使用，但不会包括行选中checkbox功能
	 * @param groupId
	 * @return
	 */
	/*@Cacheable(value = { "DEFAULT_CACHE" })*/
	public List<Tree> tree(Long groupId) {
		System.out.println("groupId  >>　" + groupId);
		List<Permission> pPermissions = Lists.newArrayList();
		if(SecurityUtils.getSubject().hasRole("administrator")){
			pPermissions = permissionDao.findByParentId(0L);
		}else{
			pPermissions = this.findRootByGroupId(AccountUtils.getCurrentUser().getGroupId());
			System.out.println(">>>>>>>>>"+pPermissions.size());
		}
		List<Tree> trees = new ArrayList<Tree>();
		getChildPermissions(trees,pPermissions);
		return trees;
	}
	
	private List<Permission> findRootByGroupId(Long gid) {
		List<Permission> permissions = Lists.newArrayList();
		List<Permission>  list= this.getAllEntities();
		System.out.println(">>>>>>>>>"+list.size());
		for (Permission permission : list) {
			System.out.println(permission.getDisplayname());
			if(permission.getParentId()==0){
				permissions.add(permission);
			}
		}
		return permissions;
	}
	
	private List<Permission> findGroupId(Long gid,Long parentId) {
		List<Permission> permissions = Lists.newArrayList();
		List<Permission> list = this.groupDao.findOne(gid).getPermissionEntityList();
		for (Permission permission : list) {
			if(permission.getParentId()==parentId){
				permissions.add(permission);
			}
		}
		return permissions;
	}
	
	
	private List<Permission> findByGroupId(Long gid) {
		List<Permission> list = this.groupDao.findOne(gid).getPermissionEntityList();
		return list;
	}

	/**
	 * 供List<Tree> tree(Long groupId)使用的
	 * @param trees
	 * @param pPermissions
	 */
	private void getChildPermissions(List<Tree> trees,List<Permission> pPermissions){
		Tree tree = null;
		List<Permission> childPermissions = null;
		List<Tree> childTrees = null;
		if(pPermissions != null){
			for(Permission p:pPermissions){
					tree = new Tree();
					tree.setId(p.getId());
					tree.setText(p.getDisplayname());
					if(SecurityUtils.getSubject().hasRole("administrator")){
						childPermissions =this.permissionDao.findByParentId(p.getId());
					}else{
						childPermissions = this.findGroupId(AccountUtils.getCurrentUser().getGroupId(),p.getId());
					}
					childTrees = new ArrayList<Tree>();
					getChildPermissions(childTrees,childPermissions);
					if(childPermissions != null && childPermissions.size() > 0){
						tree.setChildren(childTrees);
					}else {
						if(p.getParentId() != 0){
							tree.setState(null);
						}else{
							continue;
						}
					}
					trees.add(tree);
			}
		}
	}
	
	
	/**
	 * 获取菜单的easyui树形结构
	 * @param groupId
	 * @return
	 */
	public List<Tree> treeMenuPms(Long groupId){
		List<Menu> menus = Lists.newArrayList();
		if(SecurityUtils.getSubject().hasRole("administrator")){
			menus =this.menuService.getAllMenu();
		}else{
			menus = this.menuService.getByGroupId(AccountUtils.getCurrentUser().getGroupId());
		}	
		
		List<Menu> gmenus = Lists.newArrayList();
		List<Long> mids = Lists.newArrayList();
		if(groupId!=null&&groupId!=0){
			gmenus=this.menuService.getByGroupId(groupId);
			for (Menu gm : gmenus) {
				mids.add(gm.getId());
			}
		}
		List<Permission> gpms = Lists.newArrayList();
		List<Long> pids = Lists.newArrayList();
		if(groupId!=null&&groupId!=0){
			gpms=this.findByGroupId(groupId);
			for (Permission p : gpms) {
				pids.add(p.getId());
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
					List<Menu> childrenmenus = new ArrayList<Menu>();
					childrenmenus=this.menuService.getByParentId(menus,m.getId());
					
					List<Tree> cht = new ArrayList<Tree>();
					getMenuPmsTree(menus,m,cht,childrenmenus,pids);
					tree.setChildren(cht);
					
					lt.add(tree);
				}
					
			}
		}
		return lt;
	}

	private void getMenuPmsTree(List<Menu> allmenus,Menu menu,List<Tree> lt, List<Menu> menus,List<Long> pids) {
		if (menus != null && menus.size() > 0) {
			for (Menu m : menus) {
				Tree tree = new Tree();
				BeanUtils.copyProperties(m, tree);
				tree.setText(m.getName());
				tree.setIconCls("");
				Map<String, Object> attr = new HashMap<String, Object>();
				attr.put("url", m.getUrl());
				tree.setAttributes(attr);
				List<Tree> cht = new ArrayList<Tree>();
				List<Menu> childrenmenus = new ArrayList<Menu>();
				childrenmenus=this.menuService.getByParentId(allmenus, m.getId());
				getMenuPmsTree(allmenus,m,cht,childrenmenus,pids);
				tree.setChildren(cht);
				lt.add(tree);
			}
		}else{
			List<Permission> permissions = this.permissionDao.findByMenuId(menu.getId());
			for (Permission permission : permissions) {
				Tree tree = new Tree();
				tree.setId(permission.getId());
				tree.setText(permission.getDisplayname());
				tree.setState(null);
				if(pids.size()>0 && pids.contains(permission.getId())){
					tree.setChecked(true);
				}
				lt.add(tree);
			}
		}
	}
}