var placePriceDate = function(options){
	var _self = {};
	_self.options = $.extend({
		$dom : $('#place_date_price_div'),
		$input_year_month :$('#date_year_month'),
		place_id : 1,
		place_name : '会议厅',
		row : 6,
		col : 7,
		initCallBack : function(){}
	},options);
	
	_self.options.$dom_ct =  _self.options.$dom.find('.date-picker-ct');
	_self.options.$place_date_title =  _self.options.$dom.find('.place_date_title');
	_self.options.$place_year_month =  _self.options.$dom.find('.place_year_month');
	_self.options.$place_date_month =  _self.options.$dom.find('.place_date_month');
	_self.options.$search_form =  _self.options.$dom.find('.form_place_date_price_list');
	
	_self.options.$date_icon_left =  _self.options.$dom.find('.date-icon-left');
	_self.options.$date_icon_right =  _self.options.$dom.find('.date-icon-right');
	
	_self.options.currYearMonth = _self.options.$input_year_month.val();
	
	_self.fmEnMonth = function(date){
		return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][date.getMonth()];
	};
	
	_self.init = function(op){
		var initOp = $.extend({
			year_month :  _self.options.$input_year_month.val()
			
		},op);
		 _self.options.currYearMonth = initOp.year_month  ;
		
		var dom_ct_html = [];
		
		for(var i = 0 ; i < _self.options.row;i ++){
			dom_ct_html.push('<div class="date-picker-ct-line">');
			for(var j = 0 ; j < _self.options.col ; j++){
				dom_ct_html.push('<div class="date-picker-ct-one">');
				dom_ct_html.push('<div class="date-picker-ct-day">&nbsp;</div>    <div class="date-picker-ct-money">&nbsp;</div>');
				dom_ct_html.push('</div>');
			}
			dom_ct_html.push('</div>');
		}
		_self.options.$dom_ct.html(dom_ct_html.join(''));
		
		var year_month =  _self.options.currYearMonth.split('-');
		var date = new Date(year_month[0],Number(year_month[1]) - 1,1);
		var curtDate = new Date();
		var firstDateOfMonth = new Date(date.getFullYear(),date.getMonth() ,1);
		if(date.getFullYear()===curtDate.getFullYear()&&curtDate.getMonth()===date.getMonth()){
			firstDateOfMonth = new Date(curtDate.getFullYear(),curtDate.getMonth(),1);
		}
		console.log("firstDateOfMonth>>>"+firstDateOfMonth)
		var lastDayOfMonth = new Date(date.getFullYear(),date.getMonth() + 1,0).getDate();
		var zhYear = common.formatDate(date,'yyyy年MM月');
		var enMonth = _self.fmEnMonth(date);
		
		_self.options.$place_date_title.html(_self.options.place_name);
		_self.options.$place_year_month.html(zhYear);
		_self.options.$place_date_month.html(enMonth);
		
		//var datesOfMonthArray = [];
		var dateCtStartIndex = firstDateOfMonth.getDay();
		var allDateCtOnes = _self.options.$dom_ct.find('.date-picker-ct-one');
		for(var i = 0 ; i < lastDayOfMonth ; i++){
			
			//datesOfMonthArray.push();	
			var currDate = new Date(date.getFullYear(),date.getMonth() , i + 1);
			
			var $currDateCtOne = allDateCtOnes.eq(dateCtStartIndex);
			$currDateCtOne.attr('date',common.formatDate(currDate)).attr('day',currDate.getDate());
			$currDateCtOne.find('.date-picker-ct-day').text(currDate.getDate());
			
			//$currDateCtOne.find('.date-picker-ct-money').text(currDate.getDate());
			dateCtStartIndex++;
		}
		
		$('#search_EQ_placeId').val(_self.options.place_id);
		$('#search_GTE_onlinePrice').val(common.formatDate(firstDateOfMonth));
		$('#search_LTE_onlinePrice').val(year_month[0] + '-' + year_month[1] + '-' + lastDayOfMonth);
		
		_self.loadData();
		_self.show();
		_self.options.initCallBack();
	};
	
	_self.loadData = function(data){
		common.ajaxjson({
			url : common.ctx + '/weixin/hotel/price/list/detail',
			data : common.serializeObject($('#form_place_date_price_list')),
			success : function(res){
				var list = res.object;
				var onOrOff = $("#onOrOff").val();
				$("#adjust_price_type").val(onOrOff);
				if(list!=null&&list.length>0){
					_self.setData(list,onOrOff);
				}else{
					var placeId = $("#search_EQ_placeId").val();
					var pschdls =  $("#search_GTE_onlinePrice").val().split('-');
					var placeSchedule = pschdls[0]+"-"+pschdls[1];
					list = common.getstorJson('tmp_price_'+placeId+"_"+placeSchedule);
					_self.setData(list,onOrOff);
				}
			}
		});
	};
	
	_self.setData = function(list,onOrOff){
		for(var i = 0 ; i < list.length ;i++){
			var row =  list[i];
			if(!row.placeSchedule){
				row = eval("("+row+")")
			}
			var placeSchedule = row.placeSchedule;
			var day = placeSchedule.substring(placeSchedule.lastIndexOf('-') + 1);
			var $currDateCtOne = _self.options.$dom_ct.find('[date="'+placeSchedule+'"]');
			if("off"===onOrOff){
				$currDateCtOne.find('.date-picker-ct-money').html(row.offlinePrice);
			}else{
				$currDateCtOne.find('.date-picker-ct-money').html(row.onlinePrice);
			}
		}
	}
	
	_self.options.$date_icon_left.click(function(){//上一个月
		var currYearMonthSpArray = _self.options.currYearMonth.split('-');
		var currYearMonth = common.formatDate(new Date(currYearMonthSpArray[0],Number(currYearMonthSpArray[1]) - 2,1)  ,'yyyy-MM'  )
		_self.init({
			year_month : currYearMonth
		});
	});
	
	_self.options.$date_icon_right.click(function(){//下一个月
		var currYearMonthSpArray = _self.options.currYearMonth.split('-');
		var currYearMonth = common.formatDate(new Date(currYearMonthSpArray[0],Number(currYearMonthSpArray[1]) ,1)  ,'yyyy-MM'  )
		_self.init({
			year_month : currYearMonth
		});
	});
	
	_self.show = function(){
		$('#mask_div').show();
		_self.options.$dom.show();
	}
	_self.hide = function(){
		$('#mask_div').hide();
		_self.options.$dom.hide();
	}
	
	$('#mask_div').click(function(){
		_self.hide();
	});
	return _self;
};


