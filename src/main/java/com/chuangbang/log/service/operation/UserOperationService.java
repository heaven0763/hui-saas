package com.chuangbang.log.service.operation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.log.dao.operation.UserOperationDao;
import com.chuangbang.log.entity.operation.UserOperation;
import com.chuangbang.wechat.hui.model.UserOperationModel;
import com.google.common.collect.Lists;


@Component
@Transactional(readOnly = true)
public class UserOperationService  extends BaseService<UserOperation, UserOperationDao>{
	@Autowired
	private UserOperationDao userOperationDao;
	@Autowired
	private CusQueryService cusQueryService;
	public void log(UserOperation userOperation){
		/*String sql = "insert into log_user_opetation ()";
		List<Object> params = null;
		tDao.executeNativeSQL(sql, params);*/
		this.saveEntity(userOperation);
	}

	public List<UserOperation> findByOperateTableAndOperateId(String operateTable, String operateId) {
		return userOperationDao.findByOperateTableAndOperateId(operateTable, operateId);
	}
	
	public List<UserOperationModel> findByOperateLog(PageBean<UserOperationModel> pageBean){
		String sql = "select l.id id,l.operate_id operateId,l.old_data oldData,l.new_data newData,l.operate_time operateTime"
				+ ",l.operate_type operateType,u.rname rname,u.position position"
				+ " from hui_log_operation l left join hui_user u on l.user_name = u.username"
				+ " where 1=1 ";
		List<Object> paras = Lists.newArrayList();
		pageBean.setSort("l.id");
		List<UserOperationModel> userOperationModels= cusQueryService.getAll(pageBean, sql, UserOperationModel.class, paras);
		return userOperationModels;
	}
}
