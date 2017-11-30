<%@page import="com.itextpdf.text.log.SysoLogger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<%

%>
<c:set var="turl" value="${TYPE eq 'HR'?'weixin/user/hr/index':'/base/user/index?type=2' }"/>
<c:if test="${not empty furl}">
<c:set var="turl" value="${furl}"/>
</c:if>
	<link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
    <style type="text/css">
    	.info-one-div,.eva-one-div{border-top:1px solid #cccccc;margin-top:8px;font-size:14px;}
    	.info-one-div:first-child{border:none;}
    	.eva-one-div{ padding:1rem 0 8px 0; }
    	.user-item{ border-bottom: 1px solid #f5f5f5; padding-top: 1rem; padding-bottom: 8px }
		.view{display: block;}
		.hide{display: none;}
    	.permission-item{padding: 5px;margin: 5px;text-align: center;}
		.bg-hava {border:1px solid #019FEA; color: #019FEA; }
		.bg-none {color: #CCCCCC; border:1px solid #CCCCCC; }
		.bg-back {color: #000000; border:1px solid #000000; width: 200px; text-align: center; }
    </style>
<div  class="wrapper wrapper-content">
	<div class="row">
		<div class="col-sm-6" style="position: relative;">
			<h3>场地职员信息详情</h3>
		</div>
		<div  class="col-sm-6" style="text-align: right;padding-top:15px; ">
			<c:if test="${from eq 'loadContent' }">
			 <a href="javascript:${from}(this,'${ctx}/${turl}','')" class="btn btn-warning"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
			</c:if>
			<c:choose>
				<c:when test="${(groupMap.ishotelhr or groupMap.isgrouphr) and user.state eq '1'}">
					<a  qx="user:tmpauthor" class="btn btn-primary" onclick="loadContent(this,'${ctx}/weixin/user/pms/update?hotelId=${hotel.id}&userId=${user.id}&TYPE=${TYPE}','RD');"><span class="glyphicon glyphicon-move"> </span> 调整权限</a>
					<a  qx="user:transfer" class="btn btn-primary" href="${ctx}/base/user/author/transfer/index?fromuserId=${user.id}&gid=${user.groupId}" target="dialog" title="权限转移" data-permission="user:create"><span class="glyphicon glyphicon-transfer"> </span> 权限转移</a>
				</c:when>
				<c:when test="${(groupMap.ishotelhr or groupMap.isgrouphr) and user.state eq '0'}">
						<a qx="user:update" class="btn btn-primary" onclick="recovery('${hotel.id}','${user.id}');"><span class="glyphicon glyphicon-retweet"></span> 恢复职位</a>
				</c:when>
				<c:when test="${(groupMap.ishoteladministrator or groupMap.isgroupadministrator) and user.state eq '1'}"><!--and user.groupId eq '16'  -->
					<a qx="user:tmpauthor" class="btn btn-primary" onclick="loadContent(this,'${ctx}/weixin/user/pms/update?hotelId=${hotel.id}&userId=${user.id}&TYPE=${TYPE}','RD');"><span class="glyphicon glyphicon-move"> </span> 调整权限</a>
					<a qx="user:transfer" class="btn btn-primary" href="${ctx}/base/user/author/transfer/index?fromuserId=${user.id}&gid=${user.groupId}&type=${user.groupId}" target="dialog" title="权限转移" data-permission="user:create"><span class="glyphicon glyphicon-transfer"> </span> 权限转移</a>
				</c:when>
				<c:when test="${(groupMap.isadministrator or groupMap.iscompanyadministrator) and user.state eq '1'}"><!--and user.groupId eq '16'  -->
					<a qx="user:tmpauthor" class="btn btn-primary" onclick="loadContent(this,'${ctx}/weixin/user/pms/update?hotelId=${hotel.id}&userId=${user.id}&TYPE=${TYPE}','RD');"><span class="glyphicon glyphicon-move"> </span> 调整权限</a>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
			<a qx="user:update" class="btn btn-primary" onclick="relieve('${utype eq 'HOTEL'?hotel.id:hotelGroup.id}','${user.id}');"><span class="glyphicon glyphicon-log-out"></span> 解除权限</a>
		</div>
	</div>
    
	<div class="user_list_one" style="width:100%;margin-top:1rem;margin-bottom: 4.5rem;">
		<div class="row">
			<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">基本信息</span></div>
		</div>
		<div class="" style="padding:0 2%;">
			<c:if test="${empty utype or utype eq 'HOTEL' }">
				<div style="float:left;font-size:1rem;margin-top: 10px;">所在场地：${hotel.hotelName}</div>
			</c:if>
			<c:if test="${utype eq 'GROUP' }">
				<div style="float:left;font-size:1rem;margin-top: 10px;">所在集团：${hotelGroup.name}</div>
			</c:if>
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
			<div class="flex-box flex-justify" style="border-bottom: 1px solid #f5f5f5;padding: 3px 0;">
				<div>联系电话：${user.mobile}</div>
				<div>系统登陆用户名：${user.username}</div>
			</div>
			<div class="flex-box flex-justify" style="margin: 0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 3px 0;">
				<div>电子邮箱：${user.email}</div>
				<%-- <c:if test="${user.state eq '1' && (groupMap.ishotelhr or groupMap.ishuihr or groupMap.isgrouphr) }">
					<div id="quit_edit" style="color: red;">离职编辑</div>
				</c:if>
				<c:if test="${user.state eq '1' && user.groupId eq '16' && (groupMap.isgroupadministrator or groupMap.ishoteladministrator or groupMap.iscompanyadministrator)}">
					<div id="quit_to_hr" style="color: red;">撤销权限</div>
				</c:if> --%>
				
				<c:if test="${user.state eq '1' && (groupMap.ishotelhr or groupMap.ishuihr or groupMap.isgrouphr) }">
					<button qx="user:update" id="quit_edit" type="button" class="btn btn-primary btn-sm"  > <span class="glyphicon glyphicon-log-out"></span> 离职编辑</button>
				</c:if>
				<c:if test="${user.state eq '1' && user.groupId eq '16' && (groupMap.isgroupadministrator or groupMap.ishoteladministrator or groupMap.iscompanyadministrator)}">
					<button qx="user:update" id="quit_to_hr" type="button" class="btn btn-primary btn-sm"  ><span class="glyphicon glyphicon-log-out"></span> 撤销权限</button>
				</c:if>
			</div>
		</div>
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">个人拥有权限</span></div>
			</div>
			<div id="pms_list_div" class="pms-list-parent" style="width:100%;font-size:0;margin:0.5rem 0;">
			</div>
		</div>
		<div id="tmp_pms_div"  style="margin: 0.5rem 0;">
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">临时权限</span></div>
			</div>
			<div id="tmp_pms_list_div" class="pms-list-parent" style="width:100%;font-size:0;margin:0.5rem 0;">
			</div>
		</div>
		
		<div style="margin-top: 0.5rem; ${(user.groupId eq 3 || user.groupId eq 9)?'':'display:none;'}">
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">综合评价</span></div>
			</div>
			<div id="user_evaluate_list" style="padding:0 2%;">
				
				<!--  <div class="eva-one-div" style="line-height:1.3rem;">
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
				</div>   -->
			
			</div>
		</div>
		
	</div>
	
	<form action="" id="form_list_params" style="display:none;">
		<input id="search_EQ_saleId" type="text" name="search_EQ_saleId"  value="${user.id}"/>
	</form>
</body>

<script src="${ctx}/static/weixin/myjs/dict.js"></script>


<script>
common.ctx =  '${ctx}';
$(function(){
	dict.init();
	common.pms.init();
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
				html.push('<div pid="'+permissons[i].permissionId + '" class="permission-item bg-hava" has="1" style="width:15%;float:left;">'+permissons[i].permissionName+'</div>');
				//$('#pms_list_div [pid='+permissons[i].permissionId+']').removeClass('btn-disable').addClass('bg-none-01').show().attr('has','1');
			}
			html.push('<div style="clear: both;"></div>');
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
				html.push('<div pid="'+permissons[i].permissionId + '" class="permission-item bg-hava" has="1" style="width:15%;float:left;">'+permissons[i].permissionName+'</div>');
				//$('#pms_list_div [pid='+permissons[i].permissionId+']').removeClass('btn-disable').addClass('bg-none-01').show().attr('has','1');
			}
			html.push('<div style="clear: both;"></div>');
			$('#tmp_pms_list_div').html(html.join(''));
			
		}
	});
	
	
	$("#quit_edit").click(function(){
		cfm_swal("您确定要把该员工标记为离职人员？","","warning","标记离职", "。","您取消了标记离职操作！"
				,'${ctx}/weixin/user/quit/${user.id}',"",function(){
					loadContent(this,'${ctx}/base/user/detail/${user.id}','RD');
				});
	});
	
	
	$("#quit_to_hr").click(function(){
		cfm_swal("您确定要撤销该员工的HR权限吗？","","warning","撤销HR", "。","您取消了撤销HR操作！"
				,'${ctx}/weixin/user/quit/${user.id}',"",function(){
					loadContent(this,'${ctx}/base/user/detail/${user.id}','RD');
				});
	});
	
	
	
});

function recovery(hotelId,userId){
	cfm_swal("确定要恢复该员工的职位吗？","","warning","恢复", "。","您取消了恢复操作！"
			,'${ctx}/weixin/user/recovery/'+hotelId+'/'+userId,"",function(){
				loadContent(this,'${ctx}/base/user/detail/${user.id}','RD');
			});
}
function relieve(hotelId,userId){
	if(!hotelId){
		hotelId = 0;
	}
	cfm_swal("确定要彻底解除该员工的权限吗？","","warning","解除", "。","您取消了解除操作！"
			,'${ctx}/weixin/user/relieve/'+hotelId+'/'+userId,"",function(){
				loadContent(this,'${ctx}/base/user/detail/${user.id}','RD');
			});
}

/* 
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
 */
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

</div>