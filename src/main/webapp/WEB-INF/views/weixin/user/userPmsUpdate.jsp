<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>调整权限</title>
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
    	.other-groups-pms{
    		font-size:0;
    	}
    	
    	.other-groups-pms .btn:nth-child(even) {
		    margin-left: 1%;
		}
		.other-groups-pms .btn:nth-child(odd) {
   			 margin-right: 1%;
		}
		
		#other_group_pms_list .fa {
		    -webkit-transform: scale(1.2);
		    width: 0.8rem;
		    margin-left:0.3rem;
		}
    </style>
</head>

<body class="" style="">
	<div class="user_list_one" style="width:96%;padding:0 2%;margin-top:1rem;margin-bottom: 4.5rem;">
		<div class="info-one-div" style="">
			<div>
				<div style="float:left;font-size:1rem;">所在场地名称：${hotel.hotelName}</div>
				<!-- <div class="btn btn-xs bg-type-02" style="color:#f5f5f5; float:right;padding:0.3rem 0.8rem;">重置密码</div> -->
				<div style="clear:both;"></div>
			</div>
			<div class="btn btn-xs bg-none-00" style="padding:0.2rem 1rem;margin-top:1rem;font-size: 0.85rem;">基本信息</div>
		</div>
		<div class="info-one-div" style="line-height:1.3rem;">
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;">
				<div >${user.rname}<span style="margin-left:0.5rem;color:#28A8EC;">${user.state eq '1' ?user.groupName:'已离职'}</span></div>
				<div>客户综合评价
					<div class="icon-start-02 icon-start-size-${not empty comprehensive? comprehensive:user.star}" style="display:inline-block;">
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
			</div>
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;">
				<div>联系电话：${user.mobile}</div>
				<div>系统登陆用户名：${user.username}</div>
			</div>
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;">
				<div>电子邮箱：${user.email}</div>
			</div>
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;">
				<div>个人拥有权限：
				<button class="btn bg-type-01" id="pms_slf_sel_all" type="button">全选</button>
				<button class="btn bg-type-02" id="pms_slf_unsel_all" type="button">全不选</button></div>
				</div>
			</div>
			
			<div id="pms_list_div" class="pms-list-parent" style="width:100%;font-size:0;">
				<%-- <c:forEach var="pms" items="${user.userPermissions}" >
					 <div class="btn btn-xs bg-none-01 icon-tr-02" style="padding:0.2rem 0;width:48%;">${pms.permissionName}</div>
				</c:forEach> --%>
			</div>
			
			<div id="btn_pms_add_other" class="btn btn-xs bg-none-02 flex-box flex-justify" style="padding:0.2rem 0;width:48%;align-items:flex-end;margin-top: 0.3rem;">
				<div style="border-right:0.1rem solid #FFB42B;flex-basis:85%;">添加其他职务权限</div>
				<div style="flex-basis:15%;">
					<div style="border:0.4rem solid transparent;border-top:0.4rem solid #FFB42B;width: 0;height: 0px;margin: 0 auto;"></div>
				</div>
			</div>
			
			
		</div>
		
		
		
	</div>	
		
	<div class="flex-box flex-justify" style="background-color: #ffffff;position: fixed;bottom: 0;padding: 0.5rem 2%;width:96%;">
		<div id="btn_confirm_update" class="btn btn-md bg-type-01" style="padding:0.5rem 0;width:100%;font-size: 1rem;">确认调整</div>
	</div>
	

	
	<div id="mask_full_screen" class="mask-full-screen" style=""></div>
	<div id="other_group_pms_parent" class="div-tips-dialog" style="display:none;margin-top: 0%;top:10%;height:70%;width:89%;padding:5% 3%;">
		<div style="width: 100%;line-height: 1.0rem;position: relative;">
			&nbsp;
			<div class="icon-close" style="position: absolute;top: -0.8rem;right: -0.8rem;">&nbsp;</div>
		</div>
		<div id="other_group_pms_list" style="height:85%;overflow-x:hidden;overflow-y:auto;text-align:left;">
		
		</div>
		<div id="btn_confirm_pms" class="btn btn-md bg-type-01" style="padding:0.3rem 0;width:90%;font-size:0.9rem;margin-top:1rem;">确定选择</div>
	</div>
	
	<form id="form" action="${ctx}/weixin/user/permission/savePermission" method="post"  style="display:none;">
		<input type="hidden" id="user_id" name="user_id" value="${user.id}"/>
		<input type="hidden" id="permission_old_ids" name="" />
		<input type="hidden" id="permission_ids" name="permission_ids" />
	</form>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.validate.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.metadata.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.validate.extend.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>


<script>
common.ctx =  '${ctx}';
var allPermissions = [];
var hasPmsIds = [];
$(function(){
	dict.init();
	var $form = $('#form');
	/* <div class="btn btn-xs bg-none-01 icon-tr-02" style="padding:0.2rem 0;width:48%;">${pms.permissionName}</div> */
	
	common.ajaxjson({
		url : '${ctx}/weixin/user/permission/findByGroupId?groupId=${user.groupId}',
		success : function(res){
			allPermissions = res.object? res.object :res;
			getUserPermission();
			//	var html = template('temp_script_permission', res);
		}
	});
	
	var other_group_pms_loaded = 0;
	$('#btn_pms_add_other').click(function(){	//添加其他角色权限
		$(".other-groups-pms").hide();
		$('#other_group_pms_list .pms-title').find('.fa').removeClass('fa-angle-up').addClass('fa-angle-down');
		if(other_group_pms_loaded != 1){
			loadOtherGroupPms();
			other_group_pms_loaded = 1;
		}else{
			showSelectPms();
		}
	});
	
	$('#mask_full_screen').click(function(){
		hideSelectPms();
	});
	
	
	template.helper('fm_has_pms', function(id){
		if($.inArray(id,hasPmsIds) != -1){
			return 'bg-none-01';
		}
		return 'btn-disable';
	});
	
	$('#btn_confirm_update').click(function(){	//确定调整
		saveUserPermission();
	});
	
	$('#btn_confirm_pms').click(function(){	//确定选择
		$('#other_group_pms_list .bg-none-01').each(function(){
			var $this = $(this);
			var $user_pms_target = $('#pms_list_div [pmsid='+$this.attr('pmsid')+']');
			if($user_pms_target.length > 0){	//如果用户个人拥有权限列表有这个权限
			}else{
				$('#pms_list_div').append($this.clone().prop("outerHTML"));
			}
		});
		
		$('#other_group_pms_list .btn-disable').each(function(){
			var $this = $(this);
			var $user_pms_target = $('#pms_list_div [pmsid='+$this.attr('pmsid')+']');
			if($user_pms_target.length > 0){	//如果取消了不属于当前用户组的权限
				$user_pms_target.removeClass('bg-none-01').addClass('btn-disable');
			}
		});
		hideSelectPms();
	});
	$(".icon-close").click(function(){
		hideSelectPms();
	});
	
	$("#pms_slf_sel_all").click(function(){
		$('#pms_list_div [pmsid]').addClass('bg-none-01').removeClass('btn-disable');
	});
	
	$("#pms_slf_unsel_all").click(function(){
		$('#pms_list_div [pmsid]').removeClass('bg-none-01').addClass('btn-disable');
	});
});

function showSelectPms(){
	$('#mask_full_screen').show();
	$('#other_group_pms_parent').show();
	$('#other_group_pms_list .bg-none-01').removeClass('bg-none-01').addClass('btn-disable');
	$('#pms_list_div .bg-none-01').each(function(){
		$('#other_group_pms_list [pmsid='+$(this).attr('pmsid')+']').removeClass('btn-disable').addClass('bg-none-01');
	});
	
	$('body').addClass("mbody");
	$('html').addClass("mhtml");
}
function hideSelectPms(){
	$('#mask_full_screen').hide();
	$('#other_group_pms_parent').hide();
	
	$('#pms_list_div [pmsid]').unbind('click',bindUserPmsBtnsClick).bind('click',bindUserPmsBtnsClick);
	
	$('body').removeClass("mbody");
	$('html').removeClass("mhtml");
}

function saveUserPermission(){	//保存
	var permission_ids = [];
	$('#pms_list_div .bg-none-01').each(function(){
		permission_ids.push($(this).attr('pmsid'));
	});
	$('#permission_ids').val(permission_ids.join(','));
	
	common.submitForm($('#form'),function(){	//提交表单
		toastFn('保存成功！');
		location.reload(true);
	},function(){
		toastFn('保存失败！');
	});
}

function getUserPermission(){	
	common.ajaxjson({
		url : '${ctx}/weixin/user/permission/findByUserId/${user.id}',
		success : function(res){
			var permissons = res.object? res.object :res;
			//<div class="btn btn-xs bg-none-01 " style="padding:0.2rem 0;width:48%;">${pms.permissionName}</div>
			var html = [];
			
			for(var i in permissons){
				hasPmsIds.push(permissons[i].permissionId);
				html.push('<div class="btn btn-xs bg-none-01" pmsid="'+permissons[i].permissionId + '" has="1" style="padding:0.2rem 0;width:48%;">'+permissons[i].permissionName+'</div>');
				//$('#pms_list_div [pid='+permissons[i].permissionId+']').removeClass('btn-disable').addClass('bg-none-01').show().attr('has','1');
			}
			
			$('#permission_old_ids').val(hasPmsIds.join(','));
			
			$('#pms_list_div').html(html.join(''));
			
			html = [];
			for(var i in allPermissions){
				var inArray = false;
				for(var j in hasPmsIds){
					if(hasPmsIds[j] == allPermissions[i].id){
						inArray = true;
					}
				}
				if(inArray){
					continue;
				}
				
				html.push('<div class="btn btn-xs btn-disable" pmsid="'+allPermissions[i].id + '" has="0" style="padding:0.2rem 0;width:48%;">'+allPermissions[i].displayname+'</div>');
			}
			
			$('#pms_list_div [pmsid]').unbind('click',bindUserPmsBtnsClick).bind('click',bindUserPmsBtnsClick);
			$('#pms_list_div').append(html.join(''));
			
			//	var html = template('temp_script_permission', res);
		}
	});
}

function bindUserPmsBtnsClick(){	//个人拥有权限列表点击事件	
	var $this = $(this);
	$this.toggleClass('bg-none-01').toggleClass('btn-disable');
	$('#other_group_pms_list [pmsid='+$this.attr('pmsid')+']').toggleClass('bg-none-01').toggleClass('btn-disable');
}

var removePmsIds = [];
function loadOtherGroupPms(){
	common.ajaxjson({
		url : '${ctx}/weixin/user/permission/groupPms/list?search_NE_id=${user.groupId}',
		success : function(res){
			var eachObject = {
				rows : res.object
			}
			var html = template('temp_script_group_pms', eachObject);
			$('#other_group_pms_list').html(html);
			
			$('#other_group_pms_list .pms-ren-sel-all').click(function(){	//其他角色权限全选点击事件
				var $this = $(this);
				var id = $this.attr('data');
				$('.pms-ren-'+id).addClass('bg-none-01').removeClass('btn-disable');
			});
			
			$('#other_group_pms_list .pms-ren-unsel-all').click(function(){	//其他角色权限全不选点击事件
				var $this = $(this);
				var id = $this.attr('data');
				$('.pms-ren-'+id).removeClass('bg-none-01').addClass('btn-disable');
			});
			
			$('#other_group_pms_list .pms-ren').click(function(){	//其他角色权限列表点击事件
				var $this = $(this);
				$this.toggleClass('bg-none-01').toggleClass('btn-disable');
			});
			
			$('#other_group_pms_list .pms-title').click(function(){	//选择权限点击事件
				var $this = $(this);
				$this.find('.fa').toggleClass('fa-angle-up').toggleClass('fa-angle-down');
				$this.next().toggle();
			});
			showSelectPms();
		}
	});
}
function disabledScroll(event){
	 event.preventDefault();
}
</script>

<script id="temp_script_permission" type="text/html">
{{each rows as item i}}
 <div class="btn btn-xs bg-none-01 icon-tr-02" style="padding:0.2rem 0;width:48%;">${pms.permissionName}</div>
{{/each}}
</script>
<script id="temp_script_group_pms" type="text/html">
{{each rows as item i}}
	<div class="" style="border-bottom:0.1rem solid #cccccc;padding-bottom:0.5rem;">
		<div class="flex-box flex-justify pms-title" style="font-size:1rem;margin:0.5rem 0;align-items:flex-end;">
			<div style="">{{item.name}}</div>
			<div class="chose-pms " style="font-size:0.8rem;">选择权限<i class="fa fa-angle-down toolbar-one-arrow" style=""></i></div>
		</div>
		<div class="other-groups-pms" style="border-top:0.1rem solid #cccccc;display:none;">
			<div style="text-align:right;margin:0.5rem 0;">
					<button class="btn bg-type-01  pms-ren-sel-all" data="{{item.id}}" type="button">全选</button>
					<button class="btn bg-type-02 pms-ren-unsel-all"  data="{{item.id}}" type="button">全不选</button>
			</div>
			{{each item.permissions as pms j}}
				<div class="btn btn-xs {{pms.id | fm_has_pms}} pms-ren pms-ren-{{item.id}}" pmsid="{{pms.id}}" style="padding:0.2rem 0;width:48%;margin-top:0.2rem" >{{pms.displayname}}</div>
			{{/each}}
		</div>		
	</div>
{{/each}}
</script>
</html>
