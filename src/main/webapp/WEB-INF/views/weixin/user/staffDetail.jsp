<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>人员信息列表详细</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <style type="text/css">
    	.info-one-div,.eva-one-div{
    		border-top:0.1rem solid #cccccc;margin-top:0.5rem;font-size:0.85rem;
    	}
    	
    	.info-one-div:first-child{
    		border:none;
    	}
    	.eva-one-div{
    		padding:1rem 0 0.5rem 0;
    	}
    	.user-item{
			border-bottom: 1px solid #f5f5f5;
			padding-top: 1rem;
			padding-bottom: 0.5rem
		}
		
		.view{display: block;}
		.hide{display: none;}
		
    </style>
</head>

<body class="" style="">
	<div class="user_list_one" style="width:96%;padding:0 2%;margin-top:1rem;margin-bottom: 4.5rem;">
		<div class="info-one-div" style="">
			<div class="btn btn-xs bg-none-00" style="padding:0.2rem 1rem;margin-top:1rem;font-size: 0.85rem;">基本信息</div>
		</div>
		<div class="info-one-div" style="line-height:1.3rem;">
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;line-height: 1.3rem;height: 1.3rem;">
				<div style="">
					<span style="font-size: 1rem;line-height: 1.3rem;vertical-align: middle;">${user.rname}</span>
					<span style="margin-left:0.5rem;color:#28A8EC;line-height: 1.3rem;vertical-align: middle;">${user.state eq '1' ?user.groupName:'已离职'}</span>
				</div>
				<div>
					<div class="btn btn-xs bg-type-02" style="color:#f5f5f5; float:right;padding:0.3rem 0.8rem;" rdurl="${ctx}/weixin/user/pwd/reset/${user.id}">重置密码</div>
				</div>
			</div>
			<c:if test="${ispartner }">
				<div class="flex-box flex-justify" style="margin: 0.5rem 0;">
					<div >合伙信息：${region.regionName}城市合伙人<span style="margin-left:0.5rem;">${partner.rname}</span></div>
				</div>
			</c:if>
			<%-- <div class="flex-box flex-justify" style="margin: 0.5rem 0;">
				<div >任职职务：${user.position}<span style="margin-left:0.5rem;color:#28A8EC;">${user.state eq '1' ?user.groupName:'已离职'}</span></div>
			</div> --%>
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;">
				<div >任职职务：${user.position}<%-- <span style="margin-left:0.5rem;color:#28A8EC;">${user.state eq '1' ?user.groupName:'已离职'}</span> --%></div>
			</div>
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;">
				<div>联系电话：${user.mobile}</div>
				<div>系统登陆用户名：${user.username}</div>
			</div>
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;">
				<div>电子邮箱：${user.email}</div>
				<c:if test="${user.state eq '1' && groupMap.ishuihr }">
					<div id="quit_edit" style="color: red;">离职编辑</div>
				</c:if>
				<c:if test="${user.state eq '1' && user.groupId eq '17' && groupMap.iscompanyadministrator}">
					<div id="quit_to_hr" style="color: red;">撤销权限</div>
				</c:if>
			</div>
			
			<c:if test="${ispartner }">
				<div class="flex-box flex-justify" style="margin: 0.5rem 0;">
					<input type="hidden" name="companyId" id="companyId" value="${company.id}"/>
					<div>签约期限：2017-01-01至2018-12-31</div>
					<!-- ${company.seffectiveDate}至${company.eeffectiveDate} -->
					<div id="effective_edit" style="color: red;">编辑</div>
				</div>
			</c:if>
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;">
				<div>个人拥有权限：</div>
			</div>
			<div id="pms_list_div" class="pms-list-parent" style="width:100%;font-size:0;margin:0.5rem 0;">
			</div>
			<div id="tmp_pms_div"  style="margin: 0.5rem 0;">
				<div>临时权限：</div>
				<div id="tmp_pms_list_div" class="pms-list-parent" style="width:100%;font-size:0;margin:0.5rem 0;">
				</div>
			</div>
		</div>
		
		<div style="margin-top: 0.5rem;${(user.groupId eq 3 || user.groupId eq 9)?'':'display:none;'}">
			<div style="border-bottom: 1px solid #999999;padding: 0.5rem 0;">
				<div class="btn btn-xs bg-none-00" style="padding:0.2rem 1rem;margin-top:1rem;font-size: 0.85rem;">综合评价</div>
			</div>
			<div id="user_evaluate_list">
				<!-- <div class="eva-one-div" style="line-height:1.3rem;">
					<div class="flex-box flex-justify">
						<div>张三</div>
						<div>星评：
							<div class="icon-start-02 icon-start-size-5" style="display:inline-block;">
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
							</div>
						</div>
					</div>
					<div style="color:#9e9e9e;">2016-12-12</div>
					<div style="">整体服务还是不错的。。。。。。。。。。。。。。。哈哈哈哈。。。。。。。。。。。哈哈哈哈。。。。。。。。。。。哈哈哈哈</div>
					<div style="color:#cb2b29;">回复：“谢谢。。。。。。。。。。。。。。哈。。。。。。。。。。。哈哈哈哈”</div>
				</div>  -->
			
			</div>
		</div>
		<c:if test="${not empty  users}">
		<div style="margin-top: 0.5rem;">
			<div style="border-bottom: 1px solid #999999;padding: 0.5rem 0;">
				<div class="btn btn-xs bg-none-00" style="padding:0.2rem 1rem;margin-top:1rem;font-size: 0.85rem;float: left;">人员详细信息</div>
				<div class="open date-icon-right" style="padding:0.2rem 1rem;margin-top:1rem;font-size: 0.85rem;float: right;color: #28A8EC;background-size: 10px;">展开</div>
				<div style="clear: both;"></div>
			</div>
			<div id="partner_user_list" class="hide">
				<c:forEach items="${users }" var="u">
					<div class="font-size-min flex-box user-item" style="" item-rdurl="/hui/weixin/user/staff/detail/${u.id }">
						<div style="display: table-cell;width: 27%;">姓名：${u.rname }</div>
						<div style="display: table-cell;width: 28%;">职位：${u.position }</div>
						<div style="display: table-cell;width: 45%;text-align: right;">联系电话：${u.mobile }</div>
					</div>
				</c:forEach>
			</div>
		</div>
		</c:if>
		
	</div>
	
	<c:choose>
		<c:when test="${ (groupMap.ishuihr || groupMap.iscompanyadministrator) && user.state eq '1'}">
			
			<div class="flex-box flex-justify" style="padding:0.5rem 0.4rem;background-color: #ffffff;position: fixed;width: 96%;bottom:0;font-size: 1rem;">
				<div class="btn btn-xs bg-none-01" style="width:48%;padding:0.5rem 0;font-size: 1rem;" rdurl="${ctx}/weixin/user/staff/pms/update/${user.id}">调整权限</div>
				<div class="btn btn-xs bg-type-01" style="width:48%;padding:0.5rem 0;font-size: 1rem;" rdurl="${ctx}/weixin/user/author/transfer?fromuserId=${user.id}&gid=${user.groupId}">权限转移</div>
			</div>
		</c:when>
		<c:when test="${(groupMap.ishuihr || groupMap.iscompanyadministrator)   && user.state eq '0'}">
			<div class="flex-box flex-justify" style="padding:0.5rem 2%;background-color: #ffffff;position: fixed;width: 96%;bottom:0;font-size: 1rem;">
				<div class="btn btn-xs bg-none-01" style="width:48%;padding:0.5rem 0;font-size: 1rem;" onclick="recovery('0','${user.id}');">恢复职位</div>
				<div class="btn btn-xs bg-type-01" style="width:48%;padding:0.5rem 0;font-size: 1rem;" onclick="relieve('0','${user.id}');">解除权限</div>
			</div>
		</c:when>
		<c:when test="${groupMap.iscompanyadministrator and user.groupId eq '17' && user.state eq '1'}">
			<div class="flex-box flex-justify" style="padding:0.5rem 0.4rem;background-color: #ffffff;position: fixed;width: 96%;bottom:0;font-size: 1rem;">
				<div class="btn btn-xs bg-none-01" style="width:48%;padding:0.5rem 0;font-size: 1rem;" rdurl="${ctx}/weixin/user/staff/pms/update/${user.id}">调整权限</div>
				<div class="btn btn-xs bg-type-01" style="width:48%;padding:0.5rem 0;font-size: 1rem;" rdurl="${ctx}/weixin/user/author/transfer?fromuserId=${user.id}&gid=${user.groupId}">权限转移</div>
			</div>
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>
	
	
	
	<form action="" id="form_list_params" style="display:none;">
		<input id="search_EQ_saleId" type="text" name="search_EQ_saleId"  value="${user.id}"/>
	</form>
	<div id="mask_full_screen" class="mask-full-screen" style=""></div>
	<div id="quit_job"  class="div-tips-dialog" style="display:none;margin-top: 0%;top:25%;height:20%;width:89%;padding:5% 3%;z-index:90000;background-color: #ffffff; ">
		<div style="width: 100%;line-height: 1.0rem;position: relative;">
			&nbsp;
			<div class="icon-close" style="position: absolute;top: -0.5rem;right: -0.5rem;">&nbsp;</div>
		</div>
		<div class="flex-justify" style="text-align: center;font-size: 1.2rem;color: #000000;margin-top: 0.5rem;">标记为离职人员</div>
		<div class="flex-box flex-justify" style="margin-top: 10%;">
			<div id="quit_job_no" class="btn btn-xs bg-type-02" style="width:45%;padding:0.3rem 0;font-size: 1rem;background: ">再考虑</div>
			<div id="quit_job_yes" class="btn btn-xs bg-type-01" style="width:45%;padding:0.3rem 0;font-size: 1rem;">确定</div>
		</div>
	</div>
	<div id="effectivedate_edit"  class="div-tips-dialog" style="display:none;margin-top: 0%;top:25%;height:30%;width:89%;padding:5% 3%;z-index:90000;background-color: #ffffff; ">
		<div style="width: 100%;line-height: 1.0rem;position: relative;">
			&nbsp;
			<div class="icon-close" style="position: absolute;top: -0.5rem;right: -0.5rem;">&nbsp;</div>
		</div>
		<div class="flex-justify" style="text-align: center;font-size: 1.2rem;color: #000000;margin-top: 0.5rem;">请选择时间</div>
		<div class="flex-justify" style="text-align: center;font-size: 1.2rem;color: #000000;margin-top: 1rem;">
			<input type="date" id="seffectivedate" name="seffectivedate" value="" style="width:45%;height:1.5rem;line-height:1.5rem;"> 
			- <input type="date" id="eeffectivedate" name="eeffectivedate" value="" style="width:45%;height:1.5rem;line-height:1.5rem;">
		</div>
		<div class="flex-box flex-justify" style="margin-top: 5%;">
			<div id="effectivedate_edit_btn" class="btn btn-xs bg-type-01" style="width:100%;padding:0.3rem 0;font-size: 1rem;">确定合作时间</div>
		</div>
	</div>
	
	<div id="quit_hr"  class="div-tips-dialog" style="display:none;margin-top: 0%;top:25%;height:20%;width:89%;padding:5% 3%;z-index:90000;background-color: #ffffff; ">
		<div style="width: 100%;line-height: 1.0rem;position: relative;">
			&nbsp;
			<div id="quit_hr_close" class="icon-close" style="position: absolute;top: -0.5rem;right: -0.5rem;">&nbsp;</div>
		</div>
		<div class="flex-justify" style="text-align: center;font-size: 1.2rem;color: #000000;margin-top: 0.5rem;">撤销HR权限</div>
		<div class="flex-box flex-justify" style="margin-top: 10%;">
			<div id="quit_hr_no" class="btn btn-xs bg-type-02" style="width:45%;padding:0.3rem 0;font-size: 1rem;background: ">再考虑</div>
			<div id="quit_hr_yes" class="btn btn-xs bg-type-01" style="width:45%;padding:0.3rem 0;font-size: 1rem;">确定</div>
		</div>
	</div>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>


<script>
common.ctx =  '${ctx}';
$(function(){
	dict.init();
	template.config('escape', false);
	template.helper('fm_reply_ct', function(replyContent){
		return replyContent? '<div style="color:#cb2b29;">回复：“'+replyContent+'”</div>' : '';
	});
	
	var pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/user/evaluate/list',
		form : $('#form_list_params'),
		jqobj : $('#user_evaluate_list'),
		tmpid : 'temp_script_list'
	}); 
	 

	common.ajaxjson({
		url : '${ctx}/weixin/user/permission/findByUserId/${user.id}',
		success : function(res){
			var permissons = res.object? res.object :res;
			//<div class="btn btn-xs bg-none-01 " style="padding:0.2rem 0;width:48%;">${pms.permissionName}</div>
			var html = [];
			var hasPmsIds = [];
			for(var i in permissons){
				hasPmsIds.push(permissons[i].permissionId);
				html.push('<div class="btn btn-xs bg-none-01" pid="'+permissons[i].permissionId + '" has="1" style="padding:0.2rem 0;width:48%;">'+permissons[i].permissionName+'</div>');
				//$('#pms_list_div [pid='+permissons[i].permissionId+']').removeClass('btn-disable').addClass('bg-none-01').show().attr('has','1');
			}
			$('#pms_list_div').html(html.join(''));
			
		}
	});
	
	common.ajaxjson({
		url : '${ctx}/weixin/user/permission/findTmpByUserId/${user.id}',
		success : function(res){
			var permissons = res.object? res.object :res;
			//<div class="btn btn-xs bg-none-01 " style="padding:0.2rem 0;width:48%;">${pms.permissionName}</div>
			var html = [];
			var hasPmsIds = [];
			for(var i in permissons){
				hasPmsIds.push(permissons[i].permissionId);
				html.push('<div class="btn btn-xs bg-none-01" style="padding:0.2rem 0;width:48%;">'+permissons[i].permissionName+'</div>');
				//$('#pms_list_div [pid='+permissons[i].permissionId+']').removeClass('btn-disable').addClass('bg-none-01').show().attr('has','1');
			}
			$('#tmp_pms_list_div').html(html.join(''));
			
		}
	});
	
	$("#quit_edit").click(function(){
		$('#mask_full_screen').show();
		$('#quit_job').show();
		$('body').addClass("mbody");
		$('html').addClass("mhtml");
	});
	$("#effective_edit").click(function(){
		$('#mask_full_screen').show();
		$('#effectivedate_edit').show();
		$('body').addClass("mbody");
		$('html').addClass("mhtml");
	});
	
	$("#quit_to_hr").click(function(){
		$('#mask_full_screen').show();
		$('#quit_hr').show();
	});
	
	$("#quit_hr_close").click(function(){
		$('#quit_hr').hide();
		$('#mask_full_screen').hide();
	});
	$("#quit_hr_no").click(function(){
		$('#quit_hr').hide();
		$('#mask_full_screen').hide();
	});
	
	$("#quit_hr_yes").click(function(){
		//标记为离职人员
		common.ajaxjson({
			url : '${ctx}/weixin/user/quit/${user.id}',
			success : function(res){
				toastFn('操作成功！');
				$('#quit_hr').hide();
				$('#mask_full_screen').hide();
				setTimeout(function(){
					location=location;
				},1500);
			}
		});
	});
	
	$('#mask_full_screen').click(function(){
		hide();
	});
	
	$(".icon-close").click(function(){
		hide();
	});
	
	$("#quit_job_no").click(function(){
		hide();
	});
	
	$(".open").click(function(){
		$this = $(this);
		$('#partner_user_list').toggleClass("view");
		$('#partner_user_list').toggleClass("hide");
	});
	
	$("#quit_job_yes").click(function(){
		//标记为离职人员
		common.ajaxjson({
			url : '${ctx}/weixin/user/quit/${user.id}',
			success : function(res){
				toastFn('操作成功！');
				hide();
				setTimeout(function(){
					location=location;
				},1500);
			}
		});
	});
	
	$("#effectivedate_edit_btn").click(function(){
		var seffectivedate = $('#seffectivedate').val();
		var eeffectivedate = $('#eeffectivedate').val();
		var companyId = $('#companyId').val();
		//标记为离职人员
		common.ajaxjson({
			url : '${ctx}/weixin/user/partner/effectivedate/save',
			data : {companyId:companyId,seffectivedate:seffectivedate,eeffectivedate:eeffectivedate},
			success : function(res){
				toastFn('操作成功！');
				hide();
				setTimeout(function(){
					location=location;
				},1500);
			}
		});
	});
});


function recovery(hotelId,userId){
	confirmFn("确定要恢复该员工的职位吗？",function(){
		common.ajaxjson({
			url : '${ctx}/weixin/user/recovery/'+hotelId+'/'+userId,
			success : function(res){
				toastFn('操作成功！');
				setTimeout(function(){
					location=location;
				},1500);
				
			}
		});
	});
}
function relieve(hotelId,userId){
	confirmFn("确定要彻底解除该员工的权限吗？",function(){
		common.ajaxjson({
			url : '${ctx}/weixin/user/relieve/'+hotelId+'/'+userId,
			success : function(res){
				toastFn('操作成功！');
				hide();
				setTimeout(function(){
					location=location;
				},1500);
			}
		});
	});
}


function hide(){
	$('#mask_full_screen').hide();
	$('#quit_job').hide();
	$('#effectivedate_edit').hide();
	$('body').removeClass("mbody");
	$('html').removeClass("mhtml");
}
function disabledScroll(event){
	 event.preventDefault();
}
</script>

<script id="temp_script_list" type="text/html">
{{each rows as item j}}
	<div class="eva-one-div" style="line-height:1.3rem;">
	<div class="flex-box flex-justify">
		<div>{{item.userName}}</div>
		<div>星评：
			<div class="icon-start-02 icon-start-size-{{item.comprehensive? item.comprehensive : 5}}" style="display:inline-block;">
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
			</div>
		</div>
	</div>
	<div style="color:#9e9e9e;">{{item.evaluateDate | dateFormat}}</div>
	<div style="">{{item.econtent}}</div>
	{{item.replyContent | fm_reply_ct}}
	
	</div>
{{/each}}
</script>

</html>