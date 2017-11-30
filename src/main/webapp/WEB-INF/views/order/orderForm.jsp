<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<c:set var="url" value="${ctx}${OFFTAG eq 'OFFLINE'?'/base/order/offline/check/index':'/base/order/index' }"></c:set>
<link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
<link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
<style>
.display-flex {
	display: flex;
	justify-content: space-between;
}

.num {
	width: 16px;
	height: 16px;
	border: 1px solid #999999;
	background-color: #f5f5f5;
	font-style: normal;
	line-height: 16px;
	text-align: center;
}

.room-num {
	text-align: center;
	width: 50px;
	min-width: 50px;
	height: 16px;
	line-height: 18px;
}

.bg-none-00 {
	font-size: 1rem;
}

.full {
	text-align: left;
}

.btn-sel-hotel {
	background-color: #019FEA;
	color: #ffffff;
	padding: 0.2rem 0.8rem;
	font-size: 0.85rem;
	min-width: 4.2rem;
	text-align: center;
}

.help-block {
	display: inline-block;
}

.form-control {
	display: inline-block;
}
.pad-10{padding:10px;}
.pad-10-k{padding:10px 30px;}
.pad-5{padding:5px;}
.pad-ud-5{padding:5px 0;}
.pad-ud2-5{padding:2.5px 0;}
.pad-lr-5{padding:0 5px;}
.pad-lr-10{padding:0 10px;}
.pad-lr-20{padding:0 20px;}
.pad-lr-25{padding:0 25px;}
.pad-lr-30{padding:0 30px;}

.pad-no{padding:0;}
.bottom-line{border-bottom: 1px solid #ddd;}

.mgn-5{margin:5px;}
.mgn-ud-5{margin:5px 0;}
.showRemark{background-image: url('${ctx}/static/resource/css/images/showRemark.png');background-repeat: no-repeat; }
.hideRemark{background-image: url('${ctx}/static/resource/css/images/hideRemark.png');background-repeat: no-repeat; }
.btn-icon{width:20px; height:20px;cursor: pointer;}
.col-lft{padding: 5px 0 5px 15px;}
.col-rgt{padding: 5px 15px 5px 0;}
.laydate_m{width: 100px;}
</style>
<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12" style="position: relative;">
				<a href="javascript:loadContent(this,'${url}','')" class="btn btn-warning" style="position: absolute;right: 10px;margin-top: 5px;top: 7px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
				<h3>订单信息</h3>
				<hr>
			</div>
		</div>
		<form id="form" action="${ctx}/weixin/order/offline/save">
			<div class="row">
				<div class="col-sm-4" style="color:#019FEA;font-weight: bold;margin: 6px 0;">
					预定场地名称：<span id="hotelname">${order.hotelName}</span>
					<a id="btn-sel-hotel" href="${ctx}/base/hotel/select/index" target="dialog" class="btn btn-primary" title="选择场地" width="1000"> 选择场地</a>
				</div>
				<div class="col-sm-2">
				</div>
			</div>
			<div class="row">
				<div id="detail_content" class="col-sm-12" style="">
					
				</div>
			</div>
			
			<!-- 其他费用 详情 -->
			<div class="row">
				<div class="col-sm-12" style="">
					<div class="row">
						<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">其他费用</span></div>
					</div>
					<div class="row other">
						<div class="col-sm-12" style="padding: 10px 30px 5px;">
							<!-- 其他费用 详情 -->
							<div class="row other">
								<div class="col-sm-12 other-item" style="padding: 10px 30px 5px;">
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" style="padding: 0 30px;">
									<div class="row bottom-line">
			                            <div class="col-md-9">
												<div style="padding: 0.2rem 0;">
													 <div style="width: 100%;padding:0.2rem 0;">
														 <span class="btn add other-add" style="">添加</span>
													 </div>
												</div>
			            		          </div>
			                            <div class="col-md-3" style="text-align: right;margin: 0.8rem 0;">合计：<span  id="allOtherPrice" style="color: red;"><fmt:formatNumber type="currency" value="${order.otherAmount}"/></span></div>
			                        </div>
								</div>
								<script type="text/javascript">
									$(function(){
										$(".other-edit").click(function(){
											$this = $(this);
											$this.parent().parent().hide();
											$this.parent().parent().next().show();
											$this.parent().addClass('edit');
										});
										
										$(".other-cancel").click(function(){
											$this = $(this);
											$this.parent().parent().hide();
											$this.parent().parent().prev().show();
											$this.parent().removeClass('edit');
										});
										
										$(".other-del").click(function(){
											$this = $(this);
											$this.parent().parent().parent().remove();
											//$this.parent().removeClass('edit');
											calculateOtherPrice();
										});
										
										$('.oprice').keyup(function(){	
											var $otherItem = $(this).parent();
											var oprice = $(this).val()*1;
											var oquantity = $otherItem.find('.oquantity').val()*1;
											$otherItem.find('.otherprice').val(oprice*oquantity);
											calculateOtherPrice();
										});
										$('.oquantity').keyup(function(){	
											var $otherItem = $(this).parent();
											var oquantity =$(this).val()*1;
											var oprice = $otherItem.find('.oprice').val()*1;
											$otherItem.find('.otherprice').val(oprice*oquantity);
											calculateOtherPrice();
										});
										
										$('.other-add').click(function(){
											var oitem = $("#other_fee_item").text();
											var $otherItem = $(oitem);
											$otherItem.delegate('.other-del','click',function(){	
												$otherItem.remove();
											});
											$otherItem.delegate('.oprice','keyup',function(){	
												var oprice = $(this).val()*1;
												var oquantity = $otherItem.find('.oquantity').val()*1;
												$otherItem.find('.otherprice').val(oprice*oquantity);
												calculateOtherPrice();
											});
											$otherItem.delegate('.oquantity','keyup',function(){	
												var oquantity =$(this).val()*1;
												var oprice = $otherItem.find('.oprice').val()*1;
												$otherItem.find('.otherprice').val(oprice*oquantity);
												calculateOtherPrice();
											});
											$(".other-item").append($otherItem);
										});
									});
									
									function calculateOtherPrice(){
										 var allOtherPrice =0.00;
										 var sumOtherPrice =0.00;
										 $('.otherprice').each(function(){
											 if($(this).val()){
												 sumOtherPrice+=$(this).val()*1;
											 }
										 });
										 allOtherPrice = sumOtherPrice;
										 //$("#sumOtherPrice").text("￥"+common.formatCurrency(sumOtherPrice));
										 $("#allOtherPrice").text("￥"+common.formatCurrency(allOtherPrice));
										 //$("#other_amount_dv").text("￥"+common.formatCurrency(allOtherPrice));
										 sumALLprice();
									}
								</script>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 费用合计 -->
			<div class="row">
				<div class="col-sm-12" >
					<div style="background-color: #f5f5f5;padding: 10px;margin: 10px 0;font-weight: bold;">
						<div class="row pad-ud-5">
							<div class="col-sm-6 " style="text-align: right;">
								场地费用：<span id="hall_amount_dv" style="">￥0.00</span>
							</div>
							<div class="col-sm-6" style="text-align: right;">
								总计：<span id="amount_dv" style="">￥0.00</span>
							</div>
						</div>
						<div class="row pad-ud-5">
							<div class="col-sm-6" style="text-align: right;">
								住房费用：<span id="room_amount_dv" style="">￥0.00</span>
							</div>
							<div class="col-sm-6" style="text-align: right;">
								已付订金：<span id="pay_amount_dv" style="">￥0.00</span>
							</div>
						</div>
						<div class="row pad-ud-5">
							<div class="col-sm-6" style="text-align: right;">
								用餐费用：<span id="meal_amount_dv" style="">￥0.00</span>
							</div>
							<div class="col-sm-6" style="text-align: right;">
								剩余尾款：<span id="finsh_amount_dv" style="">￥0.00</span>
							</div>
						</div>
						<div class="row pad-ud-5">
							<div class="col-sm-6" style="text-align: right;">
								其他费用：<span id="other_amount_dv" style="">￥0.00</span>
							</div>
							<div class="col-sm-6" style="text-align: right;">
								
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 基本信息  -->
			<div class="row">
				<div class="col-sm-12" style="">
					<div class="row">
						<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">基本信息</span></div>
					</div>
					<div class="row other">
						<div class="col-sm-12" style="padding: 10px 30px 5px;">
							 <div class="form-group bottom-line pad-ud-5">
							    <label for="activityTitle" class="col-sm-1 control-label col-lft">活动名称：</label>
							     <div class="col-sm-11 pad-no">
							     	<input type="text" class="form-control" name="activityTitle" data-options="required:true" value="${order.activityTitle}" style="width:200px;" placeholder="活动名称"/>
							    </div>
							  </div>
							  <div class="form-group bottom-line pad-ud-5">
							    <label for="activityDate" class="col-sm-1 control-label col-lft">活动时间：</label>
							     <div class="col-sm-11 pad-no">
							     	<input type="text" class="form-control layer-date laydate-icon" id="activityDate" name="activityDate" data-options="required:true" value="${order.activityDate}" style="width:200px;" placeholder="活动时间"/>
							    </div>
							  </div>
							  <div class="form-group bottom-line pad-ud-5">
							    <label for="organizer" class="col-sm-1 control-label col-lft">主办单位：</label>
							     <div class="col-sm-11 pad-no">
							     	<input type="text" class="form-control" name="organizer" data-options="required:true" value="${order.organizer}" style="width:200px;" placeholder="主办单位"/>
							    </div>
							  </div>
							  
							  <div class="form-group pad-ud-5">
							    <label for="linkman" class="col-sm-1 control-label col-lft">联系方式：</label>
							     <div class="col-sm-11 pad-no">
							     	<input type="text" class="form-control" name="linkman" data-options="required:true" value="${order.linkman}" style="width:200px;" placeholder="联系人"/>
							     	<input type="text" class="form-control" name="contactNumber" data-options="required:true" value="${order.contactNumber}" style="width:200px;" placeholder="联系电话"/>
							     	<input type="text" class="form-control" name="email" data-options="required:true" value="${order.email}" style="width:200px;" placeholder="联系邮箱"/>
							     	
							    </div>
							  </div>
							  
							<%-- <div class="pad-ud-5 bottom-line">
								<div class="row">
									<div class="col-sm-1 col-lft" style="padding-right: 0;">主办单位：</div>
									<div class="col-sm-2 col-rgt" style="padding-left: 0;"><input type="text" name="organizer" value="${order.organizer}" ></div>
								</div>
							</div>
							<div class="pad-ud-5">
								<div class="row">
									<div class="col-sm-1" style="padding-right: 0;">联系方式：</div>
									<div class="col-sm-5 display-flex " style="padding-left: 0;">
										<input type="text" name="linkman" value="${order.linkman}" >
										<input type="text" name="contactNumber" value="${order.contactNumber}" >
										<input type="email" name="email" value="${order.email}" >
									</div>
								</div>
							</div> --%>
						</div>
					</div>
				</div>
			</div>
			<!-- 订单备注 -->
			<div class="row">
				<div class="col-sm-12" style="">
					<div style="border-top:1px solid #cccccc;padding: 0 15px;">
						<div style="margin:0.8rem 0;">
							<div style="font-weight:bold;font-size: 0.85rem;">
								<div class="memo-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;float: left;"></div>
								<div class="remark_opt" style="display: none;float: left;margin: 10px 10px;">
									<img qx="order:update" onclick="memoShow('order_memo')" title="修改备注" id="order_memo" 
										src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" class="btn-icon">
						 			<img qx="order:update" onclick="memoCancel('order_memo_cancel')" title="取消修改备注" id="order_memo_cancel" 
										src="${ctx}/static/weixin/css/icon/common/icon-order-edit-cancel.png" class="btn-icon" style="display: none;">
								</div>
								<div style="clear: both;"></div>
							</div>
						</div>
						<div class="Remark" style="">
							<div id="memoEdit" style="margin:0.8rem 0;">
								<script type="text/plain" id="memo"  name="memo" style="height: 400px;">${order.memo}</script>
							</div>
							<div id="memoDetail" style="margin:1rem 0;padding:0 1rem;">
								${order.memo}
							</div>
							<script type="text/javascript">
								function memoShow(id){
									$("#"+id).hide();
									$("#order_memo_cancel").show();
									$("#memoEdit").show();
									$("#memoDetail").hide();
								}
								function memoCancel(id){
									$("#"+id).hide();
									$("#order_memo").show();
									$("#memoDetail").show();
									$("#memoEdit").hide();
								}
								var memo_editor = new UE.ui.Editor({
						            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
						            toolbars:[],
						            //focus时自动清空初始化时的内容
						            autoClearinitialContent:true,
						            //关闭字数统计
						            wordCount:false,
						            //关闭elementPath
						            elementPathEnabled:false,
						            //默认的编辑区域高度
						            initialFrameHeight:150
						        });
								memo_editor.render("memo");
						    </script>
						</div>
					</div>
				</div>
			</div>
			
			<div id="commission_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
				<div qx="order:add" id="btn_submit" class="btn btn-lg bg-type-01" style="width:40%;margin:0 auto;border-radius:3px;">确认提交</div>
			</div>
			<input type="hidden" id="hotelId" name="hotelId">
		</form>
		<script>	
			var o = document.getElementById('date');
			$(function(){
				common.pms.init();
				dict.init();
				//$("#btn-sel-hotel").click();
				
				var $form = $('#form');
				$form.validate({
					rules:{
						chkhallid:"required",
						ismain:"required",
						activityTitle:"required",
						activityDate:"required",
						organizer:"required",
						linkman:"required",
						contactNumber:"required"
					},
					messages:{
						chkhallid:"请选择会场",
						ismain:"请选择主会场",
						activityTitle:"请输入活动名称",
						activityDate:"请输入活动时间",
						organizer:"请输入主办单位",
						linkman:"请输入联系人姓名",
						contactNumber:"请输入联系电话"
					}
				});
				$("#btn_submit").click(function(){
				    if($form.valid && !$form.valid()){
						return;
					}
					var data = $form.serialize();
					show();
					$.post($form.attr('action'),data,function(res){
						if(res.statusCode==='200'){
							swal('提交成功！','success');
							 setTimeout(function(){
								 /* if('${OFFTAG}'==='OFFLINE'){
								 	loadContent(this,'${ctx}/base/order/offline/check/index','RD');
								 }else{
								 }  */
							 	loadContent(this,'${ctx}/base/order/index','RD');
							 },1500);
						}else{
							swal(res.message,'error');
							
						}
						hide();
					},'json');
					
				});
				
			});
			
			function loadDetailContent(hotelId){
				$("#detail_content").load('${ctx}/weixin/order/items/index/'+hotelId,function(){
					$("#detail_content").undelegate();
					
					
					/*          场地              */
					$("#detail_content").delegate('.hall-check','click',function(){	
						$this = $(this);
						selectedHall('hall',$this);
					});
					
					$("#detail_content").delegate('.hall-add-schedule','click',function(){	//
						var $this = $(this);
						var placeId = $this.attr("hallId");
						var schedule_item_index = $('#scheduleidx'+placeId).val()*1;
						var crt_item_index = schedule_item_index;
						schedule_item_index++;
						var schdl_item = $('#hall_schedule_item').text().split('{{id}}').join(placeId);
						var $hall_schedule=$(schdl_item);
						$hall_schedule.find('.date').on("input",function(){
						    if($(this).val().length>0){
							   $(this).addClass("full");
							}else{
							  $(this).removeClass("full");
						  	}
						 });
						$hall_schedule.find('.selectpicker').selectpicker(); 
						$hall_schedule.find('.selectpicker').on('show.bs.select', function (e) {
							var hotelId = $("#hotelId").val();
							var $this = $(this);
							var hallId = $this.attr("hallid");
							var idx = $this.attr("idx");
							var scheduleDate = $this.parent().parent().prev().val();
							if(!scheduleDate){
								return false;
							}
							 $.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:hallId,scheduleDate:scheduleDate},function(res){
									if(res.statusCode==='200'){
										var k =0;
										for(var i=0;i<res.object.length;i++){
											var pschedule = res.object[i].placeSchedule;
											var price  = res.object[i].onlinePrice;
											var state =  res.object[i].state;
											$this.find('option').each(function(){
												var $self = $(this);
												if($self.val()==pschedule){
													$self.attr("price",price);
													if(state==='2'){
														$self.prop('disabled', true);
														k++;
													}else{
														$self.prop('disabled', false);
													}
												}
											});
											$this.attr("price",price);
										}
										$this.selectpicker("refresh"); 
									}else{
										swal(res.message,'success');
									} 
								},"json");
						});
						
						$hall_schedule.find('.selectpicker').on('changed.bs.select', function (e) {
							var $this = $(this);
							var hallId = $this.attr("hallid");
							var price = $this.attr("price");
							var schtimes = $this.val();
							var sumprice = 0;
							if(schtimes!=null){
								if(schtimes.length===4){
									sumprice  = price*3;
								}else{
									sumprice  = price*schtimes.length;
								}
							}
							$this.parent().prev().val((schtimes+"").split(',').join('#'));
							$this.parent().parent().next().val(sumprice);
							calculateHallSchedulePrice();
						});
						$hall_schedule.delegate('.order-del','click',function(){
							$hall_schedule.remove();
							calculateHallSchedulePrice();
						});
						$this.parent().before($hall_schedule);
					});
					$("#detail_content").delegate('.order-del','click',function(){
						$(this).parent().parent().remove();
						calculateHallSchedulePrice();
					});
					
					
					/*         住房                   */
					
					$("#detail_content").delegate('.room-check','click',function(){	
						$this = $(this);
						selectedHall('room',$this);
					});
					$("#detail_content").delegate('.minus','click',function(){	
						$this = $(this);
						var num = $this.next().find('input').val()*1;
						if(num*1>0){
							var cnum = num-1;
							$this.next().find('input').val(cnum);
						}else{
							
						}
						calculateRoomSchedulePrice();
					});
					
					$("#detail_content").delegate('.plus','click',function(){	
						$this = $(this);
						var num = $this.prev().find('input').val()*1;
						var cnum = num+1;
						$this.prev().find('input').val(cnum);
						calculateRoomSchedulePrice();
					});
					
					$("#detail_content").delegate('.room-add-schedule','click',function(){	//
						var $this = $(this);
						var placeId = $this.attr("roomId");
						var schdl_item = $('#room_schedule_item').text().split('{{id}}').join(placeId);
						var $room_schedule=$(schdl_item);
						$room_schedule.find('.date').on("input",function(){
						    if($(this).val().length>0){
							   $(this).addClass("full");
							}else{
							  $(this).removeClass("full");
						  	}
						 });
						
						 $room_schedule.delegate('.room-schedule-del','click',function(){	
							$room_schedule.remove();
							calculateRoomSchedulePrice();
						}); 
						$this.parent().before($room_schedule);
					});
					$("#detail_content").delegate('.room-schedule-del','click',function(){
						var $this = $(this);
						$this.parent().parent().remove();
						calculateRoomSchedulePrice();
					});
					
					
					/*          用餐                  */
					$("#detail_content").delegate('.meal-check','click',function(){	
						$this = $(this);
						selectedHall('meal',$this);
					});
				
					$("#detail_content").delegate('.meal-minus','click',function(){	
						$this = $(this);
						var num = $this.next().find('input').val()*1;
						if(num*1>0){
							var cnum = num-1;
							$this.next().find('input').val(cnum);
						}else{
							
						}
						calculateMealSchedulePrice();
					});
					
					$("#detail_content").delegate('.meal-plus','click',function(){	
						$this = $(this);
						var num = $this.prev().find('input').val()*1;
						var cnum = num+1;
						$this.prev().find('input').val(cnum);
						calculateMealSchedulePrice();
						
					});
					$("#detail_content").delegate('.meal-add-schedule','click',function(){	//
						var $this = $(this);
						var placeId = $this.attr("mealId");
						var schdl_item = $('#meal_schedule_item').text().split('{{id}}').join(placeId);
						var $meal_schedule=$(schdl_item);
						$meal_schedule.find('.date').on("input",function(){
						    if($(this).val().length>0){
							   $(this).addClass("full");
							}else{
							  $(this).removeClass("full");
						  	}
						 });
						$meal_schedule.delegate('.meal-schedule-del','click',function(){	//
							$meal_schedule.remove();
							calculateMealSchedulePrice();
						});
						$this.parent().before($meal_schedule);
					});
					
					$("#detail_content").delegate('.meal-schedule-del','click',function(){	//
						var $this = $(this);
						$this.parent().parent().remove();
						calculateMealSchedulePrice();
					});
					hide();
				});
				
			}
			
			
			function selectedHall(type,$this){
				if("hall"===type){
					var placeId = $this.attr("hallId");
					if($this.hasClass('item-un-checked')){
						$this.parent().parent().parent().addClass('check');
						$this.removeClass('item-un-checked').addClass('item-checked');
						$this.text('已选定');
						$("#chkhallid"+placeId).attr("checked","checked"); 
					}else{
						$this.parent().parent().parent().removeClass('check')
						$this.removeClass('item-checked').addClass('item-un-checked');
						$this.text('选定');
						$("#chkhallid"+placeId).removeAttr("checked"); 
					}
					calculateHallSchedulePrice();
				}else if("room"===type){
					var placeId = $this.attr("roomId");
					if($this.hasClass('item-un-checked')){
						$this.parent().parent().parent().addClass('check');
						$this.removeClass('item-un-checked').addClass('item-checked');
						$this.text('已选定');
						$("#chkroomid"+placeId).attr("checked","checked"); 
					}else{
						$this.parent().parent().parent().removeClass('check')
						$this.removeClass('item-checked').addClass('item-un-checked');
						$this.text('选定');
						$("#chkroomid"+placeId).removeAttr("checked"); 
					}
					calculateRoomSchedulePrice();
				}else if("meal"===type){
					var mealId = $this.attr("mealId");
					
					if($this.hasClass('item-un-checked')){
						$this.parent().parent().parent().addClass('check');
						$this.removeClass('item-un-checked').addClass('item-checked');
						$this.text('已选定');
						$("#chkmealid"+mealId).attr("checked","checked"); 
					}else{
						$this.parent().parent().parent().removeClass('check')
						$this.removeClass('item-checked').addClass('item-un-checked');
						$this.text('选定');
						$("#chkmealid"+mealId).removeAttr("checked"); 
					}
					
					calculateMealSchedulePrice();
				}
				
			}
			
			
			function setMain(self){
				$this = $(self);
			}
		</script>
		<script type="text/javascript">
		$(function(){
			$("#btn-sel-hotel").click();
			var activityDate={elem:"#activityDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
			laydate(activityDate);
			remarkDisplay();
			
			$(".memo-btn").click(function(){
				var crtclass = $(this).hasClass("hideRemark");
				if(crtclass){
					$(this).removeClass("hideRemark");
					$(this).addClass("showRemark");
					$(this).parent().parent().next().hide();
					$(this).next().hide();
				}else{
					$(this).removeClass("showRemark");
					$(this).addClass("hideRemark");
					$(this).parent().parent().next().show();
					$(this).next().show();
				}
			});
			
		});
		
		function remarkDisplay(){
			$("#memoEdit").hide();
		}
		function sumALLprice(){
			  
			var sumMealSchedulePrice = 0.00;
			var allMealSchedulePrice = 0.00;
			 var mealServiceFeeRate = $("#mealServiceFeeRate").val()*1;
			$('.check .mealschedulePrice').each(function() {
				if ($(this).val()) {
					 var num =  $(this).parent().prev().find('input').val()*1;
					sumMealSchedulePrice += $(this).val() * 1 * num;
				}
			});
			allMealSchedulePrice = sumMealSchedulePrice*(1+mealServiceFeeRate/100);
			
			var sumRoomSchedulePrice = 0.00;
			var allRoomSchedulePrice = 0.00;
			$('.check .roomschedulePrice').each(function() {
				if ($(this).val()) {
					var num = $(this).parent().prev().find("input").val()*1;
					sumRoomSchedulePrice += $(this).val() * 1 * num;
				}
			});
			allRoomSchedulePrice = sumRoomSchedulePrice;
			
			var sumHallSchedulePrice = 0.00;
			var commissionFeeRate = $("#commissionFeeRate").val() * 1;
			var allHallSchedulePrice = 0.00;
			$('.check .hallschedulePrice').each(function() {
				if ($(this).val()) {
					sumHallSchedulePrice += $(this).val() * 1;
				}
			});
			allHallSchedulePrice = sumHallSchedulePrice * (1 + commissionFeeRate / 100);
			
			 var sumOtherPrice =0.00;
			 $('.otherprice').each(function(){
				 if($(this).val()){
					 sumOtherPrice+=$(this).val()*1;
				 }
			 });
			var amount = allHallSchedulePrice + allRoomSchedulePrice+allMealSchedulePrice+sumOtherPrice;
			
			$("#finsh_amount_dv").text("￥"+common.formatCurrency(amount));
			$("#pay_amount_dv").text("￥"+common.formatCurrency(0));
			$("#amount_dv").text("￥"+common.formatCurrency(amount));
			
			$("#hall_amount_dv").text("￥"+common.formatCurrency(allHallSchedulePrice));
			$("#room_amount_dv").text("￥"+common.formatCurrency(allRoomSchedulePrice));
			$("#meal_amount_dv").text("￥"+common.formatCurrency(allMealSchedulePrice));
			$("#other_amount_dv").text("￥"+common.formatCurrency(sumOtherPrice));
			
		}
		
		</script>
<!--其他费用小项  -->
<script id="other_fee_item" type="text/html">
	<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: rgb(153, 153, 153);">
		<div class="col-sm-3 pad-no">
			其他小项 :<input type="text" class="form-control" id="" name="otherdetail" placeholder="消费明细" style="width: 200px;display: inline-block;" value="">
		</div>
		<div class="col-sm-2 pad-no">
			单价： <input type="number" id="" name="oprice" class="form-control oprice" placeholder="单价" min="0" style="width: 100px;display: inline-block;" value="0">元
		</div>
		<div class="col-sm-2 pad-no">
			数量： <input type="number" id="" name="oquantity" class="form-control oquantity" placeholder="数量" min="0" style="width: 100px;display: inline-block;" value="1">
		</div>
		<div class="col-sm-2 pad-no">
			总计： <input type="number" id="" name="otherprice" class="form-control otherprice" placeholder="总计" min="0" style="width: 100px;display: inline-block;" value="00" readonly="readonly">
		</div>
		<div class="col-sm-1 pad-no" style="margin: 6px 0;">
			<img class="other-del" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="width:20px;height:20px;display: inline-block;cursor: pointer;" title="删除该项">
		</div>
	</div>
</script>


</div>
