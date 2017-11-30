<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
 <div class="wrapper wrapper-content">   
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
		.permission-item{padding: 3px;margin: 3px;text-align: center;}
		.bg-hava {border:1px solid #019FEA; color: #019FEA; }
		.bg-none {color: #CCCCCC; border:1px solid #CCCCCC; }
		.bg-back {color: #000000; border:1px solid #000000; width: 200px; text-align: center; }
    </style>
	<div class="row">
			<div class="col-sm-4" style="position: relative;">
				<h3 style="margin-top: 10px;">职员信息详情</h3>
			</div>
			<div class="col-sm-8" style="text-align: right;padding: 10px 15px 5px ;">
				<c:choose>
					<c:when test="${ (groupMap.isadministrator || groupMap.ishuihr || groupMap.iscompanyadministrator) && user.state eq '1' && user.userType ne 'CLIENT'}">
						<div qx="user:tmpauthor" class="btn btn-primary" onclick="loadContent(this,'${ctx}/base/user/staff/pms/update/${user.id}?TYPE=${TYPE }','RD');"><span class="glyphicon glyphicon-move"> </span> 调整权限</div>
					</c:when>
					<c:when test="${ (groupMap.isadministrator || groupMap.ishuihr || groupMap.iscompanyadministrator) && user.state eq '1' && user.userType eq 'HUI'}">
						<a qx="user:transfer" href="${ctx}/base/user/author/transfer/index?fromuserId=${user.id}&gid=${user.groupId}" target="dialog" class="btn btn-primary" title="权限转移" data-permission="user:create"><span class="glyphicon glyphicon-transfer"> </span> 权限转移</a>
						<button qx="user:update" id="quit_edit" type="button" class="btn btn-primary"  > <span class="glyphicon glyphicon-log-out"></span> 离职编辑</button>
					</c:when>
					<c:when test="${(groupMap.isadministrator || groupMap.ishuihr || groupMap.iscompanyadministrator)  && user.state eq '0'}">
							<a  qx="user:update" class="btn btn-primary" onclick="recovery('0','${user.id}');"><span class="glyphicon glyphicon-retweet"></span> 恢复职位</a>
					</c:when>
					<%-- <c:when test="${(groupMap.isadministrator ) && user.state eq '1'}">
							<a qx="user:tmpauthor" class="btn btn-primary" onclick="loadContent(this,'${ctx}/base/user/staff/pms/update/${user.id}?TYPE=${TYPE }','RD');"><span class="glyphicon glyphicon-move"> </span> 调整权限</a>
							<a qx="user:transfer" href="${ctx}/base/user/author/transfer/index?fromuserId=${user.id}&gid=${user.groupId}" target="dialog" class="btn btn-primary" title="权限转移" data-permission="user:create"><span class="glyphicon glyphicon-transfer"> </span> 权限转移</a>
					</c:when> --%>
					<c:when test="${user.state eq '1' && user.groupId eq '17' && (groupMap.iscompanyadministrator || groupMap.isadministrator)}">
						<button qx="user:update" id="quit_to_hr" type="button" class="btn btn-primary"  ><span class="glyphicon glyphicon-log-out"></span> 撤销权限</button>
					</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
				<c:if test="${user.userType ne 'CLIENT' }">
					<a  qx="user:update" class="btn btn-primary" onclick="relieve('0','${user.id}');"><span class="glyphicon glyphicon-log-out"></span> 解除权限</a>
				</c:if>
				<%-- <c:if test="${user.state eq '1' && (groupMap.ishuihr || groupMap.iscompanyadministrator || groupMap.isadministrator) }">
					
				</c:if>
				<c:if >
					
				</c:if> --%>
				
				
				<!-- style="position: absolute;right: 20px;margin-top: 5px;top: 7px;" style="position: absolute;right: 20px;margin-top: 5px;top: 7px;"-->
				<c:if test="${TYPE eq 'HR' }">
					<a href="javascript:loadContent(this,'${ctx}/weixin/user/hr/index','')" class="btn btn-warning" ><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
				</c:if>
				<c:if test="${TYPE ne 'HR' }">
					<a href="javascript:loadContent(this,'${ctx}/base/user/index?type=1','')" class="btn btn-warning" ><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
				</c:if>
			</div>
		</div>
	<div class="user_list_one" style="width:100%;argin: 0;">
		<div class="row">
			<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">基本信息</span></div>
		</div>
		<div class="" style="line-height:20px;padding:0 20px;">
			<div class="flex-box flex-justify" style="margin: 8px 0;line-height: 20px;border-bottom: 1px solid #f5f5f5;padding: 3px 0;">
				<div style="">
					<span style="font-size: 16px;vertical-align: middle;">${user.rname}</span>
					<span style="margin-left:8px;color:#28A8EC;line-height: 20px;vertical-align: middle;">${user.state eq '1' ?user.groupName:'已离职'}</span>
				</div>
				<div>
					<a  qx="user:update" class="btn btn-primary btn-sm"  href="${ctx}/base/user/pwdForm/${user.id}" target="dialog"><span class="glyphicon glyphicon-cog"></span> 重置密码</a>
				</div>
			</div>
			<c:if test="${ispartner }">
				<div class="flex-box flex-justify" style="margin: 8px 0;border-bottom: 1px solid #f5f5f5;padding: 3px 0;">
					<div >合伙信息：${region.regionName}城市合伙人<span style="margin-left:8px;">${partner.rname}</span></div>
				</div>
			</c:if>
			<%-- <div class="flex-box flex-justify" style="margin: 8px 0;">
				<div >任职职务：${user.position}<span style="margin-left:8px;color:#28A8EC;">${user.state eq '1' ?user.groupName:'已离职'}</span></div>
			</div> --%>
			<div class="flex-box flex-justify" style="margin: 8px 0;border-bottom: 1px solid #f5f5f5;padding: 3px 0;">
				<div >任职职务：${user.position}<%-- <span style="margin-left:8px;color:#28A8EC;">${user.state eq '1' ?user.groupName:'已离职'}</span> --%></div>
			</div>
			<div class="flex-box flex-justify" style="margin: 8px 0;border-bottom: 1px solid #f5f5f5;padding: 3px 0;">
				<div>联系电话：${user.mobile}</div>
				<div>系统登陆用户名：${user.username}</div>
			</div>
			<div class="flex-box flex-justify" style="margin: 8px 0;border-bottom: 1px solid #f5f5f5;padding: 3px 0;">
				<div>电子邮箱：${user.email}</div>
				
			</div>
			
			<c:if test="${ispartner }">
				<div class="flex-box flex-justify" style="margin: 8px 0;border-bottom: 1px solid #f5f5f5;padding: 3px 0;">
					<input type="hidden" name="companyId" id="companyId" value="${company.id}"/>
					<div>签约期限：${dUs.toDay(company.seffectiveDate)}至${dUs.toDay(company.eeffectiveDate)}</div>
					<!--  -->
					<c:if test="${groupMap.ishuihr || groupMap.iscompanyadministrator || groupMap.isadministrator}">
					<button id="effective_edit" class="btn btn-primary" data-toggle="modal" data-target="#effectivedate_edit"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
					</c:if>
				</div>
			</c:if>
			</div>
			<div>
				<div class="row">
					<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">个人拥有权限</span></div>
				</div>
				<div class="" style="line-height:20px;padding:0 20px;">
					<div id="pms_list_div" class="pms-list-parent" style="width:100%;font-size:0;margin:8px 0;padding: 0 10px;"></div>
				</div>
			</div>
			<div id="tmp_pms_div"  style="margin: 8px 0;">
				<div class="row">
					<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">临时权限</span></div>
				</div>
				<div id="tmp_pms_list_div" class="pms-list-parent" style="width:100%;font-size:0;margin:8px 0;">
				</div>
			</div>
		</div>
	
		<div style="margin-top: 8px;${(user.groupId eq 3 || user.groupId eq 9)?'':'display:none;'}">
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">综合评价</span></div>
			</div>
			<div id="user_evaluate_list">
				
			
			</div>
		</div>
		<c:if test="${not empty  users}">
		<div style="margin-top: 8px;">
			<div class="row">
				<div class="col-sm-12 flex-box flex-justify" style="background-color:#048dd3;color: #FFF;padding: 5px;">
				<span style="margin-left: 2%;">人员详细信息</span>
				<div class="open" style="padding: 3px 16px;float: right;color: #28A8EC;color: #ffffff;"><i class="fa fa-angle-down" aria-hidden="true"></i>&nbsp;&nbsp;展开</div>
				</div>
			</div>
			
			<div id="partner_user_list" class="hide">
				<c:forEach items="${users }" var="u">
					<div class="font-size-min flex-box user-item" style="border-bottom: 1px solid #f5f5f5;" item-rdurl="/hui/weixin/user/staff/detail/${u.id }">
						<div style="display: table-cell;width: 27%;">姓名：${u.rname }</div>
						<div style="display: table-cell;width: 28%;">职位：${u.position }</div>
						<div style="display: table-cell;width: 45%;text-align: right;">联系电话：${u.mobile }</div>
					</div>
				</c:forEach>
			</div>
		</div>
		</c:if>
		
	</div>
	
	<form action="" id="form_list_params" style="display:none;">
		<input id="search_EQ_saleId" type="text" name="search_EQ_saleId"  value="${user.id}"/>
	</form>
	
	<div id="effectivedate_edit" class="modal fade" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">合作时间调整</h4>
	      </div>
	      <div class="modal-body">
	       <div class="flex-justify" style="text-align: center;font-size: 1.2rem;color: #000000;margin-top: 8px;">请选择时间</div>
			<div class="flex-justify" style="text-align: center;font-size: 1.2rem;color: #000000;margin-top: 1rem;">
				<div class="row">
					<div class="col-sm-5"><input type="date" id="seffectivedate" name="seffectivedate" value=""  class="form-control"> </div>
					<div class="col-sm-2" style="line-height: 30px;">~</div>
					<div class="col-sm-5"><input type="date" id="eeffectivedate" name="eeffectivedate" value=""  class="form-control"></div>
				</div>
			</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" id="effectivedate_close_btn" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" id="effectivedate_edit_btn" class="btn btn-primary">确定合作时间</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->

<script>
common.ctx =  '${ctx}';
$(function(){
	common.pms.init();
	dict.init();
	user_table = 0;
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
			}
			html.push('<div style="clear: both;"></div>');
			$('#tmp_pms_list_div').html(html.join(''));
			
		}
	});
	/* $("#effective_edit").click(function(){
	show();
	$('#effectivedate_edit').show();
}); */
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
	
	
	$(".open").click(function(){
		$this = $(this);
		$this.find("i").toggleClass("fa-angle-down").toggleClass("fa-angle-up");
		$('#partner_user_list').toggleClass("view").toggleClass("hide");
	});
	
	
	$("#effectivedate_edit_btn").click(function(){
		var seffectivedate = $('#seffectivedate').val();
		var eeffectivedate = $('#eeffectivedate').val();
		if(!seffectivedate){
			swal('请输入开始日期', "error");
			return;
		}
		if(!eeffectivedate){
			swal('请输入结束日期', "error");
			return;
		}
		var companyId = $('#companyId').val();

		common.ajaxjson({
			url : '${ctx}/weixin/user/partner/effectivedate/save',
			data : {companyId:companyId,seffectivedate:seffectivedate,eeffectivedate:eeffectivedate},
			success : function(res){
				swal(res.message, "success");
				$("#effectivedate_close_btn").click();
				setTimeout(function(){
					loadContent(this,'${ctx}/base/user/detail/${user.id}','RD');
				},1500);
			}
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
	cfm_swal("确定要彻底解除该员工的权限吗？","","warning","解除", "。","您取消了解除操作！"
			,'${ctx}/weixin/user/relieve/'+hotelId+'/'+userId,"",function(){
				loadContent(this,'${ctx}/base/user/detail/${user.id}','RD');
			});
}

</script>

<script id="temp_script_list" type="text/html">
{{each rows as item j}}
	<div class="eva-one-div" style="line-height:20px;">
	<div class="flex-box flex-justify">
		<div>{{item.userName}}</div>
		<div>星评：
			<div class="icon-start icon-start-size-{{item.comprehensive? item.comprehensive : 5}}" style="display:inline-block;">
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
	</div>
	<div style="color:#9e9e9e;">{{item.evaluateDate | dateFormat}}</div>
	<div style="">{{item.econtent}}</div>
	{{item.replyContent | fm_reply_ct}}
	
	</div>
{{/each}}
</script>
</div>
