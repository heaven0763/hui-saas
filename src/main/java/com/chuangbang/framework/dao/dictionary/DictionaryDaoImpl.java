package com.chuangbang.framework.dao.dictionary;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Component;


@Component
public class DictionaryDaoImpl implements DictionaryDaoCustom{
	
	@PersistenceContext
	private EntityManager em;
	
	@Override
	public List findBySql(String sql) {

		
		
		Query qry = em.createNativeQuery(sql);
		

		return qry.getResultList();
	}
	
	@Override
	public List findBySql(String sql,List paras) {

		
		
		Query qry = em.createNativeQuery(sql);
		if(paras!=null&&paras.size()>0){
			for(int i=0;i<paras.size();i++)
				qry.setParameter(i+1,paras.get(i));
		}
		

		return qry.getResultList();
	}
}
