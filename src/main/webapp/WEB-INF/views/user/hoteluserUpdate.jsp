<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
<link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
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
.pms-item{padding:3px 0;margin:3px; width:24%;}
  </style>
<div  class="wrapper wrapper-content">
	<div class="row">
		<div class="col-sm-12" style="position: relative;">
			<a href="javascript:loadContent(this,'${ctx}/weixin/user/moredetail?hotelId=${user.hotelId}&userId=${user.id}&TYPE=${TYPE}','')" class="btn btn-warning" style="position: absolute;right: 20px;margin-top: 5px;top: 7px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
			<h3>权限调整</h3>
		</div>
	</div>
	<div class="user_list_one" style="margin-top:1rem;margin-bottom: 4.5rem;">
		<div class="row">
			<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">基本信息</span></div>
		</div>
		<div class="" style="padding:0 2%;">
			<div style="float:left;font-size:1rem;margin-top: 10px;">所在场地名称：${hotel.hotelName}</div>
			<a qx="user:update" class="btn btn-primary" style="float:right"  href="${ctx}/base/user/pwdForm/${user.id}" target="dialog"><span class="glyphicon glyphicon-cog"></span> 重置密码</a>
			<div style="clear:both;"></div>
		</div>
		<div class="info-one-div" style="line-height:1.3rem;padding:0 2%;">
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 3px 0;">
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
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 3px 0;">
				<div>联系电话：${user.mobile}</div>
				<div>系统登陆用户名：${user.username}</div>
			</div>
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 3px 0;">
				<div>电子邮箱：${user.email}</div>
			</div>
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;">
				<div>
					个人拥有权限：
					<button class="btn btn-primary" id="pms_slf_sel_all" type="button">全选</button>
					<button class="btn btn-default" id="pms_slf_unsel_all" type="button">全不选</button>
				</div>
			</div>
			
			<div id="pms_list_div" class="pms-list-parent" style="width:100%;font-size:0;">
				<%-- <c:forEach var="pms" items="${user.userPermissions}" >
					 <div class="btn btn-xs bg-none-01 icon-tr-02" style="padding:0.2rem 0;width:48%;">${pms.permissionName}</div>
				</c:forEach> --%>
			</div>
			
			<div id="btn_pms_add_other" class="btn btn-xs bg-none-02 flex-box flex-justify" style="padding:10px 0;width:24%;align-items:flex-end;margin-top: 5px;" data-toggle="modal" data-target="#other_group_pms_parent" >
				<div style="border-right:0.1rem solid #FFB42B;flex-basis:85%;">添加其他职务权限</div>
				<div style="flex-basis:15%;">
					<div style="border:0.4rem solid transparent;border-top:0.4rem solid #FFB42B;width: 0;height: 0px;margin: 0 auto;"></div>
				</div>
			</div>
		</div>
	</div>	
		
	<div class="flex-box flex-justify" style="background-color: #ffffff;padding: 0.5rem 2%;width:100%;">
		<div qx="user:tmpauthor" id="btn_confirm_update" class="btn btn-primary" ><span class="glyphicon glyphicon-saved"></span>确认调整</div>
	</div>
	
	<div id="other_group_pms_parent"  class="modal fade" tabindex="-1" role="dialog" >
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span>×</span> </button>
						<h4 class="modal-title" id="user_modal_title">其他角色权限</h4>
					</div>
	
	
	
					<div class="modal-body">
						<div id="other_group_pms_list" style="height: 95%; overflow-x: hidden; overflow-y: auto; text-align: left;">
	
						</div>
					</div>
					<div class="modal-footer">
						<button  id="close_btn" type="button" class="btn btn-default" data-dismiss="modal">
							<span class="glyphicon glyphicon-off"></span> 关闭
						</button>
						<button id="btn_confirm_pms" type="button" class="btn btn-primary">
							<span class="glyphicon glyphicon-save"></span> 确定选择
						</button>
					</div>
				</div>
			</div>
		</div>
	
	<!-- <div id="other_group_pms_parent" class="div-tips-dialog" style="display:none;margin-top: 0%;top:10%;height:70%;width:89%;padding:5% 3%;">
		<div style="width: 100%;line-height: 1.0rem;position: relative;">
			&nbsp;
			<div class="icon-close" style="position: absolute;top: -0.8rem;right: -0.8rem;">&nbsp;</div>
		</div>
		<div id="other_group_pms_list" style="height:85%;overflow-x:hidden;overflow-y:auto;text-align:left;">
		
		</div>
		<div id="btn_confirm_pms" class="btn btn-md bg-type-01" style="padding:0.3rem 0;width:90%;font-size:0.9rem;margin-top:1rem;">确定选择</div>
	</div> -->
	
	
	<form id="form" action="${ctx}/weixin/user/permission/savePermission" method="post"  style="display:none;">
		<input type="hidden" id="user_id" name="user_id" value="${user.id}"/>
		<input type="hidden" id="permission_old_ids" name="" />
		<input type="hidden" id="permission_ids" name="permission_ids" />
		
	</form>
</body>

<script src="${ctx}/static/weixin/myjs/dict.js"></script>


<script>
common.ctx =  '${ctx}';
var allPermissions = [];
var hasPmsIds = [];
$(function(){
	common.pms.init();
	dict.init();
	var $form = $('#form');
	
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
				var $pms_item = $this.clone().addClass('pms-item').attr("style","");
				$('#pms_list_div').append($pms_item.prop("outerHTML"));
			}
		});
		
		$('#other_group_pms_list .btn-disable').each(function(){
			var $this = $(this);
			var $user_pms_target = $('#pms_list_div [pmsid='+$this.attr('pmsid')+']');
			if($user_pms_target.length > 0){	//如果取消了不属于当前用户组的权限
				$user_pms_target.removeClass('bg-none-01').addClass('btn-disable');
			}
		});
		$('#close_btn').click();
		//hideSelectPms();
	});
	$("#close_btn").click(function(){
		hideSelectPms();
	});
	
	$("#pms_slf_sel_all").click(function(){
		$('.pms-item').addClass('bg-none-01').removeClass('btn-disable');
	});
	
	$("#pms_slf_unsel_all").click(function(){
		$('.pms-item').removeClass('bg-none-01').addClass('btn-disable');
	});
});

function showSelectPms(){
	$('#mask_full_screen').show();
	$('#other_group_pms_parent').show();
	$('#other_group_pms_list .bg-none-01').removeClass('bg-none-01').addClass('btn-disable');
	$('#pms_list_div .bg-none-01').each(function(){
		$('#other_group_pms_list [pmsid='+$(this).attr('pmsid')+']').removeClass('btn-disable').addClass('bg-none-01');
	});
	
	$('#other_group_pms_list [pmsid]').unbind('click',bindUserPmsBtnsClick).bind('click',bindUserPmsBtnsClick);
	
}
function hideSelectPms(){
	$('#mask_full_screen').hide();
	$('#other_group_pms_parent').hide();
	
	$('#pms_list_div [pmsid]').unbind('click',bindUserPmsBtnsClick).bind('click',bindUserPmsBtnsClick);
}

function saveUserPermission(){	//保存
	var permission_ids = [];
	$('#pms_list_div .bg-none-01').each(function(){
		permission_ids.push($(this).attr('pmsid'));
	});
	$('#permission_ids').val(permission_ids.join(','));
	
	
		
	common.submitForm($('#form'),function(){	//提交表单
		swal('保存成功！',"success");
		//loadContent(this,'${ctx}/weixin/user/pms/update?hotelId=${user.hotelId}&userId=${user.id}','RD');
		loadContent(this,'${ctx}/weixin/user/pms/update?hotelId=${hotel.id}&userId=${user.id}&TYPE=${TYPE}','RD');
	},function(){
		swal('保存失败！','error');
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
				html.push('<div class="btn btn-xs bg-none-01 pms-item" pmsid="'+permissons[i].permissionId + '" has="1">'+permissons[i].permissionName+'</div>');
				//$('#pms_list_div [pid='+permissons[i].permissionId+']').removeClass('btn-disable').addClass('bg-none-01').show().attr('has','1');
			}
			
			$('#permission_old_ids').val(hasPmsIds.join(','));
			console.log(hasPmsIds.join(','));
			$('#pms_list_div').html(html.join(''));
			
			html = [];
			
			for(var i in allPermissions){
				var inArray = false;
				inArray = isexit(allPermissions[i].id,hasPmsIds)
				if(inArray){
					continue;
				}
				html.push('<div class="btn btn-xs btn-disable pms-item" pmsid="'+allPermissions[i].id + '" has="1">'+allPermissions[i].displayname+'</div>');
			}
			
			$('#pms_list_div').append(html.join(''));
			$('#pms_list_div [pmsid]').unbind('click',bindUserPmsBtnsClick).bind('click',bindUserPmsBtnsClick);
			
			//	var html = template('temp_script_permission', res);
		}
	});
}

function isexit(id,hasPmsIds){
	var inArray =false;
	for(var j in hasPmsIds){
		if(hasPmsIds[j] == id){
			inArray = true;
			break;
		}
	}
	return inArray;
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
					<button class="btn btn-primary btn-sm pms-ren-sel-all" data="{{item.id}}" type="button">全选</button>
					<button class="btn btn-default btn-sm pms-ren-unsel-all"  data="{{item.id}}" type="button">全不选</button>
			</div>
			{{each item.permissions as pms j}}
				<div class="btn btn-xs {{pms.id | fm_has_pms}} pms-ren pms-ren-{{item.id}}" pmsid="{{pms.id}}" style="padding:0.2rem 0;width:48%;margin-top:0.2rem" >{{pms.displayname}}</div>
			{{/each}}
		</div>	
	</div>
{{/each}}
</script>
<!--<div style="text-align:right;">
					<button class="btn btn-primary btn-sm pms-ren-sel-all" style="padding: 1px 5px;margin:0 5px;" data="{{item.id}}" type="button">全选</button>
					<button class="btn btn-default btn-sm pms-ren-unsel-all" style="padding: 1px 5px;margin:0 5px;"  data="{{item.id}}" type="button">全不选</button>
			</div>  -->
</div>
