package com.chuangbang.framework.dao;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.NoRepositoryBean;

import com.chuangbang.framework.util.page.PageBean;


/**
 * 公共接口，实现基本的功能
 * */
@NoRepositoryBean
public interface BaseRepository<T, ID extends Serializable> extends JpaRepository<T, ID>, JpaSpecificationExecutor<T> {
/*	void sharedCustomMethod(ID id);*/
	/**
	 * 基本的jpql查询
	 * */
	public List<T> findEntitiesByJpql(String jpql,List<Object> paras);
	/**
	 * 基本的jpql查询，分页
	 * */
	public Page<T> findEntitiesByJpql(String jpql,List<Object> paras,Pageable pageable);
	
	/**
	 * 查找其他实体的jpql查询
	 * */
	public List<T> findCommonEntitiesByJpql(String jpql,List<Object> paras);
	/**
	 * 原生sql查询 加类型和参数
	 * */
	public List executeNativeQuery(final String nnq, final List<Object> params,final Class returnType,
			final int begin, final int max);
	/**
	 * 使用数据特定的语句进行查询如:oracle特定的语句
	 * @param nnq
	 * @param params
	 * @param begin
	 * @param max
	 * @return
	 */
	public List executeNativeQuery(final String nnq, final List<Object> params,
			final int begin, final int max);
	/**
	 * 使用数据特定的语句进行查询如:oracle特定的语句
	 * @param nnq
	 * @param params
	 * @return
	 */
	public List executeNativeQuery(final String nnq, final List<Object> params);

	/**
	 * 执行sql语句
	 * */
	public int executeNativeSQL(final String nnq);

	public int executeNativeSQL(String nnq, List<Object> params);
	/**
	 * 执行jpql语句
	 * */
	public int batchUpdate(final String jpql, final List<Object> params);
	/**
	 * 查找其他实体的jpql查询，分页
	 * */
	public List<?> findCommonEntitiesByJpql(String jpql, List<Object> paras,
			Pageable pageable);
	/**
	 * 批量删除
	 * @param ids
	 */
	public void batchDelete(ID[] ids);
	
	/**
	 * 执行jpql，结合dwz的pageBean进行分页
	 * @param jpql
	 * @param paras
	 * @param pageBean
	 * @return
	 */
	public List<T> findEntitiesByJpql(String jpql, List<Object> paras, PageBean<T> pageBean);
	
	public String getSeqNum();
	
	public Long getCount(String jpql,List<Object> paras);
	/**
	 * 清除缓存，进行一次同步
	 */
	public void clear();
	
	public int querydelete(String jpql);
}
