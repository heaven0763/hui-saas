
package com.chuangbang.js.dao.account;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.js.entity.account.Logininfo;

public interface LogininfoDao  extends PagingAndSortingRepository<Logininfo, Long>, BaseRepository<Logininfo, Long>{

}


