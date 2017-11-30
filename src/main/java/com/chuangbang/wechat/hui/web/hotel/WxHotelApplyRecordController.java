package com.chuangbang.wechat.hui.web.hotel;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chuangbang.framework.web.BaseController;

/**
 * 申请加入酒店Controller
 * @author xtp
 * @version 2017-08-17
 */
@Controller
@RequestMapping(value = "weixin/hotel/record")
public class WxHotelApplyRecordController extends BaseController {

	@RequestMapping(value="hotelJoinList")
	public String hotelJoinList(Model model){
		return "weixin/hotel/hotelJoinList";
	}
	
	@RequestMapping(value="hotelApplyRecord")
	public String hotelApplyRecord(Model model){
		return "weixin/hotel/hotelApplyRecord";
	}
	
	@RequestMapping(value="applyCheckList")
	public String applyCheckList(Model model){
		return "weixin/hotel/applyCheckList";
	}
}
