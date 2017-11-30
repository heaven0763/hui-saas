<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<%-- <%@include file="/WEB-INF/ui.inc.jsp"%> --%>
<%-- <link href="${staticPath}/public/hplus/css/style.min862f.css?v=4.1.0" rel="stylesheet"> --%>
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins" style="border: none">
                    <div class="" style="position: relative;">
                    	<a href="javascript:;" onclick="loadContent(this,'${ctx}/base/app/api/index','ND');" class="btn btn-warning" style="position: absolute;right: 10px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
                        <h3>添加接口信息</h3>
                        <hr/>
                    </div>
                    <br/>
                    <div class="ibox-content" style="border: none">
                    	<div class="row">
							<div class="col-sm-12">
								<form id="apiSubForm" method="post" action="${ctx}/base/app/api/save"  class="form-horizontal m-t" ><!--   -->
								  <input type="hidden" name="id" id="id" value="${api.id}" />
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">接口名称</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="name" data-options="required:true" value="${api.name}"  style="width:400px;"/>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">接口地址</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="url" data-options="required:true" value="${api.url}" style="width:400px;"/>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">支持格式</label>
									     <div class="col-sm-10">
									     	<select class="form-control" name="format"  style="width:180px;">
									   			<option value="" >请选择</option>
									   			<option value="JSON" ${api.format eq 'JSON'?'selected=\"selected\"':''}>JSON</option>
									   			<option value="XML" ${api.format eq 'XML'?'selected=\"selected\"':''}>XML</option>
									   		</select>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">请求方式</label>
									     <div class="col-sm-10">
									     	<select class="form-control" name="method" style="width:180px;">
									   			<option value="" >请选择</option>
									   			<option value="POST" ${api.method eq 'POST'?'selected=\"selected\"':''}>POST</option>
								   				<option value="GET" ${api.method eq 'GET'?'selected=\"selected\"':''}>GET</option>
									   		</select>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="example" class="col-sm-2 control-label">请求示例</label>
									     <div class="col-sm-10">
									     	<textarea id="example" name="example" style="width:800px;height:50px;">${api.example}</textarea>
									    </div>
									  </div>
									  
									  <div class="form-group form-inline">
									    <label for="params" class="col-sm-2 control-label">请求参数</label>
									     <div class="col-sm-10">
									     	<script id="params" name="params" type="text/plain" style="width:800px;height:200px;">${api.params}</script>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="result" class="col-sm-2 control-label">返回结果</label>
									     <div class="col-sm-10">
									     	<script id="result" name="result" type="text/plain" style="width:800px;height:500px;">${api.result}</script>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="memo" class="col-sm-2 control-label">接口备注</label>
									     <div class="col-sm-10">
									     	<textarea id="memo" name="memo" style="width:800px;height:50px;">${api.memo}</textarea>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									  	 <label for="btn" class="col-sm-2 control-label"></label>
									     <div class="col-sm-10" style="">
									     	<button type="submit" class="btn btn-primary" style="width: 160px;"><span class="glyphicon glyphicon-save"></span> 保存</button>
									    </div>
									  </div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$().ready(function() {
				var editor = new UE.ui.Editor();
				editor.render("result");
				var params = new UE.ui.Editor();
				params.render("params");
			    var e = "<i class='fa fa-times-circle'></i> ";
				$("#apiSubForm").validate({
			        rules: {
			        	name: "required",
			        	url: "required",
			        	format: "required",
			        	method: "required",
			        	example: "required",
			        	params: "required",
			        	result: "required"
			        },
			        messages: {
			        	name: e + "请输入接口名称",
			        	url: e + "请输入接口地址",
			        	format: e + "请输入支持格式",
			        	method: e + "请输入请求方式",
			        	example: e + "请输入请求示例",
			        	params: e + "请输入请求参数",
			        	result: e + "请输入返回结果"
			        },
			        submitHandler: function(form) {
			            var url = $(form).attr("action");
			            var data = $(form).serialize();
			            parent.show();
			       　		$.post(url, data, function (res, status) { 
			       　			if(status=="success"&&res.statusCode=="200"){
			       　				$('#close_btn').click();
			       　				swal(res.message, "success");
			       　				loadContent(this,'${ctx}/base/app/api/index','RD');
			       　			}else{
			       　				swal(res.message, "error");
			       　			}
			       　			parent.hide();
			       　		}, 'json'); 
			         }  
			    });
				
			});
		</script>
	</div>

