<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
$().ready(function() {
	$('.selectpicker').selectpicker();
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#placePriceSubForm").validate({
        rules: {
        	hotelId: "required",
        	placeType: "required",
        	placeId: "required",
        	placeSchedule: "required",
        	onlinePrice: "required",
        	offlinePrice: "required"
        },
        messages: {
        	hotelId: e + "请选择所属场地编号",
        	placeType: e + "请选择场地类型",
        	placeId: e + "请选择场地编号",
        	placeSchedule: e + "请输入场地档期",
        	onlinePrice: e + "请输入线上价格",
        	offlinePrice: e + "请输入线下价格"
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				placePrice_search();
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
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
		url += 'SELECT id,hotel_name as name FROM hui_hotel where state = \'1\'';
	}else if("HALL"===val){
		url += 'SELECT id,place_name as name FROM hui_hotel_place where state = \'1\' and place_type =\'HALL\' and hotel_id='+hotelId;
	}else if("ROOM"===val){
		url += 'SELECT id,place_name as name FROM hui_hotel_place where state = \'1\' and place_type =\'ROOM\' and hotel_id='+hotelId;
	}
	
	$.get(url, function (res, status) { 
		var str = '';
		if(status=="success"){
			str = pls;
			$.each(res, function(i, item){
				str+='<option value="'+item.value+'">'+item.text+'</option>';
			});
			
			$("#placeId").html(str);
			$("#placeId").selectpicker('refresh');
		}
	}, 'json');
}
$(function(){
	 var fplaceSchedule={elem:"#fplaceSchedule",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	 laydate(fplaceSchedule);
});
</script>
<div class="modal-body"> 
  
<form id="placePriceSubForm" method="post" action="${ctx}/base/hotel/price/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${placePrice.id}" />
  <input type="hidden" name="hotelName" id="hotelName" value="${placePrice.hotelName}" />
  <input type="hidden" name="placeName" id="placeName" value="${placePrice.placeName}" />
	  <div class="form-group form-inline">
	    <label for="hotelId" class="col-sm-3 control-label">所属场地编号</label>
	     <div class="col-sm-9">
	     	<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="hotelId"  name="hotelId"  style="width: 180px;" refval="value" reftext="text" textTarget="hotelName" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel " selectedValue="${placePrice.hotelId}" showPleaseSelect="false"  addBefore=",全部"/>
			</select>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">场地类型</label>
	     <div class="col-sm-9">
	     	<select class="form-control" name="placeType"  style="width: 180px;" onchange="loadPlace(this.value)">
				<tags:dict sql="SELECT val, name FROM hui_category where kind='PLACETYPE' and val!='HOTEL'"  selectedValue="${placePrice.placeType}" showPleaseSelect="false" addBefore=",全部"  />
			</select>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">场地编号</label>
	     <div class="col-sm-9">
	     	<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="placeId" name="placeId" refval="value" reftext="text" textTarget="placeName" style="width: 180px;">
     			<c:if test="${not empty placePrice.placeId }">
					  <tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place where place_type='HALL' and hotel_id=${placePrice.hotelId}" selectedValue="${placePrice.placeId}" showPleaseSelect="true"/> 
     			</c:if>
			</select> 
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="fplaceSchedule" class="col-sm-3 control-label">场地档期</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control layer-date laydate-icon" id="fplaceSchedule" name="placeSchedule" data-options="required:true" value="${placePrice.placeSchedule}"  />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">线上价格</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="onlinePrice" data-options="required:true" value="${placePrice.onlinePrice}"  />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">线下价格</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="offlinePrice" data-options="required:true" value="${placePrice.offlinePrice}"  />
	    </div>
	  </div>
	  
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">备注</label>
	     <div class="col-sm-9">
	     	<textarea class="form-control" name="memo">${placePrice.memo}</textarea>
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

