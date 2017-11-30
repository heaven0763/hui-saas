<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
		<div class="row">
		<div class="col-sm-12">
			<div class="ibox float-e-margins" style="border: none">
                    <div class="" style="position: relative;">
                   		 <a href="javascript:;" onclick="loadContent(this,'${ctx}/user/company/index','ND');" class="btn btn-warning" style="position: absolute;right: 10px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
                        <h3>添加企业信息</h3>
                         <hr/>
                    </div>
                    <div class="ibox-content" style="border: none">
                    	<div class="row">
							<div class="col-sm-8">
								<form id="companySubForm" method="post" action="${ctx}/user/company/save"  class="form-horizontal m-t" ><!--   -->
								  	<input type="hidden" name="id" id="id" value="${company.id}" />
								  	<input type="hidden" name="parea" id="parea" value="" />
								  	<input type="hidden" name="carea" id="carea" value="" />
								  	<input type="hidden" name="darea" id="darea" value="" />
								  	 <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">认证类型</label>
									     <div class="col-sm-10">
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="inlineRadio1" value="HOTEL" name="authType" ${company.authType eq 'HOTEL' ?'checked=\"checked\"':''}>
		                                        <label for="inlineRadio1"> 场地场地 </label>
		                                    </div>
		                                    <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="inlineRadio2" value="API" name="authType" ${company.authType eq 'API' ?'checked=\"checked\"':''}>
		                                        <label for="inlineRadio2"> 应用接口 </label>
		                                    </div>
		                                    <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="inlineRadio3" value="PARTNER" name="authType" ${company.authType eq 'PARTNER' ?'checked=\"checked\"':''}>
		                                        <label for="inlineRadio3"> 合伙人 </label>
		                                    </div>
								    	</div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">公司名称</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="companyName" data-options="required:true" value="${company.companyName}" style="width:400px;" />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">公司区域</label>
									     <div class="col-sm-10">
									     	<%-- <input type="text" class="form-control" name="companyArea" data-options="required:true" value="${company.companyArea}" style="width:400px;" /> --%>
									     	<select class="form-control"  id="province" name="province" refval="value" reftext="text" textTarget="parea" nxtref="#darea"
												refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#city" onchange="areaclear();">
												<tags:dict sql="select  id ,region_name name  from hui_region where parent_id='1' " selectedValue="${company.province}"  showPleaseSelect="true"/>
											</select>
											<select class="form-control"  id="city" name="city" refval="value" reftext="text"  textTarget="carea"
									     		refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#district" onchange="areaclear('city');">
									     		<c:if test="${not empty company.city }">
													  <tags:dict sql="select  id ,region_name name  from hui_region where parent_id=${company.province}" selectedValue="${company.city}" showPleaseSelect="true"/>
												  </c:if> 
											</select>
											<select class="form-control"  id="district" name="district" refval="value" reftext="text"  textTarget="darea" >
												<c:if test="${not empty company.district }">
													<tags:dict sql="select id,region_name name from hui_region where parent_id='${company.city}'" selectedValue="${company.district}" showPleaseSelect="true"/>
												</c:if> 
											</select> 
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">详细地址</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="companyAddress" data-options="required:true" value="${company.companyAddress}" style="width:400px;" />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">营业执照编号</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="businessLicenseNumber" data-options="required:true" value="${company.businessLicenseNumber}" style="width:400px;" />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">税务登记证编号</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="taxNumber" data-options="required:true" value="${company.taxNumber}" style="width:400px;" />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">组织机构编号</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="organizationNumber" data-options="required:true" value="${company.organizationNumber}" style="width:400px;" />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">营业执照副本</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="businessLicenseImg" data-options="required:true" value="${company.businessLicenseImg}" style="width:330px;" readonly="readonly" />
									     	<button type="button" id="imagePathBtn" class="btn btn-primary" style="line-height: 25px;"><i class="fa fa-upload"></i>&nbsp;上传</button>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">联系人姓名</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="linkmen" data-options="required:true" value="${company.linkmen}" style="width:400px;" />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">联系人电话</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="linkMobile" data-options="required:true" value="${company.linkMobile}" style="width:400px;" />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">备注	</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="memo" data-options="required:true" value="${company.memo}" style="width:400px;" />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									  	 <label for="btn" class="col-sm-2 control-label"></label>
									     <div class="col-sm-10" >
									     	<button type="submit" class="btn btn-primary" style="width: 160px;"><span class="glyphicon glyphicon-save"></span> 保存</button>
									    </div>
									  </div>
								</form>
							</div>
							<div class="col-sm-4" style="padding: 20px;">
								<c:if test="${not empty company.businessLicenseImg}">
									<img id="img" src="/${company.businessLicenseImg}"   width="250px;">
								</c:if>
								<c:if test="${empty company.businessLicenseImg}">
									<img id="img" src="" style="display: none;" width="250px;">
								</c:if>
								
							</div>
						</div>
                        
                    </div>
                </div>
		</div>
	</div>
<script type="text/javascript">
	$().ready(function() {
	    var e = "<i class='fa fa-times-circle'></i> ";
		$("#companySubForm").validate({
	        rules: {
	        	companyName: "required",
	        	companyArea: "required",
	        	companyAddress: "required",
	        	businessLicenseNumber: "required",
	        	taxNumber: "required",
	        	organizationNumber: "required",
	        	businessLicenseImg: "required",
	        	linkmen: "required",
	        	linkMobile: "required",
	        	authType: "required"
	        },
	        messages: {
	        	companyName: e + "请输入公司名称",
	        	companyArea: e + "请输入公司地址",
	        	companyAddress: e + "请输入详细地址",
	        	businessLicenseNumber: e + "请输入营业执照编号",
	        	taxNumber: e + "请输入税务登记证编号",
	        	organizationNumber: e + "请输入组织机构编号",
	        	businessLicenseImg: e + "请上传营业执照副本",
	        	linkmen: e + "请输入联系人姓名",
	        	linkMobile: e + "请输入联系人电话",
	        	authType: e + "请选择企业认证类型"
	        	
	        },
	        submitHandler: function(form) {
	            var url = $(form).attr("action");
	            var data = $(form).serialize();
	            parent.show();
	       　		$.post(url, data, function (res, status) { 
	       　			if(status=="success"&&res.statusCode=="200"){
	       　				$('#close_btn').click();
	       　				swal(res.message, "success");
	       　				loadContent(this,'${ctx}/user/company/index','RD');
	       　			}else{
	       　				swal(res.message, "error");
	       　			}
	       　			parent.hide();
	       　		}, 'json'); 
	         }  
	    });
		
		$.getScript('${ctx}/static/plugins/kindeditor-4.1.10/kindeditor.js', function() {
			KindEditor.basePath = '${ctx}/static/plugins/kindeditor-4.1.10/';
			var editor = KindEditor.editor({
		        uploadJson: '${ctx}/user/company/upload/pic',
		        allowFileManager : false
		    });
			KindEditor('#imagePathBtn').click(function() {
		    	var iconText = $('#imagePathBtn').parent().find('input');
		    	editor.loadPlugin('image', function() {
		            editor.plugin.imageDialog({
		                showRemote : false,
		                imageUrl : iconText.val(),
		                clickFn : function(url, title, width, height, border, align) {
		                	url = url.substring(1);
	                	    iconText.val(url);
	                	    editor.hideDialog();
	                	    $("#img").attr("src","/"+url);
	                	    $("#img").show();
		                }
		            });
		        });
		    });
		});
	});
	
</script>
</div>
