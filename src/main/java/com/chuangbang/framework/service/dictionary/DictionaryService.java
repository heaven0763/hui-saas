package com.chuangbang.framework.service.dictionary;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.mapper.JsonMapper;

import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.dao.dictionary.DictionaryDao;
import com.chuangbang.framework.entity.dictionary.Dictionary;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.util.easyui.Json;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

@Component("dictionaryService")
@Transactional(readOnly = true)
public class DictionaryService extends BaseService<Dictionary,DictionaryDao>{

	private static Logger logger = LoggerFactory
			.getLogger(DictionaryService.class);

	@Autowired
	private DictionaryDao dictionaryDao;
	
	public static JsonMapper mapper = JsonMapper.nonEmptyMapper();

	// -- User Manager --//
	public Dictionary getDictionary(Long id) {
		return dictionaryDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveDictionary(Dictionary entity) {
		dictionaryDao.save(entity);
	}

	@Transactional(readOnly = false)
	public void deleteDictionary(Long id) {
		dictionaryDao.delete(id);
	}
	
	public List<Dictionary> findAllOrderByCode() {
		return dictionaryDao.findAll(new Sort(Direction.ASC,"code"));
	}
	
	
	public List<String[]> findBySqlToList(String sql) {
		List list = dictionaryDao.findBySql(sql);
		List<String[]> dicts = Lists.newArrayList();
		for (Object row : list) {
			Object[] r = (Object[]) row;
			String code  =  r[0] == null ? "" : r[0].toString();
			String detail  =  r[1] == null ? "" : r[1].toString();
			String [] dict = new String[]{code,detail};
			dicts.add(dict);
		}
		return dicts;
	}

	public String trsltDictForDynamic(String sql, Object code) {
		List paras = new ArrayList();
		paras.add(code);
		Object result = code;
		List list = dictionaryDao.executeNativeQuery(sql, paras);
		if (list.size() > 0) {
			result = list.get(0);
		}
		return result==null? "":String.valueOf(result);
	}
	
	public List<Dictionary> findDetailByKindAndCode(String kind, String code) {
		return dictionaryDao.findByKindAndCode(kind, code);
	}

	public String trsltDict(String kind, String code) {
		List<Dictionary> list = dictionaryDao.findByKindAndCode(kind, code);
		return list.size() > 0? list.get(0).getDetail() : code;
	}

	public String trsltDictDetailToCode(String kind, String detail) {
		List<Dictionary> list = dictionaryDao.findByKindAndDetail(kind, detail);
		return list.size() > 0? list.get(0).getCode():detail;
	}
	
	public String getBySqlToJson(String sql,List<ArrayList<String>> addBefore) {
		List<String[]> list = this.findBySqlToList(sql);
		List<ArrayList<String>> stringList = Lists.newArrayList();
		stringList.addAll(addBefore);
		for (String[] dict : list) {
			stringList.add(Lists.newArrayList(dict[0], dict[1]));
		}
		String beanJson = mapper.toJson(stringList);
		return beanJson;
	}
	
	public String trslCombox(String sql,List paras,String value,String[] addBefore) throws UnsupportedEncodingException{
		System.out.println(sql);
		List list = dictionaryDao.executeNativeQuery(sql, paras);
		List<Map<String,Object>> listMap = Lists.newArrayList();
		boolean flag = false;
		if(addBefore != null){
			for(String str:addBefore){
				String[] strs = str.split(";");
				Map<String,Object> map = Maps.newHashMap();
				map.put("value", strs[0]);
				map.put("text", strs[1] );//new String(strs[1].getBytes("ISO-8859-1"),"UTF-8"));
				listMap.add(map);
			}
		}
		for (Object rows : list) {
			Object[] row = (Object[]) rows;
			Map<String,Object> map = Maps.newHashMap();
			map.put("value", row[0]);
			map.put("text", row[1]);
			if(StringUtils.isNotBlank(value)&&row[0].toString().equals(value)){
				flag = true;
				map.put("selected", true);
			}
			listMap.add(map);
		}
		if(!flag && listMap.size() > 0){
			listMap.get(0).put("selected", true);
		}
		return mapper.toJson(listMap);
	}

	public Object trsltDict(String kind, String code, String wxId) {
		return this.dictionaryDao.findByKindAndCodeAndSupercode(kind, code, wxId+"").get(0).getDetail();
	}
	
	@Transactional(readOnly = false)
	public void saveDict(Map<String, String[]> dict,String supercode) {
		Iterator<Map.Entry<String, String[]>> entries = dict.entrySet().iterator();  
		Map<String, String> welfares = Maps.newHashMap();
		while (entries.hasNext()) {  
		  
		    Entry<String, String[]> entry = entries.next();  
		  
		    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue()[0]);  
		    String titles[] = entry.getKey().split(";");
		    if(titles.length==3){
		    	if(titles[1].equals("14")){
		    		Dictionary dictionary = this.dictionaryDao.findBySupercodeAndKindAndDetail(supercode,titles[1],titles[2]);
		    		dictionary.setCode(entry.getValue()[0]);
		    		this.dictionaryDao.save(dictionary);
		    	}else if(titles[1].equals("21")){
		    		welfares.put(titles[2],entry.getValue()[0]);
		    		Dictionary dictionary = this.dictionaryDao.findBySupercodeAndKindAndCode(supercode,titles[1],titles[2]);
		    		dictionary.setDetail(entry.getValue()[0]);
		    		this.dictionaryDao.save(dictionary);
		    	}else{
		    		Dictionary dictionary = this.dictionaryDao.findBySupercodeAndKindAndCode(supercode,titles[1],titles[2]);
		    		dictionary.setDetail(entry.getValue()[0]);
		    		this.dictionaryDao.save(dictionary);
		    	}
		    	
	    	    System.out.println("Kind = " + titles[1] + ", Code = " + titles[2]);  
		    }
		}
		
		System.out.println(welfares.toString());
    	if(!welfares.isEmpty()){
    		Double sndWelfare = Double.valueOf(welfares.get("fst_Recharge_Commission").toString())-Double.valueOf(welfares.get("snd_Recharge_Commission").toString());
    		Double trdWelfare = Double.valueOf(welfares.get("fst_Recharge_Commission").toString())-Double.valueOf(welfares.get("trd_Recharge_Commission").toString());
    		Dictionary snddictionary = this.dictionaryDao.findBySupercodeAndKindAndCode(supercode,"22","snd_Welfare_Commission");
    		snddictionary.setDetail(sndWelfare+"");
    		this.dictionaryDao.save(snddictionary);
    		Dictionary trddictionary = this.dictionaryDao.findBySupercodeAndKindAndCode(supercode,"22","trd_Welfare_Commission");
    		trddictionary.setDetail(trdWelfare+"");
    		this.dictionaryDao.save(trddictionary);
    	}
	}
	
	@Transactional(readOnly = false)
	public void saveDicts(Map<String, String> dict,String supercode) {
		Iterator<Map.Entry<String, String>> entries = dict.entrySet().iterator();  
		while (entries.hasNext()) {  
		  
		    Entry<String, String> entry = entries.next();  
		  
		    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
		    
		    String titles[] = entry.getKey().split("_");
		    Dictionary dictionary = this.dictionaryDao.findOne(Long.valueOf(titles[0]));
		    dictionary.setDetail(entry.getValue());
		    this.dictionaryDao.save(dictionary);
		    /*if(titles.length==3){
		    	if(titles[1].equals("14")){
		    		
		    		dictionary.setCode(entry.getValue()[0]);
		    		this.dictionaryDao.save(dictionary);
		    	}else if(titles[1].equals("21")){
		    		welfares.put(titles[2],entry.getValue()[0]);
		    		Dictionary dictionary = this.dictionaryDao.findBySupercodeAndKindAndCode(supercode,titles[1],titles[2]);
		    		dictionary.setDetail(entry.getValue()[0]);
		    		this.dictionaryDao.save(dictionary);
		    	}else{
		    		Dictionary dictionary = this.dictionaryDao.findBySupercodeAndKindAndCode(supercode,titles[1],titles[2]);
		    		dictionary.setDetail(entry.getValue()[0]);
		    		this.dictionaryDao.save(dictionary);
		    	}
		    	
	    	    System.out.println("Kind = " + titles[1] + ", Code = " + titles[2]);  
		    }*/
		}
		
	}

	public List<Dictionary> findByKind(String kind) {
		// TODO Auto-generated method stub
		return dictionaryDao.findByKind(kind);
	}

	public Json deleteFile(String furl, String filename,String flgstr) {
		Json json = new Json();
		String msg="删除成功！";
		boolean bol = false;
		File file = new File(System.getProperty(Constant.WORKDIR)+furl);
		
		if(file.isDirectory()&&file.list().length==0){
			bol = file.delete();
		}else if(file.isDirectory()&&file.list().length>0){
			msg = "包含多个文件，不可删除！";
		}else{
			if(isEffectiveFile(furl, filename,flgstr)){
				msg = "有效文件，不可删除！";
			}else{
				bol = file.delete();
				if(!bol){
					msg = "文件不存在，不可删除！";
				}
			}
		}
		json.setJson(bol, msg);
		return json;
	}
	/**
	 * 
	 * @param furl
	 * @param filename
	 * @param flgstr
	 * @return true 有效；false无效
	 */
	public boolean isEffectiveFile(String furl, String filename,String flgstr){
		String str = furl.replace(flgstr+"/", "").replace("/"+filename, "");
		str = str.substring(0, str.indexOf("/"));
		String tbstrs[] = str.split("_");
		System.out.println("str>>>>"+str+"\t>>>"+tbstrs[0]+"\t>>>"+tbstrs[1]);
		String nnq = "select count(*) from hui_{0} where {1} like ?";
		if("BP".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", "project").replace("{1}", "bpurl");
			return isEffectiveFile(nnq,furl);
		}else if("banner".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", tbstrs[0]).replace("{1}", tbstrs[1].equals("icon")?tbstrs[1]:"pic_url");
			return isEffectiveFile(nnq,furl);
		}else if("project".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", "project").replace("{1}", tbstrs[1].equals("photo")?"logo":"img");
			return isEffectiveFile(nnq,furl);
		}else if("incubator".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", "incubator").replace("{1}",tbstrs[1].equals("coverspic")?"coverspic":"pic_url");
			return isEffectiveFile(nnq,furl);
		}else if("push".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", "chat_record").replace("{1}", tbstrs[1]);
			return isEffectiveFile(nnq,furl);
		}else if("comment".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", "comment").replace("{1}", "pimg");
			return isEffectiveFile(nnq,furl);
		}else if("investmenBank".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", "investmen_bank").replace("{1}", "logo");
			return isEffectiveFile(nnq,furl);
		}else if("investor".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", "investor_info").replace("{1}", tbstrs[1].equals("photo")?"business_card_url":"investorlogo");
			return isEffectiveFile(nnq,furl);
		}else if("news".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", "news").replace("{1}", tbstrs[1].equals("coverspic")?"coverspic":"pic_url");
			return isEffectiveFile(nnq,furl);
		}else if("roadshow".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", "roadshow").replace("{1}", tbstrs[1].equals("coverspic")?"coverspic":"pic_url");
			return isEffectiveFile(nnq,furl);
		}else if("serviceInfomation".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", "service_infomation").replace("{1}", "serviceInfomation_logo");
			return isEffectiveFile(nnq,furl);
		}else if("successfulDemo".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", "successful_demo").replace("{1}", tbstrs[1].equals("coverspic")?"coverspic":"show_image");
			return isEffectiveFile(nnq,furl);
		}else if("user".equals(tbstrs[0])){
			nnq = nnq.replace("{0}", "user").replace("{1}", "avator");
			return isEffectiveFile(nnq,furl);
		}
		return true;
	}
	
	/**
	 * 文件是否有效 true 有效；false无效
	 * @param nnq
	 * @param furl
	 * @return true 有效；false无效
	 */
	public boolean isEffectiveFile(String nnq,String furl){
		List<Object> params = Lists.newArrayList();
		params.add("%"+furl+"%");
		List list = this.dictionaryDao.executeNativeQuery(nnq, params);
		if(null!=list&&list.size()>0&&Integer.valueOf(list.get(0)+"")>0){
			return true;
		}else{
			return false;
		}
	}

	public Dictionary findByKindAndCode(String kind, String code) {
		return dictionaryDao.findByKindAndCode(kind, code).get(0);
	}

	public List<Dictionary> findByKindAndSuperCode(String kind, String superCode) {
		return dictionaryDao.findByKindAndSupercode(kind, superCode);
	}

	public List<Dictionary> findBySupercode(String superCode) {
		// TODO Auto-generated method stub
		return dictionaryDao.findBySupercode(superCode);
	}
}