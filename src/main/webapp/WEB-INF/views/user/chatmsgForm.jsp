<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
$().ready(function() {
	$('.selectpicker').selectpicker();
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#messageSubForm").validate({
        rules: {
        	msgType: "required",
        	rutype: "required",
        	msg: "required"
        },
        messages: {
        	msgType: e + "请选择信息类型",
        	rutype: e + "请选择接收人员类型",
        	msg: e + "请输入信息内容"
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				chatmsg_search();
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
    });
	
});
function selrutype(self){
	var $this = $(self);
	console.log($this.val());
	var val = $this.val();
	if(val==='1'){
		$("#msg-group").hide();
		$("#msg-user").hide();
		$("#msg-site").hide();
	}else if(val==='2'){
		$("#msg-group").show();
		$("#msg-user").hide();
		$("#msg-site").hide();
	}else if(val==='3'){
		$("#msg-group").hide();
		$("#msg-user").show();
		$("#msg-site").hide();
	}else if(val==='4'){
		$("#msg-group").hide();
		$("#msg-user").hide();
		$("#msg-site").show();
	}
}
</script>
<div class="modal-body"> 
  
<form id="messageSubForm" method="post" action="${ctx}/base/user/msg/send"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="" />
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">信息类型</label>
	     <div class="col-sm-9">
	     	<select class="form-control"  id="msgType" name="msgType">
				<tags:dict sql="SELECT val id,name as name FROM hui_category where kind ='MSGTYPE' "  showPleaseSelect="true"/>
			</select>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">接收人员类型</label>
	     <div class="col-sm-9">
	     	<div class="radio radio-info radio-inline">
                <input type="radio" id="rutype1" name="rutype" value="1" onchange="selrutype(this);">
                <label for="rutype1"> 全部 </label>
            </div>
            <div class="radio radio-info radio-inline">
                <input type="radio" id="rutype2" name="rutype" value="2" onchange="selrutype(this);">
                <label for="rutype2"> 按角色 </label>
            </div>
             <div class="radio radio-info radio-inline">
                <input type="radio" id="rutype3" name="rutype" value="3" onchange="selrutype(this);">
                <label for=rutype3> 按个人 </label>
            </div>
            <c:if test="${aUs.getCurrentUserType() eq 'HUI' || groupMap.isgroupadministrator }">
              	<div class="radio radio-info radio-inline">
	                <input type="radio" id="rutype4" name="rutype" value="4" onchange="selrutype(this);">
	                <label for="rutype4"> 按场地 </label>
	            </div>
            </c:if>
	    </div>
	  </div>
	  <c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
		<div id="msg-group" class="form-group form-inline" style="display: none;">
			<label for="groupId" class="col-sm-3 control-label">角色</label>
			 <div class="col-sm-9">
			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" data-title="请选择"
				id="groupId" name="groupId" multiple="multiple">
				<tags:dict sql="select id , name  from hui_group where 1=1 " showPleaseSelect="fasle" addBefore="0,全部" />
			</select>
			</div>
		</div>
		<div id="msg-user" class="form-group form-inline" style="display: none;">
			<label for="groupId" class="col-sm-3 control-label">用户</label> 
			 <div class="col-sm-9">
			<select	class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" data-title="请选择"
				id="userId" name="userId" multiple="multiple">
				<tags:dict sql="select id , rname  from hui_user where 1=1 " showPleaseSelect="fasle" addBefore="0,全部" />
			</select>
			</div>
		</div>
		<div id="msg-site" class="form-group form-inline" style="display: none;">
			<label for="hotelId"  class="col-sm-3 control-label">场地</label> 
			 <div class="col-sm-9">
			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" data-title="请选择"
				 id="hotelId" name="hotelId" multiple="multiple">
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel " showPleaseSelect="fasle" addBefore="0,全部" />
			</select>
			</div>
		</div>
		</c:if>
		 <c:if test="${aUs.getCurrentUserType() eq 'HOTEL' }">
		<div id="msg-group" class="form-group form-inline" style="display: none;">
			<label for="groupId" class="col-sm-3 control-label">角色</label>
			 <div class="col-sm-9">
			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" data-title="请选择"
				id="groupId" name="groupId" multiple="multiple">
				<tags:dict sql="select id , name  from hui_group where 1=1 AND pid=12" showPleaseSelect="fasle" addBefore="0,全部" />
			</select>
			</div>
		</div>
		<div id="msg-user" class="form-group form-inline" style="display: none;">
			<label for="groupId" class="col-sm-3 control-label">用户</label> 
			 <div class="col-sm-9">
			<select	class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" data-title="请选择"
				id="userId" name="userId" multiple="multiple">
				<tags:dict sql="select id , rname  from hui_user where 1=1 and hotel_id=${aUs.getCurrentUserHotelId() }" showPleaseSelect="fasle" addBefore="0,全部" />
			</select>
			</div>
		</div>
		<c:if test="${groupMap.isgroupadministrator}">
		<div id="msg-site" class="form-group form-inline" style="display: none;">
			<label for="hotelId"  class="col-sm-3 control-label">场地</label> 
			 <div class="col-sm-9">
			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" data-title="请选择"
				 id="hotelId" name="hotelId" multiple="multiple">
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where pid =${aUs.getCurrentUser().getPhtlid()} " showPleaseSelect="fasle" addBefore="0,全部" />
			</select>
			</div>
		</div>
		</c:if>
		</c:if>
		<div class="form-group form-inline">
		    <label for="title" class="col-sm-3 control-label">标题</label>
		     <div class="col-sm-9">
		     	<input type="text" class="form-control" name="title" data-options="required:true" value="" />
		    </div>
	  	</div>
		<div class="form-group form-inline">
		    <label for="groupId" class="col-sm-3 control-label">信息内容</label>
		     <div class="col-sm-9">
		     	<textarea type="text" class="form-control" name="msg" data-options="required:true" style="width: 100%;" rows="10"></textarea>
		    </div>
	  	</div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 发送</button>
</div>
</form>
</div>

