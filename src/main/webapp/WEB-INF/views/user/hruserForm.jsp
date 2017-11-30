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
	<form id="form_register" action="${ctx }/weixin/user/author/transfer/save" method="post" class="form-horizontal m-t" style="">
		
		<input type="hidden" name="fromuserId" value="${fromuserId}">
		<input type="hidden" name="type" value="${flag ?'HR':'OTHER'}">
		
		<div class="form-group form-inline">
			<label for="userId" class="col-sm-3 control-label">${flag ?'HR姓名':'接受移交人'}：</label>
			<div class="col-sm-9">
				<c:if test="${empty tuser}">
					<select class="form-control required" id="userId" name="userId" style="width: 200px;">
						<option value="">请选择...</option>
						<c:forEach items="${users}" var="user">
							<option value="${user.id}">${user.rname}</option>
						</c:forEach>
					</select>
				</c:if>
				<c:if test="${not empty tuser}">
					<input type="hidden" name="userId" value="${tuser.id }">
					<input class="input-form required" name="rname" type="text" style="" value="${tuser.rname }" readonly="readonly"/>
				</c:if>
			</div>
		</div>
		
		<div class="form-group form-inline">
			<label for="memo" class="col-sm-3 control-label">邮箱：</label>
			<div class="col-sm-9">
				<input class="form-control required email" name="email" type="text" style="" value="${tuser.email }"/>
			</div>
		</div>
				
		<div class="form-group form-inline">
			<label for="memo" class="col-sm-3 control-label">手机号：</label>
			<div class="col-sm-9">
				<input class="form-control required cellPhone" id="input_mobile" name="mobile" type="text" style="" value="${tuser.mobile }"/>
			</div>
		</div>
		
		<c:choose>
			<c:when test="${flag }">
				<input type="hidden" name="gid" value="${gid}">
			</c:when>
			<c:otherwise>
				<div class="form-group form-inline">
					<label for="memo" class="col-sm-3 control-label">角色权限：</label>
					<div class="col-sm-9">
						<c:if test="${empty gid}">
							<c:if test="${isgroup eq '0' }">
								<select class="form-control required" id="gid" name="gid" style="width: 200px;">
									<tags:dict sql="select id , name  from hui_group where 1=1 and pid=${gtype } and group_id LIKE \'hotel%\' " selectedValue="${gid}"  showPleaseSelect="true" />
								</select>
							</c:if>
							<c:if test="${isgroup ne '0' }">
								<select class="form-control required" id="gid" name="gid" style="width: 200px;">
									<tags:dict sql="select id , name  from hui_group where 1=1 and pid=${gtype } " selectedValue="${gid}"  showPleaseSelect="true" />
								</select>
							</c:if>
						</c:if>
						<c:if test="${not empty gid}">
							<input type="hidden" name="gid" value="${gid}">
							<input class="form-control" name="gname" type="text" style="" value="${group.name }" readonly="readonly"/>
						</c:if>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		<div class="form-group form-inline" >
			<label for="memo" class="col-sm-3 control-label">验证码：</label>
			<div class="col-sm-9">
				<input type="text" class="form-control required" name="captcha" style="" />
				<a id="btn_send_sms" class="btn btn-primary" style="">获取</a>
			</div>
		</div>
		
		<c:if test="${empty fromuserId}">
			<div class="modal-footer">
				<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal">
					<span class="glyphicon glyphicon-off"></span> 关闭
				</button>
				<button type="button"  id="btn_transfer" class="btn btn-primary">
					<span class="glyphicon glyphicon-save"></span> 确定${flag ?'授权':'转移'}
				</button>
			</div>
		</c:if>
		<c:if test="${not empty fromuserId}">
		
			<div class="modal-footer">
				<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal">
					<span class="glyphicon glyphicon-off"></span> 关闭
				</button>
				<button type="button"  id="btn_transfer" class="btn btn-primary">
					<span class="glyphicon glyphicon-save"></span> 确定转移
				</button>
			</div>
		</c:if>
	</form>
<script>

$(function(){
	common.ctx =  '${ctx}';
	var $form = $('#form_register');
	$form.validate();
	
	$('#btn_transfer').click(function(){
		 common.submitForm($form,function(res){
			 swal(res.message,'success');
			 setTimeout(function(){
				$("#close_btn").click();
				if(user_table==1){
					user_search();
				}else{
					loadContent(this,'${ctx}/base/user/detail/${fromuserId}','RD');
				}
			 },1500);  
         });
	});
	
	$('#btn_send_sms').click(function(){
		var $this = $(this);
		if($this.hasClass('captcha-disable')){
			return;
		}
		var mobile = $('#input_mobile').val();
	    var tel = /^(13|15|18)\d{9}$/; 
	    if(!tel.test(mobile)){
	    	swal('请输入正确的手机号码','error');
			return;
		}
	    swal('手机验证码已发送，请注意查收！','success');
		$this.addClass('captcha-disable');
		var timeSecond = 60;
		smsIntervalId = setInterval(function(){
			$this.text(--timeSecond);
			if(timeSecond == 0){
				clearInterval(smsIntervalId);
				$this.removeClass('captcha-disable');
				$this.text('获取');
			}
		},1000); 
		/* common.ajaxjson({
			url : '${ctx}/anon/mobile/mobiledrawcode?phone='+mobile,
			success : function(){
				swal('手机验证码已发送，请注意查收！','success');
				$this.addClass('captcha-disable');
				var timeSecond = 60;
				smsIntervalId = setInterval(function(){
					$this.text(--timeSecond);
					if(timeSecond == 0){
						clearInterval(smsIntervalId);
						$this.removeClass('captcha-disable');
						$this.text('获取');
					}
				},1000);
			}
		});  */
	});
});
</script> 
</div>