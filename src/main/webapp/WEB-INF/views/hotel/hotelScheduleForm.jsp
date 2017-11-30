<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
$().ready(function() {
	 var placeDate={elem:"#placeDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	 laydate(placeDate);
	 $('.selectpicker').selectpicker();
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#hotelScheduleSubForm").validate({
        rules: {
        	hotelId: "required",
        	placeId: "required",
        	placeDate: "required",
        	placeSchedule: "required"
        },
        messages: {
        	hotelId: e + "请选择所属场地",
        	placeId: e + "请选择场地",
        	placeDate: e + "请输入场地日期",
        	placeSchedule: e + "请选择场地档期"
        	
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
  
<form id="hotelScheduleSubForm" method="post" action="${ctx}/base/hotel/schedule/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${hotelSchedule.id}" />
  
  <input type="hidden" name="action" id="id" value="${empty hotelSchedule.id?'create':'update'}" />
  <input type="hidden" name="hotelName" id="hotelName" value="${hotelSchedule.hotelName}" />
  <input type="hidden" name="placeName" id="hallName" value="${hotelSchedule.placeName}" />
  <input type="hidden" name="placeType" id="placeType" value="HALL" />
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
	    <label for="placeId" class="col-sm-3 control-label">场地</label>
	     <div class="col-sm-9">
     		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="placeId" name="placeId" refval="value" reftext="text" textTarget="hallName" style="width: 180px;">
				  <tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place where place_type='HALL' and hotel_id=${mhotel.id}" selectedValue="${hotelSchedule.placeId}" showPleaseSelect="true"/> 
			</select> 
	    </div>
	  </div>
	   <div class="form-group form-inline">
	    <label for="placeDate" class="col-sm-3 control-label">场地日期</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control layer-date laydate-icon" id="placeDate" name="placeDate" data-options="required:true" value="${hotelSchedule.placeDate}"  />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="placeSchedule" class="col-sm-3 control-label">场地档期</label>
	     <div class="col-sm-9">
	     	<select class="form-control"  id="placeSchedule" name="placeSchedule"  style="width: 180px;">
	     		<c:if test="${empty hotelSchedule.id }">
					<tags:dict sql="SELECT id, name FROM hui_category where kind='SCHEDULETIME'" selectedValue="${hotelSchedule.placeSchedule}" showPleaseSelect="true" addBefore="ALL,全部" />
	     		</c:if>
	     		<c:if test="${not empty hotelSchedule.id }">
					<tags:dict sql="SELECT id, name FROM hui_category where kind='SCHEDULETIME'" selectedValue="${hotelSchedule.placeSchedule}" showPleaseSelect="true"  />
	     		</c:if>
			</select>
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

