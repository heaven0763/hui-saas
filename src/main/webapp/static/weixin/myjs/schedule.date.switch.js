
var clk_flag = 0;
function initDateSwitchTab($date_year_month,$date_switch_tab,datechageCallBack){
	var $date_switch_prev = $date_switch_tab.find('>.date-icon-left');
	var $date_switch_next = $date_switch_tab.find('>.date-icon-right');
	
	
	var $date_day_nums = $date_switch_tab.find('.date-day-num');
	$date_day_nums.click(function(){
		if(clk_flag==0){
			clk_flag = 1;
			$date_day_nums.find('.full-checked').removeClass('full-checked');
			$date_day_nums.find('.some-checked').removeClass('some-checked');
			$date_day_nums.find('.none-checked').removeClass('none-checked');
			
			var $this = $(this);
			$this.find('.full').addClass('full-checked');
			$this.find('.some').addClass('some-checked');
			$this.find('.none').addClass('none-checked');
			
			var dateStr = $this.attr('date');//$date_year_month.val() + '-'+ ($this.attr('day')>9?$this.attr('day'):"0"+$this.attr('day'));
			if(datechageCallBack){
				datechageCallBack(dateStr);
			}
			$("#crt_sel_day").val(dateStr);
			$date_year_month.val(dateStr);
			$("#crt_sel_day").val(dateStr);
			
			
		}
	});
	
	var date = new Date();
	
	setCommonWeek(date);
	
	$date_year_month.change(function(){
		var inpuYearMonthArray = $date_year_month.val().split('-');
		var date = new Date(inpuYearMonthArray[0],inpuYearMonthArray[1] -1,inpuYearMonthArray[2]);
		setCommonWeek(date);
		$("#crt_sel_day").val($date_year_month.val());
	});
	
	$date_switch_prev.click(function(){
		var inpuYearMonthArray = $date_year_month.val().split('-');
		var nowFirstDay = Number($date_switch_tab.find('.date-day-num:first').attr('day'));
		var nowLastDay = Number($date_switch_tab.find('.date-day-num:last').attr('day'));
		var nowWeekFirstDay = $date_switch_tab.find('.date-day-num:first').attr('date');
		nowWeekFirstDays = nowWeekFirstDay.split('-');
		var preDate = new Date(nowWeekFirstDays[0],nowWeekFirstDays[1]-1 ,nowFirstDay - 1);
		setCommonWeek(preDate);
   		
	});

	//向左结束，向右开始
	
	$date_switch_next.click(function(){	//向右
		var inpuYearMonthArray = $date_year_month.val().split('-');
		var nowFirstDay = Number($date_switch_tab.find('.date-day-num:first').attr('day'));
		var nowLastDay = Number($date_switch_tab.find('.date-day-num:last').attr('day'));
		var nowWeekLastDay = $date_switch_tab.find('.date-day-num:last').attr('date');
		nowWeekLastDays = nowWeekLastDay.split('-');
		var nextDate = new Date(nowWeekLastDays[0],nowWeekLastDays[1] -1 ,Number(nowLastDay) + 1);
		setCommonWeek(nextDate);
   		
	});
}
var weekDatearray = [];
function setCommonWeek(date){
	var $date_switch_tab = $('#date_switch_tab');
	var $date_year_month = $('#date_year_month')
	
	var month = date.getMonth() + 1  ;
	$date_year_month.val(common.formatDate(date));
	
	var inpuYearMonthArray = $date_year_month.val().split('-');
	var startDate = getWeekStartDate(new Date(inpuYearMonthArray[0],inpuYearMonthArray[1]-1 ,date.getDate()));
	var weekDayArray = getWeekDayArray(startDate.getFullYear(),startDate.getMonth() , startDate.getDate(),'start');
	
	var diffmonth = false; 
	
	var maxDayOfMonth = new Date(new Date(date.getFullYear(),date.getMonth() + 1 ,0)).getDate();//获得该月的最大天数
	
	for(var i = 0; i< weekDayArray.length ;i ++){
		if(weekDayArray[i]  == 1 || weekDayArray[i]  == maxDayOfMonth) {
			diffmonth = true;
		}
		/* if(i < weekDayArray.length -1 ){
			//console.log(weekDayArray[i]);
			//console.log(weekDayArray[i + 1]);
			if(weekDayArray[i] > weekDayArray[i+1]){
				diffmonth = true;
			}
		} */
	}
	if(diffmonth ){
		if(date.getDate() > 20){
			$date_switch_tab.attr('prevMonth','0');
			$date_switch_tab.attr('nextMonth','1');
		}else{
			$date_switch_tab.attr('prevMonth','1');
			$date_switch_tab.attr('nextMonth','0');
		}
	} else{
		$date_switch_tab.attr('prevMonth','0');
		$date_switch_tab.attr('nextMonth','0');
	}
	$date_switch_tab.find('.date-day-num');
	$date_switch_tab.find('.date-day-num');
	$date_switch_tab.find('.date-day-num');
	$date_switch_tab.find('.date-day-num').each(function(i){
		var $_date_day_num = $(this);
		$_date_day_num.attr('day',weekDayArray[i]);
		$_date_day_num.attr('date',weekDatearray[i]);
		/*if($date_switch_tab.attr('prevMonth') == '1' ){
			weekDayArray[i] = weekDayArray[i] > 20? '':weekDayArray[i]; 
		}else if($date_switch_tab.attr('nextMonth') == '1'){
			weekDayArray[i] = weekDayArray[i] < 20? '':weekDayArray[i];
		}*/
		$(this).find('.day-num-text').text(weekDayArray[i]);
		var hotelId = $('#hotelId').val();
		var placeId = $('#placeId').val();
		var placeDate = weekDatearray[i];
		if(common.formatDate(new Date())>placeDate){
			$_date_day_num.find('.day-num-text').removeClass('full').removeClass('some').removeClass('none');
			$_date_day_num.find('.day-num-text').addClass('none');
		}else{
			$.get(common.ctx+'/weixin/schedulebooking/place/ishaveschedule',{hotelId:hotelId,placeId:placeId,placeDate:placeDate},function(res){
				if(res.statusCode==='200'){
					$_date_day_num.find('.day-num-text').removeClass('full').removeClass('some').removeClass('none');
					if(res.object.cbsNum==4){
						/*if(res.object.state>='1'){
							$_date_day_num.find('.day-num-text').addClass('some');
						}else{
						}*/
						$_date_day_num.find('.day-num-text').addClass('full');
					}else if(res.object.cbsNum>0&&res.object.cbsNum<4){
						$_date_day_num.find('.day-num-text').addClass('some');
					}else{
						$_date_day_num.find('.day-num-text').addClass('none');
					}
				}else{
					$_date_day_num.find('.day-num-text').addClass('none');
				}
			},'json');
		}
		
	});
	
	dateCheckDay(date.getDate());
}

function dateCheckDay(day){
	setTimeout(function(){
		var $date_switch_tab = $('#date_switch_tab');
		$date_switch_tab.find('[day='+day+']').click();
	},200);
	
}

function setPrevMonthWeek(){
	var $date_switch_tab = $('#date_switch_tab');
	var $date_year_month = $('#date_year_month');
	var inpuYearMonthArray = $date_year_month.val().split('-');
	
	var startDate = getWeekStartDate(new Date(inpuYearMonthArray[0],inpuYearMonthArray[1] -1 , 0));
	
	var weekDayArray = getWeekDayArray(startDate.getFullYear(),startDate.getMonth() , startDate.getDate(),'start');
	
	
	$date_switch_tab.find('.date-day-num').each(function(i){
		$(this).attr('day',weekDayArray[i]);
		/*if(weekDayArray[i] < 20){
			weekDayArray[i] = '';
		}*/
		$(this).text(weekDayArray[i]);
	});
	
	var month = startDate.getMonth() + 1  ;
	$date_year_month.val(startDate.getFullYear() + '-' + (month < 10 ? '0'+month : month ));
	$date_switch_tab.attr('prevMonth','0');
	$date_switch_tab.attr('nextMonth','1');
	
	var maxDayOfMonth = new Date(new Date(startDate.getFullYear(),startDate.getMonth() + 1 ,0)).getDate();//获得该月的最大天数
	dateCheckDay(maxDayOfMonth);
}

function setNextMonthWeek(){
	var $date_switch_tab = $('#date_switch_tab');
	var $date_year_month = $('#date_year_month');
	var inpuYearMonthArray = $date_year_month.val().split('-');
	
	//var startDate = getWeekStartDate(new Date(inpuYearMonthArray[0],inpuYearMonthArray[1] -1 , 0));
	var nextMonthDate = new Date(inpuYearMonthArray[0],inpuYearMonthArray[1] , 1);
	var startDate = getWeekStartDate(nextMonthDate);
	
	var weekDayArray = getWeekDayArray(startDate.getFullYear(),startDate.getMonth() , startDate.getDate(),'start');
	
	
	var stDay  = startDate.getDay();
	var index = 0;
	for(var i = 0; i < 7 ; i ++ ){
		var $target = $date_switch_tab.find('.date-day-num:eq('+i+')');
		$target.attr('day',weekDayArray[i]);
		/*if(weekDayArray[i] > 20){
			weekDayArray[i] = '';
		}*/
		$target.text(weekDayArray[i]);
	}
	
	var month = nextMonthDate.getMonth() + 1  ;
	$date_year_month.val(startDate.getFullYear() + '-' + (month < 10 ? '0'+month : month ));
	$date_switch_tab.attr('prevMonth','1');
	$date_switch_tab.attr('nextMonth','0');
	
	dateCheckDay(1);
}

function getWeekStartDate(date){
	return new Date(date.getFullYear(),date.getMonth() , date.getDate() + (0 - date.getDay()) );
}

function getWeekDayArray(year,month,day,direction){
	var date = new Date(year,month ,day);
	var weekDayarray = [];
	weekDatearray = [];
	switch(direction){
		case 'start' :
			weekDayarray.push(new Date(date.getFullYear(),date.getMonth() ,day ).getDate());
			weekDayarray.push(new Date(date.getFullYear(),date.getMonth() ,day + 1).getDate());
			weekDayarray.push(new Date(date.getFullYear(),date.getMonth() ,day + 2).getDate());
			weekDayarray.push(new Date(date.getFullYear(),date.getMonth() ,day + 3).getDate());
			weekDayarray.push(new Date(date.getFullYear(),date.getMonth() ,day + 4).getDate());
			weekDayarray.push(new Date(date.getFullYear(),date.getMonth() ,day + 5).getDate());
			weekDayarray.push(new Date(date.getFullYear(),date.getMonth() ,day + 6).getDate());
			
			weekDatearray.push(common.formatDate(new Date(date.getFullYear(),date.getMonth() ,day )));
			weekDatearray.push(common.formatDate(new Date(date.getFullYear(),date.getMonth() ,day + 1)));
			weekDatearray.push(common.formatDate(new Date(date.getFullYear(),date.getMonth() ,day + 2)));
			weekDatearray.push(common.formatDate(new Date(date.getFullYear(),date.getMonth() ,day + 3)));
			weekDatearray.push(common.formatDate(new Date(date.getFullYear(),date.getMonth() ,day + 4)));
			weekDatearray.push(common.formatDate(new Date(date.getFullYear(),date.getMonth() ,day + 5)));
			weekDatearray.push(common.formatDate(new Date(date.getFullYear(),date.getMonth() ,day + 6)));
			break;
	}
	return weekDayarray;
	
}