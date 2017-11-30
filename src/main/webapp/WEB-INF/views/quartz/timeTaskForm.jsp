<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<script type="text/javascript">
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#subForm").validate({
        rules: {
        	taskId: "required",
        	clazz: "required",
        	taskDescribe: "required",
        	cronExpression: "required",
        	isEffect:"required",
            isStart:"required"
        },
        messages: {
        	taskId: "请输入任务ID",
        	clazz: "请输入任务类",
        	taskDescribe: "请输入任务描述",
        	cronExpression: "请输入cron表达式",
        	isEffect:"请输入0未生效,1生效了",
            isStart:"请输入0停止,1运行"
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
            
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				timeTask_search();
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
	<form id="subForm" action="${ctx}/base/quartz/save" method="post" class="form-horizontal m-t">
		<input type="hidden" name="id" value="${timeTask.id}" />
		<div class="form-group form-inline">
			<label for="taskId" class="col-sm-3 control-label">任务ID</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="taskId" name="taskId" placeholder="任务ID" value="${timeTask.taskId}" >
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="clazz" class="col-sm-3 control-label">任务类</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="clazz" name="clazz" placeholder="任务类" value="${timeTask.clazz}" >
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="taskDescribe" class="col-sm-3 control-label">任务描述</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="taskDescribe" name="taskDescribe" placeholder="任务描述" value="${timeTask.taskDescribe}" >
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="cronExpression" class="col-sm-3 control-label">cron表达式</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="cronExpression" name="cronExpression" placeholder="cron表达式" value="${timeTask.cronExpression}" >
			</div>
		</div>
		
		<div class="form-group form-inline">
			<label for="isEffect" class="col-sm-3 control-label">是否生效</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="isEffect" name="isEffect" placeholder="是否生效" value="${timeTask.isEffect}" >
			</div>
		</div>
		
		<div class="form-group form-inline">
			<label for="isStart" class="col-sm-3 control-label">是否运行</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="isStart" name="isStart" placeholder="是否运行" value="${timeTask.isStart}" >
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