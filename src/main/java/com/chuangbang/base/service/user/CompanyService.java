package com.chuangbang.base.service.user;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.CompanyModel;
import com.chuangbang.base.dao.user.CompanyDao;
import com.chuangbang.base.entity.order.Order;
import com.chuangbang.base.entity.user.Company;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.hibernate.DynamicSqlHelper;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.google.common.collect.Lists;

/**
 * 企业信息Service
 * @author heaven
 * @version 2016-11-18
 */
@Component
@Transactional(readOnly = true)
public class CompanyService extends BaseService<Company,CompanyDao> {

	@Autowired
	private CompanyDao companyDao;

	@Autowired
	private CusQueryService cusQueryService;

	public Company getEntity(Long id) {
		return companyDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveCompany(Company company) {
		if(null==company.getId()){
			company.setState("0");
			company.setCreateDate(new Date());
			company.setApplyDate(new Date());
		}
		companyDao.save(company);
	}

	@Transactional(readOnly = false)
	public void delete(Long id) {
		companyDao.delete(id);
	}

	@Transactional(readOnly = false)
	public JsonVo updateEffectiveDate(Long companyId, Date seffectivedate, Date eeffectivedate) {
		try{
			Company company = this.getEntity(companyId);
			company.setSeffectiveDate(seffectivedate);
			company.setEeffectiveDate(eeffectivedate);
			companyDao.save(company);
		}catch(Exception e){
			return JsonUtils.error("修改失败");
		}
		return JsonUtils.success("修改成功");
	}


	public List<CompanyModel> getPageList(PageBean<CompanyModel> pageBean) {

		String columstr =DynamicSqlHelper.getMappingColumnStr("c.", Company.class);
		columstr+=" u.rname rname,u.mobile mobile,u.email email,p.region_name provinceTxt,r.region_name cityTxt,d.region_name districtTxt";
		String fromWhere = " from hui_company c left join hui_user u on u.id=c.apply_user_id"
				+ " left join hui_region r on r.id=c.city left join hui_region p on p.id=c.province left join hui_region d on d.id=c.district"
				+ " where 1=1 ";
		return cusQueryService.page(pageBean, columstr+fromWhere, CompanyModel.class,null);
	} 
	
	
	public CompanyModel getOne(Long id) {
		String columstr =DynamicSqlHelper.getMappingColumnStr("c.", Company.class);
		columstr+=" u.rname rname,u.mobile mobile,u.email email,p.region_name provinceTxt,r.region_name cityTxt,d.region_name districtTxt";
		String fromWhere = " from hui_company c left join hui_user u on u.id=c.apply_user_id"
				+ " left join hui_region r on r.id=c.city left join hui_region p on p.id=c.province left join hui_region d on d.id=c.district"
				+ " where 1=1 and c.id="+id;
		return cusQueryService.getOne(columstr+fromWhere, CompanyModel.class, null);
	} 
	
	public Long countHotel(Long id){
		String nnq = "select count(*) from hui_hotel where company_id=?";
		List<Object> params = Lists.newArrayList();
		params.add(id);
		List<Object> list = this.companyDao.executeNativeQuery(nnq, params);
		if(list!=null&&list.size()>0){
			return list.get(0)==null?0L:Long.valueOf(list.get(0)+"");
		}
		return 0L;
	}
	
	public Double allAmount(Long id,String sdate,String edate){
		String nnq = "select sum(amount) from hui_order o left join hui_hotel h on h.id=o.hotel_id where h.company_id=? and o.settlement_status = '04' "
				+ "and o.settlement_date>=? and o.settlement_date<=? ";
		List<Object> params = Lists.newArrayList();
		params.add(id);
		params.add(sdate);
		params.add(edate);
		List<Object> list = this.companyDao.executeNativeQuery(nnq, params);
		if(list!=null&&list.size()>0){
			return list.get(0)==null?0D:Double.valueOf(list.get(0)+"");
		}
		return 0D;
	}
	public Double yearAmount(Long id,String year){
		String sdate = year+"-01-01 00:00:00.000";
		String edate = year+"-12-31 23:59:59.889";
		String nnq = "select sum(amount) from hui_order o left join hui_hotel h on h.id=o.hotel_id  where h.company_id=? and o.settlement_status = '04' "
				+ "and o.settlement_date>=? and o.settlement_date<=? ";
		List<Object> params = Lists.newArrayList();
		params.add(id);
		params.add(sdate);
		params.add(edate);
		List<Object> list = this.companyDao.executeNativeQuery(nnq, params);
		if(list!=null&&list.size()>0){
			return list.get(0)==null?0D:Double.valueOf(list.get(0)+"");
		}
		return 0D;
	}
}
