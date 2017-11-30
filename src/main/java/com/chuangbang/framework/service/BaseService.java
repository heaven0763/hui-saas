package com.chuangbang.framework.service;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import jodd.util.StringUtil;
import net.sf.ehcache.hibernate.management.impl.BeanUtils;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.ConversionService;
import org.springframework.core.convert.support.DefaultConversionService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.framework.entity.IdEntity;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.hibernate.persistence.DynamicSpecifications;
import com.chuangbang.framework.util.hibernate.persistence.SearchFilter;
import com.chuangbang.framework.util.page.PageBean;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Maps;


public class BaseService<T,TDao> {
	
	protected static Logger logger = LoggerFactory.getLogger(BaseService.class);
	
	protected Class<T> entityClass;                       //实体类    
	
	protected TDao tDao;
	
	//由org.codehaus.jackson.map.ObjectMapper改为com.fasterxml.jackson.databind.ObjectMapper
	//这样就可以使用@JsonIgnore来避免无限循环
    ObjectMapper mapper = new ObjectMapper(); 
    
    private static final ConversionService conversionService = new DefaultConversionService();
	
	
	public T getEntity(Long id) {
		return (T) ((CrudRepository) tDao).findOne(id);
	}
	public T getEntity(String id) {
		return (T) ((CrudRepository) tDao).findOne(id);
	}
	
	public T getOne(Integer id) {
		return (T) ((CrudRepository) tDao).findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveEntity(T entity) {
		
		  //设置json 格式
		mapper.setDateFormat(new SimpleDateFormat(DateTimeUtils.PATTERN_TO_SECOND));
		
		//默认设置最后修改人
		setProperty(entity, "setupUpdateOperator", AccountUtils.getCurrentUserId());
		//默认设置最后修改时间
		setProperty(entity, "setupUpdateTime", AccountUtils.getCurrentDate());
		
		setProperty(entity, "operator", AccountUtils.getCurrentUser().getRname());
		
		//设置创建人和创建时间
		if(((IdEntity) entity).getId() == null){
			setProperty(entity, "setupOperator", AccountUtils.getCurrentUserId());
			setProperty(entity, "setupOperateTime", AccountUtils.getCurrentDate());
		}else{
			T _entity = (T) ((CrudRepository) tDao).findOne(((IdEntity) entity).getId());
			try {
				logger.debug( "修改前："+mapper.writeValueAsString(_entity));
				logger.debug( "修改后："+mapper.writeValueAsString(entity));  
				logger.debug( " getProperty(entity, \"creator\")："+ getProperty(entity, "creator"));  
			} catch (Exception e) {
				logger.warn(e.getLocalizedMessage());
			}  
			
			setProperty(entity, "setupOperator", getProperty(_entity, "creator"));
			setProperty(entity, "setupOperateTime", getProperty(_entity, "createtime"));
		}

		((CrudRepository) tDao).save(entity);
	}
	
	/**
	 * 用于校验某个表是否已经存在相同的字段，例如：校验用户输入身份证是否已经使用过了
	 * @param idEntity 实体对象
	 * @param field   要校验的字段
	 * @return
	 */
	public boolean validateUniqueFiled(IdEntity idEntity,String field) {
		return validateUniqueFiled(idEntity, field, null, null);
	}
	
	/**
	 * 用于校验某个表是否已经存在相同的字段，可另外传入限制条件，例如：校验用户输入身份证是否在某个分店已经使用了，可传入shopId
	 * @param idEntity 实体对象
	 * @param field   要校验的字段
	 * @param appendSql 查询条件数组
	 * @param appendParas 查询参数数组 
	 * @return
	 */
	public boolean validateUniqueFiled(IdEntity idEntity,String field,String appendSql,List<Object> appendParas) {
		if ( idEntity == null ) {  return true;  }
		String jpql = "select count(*) from "+idEntity.getClass().getName() + " where " + field + " = ?";
		List<Object> paras = new ArrayList<Object>();
		try {
			paras.add(new JSONObject(idEntity).getString(field));
			if(idEntity.getId() != null){
				jpql += " and id != ?" ;
				paras.add(idEntity.getId());
			}
			if(appendSql != null){
				jpql += appendSql;
				paras.addAll(appendParas);
			}
			long count = ((BaseRepository) tDao).getCount(jpql, paras);
			if(count > 0){
	 			return false;
	 		}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return true;
	}
	
	protected void setProperty(Object bean,String name,Object value){
		try {
			org.apache.commons.beanutils.BeanUtils.setProperty(bean, name, value);
		} catch (Exception e) {
			logger.warn(e.getLocalizedMessage());
		}		
	}
	
	protected Object getProperty(Object bean,String name){
		try {
			return BeanUtils.getBeanProperty(bean, name);
		} catch (Exception e) {
			logger.warn(e.getLocalizedMessage());
		}
		return null;
	}

	@Transactional(readOnly = false)
	public void deleteEntity(Long id) {
		((CrudRepository) tDao).delete(id);
	}
	
	@Transactional(readOnly = false)
	public void deleteEntity(Integer id) {
		((CrudRepository) tDao).delete(id);
	}
	
	@Transactional(readOnly = false)
	public void batchDelete(Long[] ids){
		((BaseRepository) tDao).batchDelete(ids);
	}
	
	@Transactional(readOnly = false)
	public void batchDelete(Integer[] ids){
		((BaseRepository) tDao).batchDelete(ids);
	}
	public List<T> getAllEntities() {
		return ((JpaRepository) tDao).findAll(new Sort(Direction.DESC,"id"));
	}
	
	public Page<T> getAllEntitiesForPage() {
		//构造空的
		Map<String, Object> filterParams = Maps.newHashMap();
		Page<T> page = getEntities(  filterParams,  1,  1000000, null,null) ;
		return page;
	}
	
	public Page<T> getEntities( Map<String, Object> filterParams, int pageNumber, int pageSize,
			String sortType,String orderDirection) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType,orderDirection);
		Specification<T> spec = buildSpecification(filterParams);

		return ((JpaSpecificationExecutor) tDao).findAll(spec, pageRequest);
	}
	public Page<T> getEntities( Map<String, Object> filterParams, int pageNumber, int pageSize,
			Sort sort) {
		Pageable pageable= new PageRequest(pageNumber, pageSize,sort);
		Specification<T> spec = buildSpecification(filterParams);

		return ((JpaSpecificationExecutor) tDao).findAll(spec, pageable);
	}
	
	public Page<T> getEntitiesFilterThroughLevel( Map<String, Object> filterParams, int pageNumber, int pageSize,
			String sortType,String orderDirection) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType,orderDirection);
		//增加级别过滤参数
		Specification<T> spec = buildSpecification(addLevelToFilterParams(filterParams));

		return ((JpaSpecificationExecutor) tDao).findAll(spec, pageRequest);
	}
	
	public Page<T> getEntities( Map<String, Object> filterParams, int pageNumber, int pageSize,
			String sortType){
		return getEntities(  filterParams,  pageNumber,  pageSize,
				 sortType,"DESC") ;
	}
	
	public Page<T> getEntitiesFilterThroughLevel( Map<String, Object> filterParams, int pageNumber, int pageSize,
			String sortType){
		return getEntitiesFilterThroughLevel(  filterParams,  pageNumber,  pageSize,
				 sortType,"DESC") ;
	}
	
	/**
	 * 返回分页数据，并且修改pageBean
	 * */
	public Page<T> getEntities( Map<String, Object> filterParams, PageBean pageBean) {
		Page<T> page = getEntities(filterParams,pageBean.getPage(),pageBean.getRows(),pageBean.getSort(),pageBean.getOrder());
		//修改pageBean的属性
		pageBean.setTotalCount(page.getTotalElements());
		pageBean.setPageNumShown(page.getTotalPages());
		return page;
	}
	
	/**
	 * 返回分页数据，并且修改pageBean
	 * */
	public Page<T> getEntitiesFilterThroughLevel( Map<String, Object> filterParams, PageBean pageBean) {
		Page<T> page = getEntitiesFilterThroughLevel(filterParams,pageBean.getPage(),pageBean.getRows(),pageBean.getSort(),pageBean.getOrder());
		//修改pageBean的属性
		pageBean.setTotalCount(page.getTotalElements());
		pageBean.setPageNumShown(page.getTotalPages());
		return page;
	}
	
	/**
	 * 返回分页数据，并且修改pageBean 可多字段排序
	 * */
	public Page<T> getEntities( PageBean pageBean) {
		List<Order> orderlist=new ArrayList<Order>();
		Page<T> page =null;
		if(StringUtil.isNotBlank(pageBean.getSort())&&StringUtil.isNotBlank(pageBean.getOrder())){
			System.out.println( pageBean.getSort());
			String strSorts[] = pageBean.getSort().split(",");
			String strOrders[] = pageBean.getOrder().split(",");
			for(int i=0;i<strSorts.length;i++){
				if(strOrders[i].equals("asc")){
					orderlist.add( new Order(Direction. ASC, strSorts[i]));
				}else{
					orderlist.add( new Order(Direction. DESC, strSorts[i]));
				}
			}
			page = getEntities(pageBean.get_filterParams(),pageBean.getPage()-1,pageBean.getRows(),new Sort(orderlist));
		}else{
			page = getEntities(pageBean.get_filterParams(),pageBean.getPage()-1,pageBean.getRows(),"id");
		}
		//修改pageBean的属性
		pageBean.setTotalCount(page.getTotalElements());
		pageBean.setPageNumShown(page.getTotalPages());
		return page;
	}
	
	/**
	 * 返回分页数据
	 * */
	public List<T> getEntities( Map<String, Object> filterParams) {
		Specification<T> spec = buildSpecification(filterParams);

		return ((JpaSpecificationExecutor<T>) tDao).findAll(spec);
	}
	
	/**
	 * 返回分页数据, 可排序
	 * */
	public List<T> getEntities( Map<String, Object> filterParams,Sort sort) {
		Specification<T> spec = buildSpecification(filterParams);

		return ((JpaSpecificationExecutor<T>) tDao).findAll(spec,sort);
	}
	
	/**
	 * 返回分页数据，并且修改pageBean
	 * */
	public Page<T> getEntitiesFilterThroughLevel( PageBean pageBean) {
		Page<T> page = getEntitiesFilterThroughLevel(pageBean.get_filterParams(),pageBean.getPage(),pageBean.getRows(),pageBean.getSort(),pageBean.getOrder());
		//修改pageBean的属性
		pageBean.setTotalCount(page.getTotalElements());
		pageBean.setPageNumShown(page.getTotalPages());
		return page;
	}

	/**
	 * 创建分页请求.
	 */
	protected PageRequest buildPageRequest(int pageNumber, int pagzSize, String sortType,String direction) {
		Sort sort = null;
		Direction drctn = null;
		if("desc".equalsIgnoreCase(direction)){
			drctn = Direction.DESC;
		}else if ("auto".equalsIgnoreCase(direction)){
			if("id".equals(sortType)){
				drctn = Direction.DESC;
			}else{
				drctn = Direction.ASC;
			}
		}else if (direction == null){
			drctn = Direction.DESC;
		}else{
			drctn = Direction.ASC;
		}
		if ("auto".equals(sortType) || sortType == null) {
			sort = new Sort(drctn, "id");
		} else if (sortType != null && !"".equals(sortType)) {
			sort = new Sort(drctn, sortType);
		}
		if(pagzSize <= 0){
			pagzSize  = 10;
		}
		if(pageNumber < 1){
			pageNumber  = 1;
		}
		return new PageRequest(pageNumber - 1, pagzSize, sort);
	}

	/**
	 * 创建动态查询条件组合.
	 */
	protected Specification<T> buildSpecification( Map<String, Object> filterParams) {
		List<SearchFilter> filters = SearchFilter.parse(filterParams);
		Specification<T> spec = DynamicSpecifications.bySearchFilter(filters, this.getEntityClass());
		return spec;
	}
	
	protected Map<String,Object> addLevelToFilterParams(Map<String, Object> filterParams){
		//使用CommonBusinessEntity中的createlevelcode字段
		return filterParams;
	}
	
	@Autowired
	public void setTaskDao(TDao tDao) {
		this.tDao = tDao;
	}
	
	//通过反射对实体类进行设值
	private Class<T> getEntityClass(){
		//Class thisClass = this.getClass();
		Type GenericType = getClass().getGenericSuperclass();
		if(GenericType instanceof  ParameterizedType){
			entityClass = (Class<T>)(((ParameterizedType) 
		    getClass().getGenericSuperclass()).getActualTypeArguments()[0]);
		}
		return entityClass;
	}
	
	public void flush(){
		((JpaRepository) tDao).flush();
	}
	
	public Iterable<T> getEntitys(Iterable<String> ids){
		return ((CrudRepository) tDao).findAll(ids);
	}
	
}
