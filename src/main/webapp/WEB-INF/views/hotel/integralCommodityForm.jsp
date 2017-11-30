<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#integralCommoditySubForm").validate({
        rules: {
        	hotelId: "required",
        	name: "required",
        	integral: "required",
        	price: "required",
        	zgprice: "required",
        	pcontent: "required",
        	state: "required",
        	checkDate: "required",
        	checkMemo: "required",
        	createDate: "required",
        	memo: "required",
        },
        messages: {
        	hotelId: e + "请输入所属场地",
        	name: e + "请输入商品名称",
        	integral: e + "请输入所需积分",
        	price: e + "请输入场地价格",
        	zgprice: e + "请输入掌柜价格",
        	pcontent: e + "请输入商品介绍",
        	state: e + "请输入状态",
        	checkDate: e + "请输入审核日期",
        	checkMemo: e + "请输入审核备注",
        	createDate: e + "请输入创建日期",
        	memo: e + "请输入备注",
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				integralCommodity_search();
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
    });
	
});
//-->
</script>
<script>
$(document).ready(function(e) {
	$('.selectpicker').selectpicker();
	   $('#icimgFile').localResizeIMG({
	      width: 600,
	      quality: 1,
	      before:function(){
	    	  parent.show();
	      },
	      success: function (result) {
			  var submitData={
				  base64Str:result.clearBase64,
				  dir:'icimg'
				}; 
			 $.ajax({
			   type: "POST",
			   url: "${ctx}/account/user/upload/resizeimg",
			   data: submitData,
			   dataType:"json",
			   success: function(data){
				  parent.hide();
				 if (data.success) {
					$('input[name="img"]').val(data.obj);
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
<div class="modal-body"> 
  
<form id="integralCommoditySubForm" method="post" action="${ctx}/base/hotel/integral/commodity/save"  class="form-horizontal m-t" ><!--   -->
  <input name="img" type="hidden" value="${integralCommodity.img}"> 
  <input type="hidden" name="id" id="id" value="${integralCommodity.id}" />
  	   <div class="form-group form-inline">
	    <label for="hotelId" class="col-sm-3 control-label">所属场地</label>
	     <div class="col-sm-9">
	     	<div class="add" style="position: relative; margin-left: 1rem; height: 120px; width: 120px;">
				<img id="WX_icon" src="${integralCommodity.img}" onerror="javascript:this.src='${ctx}/public/css/images/add-img.png'" style="height: 120px; width: 120px;" /> 
					<input id="icimgFile" type="file" name="imgfile" style="position: absolute; top: 0; left: 0; opacity: 0; width: 100%; height: 100%;" />
			</div>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="hotelId" class="col-sm-3 control-label">所属场地</label>
	     <div class="col-sm-9">
	     	<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="hotelId" data-options="required:true" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部" selectedValue="${integralCommodity.hotelId}"/>
			</select> 
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">商品名称</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="name" data-options="required:true" value="${integralCommodity.name}"  />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">所需积分</label>
	     <div class="col-sm-9">
	     	<input type="number" class="form-control" name="integral" data-options="required:true" value="${integralCommodity.integral}" min="0" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">场地价格</label>
	     <div class="col-sm-9">
	     	<input type="number" class="form-control" name="price" data-options="required:true" value="${integralCommodity.price}"  min="0"/>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">掌柜价格</label>
	     <div class="col-sm-9">
	     	<input type="number" class="form-control" name="zgprice" data-options="required:true" value="${integralCommodity.zgprice}" min="0" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">商品介绍</label>
	     <div class="col-sm-9">
	     	<textarea  class="form-control" name="pcontent"  rows="7" cols="" style="width: 100%;">${integralCommodity.pcontent}</textarea>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">备注</label>
	     <div class="col-sm-9">
	     	<textarea  class="form-control" name="memo"  rows="3" cols="" style="width: 100%;">${integralCommodity.memo}</textarea>
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button qx="points-mall:update" type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

