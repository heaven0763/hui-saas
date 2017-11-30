package com.chuangbang.framework.dao.dictionary;

import java.util.List;

public interface DictionaryDaoCustom {
	public List findBySql(String sql) ;
	public List findBySql(String sql,List paras);
}
