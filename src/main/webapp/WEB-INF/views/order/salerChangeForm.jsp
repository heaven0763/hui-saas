<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#orderSaleChangeForm").validate({
        rules: {
        	saleId:"required"
        },
        messages: {
        	saleId:e + "请选择接手销售"
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				loadContent(this,'${ctx}/base/order/detail/${order.id}','');
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
    });
});
</script>
<form id="orderSaleChangeForm" method="post"
	action="${ctx}/base/order/orderSaleChangeSave" class="form-horizontal m-t">
	<!--   -->
	<div class="modal-body">
		<input type="hidden" name="orderId" id="orderId" value="${order.id}" /> 
		<div class="form-group form-inline">
			<label for="nickname" class="col-sm-3 control-label">原销售</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="username"
					name="username" placeholder="用户账号" value="${osale.rname}-${osale.mobile}"
					aria-required="true" aria-invalid="false" class="valid"
					readonly="readonly">
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="nickname" class="col-sm-3 control-label">更改销售</label>
			<div class="col-sm-9">
				<select class="form-control"  data-live-search="true"  id="saleId" name="saleId"  data-width="auto" data-size="10" >
					<option value="">全部</option>
					<c:forEach items="${sales}" var="sale">
						<option value="${sale.id }">${sale.rname }</option>
					</c:forEach>
				</select>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" id="close_btn"
			data-dismiss="modal">
			<span class="glyphicon glyphicon-off"></span> 关闭
		</button>
		<button type="submit" class="btn btn-primary">
			<span class="glyphicon glyphicon-save"></span> 保存
		</button>
	</div>
</form>
