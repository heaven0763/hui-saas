package com.chuangbang.js.service.account;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.chuangbang.framework.util.CipherUtil;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.MobileUtil;
import com.chuangbang.js.dao.account.GroupDao;
import com.chuangbang.js.dao.account.UserDao;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.Logininfo;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.shiro.CaptchaException;
import com.chuangbang.js.shiro.UnValidationException;
import com.chuangbang.js.shiro.UsernamePasswordCaptchaToken;

/**
 * 自实现用户与权限查询.
 * 演示关系，密码用明文存储，因此使用默认 的SimpleCredentialsMatcher.
 */
public class ShiroDbRealm extends AuthorizingRealm {

	@Autowired
	private UserDao userDao;
	@Autowired
	private GroupDao groupDao;
	
	@Autowired
	private LogininfoService logininfoService;
	
	/*@Autowired
    private MemcachedClient memcachedClient;*/
	 
	/**认证
	 * 认证回调函数, 登录时调用.
	 * 认证用户是谁
	 * （认证/登录方法）会返回一个AuthenticationInfo,就是认证信息。
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
		UsernamePasswordCaptchaToken token = (UsernamePasswordCaptchaToken) authcToken;
		//UsernamePasswordToken token =(UsernamePasswordToken)authcToken;
		//加密后的密码
		token.setPassword(CipherUtil.generatePassword(new String(token.getPassword())).toCharArray());
		//记录登录日志
		Logininfo logininfo= new Logininfo();
		logininfo.setHost(token.getHost());
		logininfo.setUsername(token.getUsername());
		logininfo.setLogtime(AccountUtils.getCurrentTimestamp());
		return getAuthenticationInfo(token, logininfo) ;
	}

	/**
	 * 认证
	 * @param token
	 * @param logininfo
	 * @return
	 */
	private AuthenticationInfo getAuthenticationInfo(UsernamePasswordCaptchaToken token,Logininfo logininfo){
		// 增加判断验证码逻辑
		String captcha = token.getCaptcha();
		System.out.println("captcha>>>"+captcha);
		String exitCode = (String) SecurityUtils.getSubject().getSession().getAttribute("KEY_CAPTCHA");
		System.out.println("exitCode>>>"+exitCode);
		if (null == captcha || !captcha.equalsIgnoreCase(exitCode)) {
			throw new CaptchaException("验证码错误");
		}
		User user  = null;
		if(MobileUtil.isMobileNO(token.getUsername())){
			user  = userDao.findByMobile(token.getUsername());
		}else if(MobileUtil.isMobileNO(token.getUsername())){
			user  = userDao.findByEmail(token.getUsername());
		}else{
			user  = userDao.findByUsername(token.getUsername());
		}
		if (user != null) {
			if("1".equals(user.getLocked())) {
				logininfo.setMessage("锁定用户登录失败");
				logininfoService.saveLogininfo(logininfo);
				throw new LockedAccountException();
			}
			if(!"CLIENT".equals(user.getUserType())&&"0".equals(user.getState())) {
				logininfo.setMessage("您已离职，不可再使用本系统！");
				logininfoService.saveLogininfo(logininfo);
				throw new DisabledAccountException();
			}
			if("CLIENT".equals(user.getUserType())&&!"1".equals(user.getIsvalid())) {//"CLIENT".equals(user.getUserType())&&
				logininfo.setMessage("账号尚未验证，不能登录！");
				logininfoService.saveLogininfo(logininfo);
				throw new UnValidationException();
			}
			SimpleAuthenticationInfo sati = new SimpleAuthenticationInfo(user, user.getPassword(),getName());
			if(user.getPassword().equals(new String(token.getPassword()))){
				SecurityUtils.getSubject().getSession().setAttribute("user", user);
				logininfo.setMessage("登录成功");
				logininfoService.saveLogininfo(logininfo);
				return sati;
			}else{
				throw new AuthenticationException();
			}
			
		} else {
			logininfo.setMessage("没用该用户登录失败");
			logininfoService.saveLogininfo(logininfo);
			throw new UnknownAccountException();
		}
	}
	/**
	 * 认证
	 * @param token
	 * @param logininfo
	 * @return
	 */
	private AuthenticationInfo getAuthenticationInfo(UsernamePasswordToken token,Logininfo logininfo){
		// 增加判断验证码逻辑
		User user = null;
		user = userDao.findByUsername(token.getUsername());
		if (user != null) {
			/*if ("1".equals(user.getLocked())) {
				logininfo.setMessage("锁定用户登录失败");
				logininfoService.saveLogininfo(logininfo);
				throw new LockedAccountException();
			}*/
			SimpleAuthenticationInfo sati = new SimpleAuthenticationInfo(user, user.getPassword(),getName());
			
			if(user.getPassword().equals(new String(token.getPassword()))){
				SecurityUtils.getSubject().getSession().setAttribute("user", user);
				logininfo.setMessage("登录成功");
				logininfoService.saveLogininfo(logininfo);
				return sati;
			}else{
				throw new AuthenticationException();
			}
		} else {
			logininfo.setMessage("没用该用户登录失败");
			logininfoService.saveLogininfo(logininfo);
			throw new UnknownAccountException();
		}
	}
	
	
	/**授权
	 * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用.
	 * 认证用户权限，最终判定用户是否被允许做某件事的机制。
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		return getBgAuthorizationInfo(principals);
	}

	/**
	 * 授权
	 * @param principals
	 * @return
	 */
	private AuthorizationInfo getBgAuthorizationInfo(PrincipalCollection principals){
		User shiroUser = (User) principals.fromRealm(getName()).iterator().next();
		User user = userDao.findByUsername(shiroUser.getUsername());
		if (user != null) {
			SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
			Group group = groupDao.findOne(user.getGroupId());
			//基于用户组的权限信息
			info.addRole(group.getGroupId());
			//基于Permission的权限信息
			info.addStringPermissions(group.getPermissionList());
			return info;
		} 
		return null;
	}
	
	/**
	 * 更新用户授权信息缓存.
	 */
	public void clearCachedAuthorizationInfo(String principal) {
		SimplePrincipalCollection principals = new SimplePrincipalCollection(principal, getName());
		clearCachedAuthorizationInfo(principals);
	}

	/**
	 * 清除所有用户授权信息缓存.
	 */
	public void clearAllCachedAuthorizationInfo() {
		Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();
		if (cache != null) {
			for (Object key : cache.keys()) {
				cache.remove(key);
			}
		}
	}
}