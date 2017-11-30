<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
$().ready(function() {
	 var sDate={elem:"#sDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	 var eDate={elem:"#eDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	 laydate(eDate);
	 laydate(sDate);
	 $('.selectpicker').selectpicker();
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#hotelScheduleBatchSubForm").validate({
        rules: {
        	hotelId: "required",
        	sdate: "required",
        	edate: "required"
        },
        messages: {
        	hotelId: e + "请选择所属场地",
        	sdate: e + "请选择开始日期",
        	edate: e + "请选择结束档期"
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				hotelSchedule_search();
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
  
<form id="hotelScheduleBatchSubForm" method="post" action="${ctx}/base/hotel/schedule/batch/save"  class="form-horizontal m-t" ><!--   -->
	   <c:if test="${not empty mhotel }">
 	  	<input type="hidden" name="hotelId" id="hotelId" value="${mhotel.id}" />
  </c:if>
  <c:if test="${empty mhotel }">
	  <div class="form-group form-inline">
	    <label for="hotelId" class="col-sm-3 control-label">所属场地</label>
	     <div class="col-sm-9">
	     		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="hotelId"  style="width: 180px;" refval="value" reftext="text" textTarget="hotelName" 
						refurl="${ctx}/framework/dictionary/trslCombox?sql=select id ,place_name name  from hui_hotel_place where place_type='HALL' and hotel_id={value}" refdata="hotel_id=:{value}" ref="#placeId" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel " selectedValue="${hotelSchedule.hotelId}" showPleaseSelect="true"/>
				</select> 
	    </div>
	  </div>
	  </c:if>
	   <div class="form-group form-inline">
	    <label for="placeDate" class="col-sm-3 control-label">开始日期</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control layer-date laydate-icon" id="sDate" name="sdate" data-options="required:true" value=""  />
	    </div>
	  </div>
	 <div class="form-group form-inline">
	    <label for="placeDate" class="col-sm-3 control-label">结束日期</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control layer-date laydate-icon" id="eDate" name="edate" data-options="required:true" value=""  />
	    </div>
	  </div>

	  <div class="form-group form-inline">
	    <label for="memo" class="col-sm-3 control-label">备注</label>
	     <div class="col-sm-9">
	     	<textarea class="form-control" name="memo" rows="" cols="">${hotelSchedule.memo}</textarea>
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

