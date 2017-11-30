<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script>
$(document).ready(function(e) {
	   $('#selFile').localResizeIMG({
	      width: 600,
	      quality: 1,
	      before:function(){
	    	  parent.show();
	      },
	      success: function (result) {
			  var submitData={
				  base64Str:result.clearBase64,
				  dir:'user_photo'
				}; 
			 $.ajax({
			   type: "POST",
			   url: "${ctx}/account/user/upload/resizeimg",
			   data: submitData,
			   dataType:"json",
			   success: function(data){
				  parent.hide();
				 if (data.success) {
					$('input[name="avatar"]').val(data.obj);
					$('#WX_icon').attr('src', data.obj);
					swal("上传成功", "success");
				 }else{
				  	swal(data.msg, "error");
					return false;
				 }
			   }, 
			   complete :function(XMLHttpRequest, textStatus){
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){ //上传失败 
					parent.hide();
					swal("AJAX ERROR", "error");
				}
			});
	      },
		  error:function(){ 
		  	parent.hide();
			swal("localResizeIMG ERROR", "error");
		  }
	  });
	});
</script>

<script type="text/javascript">
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#userSubForm").validate({
        rules: {
        	rname: "required",
        	username: "required",
        	mobile: "required",
        	groupId: "required",
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
        	rname: e + "请输入用户姓名",
        	username: e + "请输入用户账号",
        	mobile: e + "请输入用户手机",           
        	groupId: e + "请选择用户角色",
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
            
            /* $.ajax({
                url:url,
                type:"POST",
                data:data,
                //dataType:"json",
                success:function(res){
                	if(res.statusCode=="200"){
       　					$('#close_btn').click();
	       　				swal(res.message, "success");
	       　				user_search();
	       　			}else{
	       　				swal(res.message, "error");
	       　			}
	       　			parent.hide()
                },
                error:function(xhr,textStatus, errorThrown){
                	if(xhr.status==500){
                        var result = eval("("+xhr.responseText+")");
                        swal(result.message, "error")
                      }
                	parent.hide();}
            }); */
            
            
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

	<div class="form-group form-inline" style="height: 50px;">
		<label for="picurl" class="col-sm-3 control-label" style="margin-top: 25px; padding-left: 58px;">用户头像</label>
		<div class="col-sm-9">
			<form id="fileform" action="${ctx}/upload/picUpload" enctype="multipart/form-data" method="post">
				<div class="add"
					style="position: relative; margin-left: 1rem; height: 5.0rem; width: 5.0rem;">
					<img id="WX_icon" src="${upUser.avatar}" onerror="javascript:this.src='${ctx}/public/css/images/add-img.png'" style="height: 5.0rem; width: 5.0rem;" /> 
						<input id="selFile" type="file" name="imgfile" style="position: absolute; top: 0; left: 0; opacity: 0; width: 100%; height: 100%;" />
					<input name="dir" type="hidden" value="user_photo">
				</div>
				<input id="filesubmit" type="submit" style="display: none;">
			</form>
		</div>
	</div>
	<form id="userSubForm" method="post" action="${ctx}/account/user/save" class="form-horizontal m-t">
		<!--   -->
		<input type="hidden" name="id" id="id" value="${upUser.id}" />
		<input name="avatar" type="hidden" value="${upUser.avatar}"> 
		<c:if test="${not empty mhotel and  empty upUser.id}">
			<input name="hotelId" type="hidden" value="${mhotel.id}"> 
		</c:if>
		<c:if test="${not empty upUser.id}">
			<input name="hotelId" type="hidden" value="${upUser.hotelId}"> 
		</c:if>
		<c:if test="${empty mhotel and  empty upUser.id}">
		<div class="form-group form-inline">
			<label for="hotelId" class="col-sm-3 control-label">所属场地</label>
			<div class="col-sm-9">
				
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="hotelId" name="hotelId" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel " selectedValue="${mhotel.id }"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select>
				
			</div>
		</div>
		</c:if>
		<div class="form-group form-inline">
			<label for="groupId" class="col-sm-3 control-label">用户角色</label>
			<div class="col-sm-9">
				<select class="form-control" aria-required="true" aria-invalid="false" class="valid" id="groupId" name="groupId">
					<tags:dict sql="select id , name ,'' from hui_group where 1=1  ${empty mhotel?'':'and pid = 12'} " selectedValue="${upUser.groupId}" addBefore=",请选择" showPleaseSelect="false" />
				</select>
			</div>
		</div>
		
		<c:if test="${ not empty upUser.id}">
			<div class="form-group form-inline">
				<label for="username" class="col-sm-3 control-label">用户账号</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="username" name="username" placeholder="用户账号" value="${upUser.username}" aria-required="true" aria-invalid="false" class="valid" readonly="readonly">
				</div>
			</div>
		</c:if>
		<c:if test="${ empty upUser.id}">
			<div class="form-group form-inline">
				<label for="username" class="col-sm-3 control-label">用户账号</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="username" name="username" placeholder="用户账号" value="${upUser.username}" aria-required="true" aria-invalid="false" class="valid">
				</div>
			</div>
		</c:if>
		<div class="form-group form-inline">
			<label for="rname" class="col-sm-3 control-label">用户姓名</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="rname" name="rname" placeholder="用户名" value="${upUser.rname}" aria-required="true" aria-invalid="false" class="valid">
			</div>
		</div>
		<c:if test="${empty upUser.id}">
			<div class="form-group form-inline">
				<label for="password" class="col-sm-3 control-label">用户密码</label>
				<div class="col-sm-9">
					<input type="password" class="form-control" id="password" name="password" placeholder="用户密码" value="" aria-required="true" aria-invalid="false" class="valid">
				</div>
			</div>
			<div class="form-group form-inline">
				<label for="crfpassword" class="col-sm-3 control-label">确认密码</label>
				<div class="col-sm-9">
					<input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="确认密码" value="" aria-required="true" aria-invalid="false" class="valid">
				</div>
			</div>
		</c:if>
		<div class="form-group form-inline">
			<label for="mobile" class="col-sm-3 control-label">联系电话</label>
			<div class="col-sm-9">
				<input type="tel" class="form-control" id="mobile" name="mobile" placeholder="联系电话" value="${upUser.mobile}" aria-required="true" aria-invalid="false" class="valid">
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="email" class="col-sm-3 control-label">电子邮箱</label>
			<div class="col-sm-9">
				<input type="email" class="form-control" id="email" name="email" placeholder="电子邮箱" value="${upUser.email}" aria-required="true" aria-invalid="false" class="valid">
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="description" class="col-sm-3 control-label">用户简介</label>
			<div class="col-sm-9">
				<textarea class="form-control" id="description" name="description" rows="3" cols="40" placeholder="用户简介">${upUser.description}</textarea>
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="memo" class="col-sm-3 control-label">备注</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="memo" name="memo" placeholder="备注" value="${upUser.memo}">
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
