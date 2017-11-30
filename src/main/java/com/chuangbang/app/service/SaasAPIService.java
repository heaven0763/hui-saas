package com.chuangbang.app.service;

import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.chuangbang.base.dao.app.ApplicationDao;
import com.chuangbang.base.entity.app.Application;
import com.chuangbang.framework.util.AESUtil;
import com.chuangbang.framework.util.CipherUtil;
import com.google.common.collect.Maps;
@Component
@Transactional(readOnly = true)
public class SaasAPIService {
	
	@Autowired
	private ApplicationDao applicationDao;
	
	
	public Map<String, Object> isApplication(String params){
		Map<String, Object> res = Maps.newHashMap();

		JSONObject object = JSONObject.parseObject(params);
		if(StringUtils.isBlank(object.getString("key"))){
			res.put("error_code", "10001");
			res.put("error_msg", "错误的请求KEY");
			return res;
		}
		Iterator it = object.keySet().iterator();
		Map<String, Object> paramsMap = new TreeMap<String, Object>();
		while(it.hasNext()){  
			 String key = it.next().toString();
			 if(!key.equals("sign")){
				 paramsMap.put(key, object.get(key));
			 }
	    }
		JSONObject pobject = new JSONObject();
		Iterator mit =paramsMap.keySet().iterator();
		while(mit.hasNext()){  
			 String key = mit.next().toString();
			 pobject.put(key, object.get(key));
	    }
		
		Application application = applicationDao.findByAppId(object.getString("key"));
		if(null==application){
			res.put("error_code", "10001");
			res.put("error_msg", "错误的请求KEY");
			return res;
		}else{
			if(application.getState().equals("0")){
				res.put("error_code", "10002");
				res.put("error_msg", "该KEY无请求权限");
				return res;
			}
			/*else if(application.getEffectiveDate()){
			 	res.put("error_code", "10003");
				res.put("error_msg", "KEY过期");
				return res;
			  }*/
			try {
				String encrypt = AESUtil.NoPaddingEncrypt(pobject.toJSONString(),application.getAppKey());
				String crtsign =CipherUtil.encodeByMD5(encrypt, "UTF-8");
				if(crtsign.equals(object.get("sign"))){
					res.put("error_code", "200");
					res.put("error_msg", "校验成功！");
					return res;
				}else{
					res.put("error_code", "10004");
					res.put("error_msg", "签名错误");
					return res;
				}
				//参数错误(invalid parameter) 
			} catch (Exception e) {
				res.put("error_code", "10003");
				res.put("error_msg", "参数错误");
				return res;
			}
			
		}
	}
}
