package com.chuangbang.base.service.order;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.CommentModel;
import com.chuangbang.app.model.CommentSumModel;
import com.chuangbang.base.dao.order.EvaluateDao;
import com.chuangbang.base.entity.order.Evaluate;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.hibernate.DynamicSqlHelper;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;

/**
 * 评价表Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class EvaluateService extends BaseService<Evaluate,EvaluateDao> {

	@Autowired
	private EvaluateDao evaluateDao;
	@Autowired
	private CustomPageService customPageService;
	
	public Evaluate getEntity(Long id) {
		return evaluateDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveEvaluate(Evaluate evaluate) {
		evaluateDao.save(evaluate);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		evaluateDao.delete(id);
	}
	
	public List<CommentModel> getCommentPageList(PageBean<CommentModel> pageBean) {
		String columstr ="e.id as id, e.evaluate_type as evaluateType, e.order_no as orderNo, ifnull(o.amount,0) as orderAmount, e.star as star, e.hotel_id as hotelId, e.hotel_name as hotelName"
				+ ", e.item_type as itemType, e.item_id as itemId, e.item_name as itemName, e.goods_evaluation as goodsEvaluation, e.attitude as attitude, e.response_speed as responseSpeed"
				+ ", e.facilities as facilities, e.hygiene as hygiene, e.service as service, e.location as location, e.comprehensive as comprehensive, e.experience as experience"
				+ ", e.follow as follow, e.benefit as benefit, e.tag as tag, e.econtent as econtent, e.user_id as userId, e.user_name as userName, e.isanonymous as isanonymous"
				+ ", e.evaluate_date as evaluateDate, e.create_date as createDate, e.memo as memo";
		String fromWhere = "  from hui_evaluate e LEFT JOIN hui_order o on o.order_no =  e.order_no where 1=1 ";
		return customPageService.page(pageBean, columstr, fromWhere, CommentModel.class,null);
	} 
	
	public List<CommentModel> getAllComment(PageBean<CommentModel> pageBean) {
		String columstr ="e.id as id, e.evaluate_type as evaluateType, e.order_no as orderNo, o.amount as orderAmount, e.star as star, e.hotel_id as hotelId, e.hotel_name as hotelName"
				+ ", e.item_type as itemType, e.item_id as itemId, e.item_name as itemName, e.goods_evaluation as goodsEvaluation, e.attitude as attitude, e.response_speed as responseSpeed"
				+ ", e.facilities as facilities, e.hygiene as hygiene, e.service as service, e.location as location, e.comprehensive as comprehensive, e.experience as experience"
				+ ", e.follow as follow, e.benefit as benefit, e.tag as tag, e.econtent as econtent, e.user_id as userId, e.user_name as userName, e.isanonymous as isanonymous"
				+ ", e.evaluate_date as evaluateDate, e.create_date as createDate, e.memo as memo";
		String fromWhere = " from hui_evaluate e LEFT JOIN hui_order o on o.order_no =  e.order_no where 1=1 ";
		return customPageService.getAll(pageBean, columstr, fromWhere, CommentModel.class, null);
	}
	
	public CommentModel getComment(Long id) {
		String columstr ="e.id as id, e.evaluate_type as evaluateType, e.order_no as orderNo, o.amount as orderAmount, e.star as star, e.hotel_id as hotelId, e.hotel_name as hotelName"
				+ ", e.item_type as itemType, e.item_id as itemId, e.item_name as itemName, e.goods_evaluation as goodsEvaluation, e.attitude as attitude, e.response_speed as responseSpeed"
				+ ", e.facilities as facilities, e.hygiene as hygiene, e.service as service, e.location as location, e.comprehensive as comprehensive, e.experience as experience"
				+ ", e.follow as follow, e.benefit as benefit, e.tag as tag, e.econtent as econtent, e.user_id as userId, e.user_name as userName, e.isanonymous as isanonymous"
				+ ", e.evaluate_date as evaluateDate, e.create_date as createDate, e.memo as memo";
		String fromWhere = " from hui_evaluate e LEFT JOIN hui_order o on o.order_no =  e.order_no where 1=1 and e.id="+id;
		return customPageService.getOne(columstr, fromWhere, CommentModel.class);
	}
	
	
	public List<CommentSumModel> getAvgComment(Long hotelId,Long itemId,String itemType) {
		PageBean<CommentSumModel> pageBean = new PageBean<>();
		String columstr =" AVG(e.goods_evaluation) AS goodsEvaluation, AVG(e.attitude) AS attitude, AVG(e.response_speed) AS responseSpeed, AVG(e.facilities) AS facilities"
				+ ", AVG(e.hygiene) AS hygiene, AVG(e.service) AS service, AVG(e.location) AS location, AVG(e.comprehensive) AS comprehensive, AVG(e.experience) AS experience"
				+ ", AVG(e.follow) AS follow, AVG(e.benefit) AS benefit, e.item_type as itemType";
		if(hotelId!=null){
			columstr += ", e.hotel_id as hotelId";
		}	
		if(itemId!=null){
			columstr += ", e.item_id as itemId";
		}
	
		String fromWhere = " FROM hui_evaluate e where 1=1 ";
		String groupby = "e.item_type";
		if(hotelId!=null){
			groupby+=",e.hotel_id";
			fromWhere+=" and e.hotel_id="+hotelId;
		}
		if(itemId!=null){
			groupby+=",e.item_id";
			fromWhere+=" and e.item_id="+itemId;
		}
		if(StringUtils.isNotBlank(itemType)){
			fromWhere+=" and e.item_type='"+itemType+"'";
		}
		fromWhere +=" group by "+groupby;
		return customPageService.getAll(pageBean, columstr, fromWhere, CommentSumModel.class, null);
	}
	
	public String buildQuerySql(PageBean<Evaluate> pageBean,HttpServletRequest request){
		String colSql = DynamicSqlHelper.getMappingColumnStr("e.", Evaluate.class);
		StringBuilder sbd = new StringBuilder();
		sbd.append("select " + colSql + " from hui_evaluate e left join hui_hotel h ");
	
		sbd.append(" on e.hotel_id = h.id where 1=1 " );
		return sbd.toString();
	}

	@Transactional(readOnly = false)
	public JsonVo replySave(Long id, String replyContent) {
		Evaluate evaluate = evaluateDao.findOne(id);
		if(evaluate==null){
			return JsonUtils.error("评论不存在");
		}
		
		evaluate.setReplyContent(replyContent);
		evaluate.setReplyDate(new Date());
		evaluate.setReplyUserId(AccountUtils.getCurrentUserId());
		
		return JsonUtils.success("回复成功！");
	};
	
}
