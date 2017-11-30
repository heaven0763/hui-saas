<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
<link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
<style>
<!--
.btn-hotel-checked{color: #ffffff;background-color: #274082;}
-->
</style>
<div class="modal-body">
<style>
</style>
	<form class="form-inline" id="sel_hotel_searchForm">
	  <div class="form-group">
		  <label for="city">员工姓名</label>
		  <span class="form-control" style="width: 200px;">${user.rname }</span>
		  <label for="city">员工职务</label>
		   <span class="form-control" style="width: 200px;">${user.position }</span>
		  <label for="city">所在城市</label>
		   <%-- <span class="form-control" style="width: 200px;">${user.city }</span> --%>
		   <select class="form-control" disabled="disabled" style="width: 200px;">
		  	 <tags:dict sql="select  id ,region_name name  from hui_region where region_type='2' "  showPleaseSelect="false" selectedValue="${user.city }"/>
		   </select>
	  </div>
	  <hr/>
	  <div class="form-group">
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
			<label for="hotelName">场地名称</label>
	   		<input type="text" class="form-control" id="hotelName" name="search_LIKE_h.hotel_name" placeholder="请输入场地名称">
		  <button type="button" class="btn btn-primary" onclick="loadHotel()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
		  <button id="hotel_sel_all" type="button" class="btn btn-primary" > 全选</button>
		  <button id="hotel_unsel_all" type="button" class="btn btn-primary" > 全不选</button>
	  </div>
	</form>
	<hr>
	<div id="sel_hotel_list" style="padding: 0.2rem 0;height: 480px;overflow: auto;">
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" id="sel_hotel_close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
		<button type="button" class="btn btn-primary" id="author_hotel_save"><span class="glyphicon glyphicon-save"></span> 保存</button>
		<input type="hidden" id="userId" name="userId" value="${user.id}" />
	</div>
<script type="text/javascript">
var flag = 0;
$(function(){
	loadHotel();
	$('.selectpicker').selectpicker();
	var $sel_hotel_list = $('#sel_hotel_list');
	$sel_hotel_list.delegate('[hotelid]','click',function(){	//场地列表点击事件
		var $this = $(this);
		$this.toggleClass('btn-hotel-checked');
	});
	
	/* $("#hotelname").text($this.text());
	$("#hotelId").val($this.attr('hotelid'));
	loadDetailContent($this.attr('hotelid')); 
	$("#sel_hotel_close_btn").click(); */
	
	$("#hotel_sel_all").click(function(){
		$('#sel_hotel_list [hotelid]').addClass('btn-hotel-checked');
	});
	
	$("#hotel_unsel_all").click(function(){
		$('#sel_hotel_list [hotelid]').removeClass('btn-hotel-checked');
	});
	
	$("#author_hotel_save").click(function(){
		var hotel_ids = [];
		$('#sel_hotel_list .btn-hotel-checked').each(function(){
			hotel_ids.push($(this).attr('hotelid'));
		});
		var userId = $("#userId").val();
		var url = "${ctx}/base/user/author/hotel/save"
		$.post(url,{userId:userId,hotelIds:hotel_ids.join(',')},function(res){
			if(res.statusCode=="200"){
				swal(res.message,'success');
				//loadHotel();
			}else{
				swal(res.message,'error');
			}
		},"json");
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
			for(var i in list){
				html.push('<div class="btn btn-query btn-plain bg-none-query '+('${user.id}'==list[i].reclaimUserId?'btn-hotel-checked':'')+'" style="width:30%;margin: 0.4rem 0.2rem;" hotelid="'+list[i].id+'" hotelname="'+list[i].hotelName+'">'+list[i].hotelName+'</div>');
			}
			html.push('<div style="clear: both;"></div>');
			$('#sel_hotel_list').html(html.join(''));
		}
	});
}

</script>
</div>
