<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<div class="wrapper wrapper-content">

<style>
	.table td{word-break:break-all; word-wrap:break-all; white-space: nowrap;}
	div.a{float:left;}
	.label-01{background-color: #008cd7;color: #FFF;}
	.label-02{background-color: #ed5564;color: #FFF;}
	.label-021{background-color: #019e95;color: #FFF;}
	.label-03{background-color: #848484;color: #FFF;}
	
	.label-04{background-color: #f31f36;color: #FFF;}
	.label-05{background-color: #6f6f6f;color: #FFF;}
	.label-06{background-color: #005684;color: #FFF;}
	
	.label-10{background-color: #5d5d5d;color: #FFF;}
	.label-11{background-color: #f08b1f;color: #FFF;}
	.label-12{background-color: #a65b08;color: #FFF;}
	.laydate_m{width: 100px;}
</style>
<div class="wrapper wrapper-content">
	<h3>订单信息</h3>
	<hr>
	<div class="form-group" >
		<a qx="order:add" href="javascript:loadContent(this,'${ctx}/weixin/order/create','');"  class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
		<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
		
		</c:if>
		<c:if test="${groupMap.iscompanyfinance || groupMap.isgroupfinance || groupMap.ishotelfinance || groupMap.iscompanyadministrator || groupMap.isgroupadministrator || groupMap.ishoteladministrator}">
			<a href="${ctx}/base/order/monthSummary" target="dialog" class="btn btn-primary" title="每月订单汇总">每月订单汇总</a>
		</c:if>
	</div> 
	<form class="form-inline" id="order_searchForm">
	  <div class="form-group">
	  		<c:if test="${aUs.getHotelUserType() eq 'HUI' }">
	  			<label for="city">城市</label>
				<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="area" name="search_EQ_h.city"  >
		     		<tags:dict sql="SELECT id id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select>
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="hotelid" name="search_EQ_o.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<c:if test="${aUs.getHotelUserType() eq 'PARTNER' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-size="10" data-width="auto" id="hotelid"   name="search_EQ_o.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id = ${aUs.getCurrentUserCompanyId()}"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<c:if test="${aUs.getHotelUserType() eq 'GROUP' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   name="search_EQ_o.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where pid = ${aUs.getCurrentUserhotelPId()}"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			
			<label for="state">订单状态</label>
	   		<select class="form-control selectpicker" name="search_EQ_o.state" data-width="auto" data-size="10" >
				<tags:dict sql="SELECT code as id,detail as name FROM hui_sys_dict where kind='05' order by code "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			
			<label for="settlementStatus">结算状态</label>
	   		<select class="form-control" name="search_EQ_o.settlement_status" data-width="auto" data-size="10" >
				<tags:dict sql="SELECT code as id,detail as name FROM hui_sys_dict where kind='07' order by code "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			<br>
	   		<br>
	   		
	   		<label for="orderNo">订单编号</label>
	   		<input type="text" class="form-control" id="orderNo" name="search_EQ_o.order_no" placeholder="请输入订单编号">
	   		
			
			<label for="organizer">主办单位</label>
	   		<input type="text" class="form-control" id="organizer" name="search_LIKE_o.organizer" placeholder="请输入活动主办单位">
	   		
			<label for="linkman">联 &nbsp;系&nbsp;人</label>
	   		<input type="text" class="form-control" id="linkman" name="search_LIKE_o.linkman" placeholder="请输入联系人">
	   		
			<label for="contactNumber">联系电话</label>
	   		<input type="text" class="form-control" id="contactNumber" name="search_EQ_o.contact_number" placeholder="请输入联系电话">
			
			<c:if test="${!groupMap.iscompanysales && ! groupMap.ishotelsales }">
			<label for="reclaim_user_id">销售人员</label>
				<select class="form-control"  data-live-search="true"  id="reclaim_user_id" name="saleId"  data-width="auto" data-size="10" >
					<option value="">全部</option>
					<c:forEach items="${sales}" var="sale">
						<option value="${sale.id }">${sale.rname }</option>
					</c:forEach>
				</select>
			</c:if>
			<br>
			<br>
			<label for="placeDate">活动日期</label>
	   		<input type="text" class="form-control layer-date laydate-icon" id="screate_date" name="search_GTE_o.activity_date" placeholder="请输入活动日期">
	   		~
	   		<input type="text" class="form-control layer-date laydate-icon" id="ecreate_date" name="search_LTE_o.activity_date" placeholder="请输入活动日期">
			<c:if test="${groupMap.iscompanyfinance || groupMap.isgroupfinance }">
				<input type="hidden" name="search_OR_EQ;o.state" value="04,06,07">
			</c:if>
			<c:if test="${groupMap.ishotelfinance }">
				<input type="hidden" name="search_OR_EQ;o.state" value="04,06,07,11">
			</c:if>
			<!-- <input type="hidden" name="search_OR_EQ;o.state" value="03,05"> -->
		  <button type="button" class="btn btn-primary" onclick="order_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
		  <c:if test="${groupMap.ishotel and !groupMap.ishotelsalesdirector and !groupMap.ishoteladministrator}">
			 <input type="hidden" name="saleId" value="${guserId}">
		  </c:if>
		  <c:if test="${groupMap.iscompany and !groupMap.iscompanysalesdirector and !groupMap.iscompanyadministrator and !groupMap.isadministrator}">
			 <input type="hidden" name="saleId" value="${guserId}">
		  </c:if>
		  <c:if test="${groupMap.ishotelsales}">
			 <div class="switch" style="display: inline-block;">  <label for="all-orders">查看其他订单<input type="checkbox" id="all-orders" name="allorders" value="1" onchange="order_search();" /></label>	 </div>
		  </c:if>
	  </div>
	</form>
	<br>
	<table id="order_table" class="table-condensed" data-toggle="table" data-height="660" data-query-params="order_queryParams" data-row-style="orderRowStyle"
		data-pagination="true" data-url="${ctx}/weixin/order/list" data-data-type="json" >
	    <thead>
	        <tr>
	        	<th data-formatter="fm_order_operate">操作</th> 
				<th data-field="orderNo" style="word-break:break-all; word-wrap:break-all;" data-formatter="fm_order_orderNo">订单编号</th>
				<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				<th data-field="area">区域</th>
				<th data-field="hotelName">场地名称</th>
				</c:if>
				<th data-field="activityDate" style="word-break:break-all; word-wrap:break-all;">活动日期</th>
				<th data-field="activityTitle"  data-formatter="fm_order_activityTitle">活动名称</th>
				<th data-field="amount" data-align="right" data-formatter="fm_order_amount">金额</th>
				<th data-field="organizer" data-formatter="fm_order_organizer">主办单位</th>
				<th data-field="linkman">联系人</th>
				<th data-field="contactNumber">联系电话</th>
				<th data-field="state" data-formatter="fm_order_state">订单状态</th>
				<th data-field="settlementStatus" data-formatter="fm_order_settlementStatus">结算状态</th>
				<!-- <th data-field="commissionStatus" data-formatter="fm_order_commissionStatus">返佣状态</th> -->
				<th data-field="createDate">创建时间</th>
	        </tr>
	    </thead>
	</table>
</div>
<div id="offline_check_no_div" class="div-tips-dialog" style="top:25%;left:35%;padding:10px 2%;width:500px;text-align:left;display:none;z-index: 99997; ">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;padding: 0.5rem 0;">
			<div style="color: #000000;">不通过原因</div>
			<input id="orderNo" name="orderNo" type="hidden" value="">
			<!-- <div  class="icon-close" style="position: absolute;top: -0.5rem;right: 0;">&nbsp;</div> -->
			<button id="offline_check_no_ic_close" type="button" class="close" style="position: absolute;top: 0;right: 0;">	<span>×</span></button>
 		</div>
		<div style="padding:0 2%;" >
			<textarea id="reason" rows="15" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入不通过原因"></textarea>
		</div>
		
		<div class="" style="padding: 1rem 0;text-align: right;">
			<div id="btn_offline_check_no_cansel" class="btn btn-warning" ><span class="glyphicon glyphicon-off"></span> 再考虑</div>
			<div id="btn_offline_check_no_sure" class="btn btn-primary" onclick="reject()" ><span class="glyphicon glyphicon-save"></span> 确定</div>
		</div>
	</div>
	
	<div id="order_refund_check" class="div-tips-dialog" style="top:25%;left:35%;padding:10px 2%;width:500px;text-align:left;display:none;z-index: 99997; ">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;padding: 0.5rem 0;">
			<div style="color: #000000;"><h2>退款审核</h2></div>
			<input id="order_refund_orderNo" name="orderNo" type="hidden" value="">
			<!-- <div  class="icon-close" style="position: absolute;top: -0.5rem;right: 0;">&nbsp;</div> -->
			<button id="order_refund_no_ic_close" type="button" class="close" style="position: absolute;top: 0;right: 0;">	<span>×</span></button>
 		</div>
		<div style="padding:0 2%;" >
			<div style="padding: 5px;">订单编号：<span id="order_refund_order_no" style="font-weight: bold;"></span></div>
			<div style="padding: 5px;">订单金额：<span id="order_refund_order_amount" style="font-weight: bold;font-size: 16px;"></span></div>
			<div style="padding: 5px;">已交订金：<span id="order_refund_order_pepay" style="font-weight: bold;font-size: 16px;"></span></div>
			<div style="padding: 5px;">退款金额：<span id="order_refund_order_refund_amount" style="font-weight: bold;font-size: 16px;"></span></div>
			<div style="padding: 5px;">退款原因：<span id="order_refund_order_refund_reason"></span></div>
			<div style="padding: 5px;">确认金额：<input type="text" min="0" class="form-control" id="refund_amount" name="refund_amount" style="display: inline-block;width: 50%;" /></div>
		</div>
		
		<div class="" style="padding: 1rem 0;text-align: right;">
			<div id="btn_order_refund_check_cansel" class="btn btn-warning" ><span class="glyphicon glyphicon-off"></span> 再考虑</div>
			<div id="btn_order_refund_check_sure" class="btn btn-primary" ><span class="glyphicon glyphicon-save"></span> 确定</div>
		</div>
		<div class="col-md-12" style="position: relative;">
			<div style="color: #ff00000;position: absolute;right: 50px;top: 10px;">NEW</div>
		</div>
	</div>
<script>
function cfmSettlement(id){
	cfm_swal("您确认该订单已收款！","","warning","确认收款", "确认收款申请完成。","您取消了该操作！"
			,'${ctx}/weixin/order/state/'+id,{tostate:5},function(){
				order_search();
	});
}
function fm_order_orderNo(value,row, index){
	var $dv = $('<div  style="width：100%;height:100%;padding-right:10px;position: relative;"></div>');
	$dv.append('<a href="javascript:loadContent(this,\'${ctx}/base/order/detail/'+row.id+'\',\'\');"  title="详情">'+value+'</a>');
	/* if(isNew(row)){
		$dv.append('<div class="new"></div>');
	} */
	return $dv.prop("outerHTML");
}
function isNew(row){
	var readOrder = common.getstorage("readOrder${aUs.getCurrentUserId()}");
	var operateOrder = window.sessionStorage.getItem("operateOrder${aUs.getCurrentUserId()}")?window.sessionStorage.getItem("operateOrder${aUs.getCurrentUserId()}"):'';
	/* if(readOrder.indexOf(row.orderNo)<0&&operateOrder.indexOf(row.orderNo)<0){
		return true;
	} */
	if(row.state==="01"){
		if(readOrder.indexOf(row.orderNo)<0&&operateOrder.indexOf(row.orderNo)<0){
			return true;
		}
		return false;
	}
	return false;
}
function fm_order_activityTitle(value,row, index){
	return '<div style="width: 150px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;" title="'+value+'">'+value+'</div>';
}
function fm_order_organizer(value,row, index){
	return '<div style="width: 150px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;" title="'+value+'">'+value+'</div>';
}
function fm_order_amount(value,row, index){
	return common.formatCurrency(value);
}
function fm_order_state(value,row, index){
	return '<span class="label label-'+value+'">'+dict.trsltDict('05',value)+'</span>';
	/* if(value==='01'){
	}else if(value==='02'||value==='04'||value==='09'||value==='11'){
		return '<span class="label label-danger">'+dict.trsltDict('05',value)+'</span>';
	}else if(value==='06'||value==='07'){
		return '<span class="label label-success">'+dict.trsltDict('05',value)+'</span>';
	}else{
		return '<span class="label label-default">'+dict.trsltDict('05',value)+'</span>';
	} */
}
function fm_order_commissionStatus(value,row, index){
	return dict.trsltDict('06',row.commissionStatus);
}
function fm_order_settlementStatus(value,row, index){
	return dict.trsltDict('07',value);
}
function fm_order_operate(value,row, index){
	var btnhtml = "";
	if(row.state=='01' && "${groupMap.ishotel}"=="true" && '${guserId}' == row.hotelSaleId){
		btnhtml+='&nbsp;&nbsp;<button qx="order:deal" type="button" onclick="order_accept_fun(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-ok"></span> 受理</button>';
	}else if(('${groupMap.ishotel}'=='true' && '${guserId}' == row.hotelSaleId) && row.state=='02'){   //(row.state=='02'||row.state=='04')  ||row.state=='04'
		btnhtml+='&nbsp;&nbsp;<a qx="order:update" href="javascript:loadContent(this,\'${ctx}/weixin/order/detail/'+row.id+'\',\'\');" href="" class="btn btn-primary btn-sm" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>';
	}else if(('${groupMap.iscompany}'=='true' && '${guserId}' == row.companySaleId) && (row.state=='01'||row.state=='02') && row.orderType == 'OFFLINE'){
		btnhtml+='&nbsp;&nbsp;<a qx="order:update" href="javascript:loadContent(this,\'${ctx}/weixin/order/detail/'+row.id+'\',\'\');" href="" class="btn btn-primary btn-sm" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>';
	}else if(('${groupMap.ishotelsalesdirector}'=='true' || '${groupMap.ishoteladministrator}'=='true')&& row.state=='02'){
		btnhtml+='&nbsp;&nbsp;<a qx="order:update" href="javascript:loadContent(this,\'${ctx}/weixin/order/detail/'+row.id+'\',\'\');" href="" class="btn btn-primary btn-sm" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>';
	}else if(row.state=='11' && "${groupMap.ishotel}"=="true"){
		btnhtml+='&nbsp;&nbsp;<button qx="order:update" type="button" onclick="agree(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-ok"></span> 同意</button>';
		btnhtml+='&nbsp;&nbsp;<button qx="order:update" type="button" onclick="rejectOpenForm(\''+row.id+'\')" class="btn btn-warning btn-sm"><span class="glyphicon glyphicon-share-alt"></span> 拒绝</button>';
	}

	/* 
	else if('${groupMap.ishotelsalesdirector}'=='true'&&(row.state=='09')){
		btnhtml+='&nbsp;&nbsp;<button qx="venue-station:update" type="button" onclick="refundCheck(\''+row.orderNo+'\',\''+row.refundAmount+'\',\''+row.refundReason+'\',\''+row.amount+'\',\''+row.prepaid+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-ok"></span> 退款审核</button>';
	} */
	
	return btnhtml;
}

function order_del_fun(id) {
	var title = "您确定要删除该订单吗";
	var text = "删除后将无法恢复，请谨慎操作！";
	var url = '${ctx}/base/order/delete/' + id;
	var data = "";
	var msg = "您已经永久删除了这条信息。";
	cfmFun(title,text,'删除',url,data,msg);
}

function order_accept_fun(id) {
	var title = "您确定要受理该订单吗";
	var text = "";
	var url = '${ctx}/base/order/accept/' + id;
	var data = "";
	var msg = "您已经受理了该订单，请尽快与客户联系吧。";
	cfmFun(title,text,'受理',url,data,msg);
}
function order_commission_fun() {
	var title = "您确认要一键发起返佣吗？";
	var text = "";
	var url = '${ctx}/weixin/order/comission/batch';
	var data = "";
	var msg = "发起返佣成功！";
	cfmFun(title,text,'确认',url,data,msg);
}
function cfmFun(title, text, type, url, data,msg) {
	swal({
		title : title,
		text : text,
		type : "warning",
		showCancelButton : true,
		cancelButtonText : "取消",
		confirmButtonColor : "#DD6B55",
		confirmButtonText : type,
		closeOnConfirm : false,
		showLoaderOnConfirm : true
	}, function(isConfirm) {
		if (isConfirm) {
			parent.show();
			$.post(url, data, function(res, status) {
				if (status == "success" && res.statusCode == "200") {
					swal(res.message, "success");
					order_search();
				} else {
					swal(res.message, "error");
				}
				parent.hide();
			}, 'json');
		} else {
			swal("已取消", "您取消了"+type+"操作！", "error")
		}
	});
}
function order_queryParams(params){
	return $.extend({},params,util.serializeObject($('#order_searchForm')));
}

function order_search(){
	$("#order_table").bootstrapTable("refresh");
}

function rejectOpenForm(id){
	show();
	$("#orderNo").val(id);
	$("#offline_check_no_div").show();
}

function rejectCloseForm(){
	hide();
	$("#orderNo").val('');
	$("#reason").val('');
	$("#offline_check_no_div").hide();
}

function refundCheck(orderNo,refundAmount,reason,amount,pepay){
	show();
	$(".sk-spinner").hide();
	$("#order_refund_orderNo").val(orderNo);
	$("#order_refund_order_no").text(orderNo);
	$("#order_refund_order_amount").text(common.formatCurrency(refundAmount)+"元");
	$("#order_refund_order_pepay").text(common.formatCurrency(refundAmount)+"元");
	$("#order_refund_order_refund_amount").text(common.formatCurrency(refundAmount)+"元");
	$("#order_refund_order_refund_reason").text(reason);
	$("#refund_amount").val(refundAmount);
	$("#order_refund_check").show();
}
function refundCloseForm(){
	hide();
	$(".sk-spinner").show();
	$("#order_refund_order_no").text('');
	$("#order_refund_order_refund_amount").text('');
	$("#order_refund_order_refund_reason").text('');
	$("#refund_amount").val('');
	$("#order_refund_orderNo").val('');
	$("#order_refund_check").hide();
}
function reject(){
	var orderNo = $("#orderNo").val();
	var reason = $("#reason").val();
	if(reason===''){
		swal("请输入原因",'error');
		return;
	}
	 $.post('${ctx}/weixin/order/site/adjustment/reject',{id:orderNo,reason:reason},function(res){
		if(res.statusCode=='200'){
			swal(res.message,'success');
			order_search();
			rejectCloseForm()
		}else{
			swal(res.message,'error');
			$("#offline_check_no_div").show();
		}
	},'json'); 
}
function agree(id){
	cfm_swal("您确定同意该笔退款申请！","","warning","同意", "同意退款申请完成。","您取消了该操作！"
			,'${ctx}/weixin/order/site/adjustment/agree',{id:id},function(){
		order_search();
	});
}
$(function(){
	common.ctx = '${ctx}';
	dict.init();
	common.pms.init();
	$("#order_table").bootstrapTable({onLoadSuccess: function(data){  //加载成功时执行  
    	common.pms.init();
    	for(var n=0,len=data.rows.length;n<len;n++){
    		var row = data.rows[n];
    		if(isNew(row)){
	   			$('tr[data-index="'+n+'"] td:eq(1)').addClass("news");
    		}
    	} 
    }});
	
	$("[name='allorders']").bootstrapSwitch();
	$('.selectpicker').selectpicker();
	
	$("#area").on('changed.bs.select', function (event, clickedIndex, newValue, oldValue) {
		var city = $("#area").val();
		console.log(city);
		if(city){
			var url ='${ctx}/framework/dictionary/trslCombox?sql=SELECT id,hotel_name as name FROM hui_hotel where city='+city;
		    $.ajax({
		        url: url,
		        type: "get",
		        dataType: "json",
		        success: function (data) {
		        	var options = [];
		        	options.push("<option value=''>请选择</option>");
		            $.each(data, function (i) {
		            	options.push("<option value=" + data[i].value + ">" + data[i].text + "</option>");
		            });
		            $('#hotelid').html(options.join(''));
		            $('#hotelid').selectpicker('refresh');
		        },
		        error: function (data) {
		            //alert("查询学校失败" + data);
		        }
		    }); 
		}
		order_search();
	});
	$("#hotelid").on('changed.bs.select', function (event, clickedIndex, newValue, oldValue) {
		order_search();
	});
	$('#offline_check_no_ic_close').click(function(){
		 rejectCloseForm();
	});
	$('#btn_offline_check_no_cansel').click(function(){
		 rejectCloseForm();
	});
	
	$('#order_refund_no_ic_close').click(function(){
		 refundCloseForm();
	});
	$('#btn_order_refund_check_cansel').click(function(){
		refundCloseForm();
	});
	
	var splaceDate={elem:"#screate_date",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	laydate(splaceDate);
	var eplaceDate={elem:"#ecreate_date",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	laydate(eplaceDate);
});

</script>