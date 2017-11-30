package com.chuangbang.framework.dao;

import java.io.Serializable;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.support.SimpleJpaRepository;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import com.chuangbang.framework.util.page.PageBean;



@NoRepositoryBean
public class BaseRepositoryImpl<T, ID extends Serializable>
extends SimpleJpaRepository<T, ID> implements BaseRepository<T, ID> {

	private EntityManager entityManager;

	// There are two constructors to choose from, either can be used.
	public BaseRepositoryImpl(Class<T> domainClass, EntityManager entityManager) {
	  super(domainClass, entityManager);
	
	  // This is the recommended method for accessing inherited class dependencies.
	  this.entityManager = entityManager;
	}
	
	@Override
	public List<T> findEntitiesByJpql(String jpql,List<Object> paras) {

		//不分页查询
		Pageable pageable = new PageRequest(0,265535);
		
		return findEntitiesByJpql(jpql,paras,pageable).getContent();
	}
		
	@Override
	public Page<T> findEntitiesByJpql(String jpql,List<Object> paras,Pageable pageable){
		Query qry = entityManager.createQuery(jpql);
		if(paras!=null && paras.size()>0){
			for(int i=0;i<paras.size();i++)
				qry.setParameter(i+1,paras.get(i));
		}
		//用新方式实现count，原来的方式很耗资源
		String countQueryString = " select count (*) " + removeSelect(removeOrders(jpql));
		Long totalCount = getCount(countQueryString, paras);  
		
		qry.setFirstResult(pageable.getOffset());
		qry.setMaxResults(pageable.getPageSize());
		return new PageImpl(qry.getResultList(), pageable, totalCount.longValue());
	}
	
	@Override
	public List<T> findEntitiesByJpql(String jpql,List<Object> paras,PageBean<T> pageBean){
		Query qry = entityManager.createQuery(jpql);
		if(paras!=null && paras.size()>0){
			for(int i=0;i<paras.size();i++)
				qry.setParameter(i+1,paras.get(i));
		}
		//用新方式实现count，原来的方式很耗资源
		String countQueryString = " select count (*) " + removeSelect(removeOrders(jpql));
		int totalCount = (getCount(countQueryString, paras)).intValue(); 
		if (pageBean.getTotalCount()==null ||  pageBean.getTotalCount()==0) {
			pageBean.setTotalCount((long)totalCount);
		}
		pageBean.setPageNumShown(pageBean.getTotalPage());
		qry.setFirstResult(pageBean.getFirstRec());
		qry.setMaxResults(pageBean.getRows());
		return qry.getResultList();
	}
	
	@Override
	public List<T> findCommonEntitiesByJpql(String jpql,List<Object> paras){
		//不分页查询
		Pageable pageable = new PageRequest(0,265535);
		
		return findEntitiesByJpql(jpql,paras,pageable).getContent();
	}
	@Override
	public List<?> findCommonEntitiesByJpql(String jpql,List<Object> paras,Pageable pabl){
		Query qry = entityManager.createQuery(jpql);
		if(paras!=null && paras.size()>0){
			for(int i=0;i<paras.size();i++)
				qry.setParameter(i+1,paras.get(i));
		}
		qry.setFirstResult(pabl.getOffset());
		qry.setMaxResults(pabl.getPageSize());
		return qry.getResultList();
	}
	
	@Override
	public List executeNativeQuery(final String nnq, final List<Object> params,final Class returnType,
			final int begin, final int max) {
		
		Query query = null;
		if(returnType!=null){
			query = entityManager.createNativeQuery(nnq,returnType);
		}else{
			query = entityManager.createNativeQuery(nnq);
		}
		
		int parameterIndex = 1;
		if (params != null && params.size() > 0) {
			for (Object obj : params) {
				query.setParameter(parameterIndex++, obj);
			}
		}
		if (begin >= 0 && max > 0) {
			query.setFirstResult(begin);
			query.setMaxResults(max);
		}
		return query.getResultList();
			
	}
	
	@Override
	public List executeNativeQuery(final String nnq, final List<Object> params,
			final int begin, final int max) {
		return executeNativeQuery(nnq,params,null,begin,max);
	}
	
	@Override
	@Transactional(readOnly = true)
	public List executeNativeQuery(final String nnq, final List<Object> params) {
		return executeNativeQuery(nnq, params,-1,-1);
	}
	
	@Override
	@Transactional(readOnly = false)
	public int executeNativeSQL(final String nnq) {

		Query query = entityManager.createNativeQuery(nnq);
		return query.executeUpdate();
	}
	
	@Override
	public int executeNativeSQL(String nnq, List<Object> params) {
		Query query = entityManager.createNativeQuery(nnq);
		int parameterIndex = 1;
		if (params != null && params.size() > 0) {
			for (Object obj : params) {
				query.setParameter(parameterIndex++, obj);
			}
		}
		return query.executeUpdate();
	}
	
	@Override
	@Transactional(readOnly = false)
	public int batchUpdate(final String jpql, final List<Object> params) {
		Query query = entityManager.createQuery(jpql);
		int parameterIndex = 1;
		if (params != null && params.size() > 0) {
			for (Object obj : params) {
				query.setParameter(parameterIndex++, obj);
			}
		}
		return query.executeUpdate();
	}
	/** 
	 * 去除orderby 子句 
	 */  
	private static String removeOrders(String hql) {  
	    Assert.hasText(hql);  
	    Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*", Pattern.CASE_INSENSITIVE);  
	    Matcher m = p.matcher(hql);  
	    StringBuffer sb = new StringBuffer();  
	    while (m.find()) {  
	        m.appendReplacement(sb, "");  
	    }  
	    m.appendTail(sb);  
	    return sb.toString();  
	}  
	/** 
	 * 去除select 子句，未考虑union的情况 
	 */  
	private static String removeSelect(String hql) {  
	    Assert.hasText(hql);  
	    int beginPos = hql.toLowerCase().indexOf("from");  
	    Assert.isTrue(beginPos != -1, " hql : " + hql + " must has a keyword 'from'");  
	    return hql.substring(beginPos);  
	}
	
	@Override
	public Long getCount(String jpql,List<Object> paras){
		Query qry = entityManager.createQuery(jpql);
		if(paras!=null && paras.size()>0){
			for(int i=0;i<paras.size();i++)
				qry.setParameter(i+1,paras.get(i));
		}
		Long totalCount = (Long) qry.getResultList().get(0);
		return totalCount;
	}

	@Override
	public void batchDelete(ID[] ids) {
		for (int i = 0; i < ids.length; i++) {
			this.delete(ids[i]);
		}
	}
	
	@Override
	public void clear(){
		entityManager.clear();
	}

	@Override
	public String getSeqNum() {
		Query query = entityManager.createNativeQuery("{Call P_GetNewSeqVal_SeqT_0101001()}");
		List list =query.getResultList();  
		return list.get(0).toString();
	}

	@Override
	public int querydelete(String jpql) {
		Query qry = entityManager.createQuery(jpql);
		return qry.executeUpdate();
	}
	
	
}