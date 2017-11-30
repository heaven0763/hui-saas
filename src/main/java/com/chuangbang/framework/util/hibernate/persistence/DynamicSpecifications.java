package com.chuangbang.framework.util.hibernate.persistence;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.core.convert.converter.ConverterRegistry;
import org.springframework.core.convert.ConversionService;
import org.springframework.core.convert.support.DefaultConversionService;
import org.springframework.data.jpa.domain.Specification;
import org.springside.modules.utils.Collections3;

import com.chuangbang.framework.util.converter.StringToDateConverter;
import com.chuangbang.framework.util.hibernate.persistence.SearchFilter.Operator;
import com.google.common.collect.Lists;

public class DynamicSpecifications {
	private static final ConversionService conversionService = new DefaultConversionService();
	static {
		((ConverterRegistry)conversionService).addConverter(String.class, Date.class, new StringToDateConverter());
	}

	public static <T> Specification<T> bySearchFilter(final Collection<SearchFilter> filters, final Class<T> clazz) {
		return new Specification<T>() {

			@Override
			public Predicate toPredicate(Root<T> root, CriteriaQuery<?> query, CriteriaBuilder builder) {
				if (Collections3.isNotEmpty(filters)) {
					List<Predicate> predicates = Lists.newArrayList();
					for (SearchFilter filter : filters) {
						if(filter.operator.equals(SearchFilter.Operator.OR)){	//or 
							List<Predicate> predicateOrs = Lists.newArrayList();
							String[] searchNames = StringUtils.split(filter.fieldName, ";");	
							String fileValue = filter.value.toString();
							String[] values = StringUtils.split(fileValue, ",");
							SearchFilter newFilter = new SearchFilter(searchNames[1], Operator.valueOf(searchNames[0]), fileValue);
							if(values.length > 1){
								//一个属性多个值 ， value用逗号分隔，例如  name="search_OR_GTE;marriageDate" value="2013-01-01,2013/01/01"
								setUpMultiValuesOneField(newFilter,values, predicateOrs, root, builder);
							}else if(searchNames.length > 1){
								//多个属性一个值，属性用逗号分隔，例如  name="search_OR_LIKE;dsrName1,dsrName2" value="梁燕滨"
								setUpMultiFiledsOneValue(newFilter,searchNames, predicateOrs, root, builder);	
							}else{
								throw new IllegalArgumentException(filter.fieldName + " is not a valid search filter name");
							}
							Predicate[] strings = new Predicate[predicateOrs.size()];
							predicates.add(builder.or(predicateOrs.toArray(strings)));
						}else{
							// nested path translate
							String[] names = StringUtils.split(filter.fieldName, ".");
							Path expression = root.get(names[0]);
							for (int i = 1; i < names.length; i++) {
								expression = expression.get(names[i]);
							}
							// convert value
							Class attributeClass = expression.getJavaType();
							if(filter.operator.equals(SearchFilter.Operator.ISN) 
									|| filter.operator.equals(SearchFilter.Operator.ISNN)){
								
							}else if (!attributeClass.equals(String.class) && filter.value instanceof String
									&& conversionService.canConvert(String.class, attributeClass)) {
								filter.value = conversionService.convert(filter.value, attributeClass);
							}
	
							switch (filter.operator) {
							case EQ:
								predicates.add(builder.equal(expression, filter.value));
								break;
							case NE:
								predicates.add(builder.notEqual(expression, filter.value));
								break;
							case LIKE:
								predicates.add(builder.like(expression, "%" + filter.value + "%"));
								break;
							case LLIKE:
								predicates.add(builder.like(expression, filter.value + "%"));
								break;
							case RLIKE:
								predicates.add(builder.like(expression, "%" + filter.value));
								break;
							case GT:
								predicates.add(builder.greaterThan(expression, (Comparable) filter.value));
								break;
							case LT:
								predicates.add(builder.lessThan(expression, (Comparable) filter.value));
								break;
							case GTE:
								predicates.add(builder.greaterThanOrEqualTo(expression, (Comparable) filter.value));
								break;
							case LTE:
								predicates.add(builder.lessThanOrEqualTo(expression, (Comparable) filter.value));
								break;
							case ISN:
								predicates.add(builder.isNull(expression));
								break;
							case ISNN:
								predicates.add(builder.isNotNull(expression));
								break;
							}
						}
					}
					if (predicates.size() > 0) {
						return builder.and(predicates.toArray(new Predicate[predicates.size()]));
					}
				}

				return builder.conjunction();
			}
			
			protected void setUpMultiFiledsOneValue(SearchFilter filter,String[] searchNames,List<Predicate> predicateOrs,Root<T> root, CriteriaBuilder builder) {
				switch (filter.operator) {
				case EQ:
					for(String fileName :StringUtils.split(filter.fieldName, ",")){
						predicateOrs.add(builder.equal(root.get(fileName).as(String.class), filter.value));
					}
					break;
				case NE:
					for(String fileName :StringUtils.split(filter.fieldName, ",")){
						predicateOrs.add(builder.notEqual(root.get(fileName).as(String.class), filter.value));
					}
					break;
				case LIKE:
					for(String fileName :StringUtils.split(filter.fieldName, ",")){
						predicateOrs.add(builder.like(root.get(fileName).as(String.class), "%"+ filter.value + "%"));
					}
					break;
				case LLIKE:
					for(String fileName :StringUtils.split(filter.fieldName, ",")){
						predicateOrs.add(builder.like(root.get(fileName).as(String.class), filter.value + "%"));
					}
					break;
				case RLIKE:
					for(String fileName :StringUtils.split(filter.fieldName, ",")){
						predicateOrs.add(builder.like(root.get(fileName).as(String.class),"%"+ filter.value));
					}
					break;
				case GT:
					for(String fileName :StringUtils.split(filter.fieldName, ",")){
						predicateOrs.add(builder.greaterThan(root.get(fileName).as(String.class),(Comparable) filter.value));
					}
					break;
				case LT:
					for(String fileName :StringUtils.split(filter.fieldName, ",")){
						predicateOrs.add(builder.lessThan(root.get(fileName).as(String.class),(Comparable) filter.value));
					}
					break;
				case GTE:
					for(String fileName :StringUtils.split(filter.fieldName, ",")){
						predicateOrs.add(builder.greaterThanOrEqualTo(root.get(fileName).as(String.class),(Comparable) filter.value));
					}
					break;
				case LTE:
					for(String fileName :StringUtils.split(filter.fieldName, ",")){
						predicateOrs.add(builder.lessThanOrEqualTo(root.get(fileName).as(String.class),(Comparable) filter.value));
					}
					break;
				case ISN:
					for(String fileName :StringUtils.split(filter.fieldName, ",")){
						predicateOrs.add(builder.isNull(root.get(fileName).as(String.class)));
					}
					break;
				case ISNN:
					for(String fileName :StringUtils.split(filter.fieldName, ",")){
						predicateOrs.add(builder.isNotNull(root.get(fileName).as(String.class)));
					}
					break;
				default:
					break;
				}
				
			}
			
			protected void setUpMultiValuesOneField(SearchFilter filter,String[] values,List<Predicate> predicateOrs,Root<T> root, CriteriaBuilder builder){
				switch (filter.operator) {
				case EQ:
					for(String value :values){
						predicateOrs.add(builder.equal(root.get(filter.fieldName).as(String.class), value));
					}
					break;
				case NE:
					for(String value :values){
						predicateOrs.add(builder.notEqual(root.get(filter.fieldName).as(String.class), value));
					}
					break;
				case LIKE:
					for(String value :values){
						predicateOrs.add(builder.like(root.get(filter.fieldName).as(String.class), "%"+ value + "%"));
					}
					break;
				case LLIKE:
					for(String value :values){
						predicateOrs.add(builder.like(root.get(filter.fieldName).as(String.class), value + "%"));
					}
					break;
				case RLIKE:
					for(String value :values){
						predicateOrs.add(builder.like(root.get(filter.fieldName).as(String.class),"%"+ value));
					}
					break;
				case GT:
					for(String value :values){
						predicateOrs.add(builder.greaterThan(root.get(filter.fieldName).as(String.class),(Comparable) value));
					}
					break;
				case LT:
					for(String value :values){
						predicateOrs.add(builder.lessThan(root.get(filter.fieldName).as(String.class),(Comparable) value));
					}
					break;
				case GTE:
					for(String value :values){
						predicateOrs.add(builder.greaterThanOrEqualTo(root.get(filter.fieldName).as(String.class),(Comparable) value));
					}
					break;
				case LTE:
					for(String value :values){
						predicateOrs.add(builder.lessThanOrEqualTo(root.get(filter.fieldName).as(String.class),(Comparable) value));
					}
					break;
				case ISN:
					for(String value :values){
						predicateOrs.add(builder.isNull(root.get(filter.fieldName).as(String.class)));
					}
					break;
				case ISNN:
					for(String value :values){
						predicateOrs.add(builder.isNotNull(root.get(filter.fieldName).as(String.class)));
					}
					break;
				default:
					break;
				}
			}
			
		};
	}
}
