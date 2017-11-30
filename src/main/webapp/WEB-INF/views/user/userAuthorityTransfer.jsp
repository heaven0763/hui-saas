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
		<input type="hidden" name="crtusrty" value="${crtusrty}">
		
		<div class="form-group form-inline">
			<label for="userId" class="col-sm-3 control-label">${flag ?'HR姓名':'接受移交人'}：</label>
			<div class="col-sm-9">
				<c:if test="${empty tuser}">
					<select class="form-control required selectpicker" data-live-search="true" data-width="auto" data-size="10" id="userId" name="userId" style="width: 200px;">
						<option value="">请选择...</option>
						<c:forEach items="${users}" var="user">
							<option value="${user.id}" mobile="${user.mobile}" email="${user.email}">${user.rname}</option>
						</c:forEach>
					</select>
				</c:if>
				<c:if test="${not empty tuser}">
					<input type="hidden" name="userId" value="${tuser.id }">
					<input class="input-form required" name="rname" type="text" style="" value="${tuser.rname }" readonly="readonly"/>
				</c:if>
			</div>
		</div>
		
		<div id="cpmntr" class="form-group form-inline" style="display: none;">
			<label for="memo" class="col-sm-3 control-label" id="cpmntrtitle"></label>
			<div class="col-sm-9">
				<span class="form-control" id="cpmntrtxt" style="width: 200px;display: inline-block;"></span>
			</div>
		</div>
		
		<div class="form-group form-inline">
			<label for="memo" class="col-sm-3 control-label">邮箱：</label>
			<div class="col-sm-9">
				<input class="form-control required email" id="input_email" name="email" type="text" style="width: 200px;" value="${tuser.email }"/>
			</div>
		</div>
				
		<div class="form-group form-inline">
			<label for="memo" class="col-sm-3 control-label">手机号：</label>
			<div class="col-sm-9">
				<input class="form-control required cellPhone" id="input_mobile" name="mobile" type="text" style="width: 200px;" value="${tuser.mobile }"/>
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
								<select class="form-control required selectpicker"  data-width="200px" id="gid" name="gid" style="width: 200px;">
									<tags:dict sql="select id , name  from hui_group where 1=1 and pid=${gtype } and group_id LIKE \'hotel%\' " selectedValue="${gid}"  showPleaseSelect="true" />
								</select>
							</c:if>
							<c:if test="${isgroup eq '1' }">
								<select class="form-control required selectpicker" data-width="200px" id="gid" name="gid" style="width: 200px;">
									<tags:dict sql="select id , name  from hui_group where 1=1 and pid=${gtype } " selectedValue="${gid}"  showPleaseSelect="true" />
								</select>
							</c:if>
							<c:if test="${isgroup eq '2' }">
								<select class="form-control required selectpicker" data-width="200px" id="gid" name="gid" style="width: 200px;">
									<tags:dict sql="select id , name  from hui_group where 1=1 and pid=12 order by group_id " selectedValue="${gid}"  showPleaseSelect="true" />
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
				<input type="text" class="form-control required" name="captcha" style="width: 200px;" />
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
			 <div class="form-group form-inline" >
				<label for="memo" class="col-sm-3 control-label">转移类型：</label>
				<div class="col-sm-9">
					 <div class="radio radio-info radio-inline">
                     <input type="radio" id="transferType2" name="transferType" value="KEEP" checked="checked">
                     <label for="transferType2"> 保留原有权限</label>
                 </div>
                 <div class="radio radio-info radio-inline">
                     <input type="radio" id="transferType3" name="transferType" value="COVER">
                     <label for="transferType3"> 覆盖原有权限</label>
                 </div>
				</div>
			</div> 
			<div class="modal-footer">
				<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal">
					<span class="glyphicon glyphicon-off"></span> 关闭
				</button>
				<button qx="user:transfer" type="button"  id="btn_transfer" class="btn btn-primary">
					<span class="glyphicon glyphicon-save"></span> 确定转移
				</button>
			</div>
		</c:if>
	</form>
<script>

$(function(){
	common.ctx =  '${ctx}';
	common.pms.init();
	var $form = $('#form_register');
	$form.validate();
	$(".selectpicker").selectpicker();
	//userId
	
	$('#userId').on('changed.bs.select', function(e) {
		 var uId = e.target.value;
		 $.get('${ctx}/base/user/userinfo/'+uId,{},function(res){
			 if(res.statusCode==='200'){
				 $("#input_email").val(res.object.email);
				 $("#input_mobile").val(res.object.mobile);
				 if('${crtusrty}'=='SITE'){
					 
					 var title ="所属集团";
					 if(res.object.companyNature=='HOTEL'){
						 title ="所属场地";
						 getGroup('hotel');
					 }else{
						 getGroup('group');
					 }
					 
					 $("#cpmntrtitle").text(title);
					 $("#cpmntrtxt").text(res.object.companyName);
					 $("#cpmntr").show();
				 }
			 }
		 },'json')
	      /* if(e.target.value){
	        var project = viewModel._helper.projectCodes().filter(function(item) {
	            return item.projectCode === e.target.value;
	        });
	      } */
		  });
	　　
	$('#btn_transfer').click(function(){
		/*  common.submitForm($form,function(res){
			 swal(res.message,'success');
			 setTimeout(function(){
				$("#close_btn").click();
				if(user_table==1){
					user_search();
				}else{
					if('${fromuserId}'){
						loadContent(this,'${ctx}/base/user/detail/${fromuserId}','RD');
					}else{
						user_search();
					}
				}
			 },1500);  
         }); */
		 
		 
		 $.post($('#form_register').attr('action'),$('#form_register').serialize(),function(res){
				if(res.statusCode=='200'){
					swal(res.message,'success');
					 setTimeout(function(){
						$("#close_btn").click();
						if(user_table==1){
							user_search();
						}else{
							if('${fromuserId}'){
								loadContent(this,'${ctx}/base/user/detail/${fromuserId}','RD');
							}else{
								user_search();
							}
						} },1500);  
				}else{
					swal(res.message,'error');
				}
			},'json'); 
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
	   /*  swal('手机验证码已发送，请注意查收！','success');
		$this.addClass('captcha-disable');
		var timeSecond = 60;
		smsIntervalId = setInterval(function(){
			$this.text(--timeSecond);
			if(timeSecond == 0){
				clearInterval(smsIntervalId);
				$this.removeClass('captcha-disable');
				$this.text('获取');
			}
		},1000);  */
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
});
function getGroup(type){
	var url =encodeURI('${ctx}/framework/dictionary/trslCombox?sql=SELECT id,name as name FROM hui_group where pid=12 and group_id like \''+type+'%\' order by group_id');
    $.ajax({
        url: url,
        type: "get",
        dataType: "json",
        success: function (data) {
        	var options = [];
        	options.push("<option value=''>请选择</option>");
            $.each(data, function (i) {
            	options.push("<option value=" + data[i].value + ">" + data[i].text + "</option>");
            });
            $('#gid').html(options.join(''));
            $('#gid').selectpicker('refresh');
        },
        error: function (data) {
            //alert("查询学校失败" + data);
        }
    });
}
</script> 
</div>