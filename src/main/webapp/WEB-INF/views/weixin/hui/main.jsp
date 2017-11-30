<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html style="height:100%;">
<head>
	<title>${empty parentMenu.name? '场地SAAS系统管理' : parentMenu.name}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/main.css" rel="stylesheet" />
    
</head>

<body class="bg-body-main bg-body-main-size-${userRootMenus.size()}" style="height:100%;">
	<div id="mask_div" class="mask-div" style="display:none;"></div>
	<c:forEach items="${userRootMenus}" var="userRootMenu">
		<c:if test="${userRootMenu.type eq 'other' }">
			<div class="per-div-main font-0" style="" rdurl="${userRootMenu.url}">
				<div style="height:30%">&nbsp;</div>
				<div style="height:40%;display:table;width:100%;">
					<div class="per-div-md-lf main-icon-${userRootMenu.icon}">
					</div> 
					<div class="dp-inbl per-div-main-ct per-div-md-ct" style="">
						<div >${userRootMenu.name }</div>
						<div class="per-div-md-en">${userRootMenu.enName}</div>
					</div>
					<div class="per-div-md-rt">
					</div> 
				</div>
				<div style="height:30%">&nbsp;</div>
			</div>
		</c:if>
		<c:if test="${userRootMenu.type ne 'other' }">
			<c:set var="secondmenuUrl"  value="secondmenu/${userRootMenu.id }" ></c:set>
			<div class="per-div-main font-0" style="" rdurl="${ctx}/${empty userRootMenu.authorizedChildrenMenuList? userRootMenu.url : secondmenuUrl}">
				<div style="height:30%">&nbsp;</div>
				<div style="height:40%;display:table;width:100%;">
					<div class="per-div-md-lf main-icon-${userRootMenu.icon}">
					</div> 
					<div class="dp-inbl per-div-main-ct per-div-md-ct" style="">
						<div >${userRootMenu.name }</div>
						<div class="per-div-md-en">${userRootMenu.enName}</div>
					</div>
					<div class="per-div-md-rt">
					</div> 
				</div>
				<div style="height:30%">&nbsp;</div>
			</div>
		</c:if>
		
	</c:forEach>
	<div style="position: fixed;bottom: 0.5rem;right: 0.5rem;" rdurl="${ctx}/weixin/message/index">
		<img src="${ctx}/static/weixin/css/icon/main/ckxx.png" style="height: 16px;">
		<span style="color: #ffffff;font-size: 1.0rem;">查看消息</span>
		<div id="messageRemindState" style="width: 5px;height: 5px;background-color: red;position: absolute;right: 0;top: 0;border-radius:3px; display: none;">&nbsp;</div>
	</div>
	
	<div style="position: fixed;bottom: 0.5rem;left: 0.5rem;" rdurl="${ctx}/logout">
    	<img src="${ctx}/static/weixin/css/icon/logout.png" style="height: 16px;">
		<span style="color: #ffffff;font-size: 1.0rem;">登出系统</span>
     </div>
     
     <div id="offline_check_no_div" class="div-tips-dialog" style="top:25%;left:8%;padding:1rem 2%;width:80%;text-align:left;display:none;">
			<div  style="text-align:center;line-height: 1.5rem;position: relative;padding: 0.5rem 0;">
				<div style="color: #000000;">返佣通知</div>
				<div id="offline_check_no_ic_close" class="icon-close" style="position: absolute;top: -0.5rem;right: 0;">&nbsp;</div>
				<input id="tostate" name="tostate" type="hidden" value="">
	 		</div>
			<div style="padding:0 2%;" >
				您有<span id="commissionNum">0</span>笔订单需要进行返佣操作！
			</div>
			
			<div class="display-flex" style="padding: 1rem 0;">
				<div id="btn_offline_check_no_cancel" class="btn btn-xs bg-type-02" style="padding:0.3rem 0.8rem;width: 40%;" >再考虑</div>
				<div id="btn_offline_check_no_sure" class="btn btn-xs bg-type-01" style="padding:0.3rem 0.8rem;width: 40%;"  rdurl="${ctx}/weixin/order/index"> 去返佣</div>
			</div>
		</div>	
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/common.permission.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>

<script>

$(function(){

	
	common.ctx =  '${ctx}';
	common.clearstorage('dictJson');
	dict.init();
	var mypermissions = "<%=request.getAttribute("permissions") %>";
	if(mypermissions!=null&&mypermissions!=''&&mypermissions!='null'){
		common.setstorage("permissions",mypermissions);		
	}
	
	var $perdivmain = $('.per-div-main');
	$perdivmain.click(function(){
		$perdivmain.removeClass('per-active');
		$(this).addClass('per-active');
	});
	<c:if test="${groupMap.ishotelfinanice }">
		show();
	</c:if>
	
	$("#offline_check_no_ic_close").click(function(){
		 commissionRemindHide()
	});

	$("#btn_offline_check_no_cancel").click(function(){
		 commissionRemindHide()
	});
	
	messageRemind();
});
function commissionRemindHide(){
	$("#mask_div").hide();
	$("#offline_check_no_div").hide();
}
function show(){
	var ismain = '${main}';
	if(!window.localStorage){
        return false;
    }else{
        var hotel_finanice_remind=window.localStorage.hotel_finanice_remind;
        if(!hotel_finanice_remind&&ismain=='1'){
        	commissionRemind();
        }else{
        	var crttime = new Date().getTime();
        	var ge = crttime-hotel_finanice_remind*1;
        	if((ge>2*60*1000)&&ismain=='1'){
        		commissionRemind();
        	}
        }
    }
}
function commissionRemind(){
	$.get('${ctx}/weixin/order/remind/commission',function(res){
		if(res.statusCode==='200'){
			$("#commissionNum").text(res.object);
			if(res.object>0){
				
				$("#mask_div").show();
	    		$("#offline_check_no_div").show();
	    		window.localStorage.hotel_finanice_remind=new Date().getTime();
	    		setTimeout("commissionRemindHide()",5000);
			}
		}
	});
}

function messageRemind(){
	$.get('${ctx}/weixin/message/remind/count',function(res){
		if(res.statusCode==='200'){
			if(res.object>0){
				$("#messageRemindState").show();
			}
			setTimeout("messageRemind()",5000);
		}
	});
}
</script>
</html>
