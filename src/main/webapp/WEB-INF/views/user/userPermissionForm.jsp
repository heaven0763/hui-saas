<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div>
	<div class="row">
		<div class="col-sm-12" style="position: relative;">
			<a href="javascript:loadContent(this,'${ctx}/base/user/author/manage/index','')" class="btn btn-warning" style="position: absolute;right: 20px;margin-top: 5px;top: 7px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
			<h3>权限调整</h3>
			<hr/>
		</div>
	</div>
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
    <style>
   		.bg-item-checked{border: 1px solid #FFB42B;color: #ffffff;background-color: #FFB42B;}
    </style>
    
	<form id="form_tmppms" action="${ctx }/weixin/user/author/tmp/save" method="post" class="form-horizontal m-t" >
		<%-- <input type="hidden" name="userId" value="${tuser.id }"> --%>
		<input type="hidden" name="pmsids" id="pmsids" value="">
		<div class="form-group form-inline">
     		 <label for="rname" class="col-md-2 control-label">接受人：</label>
    		<div class="col-md-10">
				<%-- <input class="form-control required" name="rname" type="text" style="" value="${tuser.rname }" readonly="readonly"/> --%>
				<select class="form-control required selectpicker"  data-live-search="true" data-width="auto" data-size="10"  id="userId" name="userId" style="width: 200px;">
					<option value="">请选择...</option>
					<c:forEach items="${users}" var="user">
						<option value="${user.id}">${user.rname}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		
		<%-- <div class="form-group form-inline">
			<label for="email" class="col-md-2 control-label">邮箱：</label>
    		<div class="col-md-10">
				<input class="form-control email" id="input_email" name="email" type="text" style="" value="${tuser.email }"/>
			</div>
		</div> --%>
		
		
		
		<div class="form-group form-inline">
			<label for="sdate" class="col-md-2 control-label">开始日期：</label>
    		<div class="col-md-10">
				<input class="form-control required" id="input_sdate" name="sdate" type="date" style="width: 200px;" value=""/>
			</div>
		</div>
		
		<div class="form-group form-inline">
			<label for="sdate" class="col-md-2 control-label">结束日期：</label>
    		<div class="col-md-10">
				<input class="form-control required" id="input_edate" name="edate" type="date" style="width: 200px;" value=""/>
			</div>
		</div>
		
		
		<div class="form-group form-inline">
			<label for="mobile" class="col-md-2 control-label">手机号：</label>
    		<div class="col-md-10">
				<input class="form-control required cellPhone" id="input_mobile" name="mobile" type="text" style="" value=""/>
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="sdate" class="col-md-2 control-label">验证码：</label>
    		<div class="col-md-10">
				<input type="text" class="form-control required" name="captcha" style="" />
				<div id="btn_send_sms" class="btn btn-warning">获取</div>
			</div>
		</div>
		
		<div class="form-group form-inline">
			<label for="pms" class="col-md-2 control-label">授予权限：</label>
			<div class="col-md-10">
				<div>
					<button class="btn btn-primary" id="pms_sel_all" type="button">全选</button>
					<button class="btn btn-default" id="pms_unsel_all" type="button">全不选</button>
				</div>
    			<div id="pms_list_div" class="pms-list-parent" style="width:100%;font-size:0;padding 5px 0;">
					<c:forEach items="${userPermissions }" var="up">
						<div class="btn btn-xs btn-item bg-none-01" pid="${up.permissionId }" has="0" style="padding:2px 0;width:20%;margin: 5px 3px;">${up.permissionName }</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="btn" class="col-md-2 control-label"></label>
			<div class="col-md-10">
    			<div id="btn_transfer" class="btn btn-primary" style="border-radius:3px;">提交保存</div>
			</div>
		</div>
	</form>
	
	<script>
	$(function(){
		common.ctx =  '${ctx}';
		
		var $form = $('#form_tmppms');
		$form.validate();
		$(".selectpicker").selectpicker();
		
		$('#userId').on('changed.bs.select', function(e) {
			 var uId = e.target.value;
			 $.get('${ctx}/base/user/userinfo/'+uId,{},function(res){
				 if(res.statusCode==='200'){
					 /* $("#input_email").val(res.object.email);
					 $("#input_mobile").val(res.object.mobile); */
				 }
			 },'json')
		      /* if(e.target.value){
		        var project = viewModel._helper.projectCodes().filter(function(item) {
		            return item.projectCode === e.target.value;
		        });
		      } */
			  });
		
		$('#btn_transfer').click(function(){
			var arr = [];
			$(".bg-item-checked").each(function(){
				arr.push($(this).attr('pid'));
			});
			if(!arr){
				swal('请选择权限！','error');
				return;
			}
			$("#pmsids").val(arr.join(','));
			common.submitForm($form,function(res){	//提交表单
				swal('保存成功！','success');
				setTimeout(function(){
					loadContent(this,'${ctx}/base/user/author/manage/index','RD');
				},1500);
			},function(res){
				swal(res.message,'error');
			});
		});
		
		$('#btn_send_sms').click(function(){
			var $this = $(this);
			if($this.hasClass('captcha-disable')){
				return;
			}
			var mobile = $('#input_mobile').val();
		    var tel = /^(13|15|18|17)\d{9}$/; 
		    if(!tel.test(mobile)){
		    	swal('请输入正确的手机号码','error');
				return;
			}
			common.ajaxjson({
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
			});
		});
		$(".btn-item").click(function(){
			$this = $(this);
			if($this.hasClass('bg-none-01')){
				$this.removeClass("bg-none-01").addClass("bg-item-checked");
			}else{
				$this.removeClass("bg-item-checked").addClass("bg-none-01");
			}
			
		});
		
		$("#pms_sel_all").click(function(){
			$(".btn-item").removeClass("bg-none-01").addClass("bg-item-checked");
		});
		
		$("#pms_unsel_all").click(function(){
			$(".btn-item").removeClass("bg-item-checked").addClass("bg-none-01");
		});
		
	});
	</script>
</div>