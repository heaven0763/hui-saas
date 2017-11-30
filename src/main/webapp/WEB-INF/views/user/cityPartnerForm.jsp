<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<script type="text/javascript">
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#userSubForm").validate({
        rules: {
        	rname: "required",
        	username: "required",
        	mobile: "required",
        	email: "required",
        	companyName: "required",
        	province: "required",
        	city: "required",
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
        	rname: e + "请输入合伙人姓名",
        	username: e + "请输入合伙人昵称",
        	mobile: e + "请输入手机号码",           
        	email: e + "请输入电子邮箱",
        	companyName:e + "请输入公司名称",
        	province: e + "请选择省份",
        	city: e + "请选择城市",
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
       　				user_search();
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json');
         }  
    });
	
});
</script>
<div class="modal-body">

	<form id="userSubForm" method="post" action="${ctx}/weixin/city/partner/save" class="form-horizontal m-t">
		<!--   -->
		<input type="hidden" name="id" id="id" value="${upUser.id}" />
		<input name="avatar" type="hidden" value="${upUser.avatar}"> 
		
		
		<div class="form-group form-inline">
			<label for="rname" class="col-sm-3 control-label">合伙人姓名</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="rname" name="rname" placeholder="用户名" value="${upUser.rname}" >
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="username" class="col-sm-3 control-label">合伙人昵称</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="username" name="username" placeholder="用户账号" value="${upUser.username}" >
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="password" class="col-sm-3 control-label">密码</label>
			<div class="col-sm-9">
				<input type="password" class="form-control" id="password" name="password" placeholder="用户密码" value="" >
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="crfpassword" class="col-sm-3 control-label">确认密码</label>
			<div class="col-sm-9">
				<input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="确认密码" value="" >
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="mobile" class="col-sm-3 control-label">联系电话</label>
			<div class="col-sm-9">
				<input type="tel" class="form-control" id="mobile" name="mobile" placeholder="联系电话" value="${upUser.mobile}" >
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="email" class="col-sm-3 control-label">电子邮箱</label>
			<div class="col-sm-9">
				<input type="email" class="form-control" id="email" name="email" placeholder="电子邮箱" value="${upUser.email}" >
			</div>
		</div>
		
		<div class="form-group form-inline">
			<label for="companyName" class="col-sm-3 control-label">公司名称</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="companyName" name="companyName" placeholder="公司名称" value="${upUser.companyName}" >
			</div>
		</div>
		
		<div class="form-group form-inline">
			<label for="description" class="col-sm-3 control-label">所属地区</label>
			<div class="col-sm-9">
				<select  class="form-control"  id="province" name="province" refval="value" reftext="text" textTarget="parea" 
					refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#city" onchange="areaget(this)">
					<tags:dict sql="select  id ,region_name name  from hui_region where parent_id='1' " selectedValue=""  showPleaseSelect="true"/>
				</select>
				<select  class="form-control"  id="city" name="city" refval="value" reftext="text"  textTarget="carea"> </select>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal">
				<span class="glyphicon glyphicon-off"></span> 关闭
			</button>
			<button type="submit" class="btn btn-primary">
				<span class="glyphicon glyphicon-save"></span> 保存
			</button>
		</div>
	</form>
</div>

