<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="modal-body">
<style>
</style>
	<form class="form-inline" id="sel_hotel_searchForm">
	  <div class="form-group">
			<label for="hotelType">场地类型</label>
	   		<select class="form-control"  id="hotelType" name="search_EQ_h.hotel_type">
				<tags:dict sql="SELECT id,name as name FROM hui_category where kind ='HOTELTYPE' "  showPleaseSelect="false" addBefore=",全部"/>
			</select>
			<%-- <label for="hotelStar">场地星级</label>
	   		<select class="form-control"  id="hotelType" name="search_EQ_h.hotel_star">
				<tags:dict sql="SELECT id,name as name FROM hui_category where kind ='STAR' "  showPleaseSelect="false" addBefore=",全部"/>
			</select> --%>
			<label for="hotelName">场地名称</label>
	   		<input type="text" class="form-control" id="hotelName" name="search_LIKE_h.hotel_name" placeholder="请输入场地名称">
			<br>
			<br>
			<label for="city">场地所属城市</label>
	   		<select class="form-control"   id="province" name="province" refval="value" reftext="text" 
				refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#city" onchange="areaclear();">
				<tags:dict sql="select  id ,region_name name  from hui_region where parent_id='1' "  showPleaseSelect="false" addBefore=",全部" />
			</select>
			<select class="form-control"   id="city" name="city" refval="value" reftext="text" 
	     		refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#district" onchange="areaclear('city');">
	     		<option value="">全部</option>
			</select>
			<select class="form-control"   id="district" name="district" refval="value" reftext="text" 
				refurl="${ctx}/framework/dictionary/trslCombox?sql=SELECT id,district as name FROM hui_district where region_id in (select parent_id from hui_region where id={value})" refdata="region_id=:{value}" ref="#tradeArea">
				<option value="">全部</option>
			</select> 
	   		
			<label for="tradeArea">场地所属商圈</label>
			<select class="form-control"   id="tradeArea" name="search_EQ_h.trade_area" >
				<option value="">全部</option>
			</select> 
		  <button type="button" class="btn btn-primary" onclick="loadHotel()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div>
	  <c:if test="${aUs.getHotelUserType() eq 'GROUP' }">
	  	<input type="hidden" value="${aUs.getCurrentUserhotelPId() }" name="search_EQ_h.pid">
	  </c:if>
	   <c:if test="${aUs.getHotelUserType() eq 'HOTEL' }">
	  	<input type="hidden" value="${aUs.getCurrentUserHotelId() }" name="search_EQ_h.id">
	  </c:if>
	   <c:if test="${aUs.getHotelUserType() eq 'PARTNER' }">
	  	<input type="hidden" value="${aUs.getCurrentUserCompanyId() }" name="search_EQ_h.company_id">
	  </c:if>
	</form>
	<hr>
	<div id="sel_hotel_list" style="padding: 0.2rem 0;height: 480px;overflow: auto;">
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" id="sel_hotel_close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
		<!-- <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button> -->
	</div>
<script type="text/javascript">
$(function(){
	//loadHotel();
	$('.selectpicker').selectpicker();
	var $sel_hotel_list = $('#sel_hotel_list');
	$sel_hotel_list.delegate('[hotelid]','click',function(){	//场地列表点击事件
		var $this = $(this);
		$('.btn-hotel-checked').removeClass('btn-hotel-checked')
		$this.addClass('btn-hotel-checked');
		$("#hotelname").text($this.text());
		$("#hotelId").val($this.attr('hotelid'));
		loadDetailContent($this.attr('hotelid')); 
		$("#sel_hotel_close_btn").click();
		
	});
});
function loadHotel(){
	var city;
	var name;
	
	common.ajaxjson({	//获取场地类型列表
		url: '${ctx}/base/hotel/select/list',
		data:util.serializeObject($('#sel_hotel_searchForm')),
		success : function(res){
			var html = [];
			var list = res.object;
			console.log(res.object);
			for(var i in list){
				html.push('<div class="btn btn-query btn-plain bg-none-query" style="width:30%;margin: 0.4rem 0.2rem;" hotelid="'+list[i].id+'" hotelname="'+list[i].hotelName+'">'+list[i].hotelName+'</div>');
			}
			html.push('<div style="clear: both;"></div>');
			$('#sel_hotel_list').html(html.join(''));
		}
	});
}

</script>
</div>
