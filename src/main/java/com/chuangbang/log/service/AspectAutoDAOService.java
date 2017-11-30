package com.chuangbang.log.service;

import org.aspectj.lang.annotation.Aspect;  
import org.springframework.stereotype.Component;  
  
  
/** 
 * DAO层AOP拦截器，实现记录用户操作过的所有方法和参数，并实现DAO层缓存 
 *  
 * @author Administrator 
 *  
 */  
@Aspect  
@Component  
public class AspectAutoDAOService {  
  /*
 @Autowired
 private UserOperationDao userOperationDao;  
  
 @Around("execution(* com.chuangbang.*.dao.*.*DAO.*(..))")  
 public Object before(ProceedingJoinPoint joinPoint) throws Throwable {  
  // 获取请求事务ID信息  
  ThreadId threadId = new ThreadBean().getThreadId();  
  // 调用方法名称  
  String methodName = joinPoint.getSignature().getName();  
  // 调用参数  
  Object[] args = joinPoint.getArgs();  
  Object object = null;  
  
  // 数据库更新操作日志  
  if (Pattern.matches("(save|insert|add|delete|remove|del|update)[\\S]*",  
    methodName)) {  
   if (threadId != null && threadId.getTransactionalId() != null) {  
    // 获取执行请求事务ID  
    String transactionalId = threadId.getTransactionalId();  
    // 获取执行请求用户ID  
    String userId = threadId.getUserId();  
    SysLogDetail sysLogDetail = new SysLogDetail();  
    sysLogDetail.setXh(transactionalId);  
    sysLogDetail.setUserId(userId);  
    sysLogDetail.setMethod(methodName);  
    JSONObject msg = new JSONObject();  
    // 处理参数  
    for (Object temp : args) {  
     // 获取参数类型,不同参数类型数据处理不一样  
     Class<? extends Object> paramClazz = temp.getClass();  
     String classType = paramClazz.getName();  
     if (classType.equals("java.lang.String")) {  
      msg.put("key", temp);  
     } else if (classType.equals("java.util.HashMap")) {  
      msg.putAll((HashMap<?, ?>) temp);  
     } else if (classType.startsWith("com.")) {  
      try {  
       Field[] f = paramClazz.getDeclaredFields();  
       for (Field field : f) {  
        String fieldName = field.getName();  
        field.setAccessible(true);  
        msg.put(fieldName, field.get(temp));  
       }  
      } catch (SecurityException e) {  
       e.printStackTrace();  
      } catch (IllegalArgumentException e) {  
       e.printStackTrace();  
      }  
     }  
    }  
    sysLogDetail.setMsg(msg.toString());  
    // 记录DAO数据库操作日志  
    SysLogDAO.insertSysLogDetail(sysLogDetail);  
   }  
   // 执行数据库操作  
   object = joinPoint.proceed();  
  
   // 数据库查询缓存  
  } else if (Pattern.matches("(query|load|get|select|read)[\\S]*",  
    methodName)) {  
   // DAO层缓存注解  
   MemCacheKey cacheKey = new MemCacheKey();  
   // 获取cache注解属性  
   Cache cache = null;  
   // 获取请求方法  
   Class<?> cls = joinPoint.getTarget().getClass();  
   // 获取class中的所有方法  
   Method[] methods = cls.getMethods();  
   for (Method m : methods) {  
    // 获取执行方法前的注解信息。  
    if (m.getName().equals(methodName)) {  
     cache = m.getAnnotation(Cache.class);  
     break;  
    }  
   }  
  
   if (cache != null) {  
    // 获取memcacheKey,并进行MD5加密  
    cacheKey = memcacheKey(cache, args);  
    // 判断缓存服务器是否存在该可以值  
    if (memcache.exist(cacheKey.getMemcacheKey())) {  
     object = memcache.get(cacheKey.getMemcacheKey());  
    } else {  
     // 执行数据库操作  
     object = joinPoint.proceed();  
     // 将数据存放进缓存  
     if (cacheKey.getMemcacheKey() != null) {  
      memcache.put(cacheKey.getMemcacheKey(),  
        object == null ? "" : object, new Date(cacheKey  
          .getTime()));  
     }  
    }  
   } else {  
    // 执行数据库操作  
    object = joinPoint.proceed();  
   }  
  } else {  
   // 执行数据库操作  
   object = joinPoint.proceed();  
  }  
  
  return object;  
  
 }  
  
 *//** 
  * 获取根据注解中的key获取memcache的含参数key值 
  *  
  * @param cache 
  * @param parameterObject 
  * @return 
  * @author fei.zhao 2011-10-10 
  *//*  
 @SuppressWarnings("unchecked")  
 private static MemCacheKey memcacheKey(Cache cache, Object[] args) {  
  MemCacheKey tempKey = new MemCacheKey();  
  String key = "";  
  boolean flag = true;  
  StringBuilder keyBuilder = new StringBuilder(32);  
  // 获取注解中的key值  
  String cacheKey = cache.key();  
  Object[] cacheArgs = cacheKey.split("\\.");  
  
  // 设置请求参数在args[]中的序号  
  // key参数进行循环遍历  
  for (Object s : cacheArgs) {  
   // 判断是否是格式$,$...  
   if (s.toString().startsWith("$")) {  
    // 获取参数名称  
    String type = s.toString().substring(1);  
    // 获取参数值  
    Object temp = args[0];  
    // 获取参数类型,不同参数类型数据处理不一样  
    Class<? extends Object> paramClazz = temp.getClass();  
    String classType = paramClazz.getName();  
    if (classType.equals("java.lang.String")) {  
     keyBuilder.append(temp);  
    } else if (classType.equals("java.util.HashMap")) {  
     keyBuilder.append(((HashMap) temp).get(type));  
    } else if (classType.startsWith("com.")) {  
     try {  
      Field f = paramClazz.getDeclaredField(type);// 实体中字段  
      f.setAccessible(true);// 允许访问私有字段  
      keyBuilder.append(f.get(temp));  
     } catch (SecurityException e) {  
      flag = false;  
      e.printStackTrace();  
     } catch (NoSuchFieldException e) {  
      flag = false;  
      e.printStackTrace();  
     } catch (IllegalArgumentException e) {  
      flag = false;  
      e.printStackTrace();  
     } catch (IllegalAccessException e) {  
      flag = false;  
      e.printStackTrace();  
     }  
    }  
   } else {  
    keyBuilder.append(s);  
   }  
   // 每个参数后面添加 “.”号分隔  
   keyBuilder.append(".");  
  }  
  if (args.length == 3) {  
   keyBuilder.append(args[1] + ".").append(args[2]);  
  }  
  if (flag == true) {  
   key = keyBuilder.toString();  
   tempKey.setMemcacheKey(DateSHA.shaEncrypt(key));  
   tempKey.setTime(cache.time());  
  }  
  return tempKey;  
 }  */
}  