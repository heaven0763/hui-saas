package com.chuangbang.framework.service;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.ConversionService;
import org.springframework.core.convert.support.DefaultConversionService;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.chuangbang.framework.util.hibernate.persistence.SearchFilter;
import com.chuangbang.framework.util.hibernate.persistence.SearchFilter.Operator;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.js.dao.account.UserDao;

@Component
public class CusQueryService {

	protected static Logger logger = LoggerFactory.getLogger(CusQueryService.class);
	
	@Autowired
	protected UserDao dao;
	
	private static final ConversionService conversionService = new DefaultConversionService();
	
	private String sqlCol = "sqlCol";
	
	private String objCol = "objCol";
	
	private String colstr = "colstr";
	
	private String fromstr = "fromstr";
	
	/**
	 * 单个对象查询
	 * @param sql  原生sql
	 * @param resultClass  要封装成的对象类型
	 * @param paras		参数，可null
	 * @return
	 */
	public <T> T getOne(String sql,Class<T> resultClass,List<Object> paras){
		Map<String,String> map = paseSql(sql);
		String columstr = map.get(this.colstr);
		String fromWhere = map.get(this.fromstr);
		return this.getOne(columstr, fromWhere, resultClass,paras);
	}
	
	/**
	 * 分页查询
	 * @param pageBean  分页信息和排序
	 * @param sql	原生sql
	 * @param resultClass 要封装成的对象类型
	 * @param paras 参数，可null
	 * @return
	 */
	public <T> List<T> page(PageBean pageBean,String sql,Class<T> resultClass,List<Object> paras){
		Map<String,String> map = paseSql(sql);
		String columstr = map.get(this.colstr);
		String fromWhere = map.get(this.fromstr);
		return page(pageBean, columstr, fromWhere,resultClass,paras);
	}

	/**
	 * 查询全部，不分页
	 * @param pageBean   仅用于排序
	 * @param sql 原生sql
	 * @param resultClass 要封装成的对象类型
	 * @param paras 参数，可null
	 * @return
	 */
	public <T> List<T> getAll(PageBean pageBean,String sql,Class<T> resultClass,List<Object> paras){
		Map<String,String> map = paseSql(sql);
		String columstr = map.get(this.colstr);
		String fromWhere = map.get(this.fromstr);
		return getAll(pageBean, columstr, fromWhere, resultClass, paras);
	}
	
	/**
	 * 对传入的原生sql进行处理
	 * @param sql  原生sql
	 * @return 返回一个map，包含两个key :colstr和fromstr
	 */
	public Map<String,String> paseSql(String sql){
		Map<String,String> map = Maps.newHashMap();
		int index = StringUtils.indexOfIgnoreCase(sql, " from ");
		int cycleTime = 0;
		int rightBracket = 0;
		while(StringUtils.indexOf(sql, "(" ,rightBracket) < index && index < (rightBracket = StringUtils.indexOf(sql, ")",rightBracket))){
			
			rightBracket = rightBracket + 2; //循环一次，排除一对括号
			index = StringUtils.indexOfIgnoreCase(sql, " from ",rightBracket);
			if(cycleTime > 100){ //已经循环超过100次，可以说明此方法已有问题
				throw new RuntimeException(" Infinite recursion (StackOverflowError)，please check your sql：\r\n"+sql);
			}
			cycleTime++;
		}
		
		String columstr = sql.substring(0,index).trim();
		if(StringUtils.startsWithIgnoreCase(columstr, "select")){
			columstr = columstr.substring(6);
		}
		String fromWhere = sql.substring(index);
		
		map.put(colstr, columstr);
		map.put(fromstr, fromWhere);
		return map;
	}
	
	public <T> T getOne(String columstr,String fromWhere,Class<T> resultClass){
		return this.getOne(columstr, fromWhere, resultClass,null);
	}
	
	public <T> T getOne(String columstr,String fromWhere,Class<T> resultClass,List<Object> paras){
		Map<String,String> transMap = transColums(columstr);
		String sqlCol = transMap.get(this.sqlCol);
		String objCol = transMap.get(this.objCol);
		String querySql = "select " + sqlCol +" "+ fromWhere+" ";
		logger.info("querySql={}",querySql);
		List<Object> objects = dao.executeNativeQuery(querySql,paras);
		if(objects == null || objects.size() < 1){
			return null;
		}
		Object object  = null;
		String[] columArray = objCol.split(",");
		Object[] cols = (Object[])objects.get(0);
		object = transformTuple(resultClass, cols,columArray);
		return (T)object;
	}

	
	 /**
     * 有分页的查询
     * @param pageBean
     * @param columstr
     * @param fromWhere
     * @param resultClass
     * @return
     */
	public <T> List<T> page(PageBean pageBean,String columstr,String fromWhere,Class<T> resultClass){
		return page(pageBean, columstr, fromWhere, resultClass,null);
	}
	
	
	public List<Map<String,Object>> pageAsMap(PageBean pageBean,String sql,List<Object> params){
		
		Map<String,String> map = paseSql(sql);
		String columstr = map.get(this.colstr);
		String fromWhere = map.get(this.fromstr);
		
		Map<String,Object> map2 = parse(pageBean.get_filterParams(), fromWhere, params);
		fromWhere = (String) map2.get("sql");
		params = (List<Object>) map2.get("params");
	
		String countSql = "select count(*) " +fromWhere;
		logger.info("countSql={}",countSql);
		List list =  dao.executeNativeQuery(countSql,params);
		long count = ((BigInteger)list.get(0)).longValue();
		if(count < 1){
			return Lists.newArrayList();
		}
		pageBean.setTotalCount(count);
		
		String querySql =  buildQuerySql(pageBean, columstr,fromWhere);
		
		Map<String,String> transMap = transColums(columstr);
		String sqlCol = transMap.get(this.sqlCol);
		String objCol = transMap.get(this.objCol);
		
		return queryAsMap(querySql, objCol);
	}
	
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
		Map<String,String> transMap = transColums(columstr);
		String sqlCol = transMap.get(this.sqlCol);
		String objCol = transMap.get(this.objCol);
		String querySql =  buildQuerySql(pageBean, sqlCol,fromWhere);
		return queryAsList(querySql, objCol,resultClass,params);
	}	
	
	
	public <T> List<T> getAll(PageBean pageBean,String columStr,String fromWhere,Class<T> resultClass){
		return getAll(pageBean, columStr, fromWhere, resultClass, null);
	}
	
	public <T> List<T> getAll(PageBean pageBean,String columStr,String fromWhere,Class<T> resultClass,List<Object> params){
		
		Map<String,Object> map = parse(pageBean.get_filterParams(), fromWhere, params);
		fromWhere = (String) map.get("sql");
		params = (List<Object>) map.get("params");
		Map<String,String> transMap = transColums(columStr);
		String sqlCol = transMap.get(this.sqlCol);
		String objCol = transMap.get(this.objCol);
		
		String orderby = buildOrderBy(pageBean);
		String querySql = "select " + sqlCol +" "+ fromWhere+" " +orderby  +"" ;
		logger.info("querySql={}",querySql);
		List<Object> objects = dao.executeNativeQuery(querySql,params);
		List lists = Lists.newArrayList();
		String[] columArray = objCol.split(",");
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
				fromWhere += " and " + fieldName + " = ? ";
				params.add(entry.getValue());
				break;
			case NE:
				fromWhere += " and " + fieldName + " != ? ";
				params.add(entry.getValue());
				break;
			case LIKE:
				fromWhere += " and " + fieldName + " like ? ";
				params.add("%"+entry.getValue()+"%");
				break;
			case LLIKE:
				fromWhere += " and " + fieldName + " like ? ";
				params.add(entry.getValue() +"%");
				break;
			case RLIKE:
				fromWhere += " and " + fieldName + " like ? ";
				params.add(entry.getValue());
				break;
			case GT:
				fromWhere += " and " + fieldName + " > ? ";
				params.add(entry.getValue());
				break;
			case LT:
				fromWhere += " and " + fieldName + " < ? ";
				params.add(entry.getValue());
				break;
			case GTE:
				fromWhere += " and " + fieldName + " >= ? ";
				params.add(entry.getValue());
				break;
			case LTE:
				fromWhere += " and " + fieldName + " <= ? ";
				params.add(entry.getValue());
				break;
			case ISN:
				fromWhere += " and " + fieldName + " is null ";
				break;
			case ISNN:
				fromWhere += " and " + fieldName + " is not null ";
				break;
			case OR:
				String[] searchNames = StringUtils.split(fieldName, ";");	
				if(searchNames.length>2){
					String[] values = StringUtils.split(entry.getValue().toString(), ",");
					SearchFilter filter = new SearchFilter(searchNames[1], Operator.valueOf(searchNames[0]), values);
					String vle = setUpMultiValuesOneField(filter,values);
					
					SearchFilter filter1 = new SearchFilter(searchNames[2], Operator.valueOf(searchNames[0]), values);
					String vle1 = setUpMultiValuesOneField(filter1,values);
					
					fromWhere += " and (" + vle+" or "+ vle1 + " )";
				}else{
					String[] values = StringUtils.split(entry.getValue().toString(), ",");
					SearchFilter filter = new SearchFilter(searchNames[1], Operator.valueOf(searchNames[0]), values);
					String vle = setUpMultiValuesOneField(filter,values);
					fromWhere += " and (" + vle + " )";
				}
				
				break;
			}
			
		}
		map.put("sql", fromWhere);
		map.put("params", params);
		return map;
	}
	protected String setUpMultiValuesOneField(SearchFilter filter,String[] values){
		String res = "";
		switch (filter.operator) {
		case EQ:
			for(String value :values){
				if(StringUtils.isBlank(res)){
					res+=filter.fieldName+" = '"+ value+"'";
				}else{
					res+=" or "+ filter.fieldName+" = '"+ value+"'";
				}
			}
			break;
		case NE:
			for(String value :values){
				if(StringUtils.isBlank(res)){
					res+=filter.fieldName+" <> '"+ value+"'";
				}else{
					res+=" or "+ filter.fieldName+" <> '"+ value+"'";
				}
			}
			break;
		case LIKE:
			for(String value :values){
				if(StringUtils.isBlank(res)){
					res+=filter.fieldName+" like '%"+ value+"%'";
				}else{
					res+=" or "+ filter.fieldName+" like '%"+ value+"%'";
				}
			}
			break;
		case LLIKE:
			for(String value :values){
				if(StringUtils.isBlank(res)){
					res+=filter.fieldName+" like '"+ value+"%'";
				}else{
					res+=" or "+ filter.fieldName+" like '"+ value+"%'";
				}
			}
			break;
		case RLIKE:
			for(String value :values){
				if(StringUtils.isBlank(res)){
					res+=filter.fieldName+" like '%"+ value+"'";
				}else{
					res+=" or "+ filter.fieldName+" like '%"+ value+"'";
				}
			}
			break;
		case GT:
			for(String value :values){
			}
			break;
		case LT:
			for(String value :values){
			}
			break;
		case GTE:
			for(String value :values){
			}
			break;
		case LTE:
			for(String value :values){
			}
			break;
		case ISN:
			for(String value :values){
			}
			break;
		case ISNN:
			for(String value :values){
			}
			break;
		default:
			break;
		}
		
		return res;
	}
	public String buildQuerySql(PageBean pageBean,String sqlCol,String fromWhere){
		String orderby = buildOrderBy(pageBean);
		String querySql = "select " + sqlCol +" "+ fromWhere+" " +orderby  +" limit "+(pageBean.getRows()*(pageBean.getPage()-1) ) +"," +pageBean.getRows() ;
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
	
	public Map<String,String> transColums(String columstr){
		Map<String,String> transMap = new HashMap<String,String>();
		String[] colums = columstr.trim().split(",");
		StringBuilder sqlColSbd = new StringBuilder();
		StringBuilder objcolSbd = new StringBuilder();
		String[] splitStrs = null;
		String colum = "";
		for(int i = 0; i < colums.length ; i++){
			colum = colums[i].trim();
			if(colum.indexOf(' ') == -1){ //id,name的格式
				sqlColSbd.append(addUnderscores(colum));
				objcolSbd.append(colum);
			}else{	//id id,name name的格式
				int index = colums[i].lastIndexOf(' ');
				//.getClass().colum = ;
				//splitStrs = colum.split(" ");
				sqlColSbd.append(colums[i]);
				objcolSbd.append(colums[i].substring(index).trim());
			}
			
			if(i !=(colums.length -1)){
				sqlColSbd.append(",");
				objcolSbd.append(",");
			}
		}
		transMap.put(this.sqlCol, sqlColSbd.toString());
		transMap.put(this.objCol, objcolSbd.toString());
		return transMap;
	}
	
	 public String addUnderscores(String name) {
		StringBuilder buf = new StringBuilder( name);
		for (int i=1; i<buf.length()-1; i++) {
			if (
				Character.isLowerCase( buf.charAt(i-1) ) &&
				Character.isUpperCase( buf.charAt(i) ) &&
				Character.isLowerCase( buf.charAt(i+1) )
			) {
				buf.insert(i++, '_');
			}
		}
		return buf.toString().toLowerCase();
	}
	 
	 public List queryAsList(String sql,String objCol,Class<?> resultClass,List<Object> params){
		return resultClass == null? queryAsMap(sql, objCol) : queryAsObject(sql, objCol, resultClass,params);
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
	
	public List<Map<String,Object>> queryAsMap(String sql,String objCol){
		List<Object> objects = dao.executeNativeQuery(sql,null);
		List lists = Lists.newArrayList();
		Map<String,Object> map = null;
		String[] columArray = objCol.split(",");
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
	    
}
