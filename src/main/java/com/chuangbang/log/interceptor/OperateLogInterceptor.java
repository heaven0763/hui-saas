package com.chuangbang.log.interceptor;

import java.text.SimpleDateFormat;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.Ordered;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.framework.entity.IdEntity;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.spring.SpringUtils;
import com.chuangbang.log.entity.operation.UserOperation;
import com.chuangbang.log.service.operation.UserOperationService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Aspect  
//@Component  
public class OperateLogInterceptor implements Ordered{
	
	private static Logger logger = LoggerFactory.getLogger(OperateLogInterceptor.class);
	
	private int order = 1;  
	
	@Autowired
	private UserOperationService userOperationService;  
	      
	//切入，要排除自身，否则出现堆栈死循环
	@Around("execution(* com.chuangbang.framework.service.BaseService*.save*(..)) AND NOT execution(* com.chuangbang.log.service.operation.userOperationService.*(..)) ") 
	//@Around("execution(* com.chuangbang.oa.service.check.Test.*(..)) AND NOT execution(* com.chuangbang.log.service.operation.userOperationService.*(..)) ")
	public Object serviceIntercept(ProceedingJoinPoint point) throws Throwable{
    	// 调用方法名称   
        String methodName = null;
        // 调用参数  
        Object[] args = null;
        
        Object result = null;
        
        Object newObj = null;
        
        Object oldObj = null;
        
        BaseRepository baseRepository = null;
        
        ObjectMapper mapper = new ObjectMapper(); 
        
        JsonNode jsonNode = null;
        
      //设置json 格式
    	mapper.setDateFormat(new SimpleDateFormat(DateTimeUtils.PATTERN_TO_SECOND));
        
        try {
	        if(point instanceof MethodInvocationProceedingJoinPoint){  
	            MethodInvocationProceedingJoinPoint mpoint = (MethodInvocationProceedingJoinPoint)point;  
	            //  
	            // 调用方法名称  
	            methodName = point.getSignature().getName();  
	            // 调用参数  
	            args = point.getArgs();
	            newObj = args[0];
	            //判断是否是实体
	            if(newObj instanceof IdEntity){
	            	Long id = ((IdEntity) newObj).getId();
	            	//是修改的情况而不是新增
	            	if(id != null){
	            		//先json化对象，不然无法记录对象当前状态
	            		//获取实体的名字
	            		String entityName = newObj.getClass().getSimpleName();
	            		baseRepository = (BaseRepository) SpringUtils.getBean(entityName.substring(0,1).toLowerCase()+entityName.substring(1) + "Dao");
	            		
	            		oldObj = baseRepository.findOne(id);
	            		logger.warn( "修改前："+mapper.writeValueAsString(oldObj));  
	            		//先json化对象，不然无法记录对象当前状态
	            		//jsonNode = mapper.readTree(mapper.writeValueAsBytes(oldObj));
	            		//再转换成bean
	            		//oldObj = mapper.readValues(jsonNode, oldObj.getClass());
	            	}
	            }
	            
	            System.out.println("进入了方法。methodName:"+methodName+"。。thread id:"+Thread.currentThread().getId());
	            result = mpoint.proceed(args);
	            System.out.println("退出了方法。。。");
	        }
        
        	
        	
        	
        	String content = mapper.writeValueAsString(args);
        	//生成操作记录对象
        	UserOperation  userOperation = new UserOperation();
        	
        	userOperation.setHost(AccountUtils.getHost());
        	userOperation.setUserId(AccountUtils.getCurrentUserId());
        	userOperation.setUserName(AccountUtils.getCurrentUserLoginName());
        	userOperation.setOperateTime(AccountUtils.getCurrentDate());
        	userOperation.setOperateTable(null);
        	userOperation.setOperateContent(methodName+":"+content);
        	
            System.out.println("记录日志开始");  
            //userOperationService.saveEntity(userOperation);  
            logger.warn( "修改f**g**f前："+mapper.writeValueAsString(oldObj));  
            logger.warn( "修改f**g**f后："+mapper.writeValueAsString(newObj));  
            System.out.println("记录日志结束");  
        }catch(Exception ex) {
        	logger.warn( ex.getLocalizedMessage());  
        }  
        return result;  
    }  
	      
	    public void setOrder(int order){  
	        this.order = order;  
	    }  
	    @Override
		public int getOrder() {  
	        return order;  
	    }  
	}  
