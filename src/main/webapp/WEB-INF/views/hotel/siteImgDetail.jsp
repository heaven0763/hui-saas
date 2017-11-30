<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
	.bgimg{margin-left:5px;padding: 8px;margin-bottom:5px; border: 1px solid #d3d3d3; width: 260px; height: 140px;}
	.bgimg .size{width:240px; height: 120px;}
	.clogo{height: 120px; width: 120px;margin-top: 42px;margin-left: 80px;}
	.cnmlogo{width:300px; height: 198px;}
    .len1{width: 100px;}
	.len2{width: 90px;}

	 #siteImgSubForm input[type="text"]{width: 400px;}
	 #siteImgSubForm select{width: 180px;}
</style>
<body class="gray-bg">
<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins" style="border: none">
	                   <div class="" style="position: relative;">
	                   		<a href="javascript:loadHotelContent(this,'${ctx}/base/hotel/img/index','');" class="btn btn-warning" style="position: absolute;right: 10px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
	                       <h3>${action }图片信息</h3>
	                        <hr/>
	                   </div>
	                   <div class="ibox-content" style="border: none">
	                   	<div class="row">
							<div class="col-sm-12">
								<form id="siteImgSubForm" method="post" action="${ctx}/base/hotel/img/save"  class="form-horizontal m-t" ><!--   -->
								  <input type="hidden" name="id" id="id" value="${siteImg.id}" />
								   <input type="hidden" name="action"  value="${empty siteImg.id?'create':'update'}" />
								    <c:if test="${not empty mhotel }">
								  	  	<input type="hidden" name="hotelId" id="hotelId" value="${mhotel.id}" />
								  	  </c:if>
									 <c:if test="${empty mhotel }">
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">所属场地</label>
									     <div class="col-sm-10">
									     	<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
								     			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="hotelId" textTarget="hotelName">
													<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel " selectedValue="${siteImg.hotelId}" showPleaseSelect="true"/>
												</select> 
											</c:if>
											<c:if test="${aUs.getCurrentUserType() eq 'partner' }">
												<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="hotelId" textTarget="hotelName">
													<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id=${aUs.getCurrentUserCompanyId() }" selectedValue="${siteImg.hotelId}" showPleaseSelect="true"/>
												</select> 
											</c:if>
									    </div>
									  </div>
									  </c:if>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">场地类型	</label>
									     <div class="col-sm-10">
									     	<select class="form-control"  id="siteType" name="siteType" onchange="loadPlace(this.value)">
												<tags:dict sql="SELECT val, name FROM hui_category where kind='PLACETYPE' " selectedValue="${siteImg.siteType}" showPleaseSelect="true"/>
											</select> 
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="siteId" class="col-sm-2 control-label">场地编号</label>
									     <div class="col-sm-10">
									     	<select class="form-control selectpicker" data-live-search="true" data-size="10" date-width="100px"  id="siteId" name="siteId" >
									     		<tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place where hotel_id=${mhotel.id}" showPleaseSelect="true" />
											</select> 
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">图片类型</label>
									     <div class="col-sm-10">
									     	<select class="form-control"  id="picType" name="picType">
												<tags:dict sql="SELECT val, name FROM hui_category where kind='PICTYPE' " selectedValue="${siteImg.picType}" showPleaseSelect="true"/>
											</select> 
									    </div>
									  </div>
									   <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">上传图片</label>
									     <div class="col-sm-10">
									     	<button type="button" class="btn btn-default" id="site_img_upload_btn"><span class="glyphicon glyphicon-off"></span> 上传</button>
									    </div>
									  </div>
									   <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">图片列表</label>
									     <div id="site_imgs" class="col-sm-10">
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
				   +'<a href="javascript:;" onclick="javascript:$(this).parent().remove();" style="position: absolute; top: 10; right:10;"><span class="glyphicon glyphicon-remove-circle" ></span></a>';
				
			$().ready(function() {
				$('.selectpicker').selectpicker();
			    var e = "<i class='fa fa-times-circle'></i> ";
				$("#siteImgSubForm").validate({
			        rules: {
			        	hotelId: "required",
			        	siteType: "required",
			        	siteId: "required",
			        	picType: "required"
			        },
			        messages: {
			        	hotelId: e + "请输入所属场地",
			        	siteType: e + "请输入场地类型",
			        	siteId: e + "请输入场地编号",
			        	picType: e + "请输入图片类型"
			        },
			        submitHandler: function(form) {
			            var url = $(form).attr("action");
			            var data = $(form).serialize();
			            parent.show();
			       　		$.post(url, data, function (res, status) { 
			       　			if(status=="success"&&res.statusCode=="200"){
			       　				swal(res.message, "success");
			       　				loadHotelContent(this,'${ctx}/base/hotel/img/index','');
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
				        uploadJson: '${ctx}/base/hotel/img/upload',
				        allowFileManager : false
				    });
					KindEditor('#site_img_upload_btn').click(function() {
						try{
							editor.loadPlugin('multiimage', function() {
					            editor.plugin.multiImageDialog({
					                clickFn : function(urlList) {
					                	$.each(urlList,function(index,item){
					                			var _img_str = img_str;
					                			$('#site_imgs').append(_img_str.replace("{0}",item.url).replace("{1}",item.url));
					                	});
					                	
					                	editor.hideDialog();
					                }
					            });
					        });
						}catch(err){
							alert(err);
						}
				    	
				    });
				});
			});
			
			
			function loadPlace(val){
				var hotelId=$("#hotelId").val();
				if(hotelId==''){
					swal("请先选择所属场地！", "error");
					return;
				}
				var url = '${ctx}/framework/dictionary/trslCombox?sql=';
				var pls = '<option value="">请选择...</option>';
				if("HOTEL"===val){
					url += 'SELECT id,hotel_name as name FROM hui_hotel where state = \'1\' and id=${mhotel.id}';
				}else if("HALL"===val){
					
					url += 'SELECT id,place_name as name FROM hui_hotel_place where state = \'1\' and place_type =\'HALL\' and hotel_id=${mhotel.id}';
				}else if("ROOM"===val){
					url += 'SELECT id,place_name as name FROM hui_hotel_place where state = \'1\' and place_type =\'ROOM\' and hotel_id=${mhotel.id}';
				}
				
				$.get(url, function (res, status) { 
					var str = '';
					if(status=="success"){
						str = pls;
						$.each(res, function(i, item){
							str+='<option value="'+item.value+'">'+item.text+'</option>';
						});
						
						$("#siteId").html(str);
						$("#siteId").selectpicker('refresh');
					}
				}, 'json');
			}
			
			</script>
</div>

