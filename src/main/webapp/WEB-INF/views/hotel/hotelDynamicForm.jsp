<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
<style>
	.bgimg{margin-left:5px;padding: 8px;margin-bottom:5px; border: 1px solid #d3d3d3; width: 120px; height: 120px;}
	.bgimg .size{width:100px; height: 100px;}
	.clogo{height: 120px; width: 120px;margin-top: 42px;margin-left: 80px;}
	.cnmlogo{width:300px; height: 198px;}
    .len1{width: 100px;}
	.len2{width: 90px;}

 	#hotelDynamicSubForm input[type="text"]{width: 400px;}
	#hotelDynamicSubForm select{width: 180px;}
</style>
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins" style="border: none">
	                   <div class="" style="position: relative;">
	                  		<a href="javascript:loadContent(this,'${ctx}/base/hotel/dynamic/index','');" class="btn btn-warning" style="position: absolute;right: 10px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
	                       <h3>发表场地动态</h3>
	                        <hr/>
	                   </div>
	                   <div class="ibox-content" style="border: none">
	                   	<div class="row">
							<div class="col-sm-12">
								<form id="hotelDynamicSubForm" method="post" action="${ctx}/base/hotel/dynamic/save"  class="form-horizontal m-t" ><!--   -->
								  <input type="hidden" name="id" id="id" value="${hotelDynamic.id}" />
								  <input type="hidden" name="hotelName" id="hotelName" value="${hotelDynamic.hotelName}" />
								  <input type="hidden" name="hallName" id="hallName" value="${hotelDynamic.hallName}" />
								   <c:if test="${aUs.getCurrentUserType() eq 'HOTEL' }">
							  	  	<input type="hidden" name="hotelId" id="hotelId" value="${aUs.getCurrentUserHotelId()}" />
							  	  	 <div class="form-group form-inline">
									    <label for="hotelId" class="col-sm-2 control-label">场地</label>
									     <div class="col-sm-10">
									     	<span class="form-control">${mhotel.hotelName}</span>
									     </div>
									     </div>
							  	  </c:if>
								 <c:if test="${aUs.getCurrentUserType() ne 'HOTEL'}">
									  <div class="form-group form-inline">
									    <label for="hotelId" class="col-sm-2 control-label">场地</label>
									     <div class="col-sm-10">
									     	<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
								     			<select class="form-control selectpicker" data-live-search="true" data-width="400px" data-size="10"   id="hotelId" name="hotelId"  style="width: 180px;" refval="value" reftext="text" textTarget="hotelName" 
													refurl="${ctx}/framework/dictionary/trslCombox?sql=select id ,place_name name  from hui_hotel_place where place_type='HALL' and hotel_id={value}" refdata="hotel_id=:{value}" ref="#hallId" >
													<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel " selectedValue="${hotelSchedule.hotelId}" showPleaseSelect="true"/>
												</select>
									     	</c:if>
									     	<c:if test="${aUs.getCurrentUserType() eq 'PARTNER' }">
								     			<select class="form-control selectpicker" data-live-search="true" data-width="400px" data-size="10"   id="hotelId" name="hotelId"  style="width: 180px;" refval="value" reftext="text" textTarget="hotelName" 
													refurl="${ctx}/framework/dictionary/trslCombox?sql=select id ,place_name name  from hui_hotel_place where place_type='HALL' and hotel_id={value}" refdata="hotel_id=:{value}" ref="#hallId" >
													<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id = ${aUs.getCurrentUserCompanyId()}" selectedValue="${hotelSchedule.hotelId}" showPleaseSelect="true"/>
												</select>
									     	</c:if>
									    </div>
									  </div>
									   <div class="form-group form-inline">
									    <label for="hallId" class="col-sm-2 control-label">会场</label>
									     <div class="col-sm-10">
									     	<select class="form-control selectpicker" data-live-search="true" data-width="400px" data-size="10"   id="hallId" name="hallId" refval="value" reftext="text" textTarget="hallName" style="width: 180px;">
												  <tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place where place_type='HALL' " selectedValue="${hotelSchedule.placeId}" showPleaseSelect="true"/> 
											</select> 
									    </div>
									  </div>
								  </c:if>
									<c:if test="${aUs.getCurrentUserType() eq 'HOTEL' }">
										 <div class="form-group form-inline">
										    <label for="hallId" class="col-sm-2 control-label">会场</label>
										     <div class="col-sm-10">
										     	<select class="form-control selectpicker" data-live-search="true" data-width="400px" data-size="10"   id="hallId" name="hallId" refval="value" reftext="text" textTarget="hallName" style="width: 180px;">
													  <tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place where place_type='HALL' and hotel_id=${mhotel.id} " selectedValue="${hotelSchedule.placeId}" showPleaseSelect="true"/> 
												</select> 
										    </div>
										  </div>
									</c:if>
									  <div class="form-group form-inline">
									    <label for="partyTime" class="col-sm-2 control-label ">活动时间</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control layer-date laydate-icon" id="partyTime" name="partyTime" data-options="required:true" value="${_currDayOfMonth}" aria-required="true" aria-invalid="false" class="valid" />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="party" class="col-sm-2 control-label">活动执行公司</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="party" data-options="required:true" value="${hotelDynamic.party}" aria-required="true" aria-invalid="false" class="valid" />
									    </div>
									  </div>
									 <%--  <div class="form-group form-inline">
									    <label for="site" class="col-sm-2 control-label">场地</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="site" data-options="required:true" value="${hotelDynamic.site}" aria-required="true" aria-invalid="false" class="valid" />
									    </div>
									  </div>
									  
									  <div class="form-group form-inline">
									    <label for="area" class="col-sm-2 control-label">地点</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="area" data-options="required:true" value="${hotelDynamic.area}" aria-required="true" aria-invalid="false" class="valid" />
									    </div>
									  </div> --%>
									  <div class="form-group form-inline">
									    <label for="budget" class="col-sm-2 control-label">参考预算</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="budget" data-options="required:true" value="${hotelDynamic.budget}" aria-required="true" aria-invalid="false" class="valid" />元
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="pcontent" class="col-sm-2 control-label">动态内容</label>
									     <div class="col-sm-10">
									     	<textarea class="form-control" name="pcontent" style="width: 800px;height: 200px;">${hotelDynamic.pcontent}</textarea>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="upload_btn" class="col-sm-2 control-label">动态图片</label>
									     <div class="col-sm-10">
									     	<!-- <button type="button" class="btn btn-default" id="upload_btn"><span class="glyphicon glyphicon-off"></span> 上传</button> -->
								     	    <input id="dynamicupload" type="file" multiple="multiple"  accept="image/gif, image/jpeg, image/png, image/jpg, image/bmp" />
       										<div id="queue"></div>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="imgs" class="col-sm-2 control-label">图片列表</label>
									     <div id="imgs" class="col-sm-10">
									     </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="iscase" class="col-sm-2 control-label">是否案列</label>
									     <div class="col-sm-10">
									     	 <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="inlineRadio2" value="0" name="iscase" ${hotelDynamic.iscase ne '1'?'checked=\"checked\"':''}>
		                                        <label for="inlineRadio2"> 否 </label>
		                                    </div>
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="inlineRadio1" value="1" name="iscase" ${hotelDynamic.iscase eq '1'?'checked=\"checked\"':''}>
		                                        <label for="inlineRadio1"> 是 </label>
		                                    </div>
		                                   
									    </div>
									  </div>
									   <div class="form-group form-inline">
									    <label for="btn" class="col-sm-2 control-label"></label>
									     <div class="col-sm-10">
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
var img_str = '<div class="bgimg" style="position: relative;float:left;"> <img id="img" src="{0}" class="size"></img> <input type="hidden" value="{1}" name="imgs">'
	   +'<a href="javascript:;" onclick="deleteFile(this);" style="position: absolute; top: 5px; right:5px;"><span class="glyphicon glyphicon-remove-circle" ></span></a>';
	
$().ready(function() {
	var partyTime={elem:"#partyTime",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
    laydate(partyTime);
    $('.selectpicker').selectpicker();
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#hotelDynamicSubForm").validate({
        rules: {
        	hotelId: "required",
        	pcontent: "required",
        	imgs: "required"
        },
        messages: {
        	hotelId: e + "请选择场地",
        	pcontent: e + "请输入动态内容",
        	imgs: e + "请上传动态图片"
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				loadContent(this,'${ctx}/base/hotel/dynamic/index','');
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
    });
	/* $.getScript('${ctx}/static/plugins/kindeditor-4.1.10/kindeditor.js', function() {
		KindEditor.basePath = '${ctx}/static/plugins/kindeditor-4.1.10/';
		var editor = KindEditor.editor({
	        uploadJson: '${ctx}/base/hotel/img/upload',
	        allowFileManager : false,
	        imageSizeLimit : '5MB', //批量上传图片单张最大容量
            imageUploadLimit : 9 
	    });
		KindEditor('#upload_btn').click(function() {
	    	editor.loadPlugin('multiimage', function() {
	            editor.plugin.multiImageDialog({
	            	
	                clickFn : function(urlList) {
	                	$.each(urlList,function(index,item){
	                			var _img_str = img_str;
	                			$('#imgs').append(_img_str.replace("{0}",item.url).replace("{1}",item.url));
	                	});
	                	editor.hideDialog();
	                }
	            });
	        });
	    });
	});
	 */
	
	$('#hotelId').on('changed.bs.select', function (event, clickedIndex, newValue, oldValue) {
		var hotelId = $('#hotelId').val();
		var url ="${ctx}/framework/dictionary/trslCombox?sql=select id ,place_name name  from hui_hotel_place where place_type='HALL'";
		if(hotelId){
			url +=' and hotel_id='+hotelId;
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
		            $('#hallId').html(options.join(''));
		            $('#hallId').selectpicker('refresh');
		        },
		        error: function (data) {
		            //alert("查询学校失败" + data);
		        }
		    })
		}
	});
	var BASE_URL = "${ctx}/static/plugins/uploadify/scripts/";
	$('#dynamicupload').uploadify({
	    swf      : BASE_URL+'uploadify.swf',
	    uploader : '${ctx}/base/hotel/img/upload;jsessionid=<%=session.getId() %>',
	    buttonText: '<div>选择文件</div>'
	    ,fileSizeLimit:'5MB'
        ,fileTypeExts: '*.jpg;*.png;*.gif'
        ,queueSizeLimit: 20
       	,formData: {
               dir: 'dynamic'
           }
	    ,onUploadComplete: function(file){
	    	 console.log(file);
            //在每一个文件上传成功或失败之后触发，返回上传的文件对象或返回一个错误，如果你想知道上传是否成功，最后使用onUploadSuccess或onUploadError事件
        }
	    ,onQueueComplete:function(queueData){
            console.log(queueData.uploadsSuccessful+'\n'+queueData.uploadsErrored)
        }
	    , onUploadSuccess: function(file,data,respone){
            var obj = eval('('+data+')');
            var _img_str = img_str;
            $('#imgs').append(_img_str.replace("{0}",obj.url).replace("{1}",obj.url));
         }
	});
});

function deleteFile(self){
	$this = $(self);
	var $img = $this.parent().find("img");
	var path = $img.attr("src");
	$.post('${ctx}/base/hotel/img/remove',{path:path},function(){},'json');
	$this.parent().remove();
}
</script>
</div>

