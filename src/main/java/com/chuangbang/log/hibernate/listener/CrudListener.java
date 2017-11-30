package com.chuangbang.log.hibernate.listener;

import java.text.SimpleDateFormat;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.event.spi.PostDeleteEvent;
import org.hibernate.event.spi.PostDeleteEventListener;
import org.hibernate.event.spi.PostInsertEvent;
import org.hibernate.event.spi.PostInsertEventListener;
import org.hibernate.event.spi.PostUpdateEvent;
import org.hibernate.event.spi.PostUpdateEventListener;
import org.hibernate.persister.entity.EntityPersister;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.chuangbang.framework.entity.IdEntity;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.spring.SpringUtils;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.log.entity.Auditable;
import com.chuangbang.log.entity.operation.UserOperation;
import com.chuangbang.log.service.operation.UserOperationService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Maps;

/** 
 * Hibernate增删改监听器，记录审记日志 
 * <p>类名称：EntityCrudListener</p> 
 * <p>类描述：post方法在数据更新后执行,pre方法在数据更新前执行 </p> 
 * <p>创建人：dg</p> 
 * <p>创建时间：Sep 26, 2012 2:39:52 PM </p> 
 * <p>修改人：dg</p> 
 * <p>修改时间：Sep 26, 2012 2:39:52 PM </p> 
 * <p>修改备注：   </p> 
 * @version 
 */  
public class CrudListener implements PostInsertEventListener,    
        PostUpdateEventListener, PostDeleteEventListener {  
    private static final long serialVersionUID = 1L;  
      
    private static final String INSERT = "INSERT";
      
    private static final String UPDATE = "UPDATE";
      
    private static final String DELETE = "DELETE";
      
    /** 
     * 允许或不允许全部时，指定all即可 
     */  
    public static final String ALL = "all";  
      
    private final Logger logger = LoggerFactory.getLogger(this.getClass());  
      
    /** 
     * 配置操作对象的记录策略 
     */  
    private Map<String,Map<String,String>> auditableEntitys = Maps.newHashMap();  
    
    ObjectMapper mapper = new ObjectMapper();
    {
    	//设置json 格式
    	mapper.setDateFormat(new SimpleDateFormat(DateTimeUtils.PATTERN_TO_SECOND));
    }
      
	
	//@Autowired
	private UserOperationService userOperationService;  
	
	private CrudListener crudListener;
      
    @Override    
    public void onPostInsert(PostInsertEvent event) {
    	try{
            logger.debug("onPostInsert:{event.getEntity()={},event.getEntity().getClass()={}}",new Object[]{event.getEntity(),event.getEntity().getClass()});
            init();
            if (auditableEntitys.containsKey(event.getEntity().getClass().getSimpleName())  
	                && event.getEntity() instanceof IdEntity) {  
	            
	            
	            //  保存 插入日志
	            UserOperation userOperation = newUserOperation(event.getEntity());  
	            userOperation.setOperateTable(event.getEntity().getClass().getSimpleName());  
	            userOperation.setOperateId(((IdEntity)event.getEntity()).getId().toString());  
	            userOperation.setOperateType(INSERT);  
	            {
	            	Map<String,Object> columns = Maps.newHashMap();
	                Object[] state = event.getState();  
	                String[] fields = event.getPersister().getPropertyNames();
	                String content = "";  
	                if(state != null && fields != null  
	                        && state.length == fields.length){  
	                    for(int i = 0 ; i < fields.length ; i ++){  
	                        if(isLog(event.getEntity(),fields[i],INSERT)){
	                        	columns.put(fields[i], state[i]);
	                        }  
	                    }  
	                }
	                content = mapper.writeValueAsString(columns);
	                //只保存4000个字符
	                userOperation.setNewData(StringUtils.substring(content, 0, 4000));  
	            }  
	            logger.debug("插入操作日志 INSERT UserOperation ");  
	            persistUserOperation(event.getSession(),userOperation,event.getEntity());
	        }
    	}catch(Throwable e){
    		logger.warn("记录操作日志发生错误：", e);
    	}
    }    
    
    @Override    
    public void onPostUpdate(PostUpdateEvent event) {
    	try{
    		 logger.debug("onPostUpdate:event.getEntity()={}",event.getEntity());
    		 init();
	        if (auditableEntitys.containsKey(event.getEntity().getClass().getSimpleName())  
	                && event.getEntity() instanceof IdEntity) {  
	            
	            // 保存 修改日志   
	            UserOperation userOperation = newUserOperation(event.getEntity());  
	            userOperation.setOperateTable(event.getEntity().getClass().getSimpleName());  
	            userOperation.setOperateId(((IdEntity)event.getEntity()).getId().toString());  
	            userOperation.setOperateType(UPDATE);  
	            {  
	                Object[] oldState = event.getOldState();  
	                Object[] newState = event.getState();  
	                String[] fields = event.getPersister().getPropertyNames();  
	                
	                Map<String,Object> oldColumns = Maps.newHashMap();
	                Map<String,Object> newColumns = Maps.newHashMap();
	                String oldContent = "";  
	                String newContent = "";  
	                if(oldState != null && newState != null && fields != null  
	                        && oldState.length == newState.length && oldState.length == fields.length){  
	                    for(int i = 0 ; i < fields.length ; i ++){
	                        if(isLog(event.getEntity(),fields[i],UPDATE)){  
	                            if((newState[i] == null && oldState[i] != null)  
	                                    || (newState[i] != null && !newState[i].equals(oldState[i]) )){  
	                            	oldColumns.put(fields[i], oldState[i]);
	                            	newColumns.put(fields[i], newState[i]);
	                            }  
	                        }  
	                    }  
	                }
	                oldContent = mapper.writeValueAsString(oldColumns);
	                newContent = mapper.writeValueAsString(newColumns);
	                //只保存4000个字符
	                userOperation.setOldData(StringUtils.substring(oldContent, 0, 4000));
	                userOperation.setNewData(StringUtils.substring(newContent, 0, 4000));
	                
	                //userOperation.setContent("[" + content + "]");  
	            }  
	            logger.debug("插入操作日志 UPDATE UserOperation ");  
	            persistUserOperation(event.getSession(),userOperation,event.getEntity());
	        }
    	}catch(Throwable e){
    		logger.warn("记录操作日志发生错误：", e);
    	}
    }  
  
    @Override    
    public void onPostDelete(PostDeleteEvent event) {
    	try{
    		logger.debug("onPostDelete:event.getEntity()={}",event.getEntity());
    		init();
	        if (auditableEntitys.containsKey(event.getEntity().getClass().getSimpleName())  
	                && event.getEntity() instanceof IdEntity) {
	            // 保存 删除日志  
	            UserOperation userOperation = newUserOperation(event.getEntity());  
	            userOperation.setOperateTable(event.getEntity().getClass().getSimpleName());  
	            userOperation.setOperateId(((IdEntity)event.getEntity()).getId().toString());  
	            userOperation.setOperateType(DELETE);  
	            {  
	                Object[] state = event.getDeletedState();  
	                String[] fields = event.getPersister().getPropertyNames();  
	                
	                Map<String,Object> columns = Maps.newHashMap();
	                String content = "";  
	                if(state != null && fields != null  
	                        && state.length == fields.length){  
	                    for(int i = 0 ; i < fields.length ; i ++){  
	                        if(isLog(event.getEntity(),fields[i],DELETE)){
	                        	columns.put(fields[i], state[i]);
	                        }  
	                    }  
	                }
	                content = mapper.writeValueAsString(columns);
	                //只保存4000个字符
	                userOperation.setOldData(StringUtils.substring(content, 0, 4000));  
	            }  
	            logger.debug("插入操作日志 DELETE UserOperation ");  
	            persistUserOperation(event.getSession(),userOperation,event.getEntity());
	        }
    	}catch(Throwable e){
    		logger.warn("记录操作日志发生错误：", e);
    	}
    }  
      
  
    /** 
     * 创建日志对象，同时设置操作人操作时间等信息 
     * @Title: newUserOperation  
     * @return UserOperation 
     * @throws 
     */  
    private UserOperation newUserOperation() {
        UserOperation userOperation = new UserOperation();
        
        logger.debug("AccountUtils.getCurrentUser()={}",AccountUtils.getCurrentUser());
        logger.debug("AccountUtils.getHost()={}",AccountUtils.getHost());
    	userOperation.setHost(AccountUtils.getHost());
    	userOperation.setUserName(AccountUtils.getCurrentUserLoginName());
    	userOperation.setOperateTime(AccountUtils.getCurrentDate());
    	
        return userOperation;  
    }  
    
    /** 
     * 创建日志对象，同时设置操作人操作时间等信息 
     * @Title: newUserOperation  
     * @return UserOperation 
     * @throws 
     */  
    private UserOperation newUserOperation(Object obj) {
        UserOperation userOperation = new UserOperation();
        Object object = SecurityUtils.getSubject().getPrincipal();
		if(object instanceof User){
			logger.debug("AccountUtils.getCurrentUser()={}",AccountUtils.getCurrentUser());
			userOperation.setUserName(AccountUtils.getCurrentUserLoginName());
			userOperation.setUserId(AccountUtils.getCurrentUserId());
		}else {
			logger.debug("Trip User operate={}",obj.getClass().getSimpleName());
			userOperation.setUserName("");
		}
        logger.debug("AccountUtils.getHost()={}",AccountUtils.getHost());
    	userOperation.setHost(AccountUtils.getHost());
    	userOperation.setOperateTime(AccountUtils.getCurrentDate());
        return userOperation;  
    }  
      
    /** 
     * 验证策略是否允许记录日志，规则如下： 
     * <ol> 
     * <li>可用的关键字有：insertAllow,insertDeny,updateAllow,updateDeny,deleteAllow,deleteDeny</li> 
     * <li>没有配置对象的策略，所有字段不记录</li> 
     * <li>allow和deny都配置的按allow验证，并忽略deny</li> 
     * <li>allow和deny都允许指定all关键字</li> 
     * <li>多个字段用英文逗号隔开</li> 
     * </ol> 
     * @Title: isLog  
     * @param entity 
     * @param string 
     * @param string2 
     * @return boolean 
     * @throws 
     */  
    private boolean isLog(Object entity, String field, String op) {  
        Map<String,String> entityConfig = auditableEntitys.get(entity.getClass().getSimpleName());  
        if(entityConfig != null){  
            String allowFields = entityConfig.get(op.toLowerCase() + "Allow");  
            if(allowFields != null){  
                if(allowFields.equals(ALL) || containsField(allowFields,field)){  
                    //配置ALL，所有允许  
                    return true;  
                }  
            }else{  
                String denyFields = entityConfig.get(op.toLowerCase() + "Deny");  
                if(denyFields != null){  
                    if(denyFields.equals(ALL) || containsField(denyFields,field)){  
                        //配置ALL，所有不允许  
                        return false;  
                    }  
                }  
                return true;  
            }  
        }else{  
        }  
        //缺省不记录  
        return false;  
    }  
  
    /** 
     * 配置中是否包含当前字段 
     * @Title: containsField  
     * @param fields 
     * @param field 
     * @return boolean 
     * @throws 
     */  
    private boolean containsField(String fields, String field) {  
        String[] fs = fields.split(",");  
        for(String f : fs){  
            if(f.equals(field)){  
                return true;  
            }  
        }  
        return false;  
    }  
      
    /** 
     * 向content追加一个修改项 
     * @Title: addStr  
     * @param oldState 
     * @param newState 
     * @param fields 
     * @param content 
     * @param i 
     * @return String 
     * @throws 
     */  
    private String addStr(Object[] oldState, Object[] newState,  
            String[] fields, String content, int i) {  
        if(content.length() < 1000){  
            if(content.length() > 0){  
                content += ",";  
            }  
            content += "{columnName:\"" + fields[i] +   
                "\",oldValue:\"" + (oldState == null ? "" : String.valueOf(oldState[i])) +   
                "\",newValue:\"" + String.valueOf(newState[i]) + "\"}";  
        }else{  
            logger.warn("操作长度超过1000");  
        }  
        return content;  
    }    
  
    /** 
     * 初始化操作日志服务类 
     * @Title: init  void 
     * @throws 
     */  
    private void init(){  
        if(userOperationService == null){  
            //WebApplicationContext context =WebApplicationContextUtils.getWebApplicationContext(SessionAgentTool.getSession().getRealHttpSession().getServletContext());  
            userOperationService = (UserOperationService) SpringUtils.getBean("userOperationService");
        }
        if(auditableEntitys.size() == 0){  
            //WebApplicationContext context =WebApplicationContextUtils.getWebApplicationContext(SessionAgentTool.getSession().getRealHttpSession().getServletContext());  
        	crudListener = (CrudListener) SpringUtils.getBean("crudListener");
        	this.auditableEntitys = crudListener.getAuditableEntitys();
        	logger.debug("this.auditableEntitys={}",crudListener.getAuditableEntitys());
        }  
    }  
  
    public void setAuditableEntitys(  
            Map<String, Map<String, String>> auditableEntitys) {  
        this.auditableEntitys = auditableEntitys;  
    }
    public Map<String, Map<String, String>> getAuditableEntitys(){
    	return this.auditableEntitys;
    }
    
    
    /**
     * 阻止监听死循环
     * @param session
     * @param userOperation
     * @param entityClass
     */
    public void persistUserOperation(Session session, UserOperation userOperation, Object entityClass){
    //通过标记接口,阻止死循环
		if(!(entityClass instanceof Auditable)){
			//userOperationService.saveEntity(userOperation);
			//开启新事务
		    Session temp = session.getSessionFactory().openSession();    
		    Transaction tx = null;    
		    try {
			    tx = temp.beginTransaction();    
			    temp.save(userOperation);    
			    tx.commit();
		    } catch (Exception e) {
		    	tx.rollback();
		    	logger.warn("保存操作日志失败：",e);
		    } finally{
		    	temp.close();
		    }
		}    
    }

	/*@Override
	public boolean requiresPostCommitHanding(EntityPersister arg0) {
		// TODO Auto-generated method stub
		return false;
	}  */  
}    