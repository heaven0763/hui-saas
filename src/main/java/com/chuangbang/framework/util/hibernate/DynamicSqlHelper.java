package com.chuangbang.framework.util.hibernate;

import java.lang.reflect.Method;

public class DynamicSqlHelper {

	public static String getMappingColumnStr(Class<?> c){
		Method[] methods = c.getMethods();
		StringBuilder sbd = new StringBuilder();
		String methodName = "";
		Method m = null;
		for(int i  = 0; i < methods.length ;i++){
			m = methods[i];
			if(m.getAnnotation(javax.persistence.Transient.class) != null){
				continue;
			}
			methodName = m.getName();
			if(methodName.equals("getClass") || !methodName.startsWith("get")){
				continue;
			}
			String firstLetter = ""+methodName.charAt(3);
			sbd.append(firstLetter.toLowerCase() + methodName.substring(4) + ",");
		}
		return sbd.toString();
	}
	
	public static String getMappingColumnStr(String prefix,Class<?> c){
		Method[] methods = c.getMethods();
		StringBuilder sbd = new StringBuilder();
		String methodName = "";
		Method m = null;
		for(int i  = 0; i < methods.length ;i++){
			m = methods[i];
			if(m.getAnnotation(javax.persistence.Transient.class) != null){
				continue;
			}
			methodName = m.getName();
			if(methodName.equals("getClass") || !methodName.startsWith("get")){
				continue;
			}
			String property = (""+methodName.charAt(3)).toLowerCase() + methodName.substring(4);
			sbd.append(prefix + addUnderscores(property) + " "+property+ ",");
		}
		return sbd.toString();
	}
	
	 public static String addUnderscores(String name) {
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
}
