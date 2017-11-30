package com.chuangbang.base.service.user;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.chuangbang.base.entity.user.PointsAccount;
import com.chuangbang.base.dao.user.PointsAccountDao;

/**
 * 积分账户Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class PointsAccountService extends BaseService<PointsAccount,PointsAccountDao> {

	@Autowired
	private PointsAccountDao pointsAccountDao;
	
	public PointsAccount getEntity(Long id) {
		return pointsAccountDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void savePointsAccount(PointsAccount pointsAccount) {
		pointsAccountDao.save(pointsAccount);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		pointsAccountDao.delete(id);
	}
	
	public PointsAccount findByClientTypeAndClientId(String clientType, String clientId) {
		return pointsAccountDao.findByClientTypeAndClientId(clientType,clientId);
	}

	public Map<String, Object> count(String type) {
		Map<String, Object> res = Maps.newHashMap();
		String nnq = "select sum(total_points) totalPoints, sum(cash_points) cashPoints, sum(balance_points) balancePoints  FROM hui_points_account act";
		if("HOTEL".equals(type)){
			if("HUI".equals(AccountUtils.getCurrentUserType())){
				nnq +=" where act.client_type=? ";
			}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
				nnq +=" left join hui_hotel h on h.id =act.client_id ";
				nnq +=" where act.client_type=? and h.company_id="+AccountUtils.getCurrentUserCompanyId();
			}
		}else{
			nnq +=" where act.client_type=? ";
		}
		
		List<Object> params = Lists.newArrayList();
		params.add(type);
		List<Object> list = this.pointsAccountDao.executeNativeQuery(nnq, params);
		
		if(list!=null&&list.size()>0){
			Object []o = (Object[]) list.get(0);
			res.put("totalPoints", o[0]==null?0:o[0]);
			res.put("cashPoints",  o[1]==null?0:o[1]);
			res.put("balancePoints", o[2]==null?0:o[2]);
		}
		return res;
	}
	
}
