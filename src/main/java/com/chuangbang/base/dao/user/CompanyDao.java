package com.chuangbang.base.dao.user;

import com.chuangbang.base.entity.user.Company;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 企业信息DAO接口
 * @author heaven
 * @version 2016-11-18
 */
public interface CompanyDao extends BaseRepository<Company, Long>,PagingAndSortingRepository<Company, Long>{

}