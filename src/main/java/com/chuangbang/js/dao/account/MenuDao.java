
package com.chuangbang.js.dao.account;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.js.entity.account.Menu;

public interface MenuDao  extends PagingAndSortingRepository<Menu, Long>,MenuDaoCustom,BaseRepository<Menu, Long>{
	List<Menu> findByparentId(Long parentId,Sort sort);
	List<Menu> findByParentId(String parentId);
}


