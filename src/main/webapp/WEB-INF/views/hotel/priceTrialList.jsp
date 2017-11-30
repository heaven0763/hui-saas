<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>报价审核</h3>
	<hr>
	<form class="form-inline" id="priceTrial_searchForm">
	  <div class="form-group">
			<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				<label for="hotelId">场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_pa.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<label for="state">申请状态</label>
			<select class="form-control" name="search_EQ_pa.state" >
				<option value="">不限</option>
				<option value="0" ${groupMap.iscompanysales ?'selected="selected"':'' }>未审核</option>
				<option value="1" ${groupMap.iscompanyadministrator ?'selected="selected"':'' } >初审通过</option>
				<option value="2">终审通过</option>
				<option value="3">初审不通过</option>
				<option value="4">终审不通过</option>
			</select>
			<c:if test="${groupMap.iscompanysales }">
			 <input type="hidden" name="search_EQ_h.reclaim_user_id" value="${guserId}">
			</c:if>
	  </div>
	  <button type="button" class="btn btn-primary" onclick="priceTrial_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="priceTrial_table" data-toggle="table" data-height="660" data-query-params="priceTrial_queryParams" data-row-style="priceTrialRowStyle"
		data-pagination="true" data-url="${ctx}/base/hotel/price/trial/list" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="auditId">审核编号</th>
				<th data-field="hotelId">场地编号</th> -->
				<th data-field="area">地区</th>
				<th data-field="hotelName" data-formatter="fm_priceTrial_hotelName">场地名称</th>
				<th data-field="placeName" data-formatter="fm_priceTrial_placeName">调整事项</th>
				<th data-field="state" data-formatter="fm_priceTrial_state">申请状态</th>
				<!--<th data-field="applyUserId">提交人员编号</th>-->
				<th data-field="applyUserName">提交人员</th>
				<th data-field="applyDate">提交时间</th>
				<th data-field="trialUserName">初审人员</th>
				<th data-field="trialDate">初审时间</th>
				<th data-field="finalUserName">终审人员</th>
				<th data-field="finalDate">终审时间</th>
				<th data-formatter="fm_priceTrial_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	common.pms.init();
	$("#priceTrial_table").bootstrapTable({onLoadSuccess: function(){common.pms.init(); }});
	$('.selectpicker').selectpicker();
});
function priceTrial_queryParams(params){
	return $.extend({},params,util.serializeObject($('#priceTrial_searchForm')));
}
function priceTrial_search(){
	$("#priceTrial_table").bootstrapTable("refresh");
}
function fm_priceTrial_operate(value,row, index){
	var btnhtm = "";
	btnhtm+='<a qx="hotel-price-adjust:check" href="${ctx}/base/hotel/price/trial/check/'+row.id+'" target="dialog" class="btn btn-primary btn-sm" title="'+(row.priceType === 'on'?'系统销售价格调整审核':'线下合作销售价格调整审核')+'">'
	+'<span class="glyphicon glyphicon-eye-open"> </span> 详情</a>';
	return btnhtm;
	//+'&nbsp;&nbsp;<button type="button" onclick="priceTrial_del_fun(\''+row.id+'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}

function fm_priceTrial_hotelName(value,row, index){
	var btnhtm = "";
	btnhtm+='<a qx="hotel-price-adjust:check" href="${ctx}/base/hotel/price/trial/check/'+row.id+'" target="dialog"  title="'+(row.priceType === 'on'?'系统销售价格调整审核':'线下合作销售价格调整审核')+'">'
	+value+'</a>';
	return btnhtm;
	//+'&nbsp;&nbsp;<button type="button" onclick="priceTrial_del_fun(\''+row.id+'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}

function fm_priceTrial_placeName(value,row, index){
	var priceType = row.priceType == 'on'?'线上价格':'线下价格';
	var btnhtm = value+row.adjustSdate+"~"+row.adjustEdate+priceType+"修改";
	return btnhtm;
}
//0:初始状态；1：初审通过;2:终审通过；3：初审不通过；4：终审不通过
function fm_priceTrial_state(value,row, index){
	if("0"===value){
		return '<span class="label label-danger">待审核</span>';
	}else if("1"===value){
		return '<span class="label label-danger">待终审</span>';
	}else if("2"===value){
		return '<span class="label label-success">终审通过</span>';
	}else if("3"===value){
		return '<span class="label label-default">初审不通过</span>';
	}else if("4"===value){
		return '<span class="label label-default">终审不通过</span>';
	}else{
		return '<span class="label label-default">其他';
	}
}
function priceTrialRowStyle(row, index) {
    if (row.state === '3'||row.state === '4') {
        return {
            css: {"color":"#cccccc"}
        };
    }
    return {};
}
function priceTrial_del_fun(id){
	swal({
        title: "您确定要删除这条信息吗",
        text: "删除后将无法恢复，请谨慎操作！",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "删除",
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function (isConfirm)  {
    	if (isConfirm) {
    		parent.show();
   	     	$.post('${ctx}/hotel/price/trial/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			priceTrial_search();
   	     		}else{
   	     			swal(res.message, "error");
   	     		}
   	     		parent.hide();
   	     	}, 'json');
		} else {
			swal("已取消", "您取消了删除操作！", "error")
		}
    });
	
}
</script>