<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>人员管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
</head>

<body class="" style="">

	<div class="one-list" style="">
		<div class="one-list-ct"  style="">
		
			<div class="one-list-ct-title" style="position:relative;">
				<div style="display:inline-block;">${user.rname}</div>
				<div class="font-cl-type-02 font-size-min " style="display:inline-block;margin-left:0.3rem;font-weight:normal;">${user.groupName}</div>
				<div class="btn btn-xs bg-type-01" style="position:absolute;right:0;" rdurl="${ctx}/weixin/user/pwd/reset/${user.id}">重置密码</div>
			</div>
			
			<div class="one-list-ct-sett font-gray-01" style="">
			
				<div class="other-detail-one font-size-min" style="position: relative;">
					<div style="display:inline-block;position:absolute;left:0;">职务：${user.position}</div>
					<div style="display:inline-block;position:absolute;right:0;">邮箱：${user.email}</div>
				</div>
				
				<div class="other-detail-one font-size-min" style="position: relative;margin-bottom:0;">
					<div style="display:inline-block;position:absolute;left:0;">系统登录用户名：${user.username }</div>
					<div style="display:inline-block;position:absolute;right:0;">电话：${user.mobile}</div>
				</div>
  					
			</div>
		</div>
		
	</div>
	
	<div class="one-list-ct common-ct-inner"  style="border-top:0.1rem solid #cccccc;">
		<div class="" style="padding:1rem 0;position:relative;">
			<div style="display:inline-block;font-size:0.68rem;vertical-align:top;line-height: 1.2rem;">个人拥有权限：</div>
			<div id="btn_udpate_begin" class="btn btn-xs bg-type-02" style="position:absolute;right:0;">调整权限</div>
			<!-- <div id="btn_udpate_confirm" class="btn btn-xs bg-type-03" style="position:absolute;right:0;display:none;">确认调整</div> -->
		</div>
		
		<div id="pms_list_div" class="pms-list-parent" style="width:100%;font-size:0;">
			<%-- <c:forEach var="pms" items="${user.userPermissions}" >
				 <div class="btn btn-xs bg-none-01 icon-tr-02" style="padding:0.2rem 0;width:48%;">${pms.permissionName}</div>
			</c:forEach> --%>
		</div>
	</div>
	
	 <div class="export-res-parent" style="font-size:0.8rem;">
    	<div class="export-res-first-line"style="">提交录</div>
    	<div class="export-res-second-line">入信息</div>
     </div>


	<form id="form" action="/weixin/user/savePermission" method="post"  style="display:none;">
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

$(function(){
	dict.init();
	var $form = $('#form');
	/* <div class="btn btn-xs bg-none-01 icon-tr-02" style="padding:0.2rem 0;width:48%;">${pms.permissionName}</div> */
	
	common.ajaxjson({
		url : '${ctx}/weixin/permission/findAll',
		success : function(res){
			var allPermissions = res.object? res.object :res;
			getUserPermission(allPermissions);
			//	var html = template('temp_script_permission', res);
		}
	});
	
	
	$('#btn_udpate_begin').click(function(){
		var $this = $(this);
		if($this.hasClass('bg-type-02')){	//开始调整权限
			$this.text('确定调整').addClass('bg-type-03').removeClass('bg-type-02');
			
			$('#pms_list_div [has="1"]').addClass('icon-tr-02');
			$('#pms_list_div [has="0"]').addClass('icon-tr-01').show();
			
		}else{	//确定调整
			$this.text('调整权限').addClass('bg-type-02').removeClass('bg-type-03');
			var permission_ids = [];
			$('#pms_list_div [has="1"]').each(function(){
				permission_ids.push($(this).attr('pid'));
			});
			$('#permission_ids').val(permission_ids.join(','));
			
			if($('#permission_old_ids').val() == $('#permission_ids').val()){
				return;
			}
			
			$('#pms_list_div [has="1"]').removeClass('icon-tr-02');
			$('#pms_list_div [has="0"]').removeClass('icon-tr-01').hide();
			
			common.submitForm($form,function(res){	//提交
				 common.toast('调整成功！');
				 
	         });
		}
		
	});
	
	$('#pms_list_div').delegate('[has]','click',function(){
		var $this = $(this);
		var has = 0;
		if($this.attr('has') == '0'){
			has = 1;
			$this.removeClass('btn-disable').removeClass('icon-tr-01').addClass('icon-tr-02').addClass('bg-none-01').attr('has',has); 
		}else{
			$this.removeClass('bg-none-01').removeClass('icon-tr-02').addClass('icon-tr-01').addClass('btn-disable').attr('has',has);
		}	
	});
	
	
});

function getUserPermission(allPermissions){
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
			
			$('#permission_old_ids').val(hasPmsIds.join(','));
			
			for(var i in allPermissions){
				if($.inArray(allPermissions[i].id,hasPmsIds)){
					continue;
				}
			}
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
				
				html.push('<div class="btn btn-xs btn-disable" pid="'+allPermissions[i].id + '" has="0" style="padding:0.2rem 0;width:48%;display:none;">'+allPermissions[i].displayname+'</div>');
			}
			$('#pms_list_div').append(html.join(''));
			//	var html = template('temp_script_permission', res);
		}
	});
}

</script>

<script id="temp_script_permission" type="text/html">
{{each rows as item i}}
 <div class="btn btn-xs bg-none-01 icon-tr-02" style="padding:0.2rem 0;width:48%;">${pms.permissionName}</div>
{{/each}}
</script>
</html>
