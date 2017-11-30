<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>订单信息</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
   	<style type="text/css">
   		i.ic {
		    background-image: url(${ctx}/static/weixin/css/icon/icon-yue-red.png);
		    background-repeat: no-repeat;
		    background-size: 16px;
		    background-position: center;
		}
   	</style>
    	
</head>

<body class="">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div style="height:1.6rem;width:95%;margin:0 auto;margin-top:1rem;">
		<input id="input_search_val" type="text" name="" value="" style="width:72%;background-color:#f5f3f4;border:none;height:100%;outline:none;padding:0 4%;" placeholder="搜索订单号/手机号/场地名称" />
		<div id="btn_order_search" class="icon-search-02" style="width:20%;height:100%;background-color:#FFB42B;float:right;background-size: 30%;background-position:center center;"></div>
	</div>
	<div id="order_list_div" class="tran-list-ct" style="width:100%;margin-top:1rem;">
		<%-- <div class="one-list" style="border-bottom: 1px solid #f5f5f5;">
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="font-weight: bold;">0000254364562134656</span>
				<span style="color:#019FEA;font-size: 0.9rem; ">进行中</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="">销售名称：李玉兰</span>
				<span style="color:red;font-size: 0.9rem; ">
				<i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i>217-03-15
				<img src="${ctx}/static/weixin/css/icon/icon-yue-red.png" style="height: 20px;">
				</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="">客户名称：广州中国人寿</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="color: #999999;">理由：活动取消，没能按预期进行</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;font-size: 0.9rem;">
				<span style="width: 48%;border: 1px solid #019FEA;color:#019FEA;text-align: center;padding: 0.2rem 0;" onclick="reject(1)">拒绝</span>
				<span style="width: 48%;background-color: #019FEA;color:#ffffff;text-align: center;padding: 0.2rem 0;" onclick="agree(id)">同意</span>
			</div>
		</div>
		<div class="one-list" style="border-bottom: 1px solid #f5f5f5;">
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="font-weight: bold;">0000254364562134656</span>
				<span style="color:#019FEA;font-size: 0.9rem; ">进行中</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="">销售名称：李玉兰</span>
				<span style="color:red;font-size: 0.9rem; ">
				<i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i>217-03-15
				<img src="${ctx}/static/weixin/css/icon/icon-yue-red.png" style="height: 20px;">
				</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="">客户名称：广州中国人寿</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="color: #999999;">理由：活动取消，没能按预期进行</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;font-size: 0.9rem;">
				<span style="width: 48%;border: 1px solid #019FEA;color:#019FEA;text-align: center;padding: 0.2rem 0;" onclick="reject(1)">拒绝</span>
				<span style="width: 48%;background-color: #019FEA;color:#ffffff;text-align: center;padding: 0.2rem 0;" onclick="agree(id)">同意</span>
			</div>
		</div>
		<div class="one-list" style="border-bottom: 1px solid #f5f5f5;">
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="font-weight: bold;">0000254364562134656</span>
				<span style="color:#019FEA;font-size: 0.9rem; ">进行中</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="">销售名称：李玉兰</span>
				<span style="color:red;font-size: 0.9rem; ">
				<i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i>217-03-15
				<img src="${ctx}/static/weixin/css/icon/icon-yue-red.png" style="height: 20px;">
				</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="">客户名称：广州中国人寿</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="color: #999999;">理由：活动取消，没能按预期进行</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;font-size: 0.9rem;">
				<span style="width: 48%;border: 1px solid #019FEA;color:#019FEA;text-align: center;padding: 0.2rem 0;" onclick="reject(1)">拒绝</span>
				<span style="width: 48%;background-color: #019FEA;color:#ffffff;text-align: center;padding: 0.2rem 0;" onclick="agree(id)">同意</span>
			</div>
		</div>
		<div class="one-list" style="border-bottom: 1px solid #f5f5f5;">
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="font-weight: bold;">0000254364562134656</span>
				<span style="color:#019FEA;font-size: 0.9rem; ">进行中</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="">销售名称：李玉兰</span>
				<span style="color:red;font-size: 0.9rem; ">
				<i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i>217-03-15
				<img src="${ctx}/static/weixin/css/icon/icon-yue-red.png" style="height: 20px;">
				</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="">客户名称：广州中国人寿</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="color: #999999;">理由：活动取消，没能按预期进行</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;font-size: 0.9rem;">
				<span style="width: 48%;border: 1px solid #019FEA;color:#019FEA;text-align: center;padding: 0.2rem 0;" onclick="reject(1)">拒绝</span>
				<span style="width: 48%;background-color: #019FEA;color:#ffffff;text-align: center;padding: 0.2rem 0;" onclick="agree(id)">同意</span>
			</div>
		</div> --%>
	</div>
	
	<form id="form_list_params" style="display:none;">
		<input id="search_state" type="text" name="search_EQ_o.state" value="11" /> 
		
		<input id="search_EQ_orderNo" type="text" name="search_EQ_o.order_no" />
		<input id="search_EQ_contactNumber" type="text" name="search_EQ_o.contact_number" />
		<input id="search_LIKE_hotelName" type="text" name="search_LIKE_h.hotel_name" />
	</form>
	<div id="offline_check_no_div" class="div-tips-dialog" style="top:25%;left:8%;padding:1rem 2%;width:80%;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;padding: 0.5rem 0;">
			<div style="color: #000000;">不通过原因</div>
			<div id="offline_check_no_ic_close" class="icon-close" style="position: absolute;top: -0.5rem;right: 0;">&nbsp;</div>
			<input id="orderNo" name="orderNo" type="hidden" value="">
 		</div>
		<div style="padding:0 2%;" >
			<textarea id="reason" rows="15" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入不通过原因"></textarea>
		</div>
		
		<div class="display-flex" style="padding: 1rem 0;">
			<div id="btn_offline_check_no_cansel" class="btn btn-xs bg-type-02" style="padding:0.3rem 0.8rem;width: 40%;" >再考虑</div>
			<div id="btn_offline_check_no_sure" class="btn btn-xs bg-type-01" style="padding:0.3rem 0.8rem;width: 40%;" onclick="reject()" > 确定</div>
		</div>
	</div>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>
<script>
var pager = null;
$(function(){
	dict.init();
	pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/order/list',
		form : $('#form_list_params'),
		jqobj : $('#order_list_div'),
		tmpid : 'temp_list_order'
	}); 
	template.config('escape', false);
	template.helper('dayFormat', function(date){
		return common.formatDate(date);
	});
	$('#offline_check_no_ic_close').click(function(){
		 rejectCloseForm();
	});
	$('#btn_offline_check_no_cansel').click(function(){
		 rejectCloseForm();
	});

	$('#btn_order_search').click(function(){
		 var tel = /^(13|15|18|17)\d{9}$/;
		 var numberReg = new RegExp("^[0-9]*$");
		 var searchVal = $('#input_search_val').val();
		 $('#form_list_params')[0].reset();
		 if(tel.test(searchVal)){
			 $('#search_EQ_contactNumber').val(searchVal);
		 }else if(numberReg.test(searchVal)){
			 $('#search_EQ_orderNo').val(searchVal);
		 }else{
			 $('#search_LIKE_hotelName').val(searchVal);
		 }
		 pager.search();
		 
	});
})

function rejectOpenForm(id){
	showMaskDiv();
	$("#orderNo").val(id);
	$("#offline_check_no_div").show();
}
function rejectCloseForm(){
	hideMaskDiv();
	$("#orderNo").val('');
	$("#reason").val('');
	$("#offline_check_no_div").hide();
}
function reject(){
	var orderNo = $("#orderNo").val();
	var reason = $("#reason").val();
	if(reason===''){
		toastFn("请输入原因");
		return;
	}
	$(".mask-full-screen").css("z-index",999999);
	 $.post('${ctx}/weixin/order/site/adjustment/reject',{id:orderNo,reason:reason},function(res){
		toastFn(res.message);
		if(res.statusCode=='200'){
			pager.search();
			rejectCloseForm()
		}else{
			$("#offline_check_no_div").show();
		}
		$(".mask-full-screen").css("z-index",66666);
	},'json'); 
}
function agree(id){
	showMaskDiv();
	
	$.post('${ctx}/weixin/order/site/adjustment/agree',{id:id},function(res){
		toastFn(res.message);
		if(res.statusCode=='200'){
			pager.search();
		}else{
		}
		hideMaskDiv();
	},'json');
}
function showMaskDiv(){
	$('#mask-full-screen').show();
	$('body').css('overflow','hidden');
}

function hideMaskDiv(){
	$('body').css('overflow-y','auto');
	$('#mask-full-screen').hide();
}

</script>
<script id="temp_list_order" type="text/html">
	{{each rows as item i}}
		<div class="one-list" style="border-bottom: 1px solid #f5f5f5;">
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="font-weight: bold;">{{item.orderNo}}</span>
				<span style="color:#019FEA;font-size: 0.9rem; ">{{item.state | tp_fn05}}</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="">销售名称：{{item.hotelSaleName}}</span>
				<span style="color:red;font-size: 0.9rem; ">
					<i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i>{{item.refundDate | dayFormat}}
				</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="">客户名称：{{item.linkman}}</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
				<span style="color: #999999;">理由：{{item.refundReason}}</span>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;font-size: 0.9rem;">
				<span style="width: 48%;border: 1px solid #019FEA;color:#019FEA;text-align: center;padding: 0.2rem 0;" onclick="rejectOpenForm('{{item.id}}')">拒绝</span>
				<span style="width: 48%;background-color: #019FEA;color:#ffffff;text-align: center;padding: 0.2rem 0;" onclick="agree('{{item.id}}')">同意</span>
			</div>
		</div>
	{{/each}}
</script>
</html>
