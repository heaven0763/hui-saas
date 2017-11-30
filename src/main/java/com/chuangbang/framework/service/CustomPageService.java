package com.chuangbang.framework.service;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.ConversionService;
import org.springframework.core.convert.support.DefaultConversionService;
import org.springframework.stereotype.Component;

import com.chuangbang.framework.dao.system.SystemParameterDao;
import com.chuangbang.framework.util.hibernate.persistence.SearchFilter;
import com.chuangbang.framework.util.page.PageBean;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 基于mysql的自定义查询方法封装
 * @author HeavenChen
 *
 */
@Component
public class CustomPageService {
	
	protected static Logger logger = LoggerFactory.getLogger(CustomPageService.class);
	
	@Autowired
	protected SystemParameterDao dao;
	
	private static final ConversionService conversionService = new DefaultConversionService();
	
    /**
     * 有分页的查询
     * @param pageBean
     * @param columstr
     * @param fromWhere
     * @param resultClass
     * @return
     */
	public <T> List<T> page(PageBean pageBean,String columstr,String fromWhere,Class<T> resultClass){
		String countSql = "select count(*) " +fromWhere;
		logger.info("countSql={}",countSql);
		List list =  dao.executeNativeQuery(countSql,null);
		long count = ((BigInteger)list.get(0)).longValue();
		if(count < 1){
			return Lists.newArrayList();
		}
		pageBean.setTotalCount(count);
		String colums = getColums(columstr);
		String querySql = buildQuerySql(pageBean, count, columstr,colums, fromWhere);
		return queryAsList(querySql, colums,resultClass,null);
	}
	
	
	 /**
     * 有分页的查询
     * @param pageBean
     * @param columstr
     * @param fromWhere
     * @param resultClass
     * @return
     */
	public <T> List<T> queryAsPageList(PageBean pageBean,String columstr,String fromWhere){
		String countSql = "select count(*) " +fromWhere;
		logger.info("countSql={}",countSql);
		List list =  dao.executeNativeQuery(countSql,null);
		long count = ((BigInteger)list.get(0)).longValue();
		if(count < 1){
			return Lists.newArrayList();
		}
		pageBean.setTotalCount(count);
		String colums = getColums(columstr);
		String querySql = buildQuerySql(pageBean, count, columstr,colums, fromWhere);
		return queryAsList(querySql, colums,null,null);
	}

	/**
	 * 有分页的查询，支持search_GTE_xxx形式的查询条件
	 * 例如：
	 * 	Map<String, Object> searchparas = Servlets.getParametersStartingWith(request, "search_");
		pageBean.set_filterParams(searchparas);
	 * @param pageBean
	 * @param columstr
	 * @param fromWhere
	 * @param resultClass
	 * @param params
	 * @return
	 */
	public <T> List<T> page(PageBean pageBean,String columstr,String fromWhere,Class<T> resultClass,List<Object> params){
		Map<String,Object> map = parse(pageBean.get_filterParams(), fromWhere, params);
		fromWhere = (String) map.get("sql");
		params = (List<Object>) map.get("params");
		String countSql = "select count(*) " +fromWhere;
		logger.info("countSql={}",countSql);
		List list =  dao.executeNativeQuery(countSql,params);
		long count = ((BigInteger)list.get(0)).longValue();
		if(count < 1){
			return Lists.newArrayList();
		}
		pageBean.setTotalCount(count);
		String colums = getColums(columstr);
		String querySql = buildQuerySql(pageBean, count, columstr,colums, fromWhere);
		return queryAsList(querySql, colums,resultClass,params);
	}	
	
	public <T> List<T> hotelList(PageBean pageBean,String columstr,String fromWhere,Class<T> resultClass,List<Object> params){
		Map<String,Object> map = parse(pageBean.get_filterParams(), fromWhere, params);
		fromWhere = (String) map.get("sql");
		params = (List<Object>) map.get("params");
		String countSql = "select count(*) " +fromWhere;
		logger.info("countSql={}",countSql);
		countSql = countSql.substring(0,countSql.indexOf("GROUP BY"));
		logger.info("*******************countSql={}",countSql);
		List<Object> list =  dao.executeNativeQuery(countSql,params);
		long count = ((BigInteger)list.get(0)).longValue();
		if(count < 1){
			return Lists.newArrayList();
		}
		pageBean.setTotalCount(count);
		String colums = getColums(columstr);
		String querySql = buildQuerySql(pageBean, count, columstr,colums, fromWhere);
		return queryAsList(querySql, colums,resultClass,params);
	}	
	
	
	/**
	 * 根据条件查询出一条记录并封装成对象返回
	 * @param columStr
	 * @param fromWhere
	 * @param resultClass
	 * @return
	 */
	public <T> T getOne(String columStr,String fromWhere,Class<T> resultClass){
		
		String colums = getColums(columStr);
		String querySql = "select " + columStr +" "+ fromWhere+" ";
		logger.info("querySql={}",querySql);
		List<Object> objects = dao.executeNativeQuery(querySql,null);
		if(objects == null || objects.size() < 1){
			return null;
		}
		Object object  = null;
		String[] columArray = colums.split(",");
		Object[] cols = (Object[])objects.get(0);
		object = transformTuple(resultClass, cols,columArray);
		return (T)object;
	}
	
	/**
	 * 根据条件查询出一条记录并封装成对象返回，支持search_GTE_xxx形式的查询条件
	 * 例如：
	 * 	Map<String, Object> searchparas = Servlets.getParametersStartingWith(request, "search_");
		pageBean.set_filterParams(searchparas);
	 * @param columStr
	 * @param fromWhere
	 * @param resultClass
	 * @param params
	 * @return
	 */
	public <T> T getOne(String columStr,String fromWhere,Class<T> resultClass,List<Object> params){
		String colums = getColums(columStr);
		String querySql = "select " + columStr +" "+ fromWhere+" ";
		logger.info("querySql={}",querySql);
		List<Object> objects = dao.executeNativeQuery(querySql,params);
		if(objects == null || objects.size() < 1){
			return null;
		}
		Object object  = null;
		String[] columArray = colums.split(",");
		Object[] cols = (Object[])objects.get(0);
		object = transformTuple(resultClass, cols,columArray);
		return (T)object;
	}
	
	/**
	 * 没有分页的查询
	 * @param pageBean	在该方法中仅用于排序
	 * @param columStr
	 * @param fromWhere
	 * @param resultClass
	 * @return
	 */
	public <T> List<T> getAll(PageBean pageBean,String columStr,String fromWhere,Class<T> resultClass){
		String colums = getColums(columStr);
		String orderby = buildOrderBy(pageBean);
		String querySql = "select " + columStr +" "+ fromWhere+" " +orderby  +"" ;
		logger.info("querySql={}",querySql);
		List<Object> objects = dao.executeNativeQuery(querySql,null);
		List lists = Lists.newArrayList();
		String[] columArray = colums.split(",");
		for(Object row: objects){
			Object[] cols = (Object[])row;
			lists.add(transformTuple(resultClass, cols,columArray));
		}
		return lists;
	}

	/**
	 * 没有分页的查询，支持search_GTE_xxx形式的查询条件
	 * 例如：
	 * 	Map<String, Object> searchparas = Servlets.getParametersStartingWith(request, "search_");
		pageBean.set_filterParams(searchparas);
	 * @param pageBean	在该方法中仅用于排序
	 * @param columStr
	 * @param fromWhere
	 * @param resultClass
	 * @param params
	 * @return
	 */
	public <T> List<T> getAll(PageBean pageBean,String columStr,String fromWhere,Class<T> resultClass,List<Object> params){
		Map<String,Object> map = parse(pageBean.get_filterParams(), fromWhere, params);
		fromWhere = (String) map.get("sql");
		params = (List<Object>) map.get("params");
		String colums = getColums(columStr);
		String orderby = buildOrderBy(pageBean);
		String querySql = "select " + columStr +" "+ fromWhere+" " +orderby  +"" ;
		logger.info("querySql={}",querySql);
		List<Object> objects = dao.executeNativeQuery(querySql,params);
		List lists = Lists.newArrayList();
		String[] columArray = colums.split(",");
		for(Object row: objects){
			Object[] cols = (Object[])row;
			lists.add(transformTuple(resultClass, cols,columArray));
		}
		return lists;
	}
	
	public Map<String,Object> parse(Map<String, Object> filterParams,String fromWhere,List<Object> params){
		Map<String,Object> map = Maps.newHashMap();
		params = params != null? params : Lists.newArrayList();
		String condition = null;
		String fieldName = null;
		for (Entry<String, Object> entry : filterParams.entrySet()) {
			if(entry.getValue() == null || StringUtils.isBlank(entry.getValue().toString())){
				continue;
			}
			if(entry.getKey().indexOf("_") == -1 ){
				throw new IllegalArgumentException(entry.getKey() + " is not a valid search filter name");
			}
			condition = entry.getKey().substring(0,entry.getKey().indexOf("_"));
			fieldName = entry.getKey().substring(entry.getKey().indexOf("_") + 1);
			switch (SearchFilter.Operator.valueOf(condition)) {
			case EQ:
				fromWhere += " AND " + fieldName + " = ? ";
				params.add(entry.getValue());
				break;
			case NE:
				fromWhere += " AND " + fieldName + " != ? ";
				params.add(entry.getValue());
				break;
			case LIKE:
				fromWhere += " AND " + fieldName + " like ? ";
				params.add("%"+ entry.getValue()+"%");
				break;
			case LLIKE:
				fromWhere += " AND " + fieldName + " like ? ";
				params.add(entry.getValue()+"%");
				break;
			case RLIKE:
				fromWhere += " AND " + fieldName + " like ? ";
				params.add("%"+entry.getValue());
				break;
			case GT:
				fromWhere += " AND " + fieldName + " > ? ";
				params.add(entry.getValue());
				break;
			case LT:
				fromWhere += " AND " + fieldName + " < ? ";
				params.add(entry.getValue());
				break;
			case GTE:
				fromWhere += " AND " + fieldName + " >= ? ";
				params.add(entry.getValue());
				break;
			case LTE:
				fromWhere += " AND " + fieldName + " <= ? ";
				params.add(entry.getValue());
				break;
			case ISN:
				fromWhere += " AND " + fieldName + " is null ";
				break;
			case ISNN:
				fromWhere += " AND " + fieldName + " is not null ";
			case IN:
				fromWhere += " AND " + fieldName + "in ("+entry.getValue().toString()+") ";
			case OR:
				String[] searchNames = StringUtils.split(fieldName, ";");	
				String fileValue = entry.getValue().toString();
				String[] values = StringUtils.split(fileValue, ",");
				String str = "";
				if(values.length > 1){
					//一个属性多个值 ， value用逗号分隔，例如  name="search_OR_GTE;marriageDate" value="2013-01-01,2013/01/01"
					str = setUpMultiValuesOneField(searchNames[0],searchNames[1],values);
				}else if(searchNames.length > 1){
					//多个属性一个值，属性用逗号分隔，例如  name="search_OR_LIKE;dsrName1,dsrName2" value="梁燕滨"
					str = setUpMultiFiledsOneValue(searchNames[0],searchNames[1], values[0]);	
				}else{
					throw new IllegalArgumentException(fieldName + " is not a valid search filter name");
				}
				fromWhere += " AND (" + str + " ) ";
				break;
			}
			
		}
		map.put("sql", fromWhere);
		map.put("params", params);
		return map;
	}
	private String setUpMultiFiledsOneValue(String filter, String searchNames, String value) {
		String params = "";
		switch (SearchFilter.Operator.valueOf(filter)) {
		case EQ:
			for(String fieldName :StringUtils.split(searchNames, ",")){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+=fieldName+" = '"+value+"' ";
			}
			break;
		case NE:
			for(String fieldName :StringUtils.split(searchNames, ",")){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+=fieldName+" <> '"+value+"' ";
			}
			break;
		case LIKE:
			for(String fieldName :StringUtils.split(searchNames, ",")){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+=fieldName+" LIKE '%"+value+"%' ";
			}
			break;
		case LLIKE:
			for(String fieldName :StringUtils.split(searchNames, ",")){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" = '"+value+"%' ";
			}
			break;
		case RLIKE:
			for(String fieldName :StringUtils.split(searchNames, ",")){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" = '%"+value+"' ";
			}
			break;
		case GT:
			for(String fieldName :StringUtils.split(searchNames, ",")){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" > '"+value+"' ";
			}
			break;
		case LT:
			for(String fieldName :StringUtils.split(searchNames, ",")){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" < '"+value+"' ";
			}
			break;
		case GTE:
			for(String fieldName :StringUtils.split(searchNames, ",")){
				params+= fieldName+" >= '"+value+"' ";
			}
			break;
		case LTE:
			for(String fieldName :StringUtils.split(searchNames, ",")){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" <= '"+value+"' ";
			}
			break;
		case ISN:
			for(String fieldName :StringUtils.split(searchNames, ",")){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" is null ";
			}
			break;
		case ISNN:
			for(String fieldName :StringUtils.split(searchNames, ",")){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" is not null ";
			}
			break;
		default:
			break;
		}
		return  params;
	}

	protected String setUpMultiValuesOneField(String filter,String fieldName,String[] values){
		String params = "";
		switch (SearchFilter.Operator.valueOf(filter)) {
		case EQ:
			for(String value :values){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" = '"+value+"' ";
			}
			break;
		case NE:
			for(String value :values){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" <> '"+value+"' ";
			}
			break;
		case LIKE:
			for(String value :values){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" like '%"+value+"%' ";
			}
			break;
		case LLIKE:
			for(String value :values){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" like '"+value+"%' ";
			}
			break;
		case RLIKE:
			for(String value :values){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" like '%"+value+"' ";
			}
			break;
		case GT:
			for(String value :values){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" > '"+value+"' ";
			}
			break;
		case LT:
			for(String value :values){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" < '"+value+"' ";
			}
			break;
		case GTE:
			for(String value :values){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" >= '"+value+"' ";
			}
			break;
		case LTE:
			for(String value :values){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" <= '"+value+"' ";
			}
			break;
		case ISN:
			for(String value :values){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" is null ";
			}
			break;
		case ISNN:
			for(String value :values){
				if(!"".equals(params)){
					params+= " OR ";
				}
				params+= fieldName+" is not null ";
			}
			break;
		default:
			break;
		}
		return params;
	}
	public String buildQuerySql(PageBean pageBean,Long count,String columStr,String colums,String fromWhere){
		String orderby = buildOrderBy(pageBean);
		String querySql = "select " + columStr +" "+ fromWhere+" " +orderby  +" limit "+(pageBean.getRows()*(pageBean.getPage()-1) ) +"," +pageBean.getRows() ;
		logger.info("querySql={}",querySql);
		
		return querySql;
	}
	
	public String buildOrderBy(PageBean pageBean){
		String orderby = " order by "+pageBean.getSort()+" "+pageBean.getOrder();
		if(pageBean.getSort().indexOf(",") != -1){
			String[] sorts = pageBean.getSort().split(",");
			String[] orders = pageBean.getOrder().split(",");
			orderby = " order by ";
			for(int i = 0; i< sorts.length ; i++){
				//orderby += sorts[i] + " " +  orders[i];
				if("FIND_IN_SET".equals(orders[i])){
					String[] vls = sorts[i].split("#");
					orderby +="FIND_IN_SET("+vls[0]+",'"+vls[1].replaceAll("@", ",")+"')";
				}else{
					orderby += sorts[i] + " " +  orders[i];
				}
				if(sorts.length > i +1){
					orderby += ",";
				}
			}
		}
		return orderby;
	}
	
	public String getColums(String columstr){
		String[] colums = columstr.trim().split(", ");
		StringBuilder sbd = new StringBuilder();
		for(int i = 0; i < colums.length ; i++){
			sbd.append(colums[i].substring(colums[i].lastIndexOf(' ')).trim());
			if(i !=(colums.length -1)){
				sbd.append(",");
			}
		}
		return sbd.toString();
	}
	
	public List queryAsList(String sql,String colums,Class<?> resultClass,List<Object> params){
		return resultClass == null? queryAsMap(sql, colums, resultClass,params) : queryAsObject(sql, colums, resultClass,params);
	}
	
	public List queryAsObject(String sql,String colums,Class<?> resultClass,List<Object> params){
		List<Object> objects = dao.executeNativeQuery(sql,params);
		List lists = Lists.newArrayList();
		String[] columArray = colums.split(",");
		
		for(Object row: objects){
			Object[] cols = (Object[])row;
			lists.add(transformTuple(resultClass, cols,columArray));
		}
		return lists;
	}
	
	public List<Map<String,Object>> queryAsMap(String sql,String colums,Class<?> resultClass,List<Object> params){
		List<Object> objects = dao.executeNativeQuery(sql,params);
		List lists = Lists.newArrayList();
		Map<String,Object> map = null;
		String[] columArray = colums.split(",");
		for(Object row: objects){
			Object[] cols = (Object[])row;
			map = Maps.newHashMap();
			for(int i = 0;i < columArray.length;i++){
				map.put(columArray[i], cols[i]==null? "":cols[i].toString());
			}
			lists.add(map);
		}
		return lists;
	}
	public List<Map<String,Object>> queryAsMap(String sql,String colums,Class<?> resultClass){
		return queryAsMap(sql,colums,resultClass,null);
	}
		
	//将结果封闭成指定的class对象返回
    public Object transformTuple(Class<?> resultClass,Object[] tuple, String[] aliases) {  
    	if(resultClass==null) throw new IllegalArgumentException("resultClass cannot be null");  
        Object result = null;  
        try {
			result = resultClass.newInstance();
			//这里使用SETTER方法填充POJO对象  
			Class<?> fiedType;
			for (int i = 0; i < aliases.length; i++) {
				fiedType = PropertyUtils.getPropertyType(result, aliases[i]);
				//System.out.println(result.getClass()+"<><><><>"+aliases[i]+"<><><>"+tuple[i]+"<><><>"+fiedType);
				if(fiedType == null){
					throw new RuntimeException("fiedType could not be null :" +aliases[i]);
				}
				tuple[i] = conversionService.convert(tuple[i], fiedType);
				PropertyUtils.setProperty(result, aliases[i], tuple[i]);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;  
    }


	public List<Map<String, Object>> pageAsMap(PageBean<Map<String, Object>> pageBean, String columstr,String fromWhere, List<Object> params) {
		Map<String,Object> map = parse(pageBean.get_filterParams(), fromWhere, params);
		fromWhere = (String) map.get("sql");
		params = (List<Object>) map.get("params");
		String countSql = "select count(*) " +fromWhere;
		logger.info("countSql={}",countSql);
		List list =  dao.executeNativeQuery(countSql,params);
		long count = ((BigInteger)list.get(0)).longValue();
		if(count < 1){
			return Lists.newArrayList();
		}
		pageBean.setTotalCount(count);
		String colums = getColums(columstr);
		String querySql = buildQuerySql(pageBean, count, columstr,colums, fromWhere);
		return queryAsList(querySql, colums,null,params);
	}  
    
}
