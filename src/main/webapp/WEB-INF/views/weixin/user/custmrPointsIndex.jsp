<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>个人客户积分查询</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   
    <style type="text/css">
    	.hide{display: none;}
    	.bg-type-05{background-color: #999999;border-color: #999999;}
    </style>
</head>

<body class="">
	<div style="height:1.6rem;width:95%;margin:0 auto;margin-top:1rem;">
		<input id="input_search_val" type="text" name="" value="" style="width:72%;background-color:#f5f3f4;border:none;height:100%;outline:none;padding:0 4%;" placeholder="搜索客户姓名" />
		<div id="btn_search" class="icon-search-02" style="width:20%;height:100%;background-color:#FFB42B;float:right;background-size: 30%;background-position:center center;"></div>
	</div>
	<div id="points_list_div" class="tran-list-ct" style="width:100%;margin-top:1rem;">
		<!-- <div class="one-list" style="">
			<div class="one-list-ct itemdetail" style="" data="125">
				<div class="one-list-ct-title" style="display: flex;justify-content: space-between;width: 100%;">
					<div>
						<div style="display:inline-block;">拔高场地</div>
						<div class="list-ct-state list-ct-state-02 " style="display:inline-block;margin-left: 1rem;">广州</div>
					</div>
					<div>
						<div id="opn125" class="btn btn-xs btn-state-left bg-type-01" style="padding: 0.2rem 1rem;" >展开详情</div>
					</div>
				</div>
				
				<div style="width: 100%;">
					<div style="display: flex;justify-content: space-between;width: 100%;padding: 0.8rem 0;font-size: 0.9rem;">
						<span>累计积分：2500</span>
						<span>已兑现积分：800</span>
						<span>结余积分：1700</span>
					</div>
				</div>
			</div>
			<div class="one-list-ct hide" style="">
				<div style="display: flex;justify-content: space-between;width: 100%;padding: 0.3rem 0;font-size: 0.9rem;">
					<span style="color: red;">累计消费金额：￥250000</span>
				</div>
				<div style="display: flex;justify-content: space-between;width: 100%;padding: 0.3rem 0;font-size: 0.9rem;">
					<span>积分计算标准：xx元折算一分</span>
					<span>目前结余积分：1700</span>
				</div>
			</div>
		</div>
		<div class="one-list" style="">
			<div class="one-list-ct itemdetail" style="" data="126">
				<div class="one-list-ct-title" style="display: flex;justify-content: space-between;width: 100%;">
					<div>
						<div style="display:inline-block;">拔高场地</div>
						<div class="list-ct-state list-ct-state-02 " style="display:inline-block;margin-left: 1rem;">广州</div>
					</div>
					<div>
						<div id="opn126" class="btn btn-xs btn-state-left bg-type-01" style="padding: 0.2rem 1rem;" >展开详情</div>
					</div>
				</div>
				
				<div style="width: 100%;">
					<div style="display: flex;justify-content: space-between;width: 100%;padding: 0.8rem 0;font-size: 0.9rem;">
						<span>累计积分：2500</span>
						<span>已兑现积分：800</span>
						<span>结余积分：1700</span>
					</div>
				</div>
			</div>
			<div class="one-list-ct hide" style="">
				<div style="display: flex;justify-content: space-between;width: 100%;padding: 0.3rem 0;font-size: 0.9rem;">
					<span style="color: red;">累计消费金额：￥250000</span>
				</div>
				<div style="display: flex;justify-content: space-between;width: 100%;padding: 0.3rem 0;font-size: 0.9rem;">
					<span>积分计算标准：xx元折算一分</span>
					<span>目前结余积分：1700</span>
				</div>
			</div>
		</div> -->
	</div>
	<div style="background-color: #f5f5f5;">
		<div style="color: #5f5f5f;margin: 0 2%; padding: 0.5rem 0;">积分情况</div>
		<div style="background-color: #019FEA;color: #ffffff; padding: 0.5rem 0;">
			<div style="margin: 0.3rem 3%;display: flex;justify-content: space-between;">
				<span style="width: 33%;">累计积分：${res.totalPoints }</span>
				<span style="width: 33%;">已兑现积分：${res.cashPoints }</span>
				<span style="width: 33%;">结余积分：${res.balancePoints }</span>
			</div>
		</div>
	</div>
	<form id="form_list_params" style="display:none;">
		<input type="hidden" name="search_EQ_clientType" value="CLIENT">
		<input type="hidden" id="search_name" name="search_LIKE_clientName" value="">
	</form>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>

<script>
$(function(){
	var pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/user/points/list',
		form : $('#form_list_params'),
		jqobj : $('#points_list_div'),
		tmpid : 'temp_list_points'
	}); 
	
	$('#points_list_div').delegate('.itemdetail','click',function(){	//不限
		var $this = $(this);
		var flag = $this.next().hasClass('hide');
		if(flag){
			$('.itemdetail').each(function(){
				var $_this = $(this);
				var id= $_this.attr("data");
				var _flag = $_this.next().hasClass('hide');
				if(!_flag){
					$_this.next().addClass('hide');
					$("#opn"+id).text('展开详情');
					$("#opn"+id).removeClass('bg-type-05');
				}
			});
			var pid = $this.attr("data");
			$("#opn"+pid).text('收起详情');
			$("#opn"+pid).addClass('bg-type-05');
		}else{
			var pid = $this.attr("data");
			$("#opn"+pid).text('展开详情');
			$("#opn"+pid).removeClass('bg-type-05');
		}
		
		$this.next().toggleClass("hide");
	});
	
	$('#btn_search').click(function(){
		 var tel = /^(13|15|18|17)\d{9}$/;
		 var numberReg = new RegExp("^[0-9]*$");
		 var searchVal = $('#input_search_val').val();
		 $('#form_list_params')[0].reset();
		 if(tel.test(searchVal)){
			 //$('#search_EQ_hotelSaleMobile').val(searchVal);
		 }else if(numberReg.test(searchVal)){
			 //$('#search_EQ_orderNo').val(searchVal);
		 }else{
		 }
		 $('#search_LIKE_clientName').val(searchVal);
		 pager.search();
		 
	});
});
</script>
<script id="temp_list_points" type="text/html">
	{{each rows as item i}}
		<div class="one-list" style="">
			<div class="one-list-ct itemdetail" style="" data="{{item.id}}">
				<div class="one-list-ct-title" style="display: flex;justify-content: space-between;width: 100%;">
					<div>
						<div style="display:inline-block;">{{item.clientName}}</div>
						<div class="list-ct-state list-ct-state-02 " style="display:inline-block;margin-left: 1rem;">{{item.clientArea}}</div>
					</div>
					<div>
						<div id="opn{{item.id}}" class="btn btn-xs btn-state-left bg-type-01" style="padding: 0.2rem 1rem;" >展开详情</div>
					</div>
				</div>
				
				<div style="width: 100%;">
					<div style="display: flex;justify-content: space-between;width: 100%;padding: 0.8rem 0;font-size: 0.9rem;">
						<span>累计积分：{{item.totalPoints}}</span>
						<span>已兑现积分：{{item.cashPoints}}</span>
						<span>结余积分：{{item.balancePoints}}</span>
					</div>
				</div>
			</div>
			<div class="one-list-ct hide" style="">
				<div style="display: flex;justify-content: space-between;width: 100%;padding: 0.3rem 0;font-size: 0.9rem;">
					<span style="color: red;">累计消费金额：￥{{item.totalAmount}}</span>
				</div>
				<div style="display: flex;justify-content: space-between;width: 100%;padding: 0.3rem 0;font-size: 0.9rem;">
					<span>积分计算标准：{{item.pointStandard}}</span>
					<span>目前结余积分：{{item.balancePoints}}</span>
				</div>
			</div>
		</div>
	{{/each}}
</script>
</html>
