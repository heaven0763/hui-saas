
package com.chuangbang.framework.dao.dictionary;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.framework.entity.dictionary.Dictionary;

public interface DictionaryDao  extends PagingAndSortingRepository<Dictionary, Long>,DictionaryDaoCustom,BaseRepository<Dictionary, Long>{
	List<Dictionary> findByKind(String kind);
	
	List<Dictionary> findByKindAndCode(String kind,String code);

	List<Dictionary> findByKindAndDetail(String kind, String detail);
	
	Page<Dictionary> findByKind(String kind,Pageable pageable);

	List<Dictionary> findByKindAndCodeAndSupercode(String kind, String code,
			String supercode);

	Dictionary findBySupercodeAndKindAndCode(String supercode, String string,
			String string2);

	Dictionary findBySupercodeAndKindAndDetail(String supercode, String kind,
			String detail);

	List<Dictionary> findByKindAndSupercode(String kind, String superCode);
	
	List<Dictionary> findBySupercode(String superCode);
	
}


