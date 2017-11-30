<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
.simpleline{    line-height: 20px;
    padding: 12px 0;
    width: 100%;
    overflow: hidden;
    word-break: break-all;
    color: #777;
    border-bottom: 1px dashed #f2f2f2;}
.simpleTable{
    margin-bottom: 20px;
    border-bottom: 0;
    
} 
.prediv{
	padding:10px;
	border: 1px dashed #f2f2f2;
}

</style>
<script type="text/javascript">
function test_api_fun(){
	
	var url =$("#url").val();
	var method = '${api.method}';
	//var params =$("#params").val();
	var data = "";
	/*if(params){
		data = eval('('+params+')');
	} */
	 $('#test_result').empty();   //清空test_result里面的所有内容
	if(method=="POST"){
		$.post(url, data , function (res) { 
	         var html =formatJson(res);
	         $('#test_result').html(html);
		}, 'json'); 
	}else{
		$.ajax({
	         type: method,
	         url: url,
	         data: data,
	         dataType: "json",
	         success: function(res){
	            var html =formatJson(res);
	            $('#test_result').html(html);
	         },error:function(){
	        	 swal("ERROR", "error");
	         }
	     });
	}
 	
	
}
</script>

<body class="gray-bg">
	<div class="wrapper wrapper-content">

		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="" style="position: relative;">
                    	<a href="javascript:;" onclick="loadContent(this,'${ctx}/base/app/api/index','ND');" class="btn btn-warning" style="position: absolute;right: 10px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
                        <h3>${api.name}</h3>
                        <hr/>
                    </div>
                    <br/>
                    <div class="ibox-content">
                    	<div class="row">
							<div class="col-sm-12">
								<div class="m-b-md">
                                    <!-- <a href="project_detail.html#" class="btn btn-white btn-xs pull-right">编辑项目</a> -->
                                   
                                </div>
                                <div class="simpleline"><strong>接口地址：</strong><span class="url">${api.url}</span></div>
                                <div class="simpleline"><strong>支持格式：</strong><span class="url">${api.format}</span></div>
                                <div class="simpleline"><strong>请求方式：</strong><span class="url">${api.method}</span></div>
                                <div class="simpleline"><strong>请求示例：</strong><span class="url">${api.example}</span></div>
                                <div class="simpleline"><strong>接口备注：</strong><span class="url">${api.memo}</span></div>
                                
							</div>
						</div>
						 <div class="row">
                            <div class="col-sm-12">
                                <div class="panel blank-panel">
                                    <div class="panel-heading">
                                        <div class="panel-options">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a href="#tab-1" data-toggle="tab" aria-expanded="true">API</a>
                                                </li>
                                                <li class=""><a href="#tab-2" data-toggle="tab" aria-expanded="false">接口测试</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="panel-body">

                                        <div class="tab-content">
                                            <div class="tab-pane active" id="tab-1">
                                          	  <div class="simpleline simpleTable">
						                            <b>请求参数：</b>
						                            <div class="prediv">
						                                ${api.params}
						                            </div>
						                        </div>
                                                <div class="simpleline simpleTable">
						                            <b>JSON返回结果：</b>
						                            <div class="prediv">
						                                ${api.result}
						                            </div>
						                        </div>
                                            </div>
                                            <div class="tab-pane" id="tab-2">
                                            	<div class="row">
							  						 <div class="col-sm-12 form-horizontal m-t">
														<div class="form-group form-inline">
														    <label for="url" class="col-sm-2 control-label">请求示例</label>
														    <div class="col-sm-10">
															    <textarea class="form-control" style="width:800px;height:100px;"id="url" name="url" placeholder="API路径" >${api.example}</textarea>
															  </div>
														</div>
													  <!--  <div class="form-group form-inline">
														    <label for="tab" class="col-sm-2 control-label">参数</label>
														    <div class="col-sm-10">
														    	<textarea class="form-control" style="width:800px;height:100px;" id="params" name="params"  placeholder="参数"></textarea>
															</div>
											  			</div> -->
											  			<div class="form-group form-inline">
														    <label for="tab" class="col-sm-2 control-label"></label>
														    <div class="col-sm-10">
														    	<button type="button" class="btn btn-primary" onclick="test_api_fun()"><span class="glyphicon glyphicon-save"></span> 测试</button>
															</div>
											  			</div>
										  			</div>
									  			</div>
                                                <div class="row">
							  						 <div class="col-sm-12">
							  							<textarea class="form-control" rows="20" cols="60"  id="test_result"   readonly="readonly"></textarea>
							  						</div>
							  					</div>

                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

