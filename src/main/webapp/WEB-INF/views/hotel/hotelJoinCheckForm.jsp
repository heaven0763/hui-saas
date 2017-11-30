<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="modal-body">
	 <style>
   		.per-div{
	   		background-image: url(${ctx}/static/weixin/css/icon/common/arrow-right.png);
		    background-size: 20px;
		    background-repeat: no-repeat;
		    background-position: right;
   		}
   		.down-div{
	   		background-image: url(${ctx}/static/weixin/css/icon/common/arrow-right.png);
		    background-size: 20px;
		    background-repeat: no-repeat;
		    background-position: right;
   		}
    </style>
	<form id="form_record" action="${ctx }/weixin/user/author/transfer/save" method="post" class="form-horizontal m-t" style="">
		
		<input type="hidden" name="recordId" value="${record.id}">
		
		<div class="form-group form-inline">
			<label for="userId" class="col-sm-3 control-label">申请人姓名：</label>
			<div class="col-sm-9">
				<input type="hidden" name="userId" value="${record.userId }">
				<input class="input-form required" name="rname" type="text" style="" value="${user.rname }" readonly="readonly"/>
			</div>
		</div>
		
		<div class="form-group form-inline">
			<label for="memo" class="col-sm-3 control-label">邮箱：</label>
			<div class="col-sm-9">
				<input class="form-control required email" id="input_email" name="email" type="text"  readonly="readonly" value="${user.email }"/>
			</div>
		</div>
				
		<div class="form-group form-inline">
			<label for="memo" class="col-sm-3 control-label">手机号：</label>
			<div class="col-sm-9">
				<input class="form-control required cellPhone" id="input_mobile" name="mobile" type="text"  readonly="readonly" value="${user.mobile }"/>
			</div>
		</div>
		
				<div class="form-group form-inline">
					<label for="memo" class="col-sm-3 control-label">角色权限：</label>
					<div class="col-sm-9">
					<c:if test="${record.type eq 'HOTEL' }">
								<select class="form-control required" id="gid" name="gid" style="width: 200px;">
									<tags:dict sql="select id , name  from hui_group where 1=1 and pid=12 and group_id LIKE \'hotel%\' " selectedValue=""  showPleaseSelect="true" />
								</select>
							</c:if>
							<c:if test="${record.type eq 'GROUP' }">
								<select class="form-control required" id="gid" name="gid" style="width: 200px;">
									<tags:dict sql="select id , name  from hui_group where 1=1 and pid=12 and group_id LIKE \'group%\' " selectedValue=""  showPleaseSelect="true" />
								</select>
							</c:if>
							<c:if test="${record.type eq 'HUI' }">
								<select class="form-control required" id="gid" name="gid" style="width: 200px;">
									<tags:dict sql="select id , name  from hui_group where 1=1 and pid=11 order by group_id " selectedValue=""  showPleaseSelect="true" />
								</select>
							</c:if>
					</div>
				</div>
		<!--  <div class="form-group form-inline" >
			<label for="memo" class="col-sm-3 control-label">验证码：</label>
			<div class="col-sm-9">
				<input type="text" class="form-control required" name="captcha" style="" />
				<a id="btn_send_sms" class="btn btn-primary" style="">获取</a>
			</div>
		</div>  -->
		
			<div class="modal-footer">
				<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal">
					<span class="glyphicon glyphicon-off"></span> 关闭
				</button>
				<a qx="user:joincheck" href="javascript:;" onclick="hotel_check_fun('${record.id}',1)" class="btn btn-primary btn-sm" title="审核通过">审核通过</a>
				<a qx="user:joincheck" href="javascript:;" onclick="hotel_check_fun('${record.id}',2)" class="btn btn-primary btn-sm" title="审核不过">审核不过</a>
			</div>
		
	</form>
<script>

$(function(){
	common.ctx =  '${ctx}';
	common.pms.init();
});

</script> 
</div>