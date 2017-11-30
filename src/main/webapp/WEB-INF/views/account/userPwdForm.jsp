<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#userPwdSubForm").validate({
        rules: {
            password: {
                required: !0,
                minlength: 5
            },
            confirm_password: {
                required: !0,
                minlength: 5,
                equalTo: "#password"
            }
        },
        messages: {
            password: {
                required: e + "请输入您的密码",
                minlength: e + "密码必须5个字符以上"
            },
            confirm_password: {
                required: e + "请再次输入密码",
                minlength: e + "密码必须5个字符以上",
                equalTo: e + "两次输入的密码不一致"
            }
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				console.log(user_search);
       　				if(!'${un}'){
       　					user_search();
     　				}
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
    });
});

</script>
<form id="userPwdSubForm" method="post" action="${ctx}/account/user/savePersonPwd"  class="form-horizontal m-t" ><!--   -->
<div class="modal-body"> 
  	<input type="hidden" name="id" id="id" value="${upUser.id}" />
  	<input type="hidden" name="self" id="self" value="${self}" />
  	<div class="form-group form-inline">
    <label for="nickname" class="col-sm-3 control-label">用户账号</label>
    <div class="col-sm-9">
   		 <input type="text" class="form-control" id="username" name="username" placeholder="用户账号" value="${upUser.username}" aria-required="true" aria-invalid="false" class="valid" readonly="readonly" >
    </div>
  </div>
  	  	<c:if test="${not empty self }">
			<div class="form-group form-inline">
				<label for="oldpassword" class="col-sm-3 control-label">旧密码</label>
				<div class="col-sm-9">
					<input type="password" class="form-control" id="oldpassword" name="oldpassword" placeholder="旧密码" value="" aria-required="true" aria-invalid="false" class="valid">
				</div>
			</div>
		</c:if>	
  	   <div class="form-group form-inline">
		    <label for="oldpassword" class="col-sm-3 control-label">用户密码</label>
		    <div class="col-sm-9">
		   		 <input type="password" class="form-control" id="password" name="password" placeholder="用户密码" value="" aria-required="true" aria-invalid="false" class="valid" >
		    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="crfpassword" class="col-sm-3 control-label">确认密码</label>
	    <div class="col-sm-9">
	   		 <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="确认密码" value="" aria-required="true" aria-invalid="false" class="valid" >
	    </div>
	  </div>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
