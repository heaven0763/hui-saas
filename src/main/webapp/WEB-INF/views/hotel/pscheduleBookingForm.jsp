<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
<!--
.arr-down{background-image: url('${ctx}/static/weixin/css/icon/common/arrow-down.png');background-position: 90% 50%;background-repeat: no-repeat;background-size:20px; }
-->
</style>
<div class="modal-body"> 
	<form id="form_booking" action="${ctx}/weixin/schedulebooking/place/booking/save" method="post" class="form-horizontal m-t" style="">
		<input type="hidden" id="hotelId" name="hotelId" value="${hall.hotelId }">
		<input type="hidden" id="placeId" name="placeId" value="${hall.id }">
		<div class="form-group form-inline" style="">
			<label for="hotelName" class="col-sm-3 control-label">预定场地</label>
	     	<div class="col-sm-9">
				<input class="form-control" name="hotelName" type="text" style="" value="${hall.hotelName}——${hall.placeName }" readonly="readonly"/>
			</div>
		</div>
		
		
		<div class="form-group form-inline" style="">
			<label for="placeDate" class="col-sm-3 control-label">销售人员</label>
	     	<div class="col-sm-9">
				<input class="form-control" name="username" type="text" style="" value="${sale }" readonly="readonly"/>
			</div>
		</div>
		
		<div class="form-group form-inline" style="">
			<label for="placeDate" class="col-sm-3 control-label">预定日期</label>
	     	<div class="col-sm-9">
				<input class="form-control" id="placeDate" name="placeDate" type="date" style="" value="${placeDate}"/>
			</div>
		</div>
		<div class="form-group form-inline" style="">
			<label for="placeDate" class="col-sm-3 control-label">预定档期</label>
	     	<div class="col-sm-9">
				<div class="timesolt" style="width: 180px;position: relative;" tabindex="1" hallid="${hall.id }">
					<input type="hidden" id="scheduleTime" name="scheduleTime" value="">   
					<input type="hidden" id="scheduleTimeTxt" name="scheduleTimeTxt" value="">   
					<div id="scheduleTimeTxtdv" style="width: 100%;height:35px; border: 1px solid #ccc; border-radius: 4px;line-height: 35px;" class="arr-down"  >
						<span  class="timesolt-text" style="height:35px;line-height: 35px;padding: 0 5px;">  请选择</span>
						<!-- <i class="" style="    font-size: 3em;"></i> -->
					</div>
					<div  class="timesolt-item" tabindex="2" style="position: absolute;left: 0;top: 35px;background-color: #ffffff;width:100%;display: none;z-index: 2000;">
						<c:forEach items="${ctimes}" var="ctme">
							<div style="width: 100%;height:30px; border: 1px solid #999999;">
								<label for="timesolt_${ctme.id}" style="width:100%;line-height:30px;vertical-align:middle;">
									<input class="timesolt-select-item" id="timesolt_${ctme.id}" type="checkbox" name="timesolt" value="${ctme.id}"  style="margin:9px;" data="${ctme.name}" ${ctme.name eq bookingRecordModel.placeSchedule?'checked="checked"':''}>
									${ctme.name}
								</label>
							</div>
						</c:forEach>
						<div style="width:100%;height:30px;border:1px solid #999999;">
							<label for="timesolt_all" style="width:100%;line-height:30px;vertical-align:middle;">
								<input class="timesolt-select-item timesolt_all" id="timesolt_all" type="checkbox" name="timesolt" value="ALL" style="margin:9px;" data="全天" >
								全天
							</label>
						</div>
						<div style="width:100%;height:40px;border:1px solid #999999;text-align: center;padding: 5px;">
							<button type="button"  class="btn btn-primary btn-sm timesolt-select"  style="width: 40%;"  >确定</button>
							<button type="button"  class="btn btn-default btn-sm timesolt-cancel"  style="width: 40%;"  >取消</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="form-group form-inline" style="">
			<label for="activityTitle" class="col-sm-3 control-label">活动名称</label>
	     	<div class="col-sm-9">
				<input class="form-control required" id="input-mobile" name="activityTitle" type="text" style=""/>
			</div>
		</div>
		<div class="form-group form-inline" style="">
			<label for="company" class="col-sm-3 control-label">公司名称</label>
	     	<div class="col-sm-9">
				<input class="form-control required" name="company" type="text" style=""/>
			</div>
		</div>
		<div class="form-group form-inline" style="">
			<label for="linkman" class="col-sm-3 control-label">客户姓名</label>
	     	<div class="col-sm-9">
				<input class="form-control required" name="linkman" type="text" style=""/>
			</div>
		</div>
		<div class="form-group form-inline" style="">
			<label for="mobile" class="col-sm-3 control-label">手机号码</label>
	     	<div class="col-sm-9">
				<input class="form-control required cellPhone" id="input-mobile" name="mobile" type="text" style="" maxlength="11"/>
			</div>
		</div>
		<div class="form-group form-inline" style="">
			<label for="email" class="col-sm-3 control-label">联系邮箱</label>
	     	<div class="col-sm-9">
				<input class="form-control required" id="input-email" name="email" type="email" style=""/>
			</div>
		</div>
		 <div class="modal-footer">
			<button type="button" class="btn btn-default" id="book_close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
			<a qx="schedulebooking:add" id="btn_booking" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 我要BOOKING</a>
		</div>
	</form>
	<script>
		$(function(){
			common.ctx =  '${ctx}';
			var $form = $('#form_booking');
			$form.validate();
			$('#btn_booking').click(function(){
				common.submitForm($form,function(res){
					 swal('提交成功！','success');
					 setTimeout(function(){
						 $("#book_close_btn").click();
						 var dates =$("#placeDate").val().split('-');
						 var date = new Date(dates[0],dates[1]*1-1,dates[2]);
						 setCommonWeek(date);
						 scheduleBooking_search();
					 },1500);
		         },function(res){
		        	 swal(res.message,'error');
		         });
			});
			
			
			$(".timesolt").focus(function(){
				var $this = $(this);
				var tabindex = $this.attr('tabindex');
				//$this.attr('tabindex',-1);
				//$this.css("height","240px");
				var hallId = $this.attr("hallid");
				var scheduleDate =$('input[name="placeDate"]').val();
				var hotelId = '${order.hotelId}';
				var scheduleTime = $("#scheduleTime").val();
				$.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:hallId,scheduleDate:scheduleDate},function(res){
					if(res.statusCode==='200'){
						var k =0;
						for(var i=0;i<res.object.length;i++){
							var id='#'+res.object[i].id;
							$this.find('input[id="timesolt_'+res.object[i].placeSchedule+'"]').attr("price",res.object[i].onlinePrice);
							if(res.object[i].state==='2'&&res.object[i].orderNo!='${order.orderNo}'){
								$("#timesolt_"+res.object[i].placeSchedule).attr("disabled","disabled");
								k++;
							}
							if(scheduleTime.indexOf(res.object[i].placeSchedule)>=0){
								$("#timesolt_"+res.object[i].placeSchedule).attr("checked","checked"); 
							}
						}
						
						if(k!=0){
							$this.find('input[id="timesolt_all"]').attr("disabled","disabled");
						}
						
						$this.find('.timesolt-item').show();
					}else{
						swal(res.message,'success');
					} 
				},"json");
				
			});
			/* 
			$(".timesolt-item").focus(function(){
				$('.timesolt-item').show();
			});
			$(".timesolt").blur(function(){
				var $this = $(this);
				setTimeout(function(){
					$this.find('input[type="checkbox"]').removeAttr("checked"); 
					$('input[name="scheduleTimeTxt"]').val('');
					$('input[name="scheduleTime"]').val('');
					$('#scheduleTimeTxtdv').text('');
					$this.find('.timesolt-item').hide();
				},300)
				
				
			}); */
			$(".timesolt-cancel").click(function(){
				$('.timesolt-item').hide();
			});
			$(".timesolt-select").click(function(){
				var $this = $(this);
				$this.attr('tabindex',1);
				$this.parent().parent().hide();
				var sles = [];
				var slestxt = [];
				var hallId = $this.attr('hallId');
				var n = 0;
				var sumPrice = 0;
				$this.parent().parent().find('input[type="checkbox"]:checked').each(function(){
					var $self = $(this);
					if($self.val()!='ALL'){
						sles.push($self.val());
						slestxt.push($self.attr('data'));
						n++;
					}
				});
				$this.parent().parent().prev().text(slestxt.join(','));
				$('input[name="scheduleTimeTxt"]').val(slestxt.join(','));
				$('input[name="scheduleTime"]').val(sles.join('#'));
			});
			
			$(".timesolt-select-item").change(function(){
				var $this = $(this);
				if($this.val()=='ALL'&&$(this).attr("checked")){
					$this.parent().parent().parent().find('input[type="checkbox"]').attr("checked","checked"); 
				}else if($this.val()=='ALL'&&!$(this).attr("checked")){
					$this.parent().parent().parent().find('input[type="checkbox"]').removeAttr("checked"); 
				}else if(!$(this).attr("checked")){
					$this.parent().parent().parent().find('.timesolt_all').removeAttr("checked"); 
				}
				
			});
		});
	</script>
</div>