<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
 
<div class="wrapper wrapper-content">
	<h3>积分商城对账</h3>
	<hr>
	<div class="form-group">
		<c:if test="${groupMap.iscompanyfinance }">
			<a qx="points-mall:reconciliation" id="btn_custom_settlement" class="btn btn-primary"><span class="glyphicon glyphicon-list-alt"> </span> 自定义确认</a>
			<a qx="points-mall:reconciliation" id="btn_batch_settlement" class="btn btn-primary"><span class="glyphicon glyphicon-list-alt"> </span> 一键确认</a>
		</c:if>
		<c:if test="${groupMap.ishotelfinance or groupMap.isgroupfinance}">
			<a qx="points-mall:reconciliation" id="btn_custom_settlement" class="btn btn-primary"><span class="glyphicon glyphicon-list-alt"> </span> 自定义申请</a>
			<a qx="points-mall:reconciliation" id="btn_batch_settlement" class="btn btn-primary"><span class="glyphicon glyphicon-list-alt"> </span> 一键申请</a>
		</c:if>
	</div>
	<form class="form-inline" id="integralReconciliation_searchForm">
	  <div class="form-group">
			<label for="hotelId">地区</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_LIKE_o.area" >
				<tags:dict sql="SELECT region_name id,region_name as name FROM hui_region where region_type = 2 order by zimu "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
	   		<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				<label for="hotelId">场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_o.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			
			<label for="settlement_status">对账状态</label>
	   		<select class="form-control" id="settlement_status" name="search_EQ_o.settlement_status"  style="width: 200px;">
	   			<option value="">不限</option>
	   			<option value="0">未对账</option>
	   			<option value="1">已申请</option>
	   			<option value="2">已对账</option>
	   		</select>
	   		<label for="order_no">订单编号</label>
	   		<input type="text" class="form-control" id="order_no" name="search_EQ_o.order_no" placeholder="请输入订单编号">
	   		<label for="mobile">手机号码</label>
	   		<input type="text" class="form-control" id="mobile" name="search_EQ_o.client_mobile" placeholder="请输入手机号码">
	   		<br>
	   		<br>
	   		<label for="item_name">商品名称</label>
	   		<input type="text" class="form-control" id="item_name" name="search_LIKE_i.item_name" placeholder="请输入商品名称">
	   		
	   		<label for="create_date1">日期</label>
	   		<input type="date" class="form-control" id="create_date1" name="search_GTE_o.create_date">
	   		~
	   		<input type="date" class="form-control" id="create_date2" name="search_LTE_o.create_date">
	   		
		  <button type="button" class="btn btn-primary" onclick="integralReconciliation_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div>
	</form>
	<br/>
	<table id="integralReconciliation_table" data-toggle="table" data-height="600" data-query-params="integralReconciliation_queryParams"
	data-pagination="true" data-url="${ctx}/weixin/hotel/integral/reconciliation/pc/list" data-data-type="json">
	    <thead>
	        <tr>
	        	<th data-checkbox="true" data-formatter="stateFormatter"></th>
				<th data-field="orderNo">订单编号</th>
				<th data-field="itemName">商品名称</th>
				<th data-field="clientName">兑换客户</th>
				<th data-field="clientMobile">手机号码</th>
				<th data-field="area">地区</th>
				<th data-field="createDate">兑换时间</th>
				<th data-field="points" data-align="right">兑换积分</th>
				<th data-field="zgamount" data-align="right">会掌柜结算金额</th>
				<th data-field="settlementStatus" data-formatter="fm_integralReconciliation_checkState">对账状态</th>
				<th data-formatter="fm_integralReconciliation_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
	<div style="width:100%;background-color: #f5f5f5;padding: 10px 0;">
		<div style="float: left;margin-left: 2%;">应结：
			<fmt:formatNumber type="currency" value="${empty res.jdamount?0:res.jdamount }" />
		</div>
		<div style="float: right;text-align: right;margin-right: 2%;display:inline;color:red;font-weight: bold;">实结：
			<fmt:formatNumber type="currency" value="${empty res.zgamount?0:res.zgamount  }" />
		</div>
		<div style="clear: both;"></div>
	</div>
</div>
<script>
function fm_integralReconciliation_operate(value,row, index){
	var btn_htm = "";
	btn_htm = '<a href="javascript:;" onclick="loadContent(this,\'${ctx}/weixin/hotel/integral/reconciliation/detail/'+row.id+'\',\'\')" class="btn btn-primary" title="详情"><span class="glyphicon glyphicon-eye-open"> </span> 详情</a>'
	if(row.settlementStatus=='0'&&'${type}'=='HOTEL'&&'${groupMap.ishotelfinance or groupMap.isgroupfinance}'=='true'){
		btn_htm += '&nbsp;&nbsp;<button qx="points-mall:reconciliation" type="button"onclick=" settlement(\''+row.orderNo+'\',\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-list-alt"> </span> 申请对账</button>'
	}else if(row.settlementStatus=='1'&&'${type}'=='HUI'&&'${groupMap.iscompanyfinance}'=='true'){
		btn_htm += '&nbsp;&nbsp;<button qx="points-mall:reconciliation" type="button" onclick=" settlement(\''+row.orderNo+'\',\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-list-alt"> </span> 确认结账</button>'
	}
	
	return btn_htm;
}
function fm_integralReconciliation_img(value,row, index){
	return '<img alt="image" src="'+value+'" style="width:120px;height:120px;" >';
}
// 0:未审核；1：场地主管审核；3：公司销售审核:5：运营总监审核；6：~不通过；
function fm_integralReconciliation_checkState(value,row, index){
	if(value==='0'){
		return '未对账';
	}else if(value==='1'){
		return '已申请';
	}else if(value==='2'){
		return '已对账';
	}
}


function settlement(orderNo,id){
	var action = "";
	var btns = "";
	if('${type}'==='HUI'){
		action="确认";
	}else{
		action="申请";
	}
	cfm_swal("您确定要"+action+"该对账信息","","warning",action, "对账信息"+action+"完成。","您取消了该操作！"
			,'${ctx}/weixin/hotel/integral/reconciliation/settlement?orderNo='+orderNo+'&itemId='+id,"",function(){
		integralReconciliation_search();
	});
}

function integralReconciliation_queryParams(params){
	return $.extend({},params,util.serializeObject($('#integralReconciliation_searchForm')));
}

function integralReconciliation_search(){
	$("#integralReconciliation_table").bootstrapTable("refresh");
}
function stateFormatter(value, row, index) {
    if (row.settlementStatus === '1' && '${type}'==='HUI') {
        return {
            disabled: false,
            checked: false
        };
    }else if (row.settlementStatus === '0' && '${HOTEL}'==='HUI') {
        return {
            disabled: false,
            checked: false
        };
    }else{
    	 return {
             disabled: true,
             checked: false
         }
    }
}
$(function(){
	common.pms.init();
	$("#integralReconciliation_table").bootstrapTable({onLoadSuccess:function(){common.pms.init();}});
	$('.selectpicker').selectpicker();
	$('#btn_batch_settlement').click(function(){
		var action = "";
		var btns = "";
		if('${type}'==='HUI'){
			action="确认";
			btns = "一键确认";
		}else{
			action="申请确认";
			btns = "一键申请";
		}
		
		cfm_swal("您确定要一键"+action+"所有对账信息","","warning",btns, "对账信息"+action+"完成。","您取消了该操作！"
				,'${ctx}/weixin/hotel/integral/reconciliation/batchsettlement',"",function(){
			integralReconciliation_search();
		});
		
		/* show();
		$.post('${ctx}/weixin/hotel/integral/reconciliation/batchsettlement',{},function(res){
			if(res.statusCode=='200'){
				swal(res.message,'success');
				integralReconciliation_search();
			}else{
				swal(res.message,'error');
			}
			hide();
		})  */
	});
	$('#btn_custom_settlement').click(function(){
		var rows = $("#integralReconciliation_table").bootstrapTable("getAllSelections");
		if(rows.length===0){
			swal("请先选择需要确认的订单！",'error');
			return;
		}
		var orderNos = [];
		for(var i=0;i<rows.length;i++){
			orderNos.push(rows[i].orderNo);
		}
		var action = "";
		var btns = "";
		if('${type}'==='HUI'){
			action="确认";
			btns = "确认所选";
		}else{
			action="申请确认";
			btns = "申请所选";
		}
		
		cfm_swal("您确定要"+action+"所选中的对账信息","","warning",btns, "对账信息"+action+"完成。","您取消了该操作！"
				,'${ctx}/weixin/hotel/integral/reconciliation/batchsettlement',{orderNos:orderNos.join(',')},function(){
			integralReconciliation_search();
		});
		
		
		/* show();
		$.post('${ctx}/weixin/hotel/integral/reconciliation/batchsettlement',{orderNos:orderNos.join(',')},function(res){
			toastFn(res.message);
			if(res.statusCode=='200'){
				swal(res.message,'success');
				integralReconciliation_search();
			}else{
				swal(res.message,'error');
			}
			hide();
		})  */
	});
});
</script>