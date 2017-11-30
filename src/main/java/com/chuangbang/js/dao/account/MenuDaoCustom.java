package com.chuangbang.js.dao.account;

import java.util.List;

import org.springframework.data.domain.Sort;

import com.chuangbang.js.entity.account.Menu;

public interface MenuDaoCustom {
	List<Menu> findRootMenuByUserId(String UserId,Sort sort);
	List<Menu> findByUserId(String UserId,Sort sort);
}
