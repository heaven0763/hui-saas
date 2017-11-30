<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
 
<div class="wrapper wrapper-content">
	<h3>积分商城</h3>
	<hr>
	<c:if test="${groupMap.ishotel}">
	</c:if>
	<div class="form-group">
		<a qx="points-mall:add" href="${ctx}/base/hotel/integral/commodity/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="integralCommodity_searchForm">
	  <div class="form-group">
			
			<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
	   		<label for="hotelId">所属场地</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="search_EQ_hotelId" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			</c:if>
			<c:if test="${aUs.getCurrentUserType() eq 'partner' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_hotelId" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id = ${aUs.getCurrentUserCompanyId()}"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			
			<label for="name">商品名称</label>
	   		<input type="text" class="form-control" id="name" name="search_LIKE_name" placeholder="请输入商品名称">
			<label for="checkState">审核状态</label>
	   		<select class="form-control" id="checkState" name="checkState"  style="width: 200px;">
	   			<option value="">不限</option>
	   			<option value="0">未审核</option>
	   			<option value="1">审核中</option>
	   			<option value="5">已审核</option>
	   			<option value="6">审核不通过</option>
	   		</select>
	  </div>
	  <button type="button" class="btn btn-primary" onclick="integralCommodity_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br/>
	<table id="integralCommodity_table" data-toggle="table" data-height="660" data-query-params="integralCommodity_queryParams"
	data-pagination="true" data-url="${ctx}/base/hotel/integral/commodity/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="img" data-align="center" data-formatter="fm_integralCommodity_img">商品图片</th>
				<th data-field="hotelName">场地</th>
				<th data-field="name">商品名称</th>
				<th data-field="integral" data-align="right">所需积分</th>
				<th data-field="price" data-align="right">场地价格</th>
				<th data-field="zgprice" data-align="right">掌柜价格</th>
				<th data-field="checkState" data-formatter="fm_integralCommodity_checkState">审核状态</th>
				<th data-formatter="fm_integralCommodity_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_integralCommodity_operate(value,row, index){
	var btn_htm = "";
	//btn_htm = '<a href="${ctx}/base/hotel/integral/commodity/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	if(row.checkState=='0'&&mtype=='HOTEL'&&'${groupMap.ishotel}'=='true'){
		btn_htm += '&nbsp;&nbsp;<button qx="points-mall:check" type="button" onclick="pass(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 通过</button>'
		btn_htm += '&nbsp;&nbsp;<button qx="points-mall:check" type="button" onclick="nopass(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 不通过</button>'
	}else if(row.checkState=='1'&&mtype=='HUI'&&'${groupMap.iscompany}'=='true'){//公司销售审核
		btn_htm += '&nbsp;&nbsp;<button qx="points-mall:check" type="button" onclick="pass(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 通过</button>'
		btn_htm += '&nbsp;&nbsp;<button qx="points-mall:check" type="button" onclick="nopass(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 不通过</button>'
	}else if(row.checkState=='3'&&mtype=='HUI'&&'${groupMap.iscompany}'=='true'){//运营总监审核
		btn_htm += '&nbsp;&nbsp;<button qx="points-mall:check" type="button" onclick="pass(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 通过</button>'
		btn_htm += '&nbsp;&nbsp;<button qx="points-mall:check" type="button" onclick="nopass(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 不通过</button>'
	}else if(row.checkState=='6'&&'${groupMap.ishotel}'=='true'){
		btn_htm += '&nbsp;&nbsp;<a qx="points-mall:update" href="${ctx}/base/hotel/integral/commodity/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
		btn_htm += '&nbsp;&nbsp;<button qx="points-mall:delete" type="button" onclick="integralCommodity_del_fun(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
	}
	
	
	return btn_htm;
}
function fm_integralCommodity_img(value,row, index){
	return '<img alt="image" src="'+value+'" style="width:120px;height:120px;" >';
}
// 0:未审核；1：场地主管审核；3：公司销售审核:5：运营总监审核；6：~不通过；
function fm_integralCommodity_checkState(value,row, index){
	if(value==='0'){
		return '未审核';
	}else if(value==='1'){
		return '场地主管审核通过';
	}else if(value==='3'){
		return '公司销售审核通过';
	}else if(value==='5'){
		return '运营总监审核通过';
	}else if(value==='6'){
		return '审核不通过';
	}
}


function integralCommodity_del_fun(id){
	cfm_swal("您确定要删除这条信息吗","删除后将无法恢复，请谨慎操作！","warning","删除", "您已经永久删除了这条信息。","您取消了删除操作！"
			,'${ctx}/base/hotel/integral/commodity/delete/'+id,"",function(){
				integralCommodity_search();
			});
}
function nopass(id){
	cfm_swal("您确定要审核不通过这个商品吗","","warning","不通过", "该商品已不通过审核。","您取消了该操作！"
			,'${ctx}/weixin/hotel/integral/nopass/'+id,"",function(){
		integralCommodity_search();
	});
}

function pass(id){
	cfm_swal("您确定要审核通过这个商品吗","","warning","通过", "该商品已通过审核。","您取消了该操作！"
			,'${ctx}/weixin/hotel/integral/pass/'+id,"",function(){
		integralCommodity_search();
	});
}
function integralCommodity_queryParams(params){
	return $.extend({},params,util.serializeObject($('#integralCommodity_searchForm')));
}

function integralCommodity_search(){
	$("#integralCommodity_table").bootstrapTable("refresh");
}
$(function(){
	common.pms.init();
	$("#integralCommodity_table").bootstrapTable({onLoadSuccess:function(){common.pms.init();}});
	$('.selectpicker').selectpicker();
});
</script>