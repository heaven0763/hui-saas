
package com.chuangbang.framework.dao.system;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.framework.entity.system.SystemParameter;

public interface SystemParameterDao  extends PagingAndSortingRepository<SystemParameter, Long>,BaseRepository<SystemParameter, Long>{
	List<SystemParameter> findByCode(String code);
}


