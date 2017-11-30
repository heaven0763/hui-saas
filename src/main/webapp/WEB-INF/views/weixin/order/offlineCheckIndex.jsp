<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>线下活动审核</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   	<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" type="text/css" />
    <style>
		
		.btn-state-left,.btn-state-right{
			width:32%;
		}
	
		.btn-state-left{
			position:absolute;left:18%;
		}
	
		.btn-state-right{
			position:absolute;right:0;
		}
		.one-item{padding: 0 2%;padding-top:1.5rem; border-bottom: 1px solid #cccccc;}
		/* .one-item:last-child {
			border:none;
		}  */
		
		.btn-hotel-type-1{ color: #019FEA;border: 1px solid #019FEA;}
		.btn-hotel-type-2{ color: #FFB635;border: 1px solid #FFB635;}
		.hide{display: none;}
		.show{}
		.more-item-active{color: #274082;}
		.partner-city-show-default{min-height: 1rem;}
		.partner-city-list-parent{margin-bottom: 50px;}
		.btn-pass{display:inline-block;background-color:#FFB635;color: #ffffff;padding: 0.3rem 0.5rem;}
		.btn-nopass{display:inline-block;background-color:#019FEA;color: #ffffff;padding: 0.3rem 0.5rem;}
    </style>
    
</head>

<body class="">
<div id="mask-full-screen" class="mask-full-screen"></div>
	<div class="tran-list-ct conent-list" style="width:100%;">
		
		<div id="offlineorder_list">
			
		</div>
			
		<form id="form_list_params" style="display:none;">
		</form>
	</div>
	
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script>
var pager = null;
$(function(){
	pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/order/offline/check/list',
		form : $('#form_list_params'),
		jqobj : $('#offlineorder_list'),
		tmpid : 'temp_list_offlineorder'
	}); 
	
	template.config('escape', false);
	template.helper('createDate', function(createDate){
		return common.formatDate(createDate,'yy-MM-dd');
	});
	
	template.helper('activityDate', function(activityDate){
		return common.formatDate(activityDate,'MM-dd');
	});
	
});

function showMaskDiv(){
	$('#mask-full-screen').show();
	$('body').css('overflow','hidden');
}

function hideMaskDiv(){
	$('body').css('overflow-y','auto');
	$('#mask-full-screen').hide();
}

function disabledScroll(event){
	 event.preventDefault();
};

</script>

<script id="temp_list_offlineorder" type="text/html">
	{{each rows as item i}}
			<div class="one-item" style="padding-bottom: 0.5rem;" item-rdurl="${ctx}/weixin/order/detail/{{item.id}}">
				<div class="itemdetail">
					<div style="position:relative;width:100%;vertical-align:bottom;">
						<div style="display:inline-block;font-weight:bold;font-size:1.0rem;">{{item.hotelName}}</div>
						<div style="display:inline-block;margin-left:0.8rem;font-size:0.9rem;color: #FFB42B;">{{item.area}}</div>
						{{if item.offlineState == '0'}}
						<div style="text-align: right;float: right;">
							<div class="btn btn-xs btn-nopass" style="" >点击审核</div>
						</div>
						{{/if}}
						{{if item.offlineState == '1'}}
						<div style="text-align: right;float: right;color: #019FEA;">
							<div class="btn btn-xs bg-none-01" style="" >通过审核</div>
						</div>
						{{/if}}
						{{if item.offlineState == '2'}}
						<div style="text-align: right;float: right;color:#FFB42B;" >
							<div class="btn btn-xs bg-none-02" style="" >不通过</div>
						</div>
						{{/if}}
						<div style="clear: both;"></div>
					</div>
					<div class="display-flex" style="width:100%;font-size:0.8rem;"><!--   -->
						<div style="margin:0.3rem 0;">提交人：{{item.companySaleName}}</div>
						<div style="margin:0.3rem 0;">提交时间：{{item.createDate | createDate}}	</div>
						<div style="margin:0.3rem 0;">活动时间：{{item.activityDate | activityDate}}	</div>
					</div>
				</div>
			</div>
	{{/each}}

</script>
</html>
