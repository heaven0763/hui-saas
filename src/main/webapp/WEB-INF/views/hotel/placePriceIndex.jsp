<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>场地价格管理</h3>
	<hr>
    <link href="${ctx}/static/weixin/css/place.price.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
   <div class="row">
		<div class="col-sm-12" style="position: relative;">
    <style type="text/css">
		.date-icon-left, .date-icon-right {
		    background-repeat: no-repeat;
		    background-size: 13px;
		}
		.icon-search{ background-repeat: no-repeat;background-size: 20px;width: auto;cursor: pointer;}
		.date-icon-left {
		    display: table-cell;
		    width: 20px;
		    height: 34px;
		    line-height: 34px;
		    cursor: pointer;
		}
		.date-icon-right {
		    display: table-cell;
		    width: 20px;
		    height: 34px;
		    line-height: 34px;
		    cursor: pointer;
		}
		.icon-close{cursor: pointer;}
		.date-icon-checked{background-size:28px; }
		.date-picker-ct-one{cursor: pointer;}
		.pagination li a{cursor: pointer;}
	</style>
    		
 	<div style="">
 			
 	    <div class="common-ct-inner" style="">
 	 	   <div style="font-size:0;margin:0.5rem auto;padding:0 2%;width:96%;">
				<div class="btn btn-md bg-type-01 btn-plain" onOrOff="on" style="width:45%;margin-right:5%;">系统销售价格调整</div>
				<div class="btn btn-md bg-none-00 btn-plain" onOrOff="off" style="width:45%;margin-left:5%;">线下合作销售价格调整</div>
			</div>
			<div class="input-date-parent" style="">
				<div style="display: inline-block;vertical-align: middle;">
	  			<div id="month-icon-left" class="date-icon-left" style="float: left;">&nbsp;</div>
	   			<input type="month" id="date_year_month" class="form-control"  style="float: left;width: 180px;"  /> 
	   			<div id="month-icon-right" class="date-icon-right" style="float: left;">&nbsp;</div>
	   			<div style="clear: both;"></div>
	   			</div>
	   			<div  style="display: inline-block;vertical-align: middle;">
	   				<form id="form_list_params">
		   				<c:if test="${aUs.getHotelUserType() eq 'HUI' }">
							<label for="city">城市</label>
							<select class="form-control selectpicker" data-live-search="true" data-width="200px" data-size="10"   id="area" name="city"  >
					     		<tags:dict sql="SELECT id id,region_name name FROM hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
							</select>
					   		<label for="hotelId">场地</label>
					   		<select class="form-control selectpicker" data-live-search="true" data-width="200px" data-size="10" id="sch_hotelId" name="hotelId"  style="width: 180px;" onchange="getHallList();">
								<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="false" addBefore=",全部"/>
							</select> 
							<label for="splaceId">会场</label>
					   		<select class="form-control selectpicker" data-live-search="true" data-width="200px" data-size="10"   id="splaceId" name="placeId" refval="value" reftext="text"  style="width: 180px;">
					   			<tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place where place_type='HALL'" showPleaseSelect="false" addBefore=",全部"/>
							</select>
						</c:if>
						<c:if test="${aUs.getHotelUserType() eq 'GROUP' }">
							<label for="city">城市</label>
							<select class="form-control selectpicker" data-live-search="true" data-width="200px" data-size="10"   id="area" name="city"  >
					     		<tags:dict sql="SELECT id id,region_name name FROM hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
							</select>
					   		<label for="hotelId">场地</label>
					   		<select class="form-control selectpicker" data-live-search="true" data-width="200px" data-size="10" id="sch_hotelId" name="hotelId"  style="width: 180px;" onchange="getHallList();">
								<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where pid=${aUs.getCurrentUserhotelPId() }"  showPleaseSelect="false" addBefore=",全部"/>
							</select> 
							<label for="splaceId">会场</label>
					   		<select class="form-control selectpicker" data-live-search="true" data-width="200px" data-size="10"   id="splaceId" name="placeId" data-none-selected-text="请选择..."  style="width: 180px;">
							</select>
						</c:if>
						<c:if test="${aUs.getHotelUserType() eq 'HOTEL' }">
						
							<label for="splaceId">会场</label>
					   		<select class="form-control selectpicker" data-live-search="true" data-width="200px" data-size="10"   id="splaceId" name="placeId" refval="value" reftext="text"  style="width: 180px;">
					   			<tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place where place_type='HALL' and hotel_id=${aUs.getCurrentUserHotelId()}" showPleaseSelect="false" addBefore=",全部"/>
							</select>
						</c:if>
					
						 <input type="hidden" id="search_EQ_placeSchedule" name="searchDates" />
					 	 <input type="hidden" id="onOrOff" name="onOrOff" value="on"/>
					 </form>
	   			</div>
	   			<button id="btn_search" class="btn btn-primary"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	   		</div>
  		</div>	
  		
  		
  		<div style="width:100%;text-align:center;font-size:0.75rem;color:#666666;height:1.8rem;line-height:1.8rem;">
  				<div style="border-bottom:0.15rem solid #cccccc;width:96%;padding:0 2%;">
   					<div style="width:20%;float:left;"></div>
	  				<div style="display:table;width:80%;color:#000000;height:20px;line-height:20px;font-weight: bold;padding: 5px 0;float:right;">
		    			<div style="display:table-cell;width:5%;">&nbsp;</div>
		    			<div style="display:table-cell;width:12.85%;">日</div>
		    			<div style="display:table-cell;width:12.85%;">一</div>
		    			<div style="display:table-cell;width:12.85%;">二</div>
		    			<div style="display:table-cell;width:12.85%;">三</div>
		    			<div style="display:table-cell;width:12.85%;">四</div>
		    			<div style="display:table-cell;width:12.85%;">五</div>
		    			<div style="display:table-cell;width:12.85%;">六</div>
		    			<div style="display:table-cell;width:5%;">&nbsp;</div>
		    		</div>
	    		</div>
	    	
	   			<div style="border-bottom:0.15rem solid #cccccc;width:96%;padding:0 2%;">
	   				<div style="width:20%;float:left;"></div>
		    		<div id="date_switch_tab" style="display:table;width:80%;float:right;">
		    			<div class="date-icon-left" style="display:table-cell;width:5%;cursor: pointer;">&nbsp;</div>
		    			<div class="date-day-num" day="6" style="display:table-cell;width:12%;font-weight: bold;">6</div>
		    			<div class="date-day-num" day="7" style="display:table-cell;width:12%;font-weight: bold;">7</div>
		    			<div class="date-day-num" day="8" style="display:table-cell;width:12%;font-weight: bold;">8</div>
		    			<div class="date-day-num" day="9" style="display:table-cell;width:12%;font-weight: bold;">9</div>
		    			<div class="date-day-num" day="10" style="display:table-cell;width:12%;font-weight: bold;">10</div>
		    			<div class="date-day-num" day="11" style="display:table-cell;width:12%;font-weight: bold;">11</div>
		    			<div class="date-day-num" day="12" style="display:table-cell;width:12%;font-weight: bold;">12</div>
		    			<div class="date-icon-right" style="display:table-cell;width:5%;cursor: pointer;">&nbsp;</div>
		    		</div>
	   				<div style="clear:both;"></div>	
	   			</div>
	    		
	    		<div id="list_div_parent" >
	    		</div>
	    		<div style="margin-right: 50px;text-align: right;">
						<div class="pull-left pagination-detail" style="margin: 20px 0;">
							<span class="pagination-info">显示第 1 到第 10 条记录，总共 121 条记录</span>
							<span class="page-list">
								每页显示 
								<span class="btn-group dropup">
									<button type="button" class="btn btn-default  dropdown-toggle" data-toggle="dropdown">
										<span class="page-size">10</span> <span class="caret"></span>
									</button>
									<ul class="dropdown-menu" role="menu">
										<li class="active" page-size="10"><a href="javascript:void(0)">10</a></li>
										<li page-size="25"><a href="javascript:void(0)">25</a></li>
										<li page-size="50"><a href="javascript:void(0)">50</a></li>
										<li page-size="100"><a href="javascript:void(0)">100</a></li>
									</ul>
								</span> 
								条记录
							</span>
							<span>
								（PS:请点击数字修改价格）
							</span>
						</div>
						<ul class="pagination"></ul> 
	    		</div>
	    		
	 		</div>
 	</div>
	 
 	<div id="mask_div" class="mask-div" style="display:none;"></div>
 	<div id="place_date_price_div" class="div-tips-dialog" style="top:35%;left:35%;padding:1rem 2%;width:500px;display:none;">
 		<form id="form_place_date_price_list" class="form_place_date_price_list" style="display:none;">
 			<input type="hidden" id="search_EQ_placeId" name="search_EQ_placeId"  />
 			<input type="hidden" id="search_GTE_onlinePrice"  name="search_GTE_placeSchedule"  />
 			<input type="hidden" id="search_LTE_onlinePrice" name="search_LTE_placeSchedule"  />
 			
 		</form>
 		<div style="position: relative;">
			<div class="place_date_title" style="text-align:left;"> 会议厅 </div>
			<div id="place_date_close" class="icon-close" style="position: absolute;top: 0;right: 0rem;">&nbsp;</div>
		</div>
 		
 		<div style="height:2rem;line-height:2rem;margin-top:1rem;display:flex;justify-content:space-between;">
 			<div class="date-icon-left" style="display:table-cell;width:5%;">&nbsp;</div>
 			<div style="font-size:1rem;"><span class="place_year_month">2017年1月</span><span class="place_date_month" >January</span></div>
 			<div class="date-icon-right" style="display:table-cell;width:5%">&nbsp;</div>
 		</div>
 	
 		<div style="display:flex;justify-content:space-between;font-size:0.75rem;width:95%;margin:0.5rem; auto;">
 			<div class="date-picker-week-one" style="">Sun</div>
 			<div class="date-picker-week-one" style="">Mon</div>
 			<div class="date-picker-week-one" style="">Tue</div>
 			<div class="date-picker-week-one" style="">Wed</div>
 			<div class="date-picker-week-one" style="">Thu</div>
 			<div class="date-picker-week-one" style="">Fri</div>
 			<div class="date-picker-week-one" style="">Sat</div>
 		</div>
 	
 		<div class="date-picker-ct">
 		
 		</div>
 	
 		<div qx="hotelprice:add" id="btn_batch_update_price" class="btn btn-lg bg-type-01" style="margin:1.3rem 0 1rem 0;">一键修改价格</div>
 	</div>
 	<div id="place_price_adjust_div" class="div-tips-dialog" style="top:35%;left:30%;padding:10px 20px;width:600px;display:none;text-align:left;">
 		<form id="form_place_price_adjust" action="${ctx}/weixin/hotel/price/adjust/save"  method="post" >
 		<input type="hidden" id="adjust_price_id" name="search_EQ_placeId" />
 		<input type="hidden" id="adjust_price_type" name="price_type" />
 		<!-- <input type="hidden" id="adjust_price_start_day" name="search_GTE_placeSchedule" />
 		<input type="hidden" id="adjust_price_end_day" name="search_LTE_placeSchedule" /> -->
 		<div class="place_date_title" style="text-align:left;line-height: 1.5rem;">
 			<div id="btn_adjust_price_back" class="date-icon-left"  style="float:left;width:5%;">&nbsp;</div>
 			<div style="float:left;color: 5f5f5f;font-size: 16px;vertical-align: top;line-height: 34px;font-weight: bold;">修改金额</div>
 			<div id="btn_adjust_price_close" class="icon-close"  style="float:right;">&nbsp;</div>
 			<div style="clear: both;"></div>
 		</div>
 		<div style="color:#019FEA;margin-top:1rem;">原来价格：￥<span id="adjust_price_old">12564</span></div>
 		<div style="border-bottom: 1px solid #f5f5f5; padding: 5px 0;">
	 		<span style="vertical-align: middle;">修改日期：</span>
	 		<input type="date" id="adjust_price_start_day" name="search_GTE_placeSchedule" class="form-control" style="width: 200px;display: inline-block;"/><!-- style="width:31%;height:1.5rem;line-height:1.5rem;" -->
	 		<span style="vertical-align: middle;">&nbsp;~&nbsp;</span>
	 		<input type="date" id="adjust_price_end_day" name="search_LTE_placeSchedule" class="form-control"  style="width: 200px;display: inline-block;"/>
 		
 		<!-- <span id="adjust_zh_year_month">2017年01月</span> -->
 		</div>
 		<div style="">
 			<span>修改价格：</span>
		</div>
		<div style="">
			<div style="display:flex;justify-content:space-between;font-size:0.75rem;width:95%;margin:0.5rem; auto;margin-left: 3%;border-bottom: 1px solid #f5f5f5;padding: 5px 0;">
 			<div class="date-picker-week-one" style="text-align: center;background-color: #019FEA;">Sun</div>
	 			<div class="date-picker-week-one" style="text-align: center;background-color: #019FEA;">Mon</div>
	 			<div class="date-picker-week-one" style="text-align: center;background-color: #019FEA;">Tue</div>
	 			<div class="date-picker-week-one" style="text-align: center;background-color: #019FEA;">Wed</div>
	 			<div class="date-picker-week-one" style="text-align: center;background-color: #019FEA;">Thu</div>
	 			<div class="date-picker-week-one" style="text-align: center;background-color: #019FEA;">Fri</div>
	 			<div class="date-picker-week-one" style="text-align: center;background-color: #019FEA;">Sat</div>
	 		</div>
	 		<div style="display:flex;justify-content:space-between;font-size:0.75rem;width:95%;">
	 			<div style="color: #999999;width: 2rem;height: 2rem; line-height: 2rem;"><input  type="number" name="sun"  value="0" min="0" class="" style="width: 70px;"/></div>
	 			<div style="color: #999999;width: 2rem;height: 2rem; line-height: 2rem;"><input  type="number" name="mon"  value="0" min="0" class="" style="width: 70px;"/></div>
	 			<div style="color: #999999;width: 2rem;height: 2rem; line-height: 2rem;"><input  type="number" name="tue"  value="0" min="0" class="" style="width: 70px;"/></div>
	 			<div style="color: #999999;width: 2rem;height: 2rem; line-height: 2rem;"><input  type="number" name="wed"  value="0" min="0" class="" style="width: 70px;"/></div>
	 			<div style="color: #999999;width: 2rem;height: 2rem; line-height: 2rem;"><input  type="number" name="thu"  value="0" min="0" class="" style="width: 70px;"/></div>
	 			<div style="color: #999999;width: 2rem;height: 2rem; line-height: 2rem;"><input  type="number" name="fri"  value="0" min="0" class="" style="width: 70px;"/></div>
	 			<div style="color: #999999;width: 2rem;height: 2rem; line-height: 2rem;"><input  type="number" name="sat"  value="0" min="0" class="" style="width: 70px;"/></div>
	 		</div>
		</div>
 		<!-- <div style="margin-left:5%;">
 			<input id="adjust_price" type="number" name="adjust_price"  value="" style="-webkit-box-shadow:inset 0 0 1px #ffd1d1;width:85%;padding:0 5%;height:2rem;line-height:2rem;font-size:1.2rem;background-color:#F5F3F3;border:none;outline: none;"/>
 			
 		</div> -->
 		<div qx="hotelprice:add" id="btn_adjust_price_sumit" class="btn btn-lg bg-type-01" style="width:90%;margin:0 auto;margin-top:1rem;margin-bottom:1rem;;">确认修改</div>
 		</form>
 	</div>
 	<input type="hidden" id="adjust_curt_date" name="adjust_curt_date" value="${_currDayOfMonth}" />
 	
 	<div id="suc_tips_div" class="div-tips-dialog" style="top:30%;left:35%;padding:10px 2%;width:400px;text-align:left;display:none;">
 		<div class="place_date_title" style="text-align:center;line-height: 1.5rem;padding: 0.5rem;">
 			<div style="color: #000000;font-size: 1rem;vertical-align: top;">修改金额</div>
 		</div>
 		<div style="padding: 0.8rem;">
 			您的价格变动信息已提交，我们将在一个工作日内完成审批，如有特殊情况，将及时与您联系，感谢您的使用。
 		</div>
 		<div style="text-align: right;padding: 0.8rem;">
 			<div id="priceCalendar" style="color:#019FEA; " >返回价格日历界面</div>
 		</div>
 	</div>

<%-- <script type="text/javascript" src="${ctx}/public/bootstrap/js/bootstrap-paginator.js"></script> --%>
<script src="${ctx}/static/weixin/myjs/place.date.switch.js"></script>
<script src="${ctx}/static/weixin/myjs/place.price.date.js"></script>
<script>
var currPlacePriceDate;
var pager ;
var price_page = 1;
var price_crt_page = 1;
var price_rows = 10;
common.ctx = '${ctx}';
$(function(){
	dict.init();
	common.pms.init();
	$('.selectpicker').selectpicker();
	$('#area').on('changed.bs.select', function (event, clickedIndex, newValue, oldValue) {
			var area = $('#area').val();
			
			var url ='${ctx}/framework/dictionary/trslCombox?sql=SELECT id,hotel_name as name FROM hui_hotel where 1=1';
			if(area){
				url +=' and city='+area;
			}

			var type= '${aUs.getHotelUserType()}';
			if(type==="GROUP"){
				var pid = "${aUs.getCurrentUserhotelPId() }";
				if(pid){
					url +=' and pid='+pid;
				}
			}
		    $.ajax({
		        url: url,
		        type: "get",
		        dataType: "json",
		        success: function (data) {
		        	var options = [];
		        	options.push("<option value=''>请选择</option>");
		            $.each(data, function (i) {
		            	options.push("<option value=" + data[i].value + ">" + data[i].text + "</option>");
		            });
		            $('#sch_hotelId').html(options.join(''));
		            $('#sch_hotelId').selectpicker('refresh');
		        },
		        error: function (data) {
		            //alert("查询学校失败" + data);
		        }
		    });
	});
	 
	template.config('escape', false);
	template.helper('update_class', function(update_date){
		return update_date? 'last-modify' : '';
	});
	
	var $date_switch_tab = $('#date_switch_tab');
	template.helper('fm_price', function(item){
		var resHtml = [];
		var price_index = 0;
		$date_switch_tab.find('.date-day-num').each(function(){
			var $this = $(this);
			if(!$this.text()){
				resHtml.push('<div class="" style="display:table-cell;width:12%;cursor: pointer;">&nbsp;</div>');
			}else{
				resHtml.push('<div class="'+ (item['update_date_'+price_index]? 'last-modify' : '') +'" style="display:table-cell;width:12%;cursor: pointer;">'+item['price_'+price_index]+'</div>');
				price_index++;
			}
			
		});
		
		return resHtml.join('');
	});
	
	currPlacePriceDate = new placePriceDate({
		initCallBack : function(){
			currPlacePriceDate.options.$dom_ct.find('.date-picker-ct-one').click(function(){//单个价格修改
				var $this = $(this);
				if(!$this.attr('date')){
					return;
				}
				if($this.attr('date')<=$('#adjust_curt_date').val()){
					swal("今天之前的价格不可修改！", "error");
					return ;
				}
				$('#adjust_price_id').val($('#search_EQ_placeId').val());
				$('#adjust_price_start_day').val($this.attr('date'));
				$('#adjust_price_end_day').val($this.attr('date'));
				
				$('#adjust_zh_year_month').html($this.attr('date').replace('-','年').replace('-','月')  + '日');
				$('#adjust_price_old').html($this.find('.date-picker-ct-money').html());
				
				currPlacePriceDate.hide();
				$('#mask_div').show();
				$('#place_price_adjust_div').show();
				
				$('#adjust_price').val('');
			});
		}
	});
	
	var $date_year_month = $('#date_year_month');
	schedule_data_num = 7;
	initDateSwitchTab($date_year_month,$date_switch_tab,datechageCallBack);
	
	

	$('#btn_search').click(function(){
		searchCallBack();
		price_search();
	});
	
	$('[onOrOff]').click(function(){
		$('[onOrOff]').removeClass('bg-type-01').addClass('bg-none-00');
		var $this = $(this);
		$this.removeClass('bg-none-00').addClass('bg-type-01');
		$('#onOrOff').val($this.attr('onOrOff'));
		price_search();
	});
	
	//$('#btn_search').click();
	AjaxPaginator($(".pagination"));
	$('#btn_batch_update_price').click(function(){	//一键修改价格
		//$('#adjust_curt_date').val()
		$('#adjust_price_id').val($('#search_EQ_placeId').val());
		var dfd=$('#search_GTE_onlinePrice').val();
		var date = new Date(dfd);
		var curtDate = new Date();
		var firstDateOfMonth = new Date(date.getFullYear(),date.getMonth() ,1);
		
		if(date.getFullYear()===curtDate.getFullYear()&&curtDate.getMonth()===date.getMonth()){
			firstDateOfMonth = new Date(curtDate.getFullYear(),curtDate.getMonth(),curtDate.getDate()+1);
		}
		$('#adjust_price_start_day').val(common.formatDate(firstDateOfMonth));
		$('#adjust_price_end_day').val($('#search_LTE_onlinePrice').val());
		
		$('#adjust_zh_year_month').html(currPlacePriceDate.options.$place_year_month.html());
		$('#adjust_price_old').html(currPlacePriceDate.options.$dom_ct.find('[date]:first').find('.date-picker-ct-money').html());
		
		
		currPlacePriceDate.hide();
		$('#mask_div').show();
		$('#place_price_adjust_div').show();
		$('#adjust_price').val('');
	});
	
	$('#btn_adjust_price_sumit').click(function(){	//确定修改
		/* if(!$('#adjust_price').val()){
			//toastFn('请输入价格！');
			swal("请输入价格！", "error");
			return;
		} */
		show(99998);
		
		common.submitForm($('#form_place_price_adjust'),function(res){
		 	$('#place_price_adjust_div').hide();
	 		$("#suc_tips_div").show();
			var onOrOff = $("#adjust_price_type").val();
			var pstdays = $("#adjust_price_start_day").val().split('-');
			var stday = pstdays[2]*1;
			var edday = ($("#adjust_price_end_day").val().split('-'))[2]*1;
	 		var placeId = $("#search_EQ_placeId").val();
			var placeSchedule = pstdays[0]+"-"+pstdays[1];
			var list = [];
			for(var n=stday;n<=edday;n++){
				var ctday = n<10?'0'+n:n;
				var pprice = { "placeSchedule":placeSchedule+"-"+ctday , "onlinePrice":0, "offlinePrice":0 };
				var ajprice = getAJprice(pprice.placeSchedule);
				if("off"===onOrOff){
					pprice.offlinePrice=ajprice;
				}else{
					pprice.onlinePrice=ajprice;
				}
				list.push(JSON.stringify(pprice));
			}
		    common.setstorage('tmp_price_'+placeId+"_"+placeSchedule,"["+list.join(',')+"]");
		    currPlacePriceDate.setData(list,onOrOff); 
		    hide();
		},function(){
			swal(res.message, "error");
			 hide();
		});
	});
	$('#mask_div').click(function(){
		currPlacePriceDate.hide();
		$('#place_price_adjust_div').hide();
		$("#suc_tips_div").hide();
	});
	
	$('#btn_adjust_price_back').click(function(){	//修改金额界面返回
		$('#place_price_adjust_div').hide();
		currPlacePriceDate.show();
	});
	$("#month-icon-left").click(function(){
		var date = $("#date_year_month").val();
		var vdate=date.split('-');
		var newdate = new Date(vdate[0],vdate[1] -2,1);
		var mon = (newdate.getMonth()*1+1);
		var nmonth = newdate.getFullYear()+"-"+(mon>9?mon:"0"+mon);
		$("#date_year_month").val(nmonth);
		setCommonWeek(newdate);
	});
	$("#month-icon-right").click(function(){
		var date = $("#date_year_month").val();
		var vdate=date.split('-');
		var newdate = new Date(vdate[0],vdate[1],1);
		var mon = (newdate.getMonth()*1+1);
		var nmonth = newdate.getFullYear()+"-"+(mon>9?mon:"0"+mon);
		$("#date_year_month").val(nmonth);
		setCommonWeek(newdate);
	});
	$("#btn_adjust_price_close").click(function(){
		currPlacePriceDate.hide();
		$('#place_price_adjust_div').hide();
	});
	
	$("#place_date_close").click(function(){
		currPlacePriceDate.hide();
		$('#place_price_adjust_div').hide();
	});
	$("#priceCalendar").click(function(){
		$("#suc_tips_div").hide();
		currPlacePriceDate.show();
	});
	
	
	$(".pagination-detail ul li").click(function(){
		price_rows = $(this).attr("page-size");
		AjaxPaginator($(".pagination"));
	});
});
	function getAJprice(datestr){
		var date = new Date(datestr.replace(/-/g, "/"));
		var day = date.getDay();
		var price = 0;
		
		switch(day){
		case 0:
			price = $("input[name='sun']").val();
			break;
		case 1:
			price = $("input[name='mon']").val();
			break;
		case 2:
			price = $("input[name='tue']").val();
			break;
		case 3:
			price = $("input[name='wed']").val();
			break;
		case 4:
			price = $("input[name='thu']").val();
			break;
		case 5:
			price = $("input[name='fri']").val();
			break;
		case 6:
			price = $("input[name='sat']").val();
			break;
		}
		return price;
	}
	function datechageCallBack(){
		
	}
	
	function searchCallBack(){
		var $date_year_month = $('#date_year_month');
		var $date_switch_tab = $('#date_switch_tab');
		var dateStrArray = [];
		$date_switch_tab.find('.date-day-num').each(function(){
			var $this = $(this);
			if(!$this.text()){
				return true;
			}
			var day = $this.text().length < 2? '0'+$this.text() : $this.text();
			dateStrArray.push($date_year_month.val() + '-' + day);
		});
		$('#search_EQ_placeSchedule').val(dateStrArray.join(','));
	}

	
	function price_search(page, rows) {
		searchCallBack();
		page = page || 1;
		rows = rows || 10;
		var data = $.extend({page:page,rows : rows}, common.serializeObject($('#form_list_params')));
		show();
		$.ajax({
			url : '${ctx}/weixin/hotel/price/list', //点击分页提交当前页码
			data : data,
			success : function(res) {
				hide();
				if (res != null) {//DOM操作
					fillSetDate(res)
					var fir = (res.currtPage-1)*price_rows+1
					var end = (res.currtPage-1)*price_rows+res.rows.length;
					paginationDetail(fir,end,res.total,price_rows);
				}else{
					paginationDetail(1,0,0,price_rows);
				}
			}
		});
	}
	function fillSetDate(data) {
		var html = template('temp_list_script', data);
		var $appendContent = $(html);
		$('#list_div_parent').html($appendContent);
		$appendContent.each(function() {
			var $this = $(this);
			$this.click(function() {
				currPlacePriceDate.options.place_id = $this.attr('place_id');
				currPlacePriceDate.options.place_name = $this.attr('place_name');
				currPlacePriceDate.init({});
			});
		});
	}
	function AjaxPaginator(obj) {
		searchCallBack();
		var data = $.extend({page : price_page,rows : price_rows}, common.serializeObject($('#form_list_params')));
		$.ajax({
			type : 'POST',
			url : '${ctx}/weixin/hotel/price/list',
			data : data,
			dataType : 'JSON',
			success : function(data) {
				if (data != null) {//DOM操作
					fillSetDate(data);
					var fir = (data.currtPage-1)*price_rows+1
					var end = (data.currtPage-1)*price_rows+data.rows.length;
					paginationDetail(fir,end,data.total,price_rows);
				}else{
					paginationDetail(1,0,0,price_rows);
				}
			},
			complete : function(data) {
				var doj = eval('('+data.responseText+')');
				var currentPage = doj.currtPage || 1;
				var totalPages = doj.totalPage || 0;//data.total/price_rows;
				var options = {
					currentPage : currentPage, //当前页
					totalPages : totalPages, //总页数
					numberOfPages : 5, //设置控件显示的页码数
					bootstrapMajorVersion : 3,//如果是bootstrap3版本需要加此标识，并且设置包含分页内容的DOM元素为UL,如果是bootstrap2版本，则DOM包含元素是DIV
					useBootstrapTooltip : true,//是否显示tip提示框
					onPageClicked : function(event, originalEvent, type, page) {
						price_crt_page = page;
						price_search(page, price_rows);
					}
				}
				obj.bootstrapPaginator(options);
			}
		})
	}
	
	function paginationDetail(fir,end,total,rows){
		var info ="显示第 "+fir+"到第 "+end+"条记录，总共 "+total+" 条记录";
		$(".pagination-info").text(info);
		$(".page-size").text(rows);
		
		$(".pagination-detail ul li").each(function(){
			if($(this).attr("page-size")==rows){
				$(this).addClass("active");
			}else{
				$(this).removeClass("active");
			}
		});
		
	}
	
	function getHallList() {//获取下拉会场列表
		var hotelId = $("#sch_hotelId").val();
		var url ='${ctx}/framework/dictionary/trslCombox?sql=select id ,place_name name  from hui_hotel_place where place_type=\'HALL\' and hotel_id='+hotelId;
	    $.ajax({
	        url: url,
	        type: "get",
	        dataType: "json",
	        success: function (data) {
	        	var options = [];
	        	options.push("<option value=''>请选择</option>");
	            $.each(data, function (i) {
	            	options.push("<option value=" + data[i].value + ">" + data[i].text + "</option>");
	            });
	            $('#splaceId').html(options.join(''));
	            $('#splaceId').selectpicker('refresh');
	        },
	        error: function (data) {
	            //alert("查询学校失败" + data);
	        }
	    })

	}
</script>
<script id="temp_list_script" type="text/html">
{{each rows as item i}}
	<div class="place_price_list_one" style="border-bottom:0.05rem solid #cccccc;margin:0.5rem 0;width:96%;padding:0 2%;" place_id="{{item.id}}" place_name="{{item.placeName}}" >
		<div style="width:20%;float:left;">{{item.placeName}}</div>
 		<div style="display:table;width:80%;color:#666666;height:1.8rem;line-height:1.8rem;float:right;">
 			<div style="display:table-cell;width:5%;">&nbsp;</div>
			{{item | fm_price}}
 			<div class="" style="display:table-cell;width:5%">&nbsp;</div>
 		</div>
 		<div style="clear:both;"></div>
	</div>
{{/each}}	    			
</script>
<script id="temp_list_script2" type="text/html">
{{each rows as item i}}
	<div class="place_price_list_one" style="border-bottom:0.05rem solid #cccccc;margin:0.5rem 0;width:96%;padding:0 2%;" place_id="{{item.id}}" place_name="{{item.placeName}}" >
		<div style="width:20%;float:left;">{{item.placeName}}</div>
 		<div style="display:table;width:80%;color:#666666;height:1.8rem;line-height:1.8rem;float:right;">
 			<div style="display:table-cell;width:5%;">&nbsp;</div>
 			<div class="{{item.update_date_0 | update_class}}" style="display:table-cell;width:12%;cursor: pointer;">{{item.online_price_0}}</div>
 			<div class="{{item.update_date_1 | update_class}}" style="display:table-cell;width:12%;cursor: pointer;">{{item.online_price_1}}</div>
 			<div class="{{item.update_date_2 | update_class}}" style="display:table-cell;width:12%;cursor: pointer;">{{item.online_price_2}}</div>
 			<div class="{{item.update_date_3 | update_class}}" style="display:table-cell;width:12%;cursor: pointer;">{{item.online_price_3}}</div>
 			<div class="{{item.update_date_4 | update_class}}" style="display:table-cell;width:12%;cursor: pointer;">{{item.online_price_4}}</div>
			<div class="{{item.update_date_5 | update_class}}" style="display:table-cell;width:12%;cursor: pointer;">{{item.online_price_5}}</div>
			<div class="{{item.update_date_6 | update_class}}" style="display:table-cell;width:12%;cursor: pointer;">{{item.online_price_6}}</div>
 			<div class="" style="display:table-cell;width:5%">&nbsp;</div>
 		</div>
 		<div style="clear:both;"></div>
	</div>
{{/each}}	    			
</script>
</div>
</div>
</div>
