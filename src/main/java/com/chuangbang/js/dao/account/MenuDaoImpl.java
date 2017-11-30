package com.chuangbang.js.dao.account;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.domain.Sort;

import com.chuangbang.js.entity.account.Menu;

public class MenuDaoImpl implements MenuDaoCustom{
	
	@PersistenceContext
	private EntityManager em;
	
	private static final String QUERY_MENU_BY_USERID = "select distinct m from User u left join u.groupList g left join  g.menuList m  where u.id=? order by m.orderId";
	private static final String QUERY_ROOT_MENU_BY_USERID = "select distinct m from User u left join u.groupList g  left join  g.menuList m  where u.id=? and m.parentId=0  order by m.orderId";
	private static final String QUERY_MENU_BY_USERID_AND_PARENTID = "select distinct m from User u left join u.groupList g  left join  g.menuList m  where u.id=? and m.parentId=?  order by m.orderId";
	
	
	
	

	@Override
	public List<Menu> findRootMenuByUserId(String UserId, Sort sort) {
		List<Menu> menus = em.createQuery(QUERY_ROOT_MENU_BY_USERID).setParameter(1, UserId).getResultList();
		setAuthorizedChildrenMenu(menus,UserId);
		return menus;
	}

	@Override
	public List<Menu> findByUserId(String UserId, Sort sort) {
		List<Menu> menus = em.createQuery(QUERY_MENU_BY_USERID).setParameter(1, UserId).getResultList();
		return menus;
	}
	
	private void setAuthorizedChildrenMenu(List<Menu> menus,String UserId){
		for(Menu menu:menus){
			List<Menu> childMenus = em.createQuery(QUERY_MENU_BY_USERID_AND_PARENTID).setParameter(1, UserId).setParameter(2, menu.getId()).getResultList();
			if(childMenus.size() > 0){
				menu.setAuthorizedChildrenMenuList(childMenus);
				//递归调用
				setAuthorizedChildrenMenu(childMenus,UserId);
			}
		}
	}
}
