<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<div class="row">
		<div class="col-sm-12">
			<div class="ibox float-e-margins" style="border: none">
                   <div class="" style="position: relative;">
                   		<a href="javascript:loadHotelContent(this,'${ctx}/base/hotel/menu/index','');" class="btn btn-warning" style="position: absolute;right: 10px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
                       <h3>${action }餐饮菜单信息</h3>
                        <hr/>
                   </div>
                   <div class="ibox-content" style="border: none">
                   	<div class="row">
						<div class="col-sm-12">
							<form id="hotelMenuSubForm" method="post" action="${ctx}/base/hotel/menu/save"  class="form-horizontal m-t" ><!--   -->
							  <input type="hidden" name="id" id="id" value="${hotelMenu.id}" />
							   <input type="hidden" name="hotelName" id="hotelName" value="${hotelMenu.hotelName}" />
							    <c:if test="${not empty mhotel }">
							  	  	<input type="hidden" name="hotelId" id="hotelId" value="${mhotel.id}" />
							  	  </c:if>
								 <c:if test="${empty mhotel }">
								  <div class="form-group form-inline">
								    <label for="hotelId" class="col-sm-2 control-label">所属场地</label>
								     <div class="col-sm-10">
								     	<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
							     			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="hotelId" textTarget="hotelName">
												<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel " selectedValue="${hotelMenu.hotelId}" showPleaseSelect="true"/>
											</select> 
										</c:if>
										<c:if test="${aUs.getCurrentUserType() eq 'partner' }">
											<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="hotelId" textTarget="hotelName">
												<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id=${aUs.getCurrentUserCompanyId() }" selectedValue="${hotelMenu.hotelId}" showPleaseSelect="true"/>
											</select> 
										</c:if>
								    </div>
								  </div>
								  </c:if>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">菜单名称</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="name" data-options="required:true" value="${hotelMenu.name}" aria-required="true" aria-invalid="false" class="valid" />
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">价格</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="price" data-options="required:true" value="${hotelMenu.price}" aria-required="true" aria-invalid="false" class="valid" />
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">介绍</label>
								     <div class="col-sm-10">
								     	<textarea class="form-control" name="introduction" style="width: 600px;height: 100px;" >${hotelMenu.introduction}</textarea>
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">备注</label>
								     <div class="col-sm-10">
								     	<textarea class="form-control" name="memo" style="width: 600px;height: 80px;">${hotelMenu.memo}</textarea>
								    </div>
								  </div>
								   
								  <c:if test="${not empty  hotelMenu.id}">
									<div class="form-group form-inline">
								   	 <label  class="col-sm-2 control-label">菜单详情</label>
								     <div class="col-sm-10">
								     		<div style="padding: 5px 0;">
								     			<a qx="hotelmenu:update" href="${ctx}/base/hotel/menu/detail/create/${hotelMenu.id}" width="600" target="dialog" class="btn btn-primary btn-sm" title="菜单详情"><span class="glyphicon glyphicon-pencil"> </span> 添加菜单详情</a>
								     		</div>
								  			<table id="hotelMenuDetail_table" data-toggle="table" data-height="660" data-query-params="hotelMenuDetail_queryParams"
												data-pagination="true" data-url="${ctx}/base/hotel/menu/detail/list?search_EQ_menuId=${hotelMenu.id}" data-data-type="json">
											    <thead>
											        <tr>
														<th data-field="name">菜名</th>
														<th data-field="price">价格</th>
														<th data-field="createDate">创建时间</th>
														<th data-formatter="fm_hotelMenuDetail_operate">操作</th> 
											        </tr>
											    </thead>
											</table>
								 		</div>
								 		<script>
											function hotelMenuDetail_queryParams(params){
												return $.extend({},params,util.serializeObject($('#hotelMenuDetail_searchForm')));
											}
											function hotelMenuDetail_search(){
												$("#hotelMenuDetail_table").bootstrapTable("refresh");
											}
											function fm_hotelMenuDetail_operate(value,row, index){
												return '<button type="button" onclick="hotelMenuDetail_del_fun(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
											}
											function hotelMenuDetail_del_fun(id){
												swal({
											        title: "您确定要删除这条信息吗",
											        text: "删除后将无法恢复，请谨慎操作！",
											        type: "warning",
											        showCancelButton: true,
											        confirmButtonColor: "#DD6B55",
											        confirmButtonText: "删除",
											        cancelButtonText: "取消",
											        closeOnConfirm: false,
											        showLoaderOnConfirm: true
											    }, function (isConfirm)  {
											    	if (isConfirm) {
											    		parent.show();
											   	     	$.post('${ctx}/base/hotel/menu/detail/delete/'+id, "", function (res, status) { 
											   	     		if(status=="success"&&res.statusCode=="200"){
											   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
											   	     			hotelMenuDetail_search();
											   	     		}else{
											   	     			swal(res.message, "error");
											   	     		}
											   	     		parent.hide();
											   	     	}, 'json');
													} else {
														swal("已取消", "您取消了删除操作！", "error")
													}
											    });
												
											}
											$(function(){
												$("#hotelMenuDetail_table").bootstrapTable();
											});
										</script>
								  	</div>
								  </c:if>
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
<script>
$().ready(function() {
	$('.selectpicker').selectpicker();
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#hotelMenuSubForm").validate({
        rules: {
        	hotelId: "required",
        	name: "required",
        	price: "required"
        },
        messages: {
        	hotelId: e + "请选择所属场地",
        	name: e + "请输入菜单名称",
        	price: e + "请输入价格"
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				swal(res.message, "success");
       　				loadHotelContent(this,'${ctx}/base/hotel/menu/index','');
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

