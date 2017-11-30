
package com.chuangbang.js.dao.account;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.js.entity.account.Department;

public interface DepartmentDao  extends PagingAndSortingRepository<Department, Long>,BaseRepository<Department, Long>{
	public Department findByUnitcode(String unitcode);
}


