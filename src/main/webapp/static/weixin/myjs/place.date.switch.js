function initDateSwitchTab($date_year_month,$date_switch_tab,datechageCallBack){
	var $date_switch_prev = $date_switch_tab.find('>.date-icon-left');
	var $date_switch_next = $date_switch_tab.find('>.date-icon-right');
	
	
	var $date_day_nums = $date_switch_tab.find('.date-day-num');
	$date_day_nums.click(function(){
	});
	
	var date = new Date();
	
	setCommonWeek(date);
	
	$date_year_month.change(function(){
		var inpuYearMonthArray = $date_year_month.val().split('-');
		var date = new Date(inpuYearMonthArray[0],inpuYearMonthArray[1] -1,1);
		setCommonWeek(date);
	});
	
	$date_switch_prev.click(function(){
		var inpuYearMonthArray = $date_year_month.val().split('-');
		var nowFirstDay = Number($date_switch_tab.find('.date-day-num:first').attr('day'));
		var nowLastDay = Number($date_switch_tab.find('.date-day-num:last').attr('day'));
		
		if($date_switch_tab.attr('prevMonth') != '1'){
			
			var preDate = new Date(inpuYearMonthArray[0],inpuYearMonthArray[1]-1 ,nowFirstDay - 1);
			setCommonWeek(preDate,'prev');
   			
		}else{
			setPrevMonthWeek();
		}
   		
	});

	//向左结束，向右开始
	
	$date_switch_next.click(function(){	//向右
		var inpuYearMonthArray = $date_year_month.val().split('-');
		var nowFirstDay = Number($date_switch_tab.find('.date-day-num:first').attr('day'));
		var nowLastDay = Number($date_switch_tab.find('.date-day-num:last').attr('day'));
		
   		if($date_switch_tab.attr('nextMonth') != '1'){
   			var nextDate = new Date(inpuYearMonthArray[0],inpuYearMonthArray[1] -1 ,Number(nowLastDay) + 1);
			setCommonWeek(nextDate,'next');
		}else{
			setNextMonthWeek();
		}
   		
	});
}

function setCommonWeek(date,which){
	var $date_switch_tab = $('#date_switch_tab');
	var $date_year_month = $('#date_year_month')
	
	var month = date.getMonth() + 1  ;
	$date_year_month.val(date.getFullYear() + '-' + (month < 10 ? '0'+month : month ));
	
	var inpuYearMonthArray = $date_year_month.val().split('-');
	var startDate = getWeekStartDate(new Date(inpuYearMonthArray[0],inpuYearMonthArray[1]-1 ,date.getDate()),which);
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
	
	
	$date_switch_tab.find('.date-day-num').each(function(i){
		$(this).attr('day',weekDayArray[i]);
		if(new Date().getDate()==weekDayArray[i]&&common.formatDate(date)==common.formatDate(new Date())){
			$(this).addClass('date-icon-checked')
		}else{
			$(this).removeClass('date-icon-checked')
		}
		if($date_switch_tab.attr('prevMonth') == '1' ){
			weekDayArray[i] = weekDayArray[i] > 20? '':weekDayArray[i]; 
		}else if($date_switch_tab.attr('nextMonth') == '1'){
			weekDayArray[i] = weekDayArray[i] < 20? '':weekDayArray[i];
		}
		$(this).text(weekDayArray[i]);
		
	});
	
	dateCheckDay(date.getDate());
	
	
}

function dateCheckDay(day){
	var $date_switch_tab = $('#date_switch_tab');
	$date_switch_tab.find('[day='+day+']').click();
	$('#btn_search').click();
}

function setPrevMonthWeek(){
	console.log('setPrevMonthWeek');
	var $date_switch_tab = $('#date_switch_tab');
	var $date_year_month = $('#date_year_month');
	var inpuYearMonthArray = $date_year_month.val().split('-');
	
	var startDate = getWeekStartDate(new Date(inpuYearMonthArray[0],inpuYearMonthArray[1] -1 , 0));
	
	var weekDayArray = getWeekDayArray(startDate.getFullYear(),startDate.getMonth() , startDate.getDate(),'start');
	
	
	$date_switch_tab.find('.date-day-num').each(function(i){
		$(this).attr('day',weekDayArray[i]);
		if(weekDayArray[i] < 20){
			weekDayArray[i] = '';
		}
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
	console.log('setNextMonthWeek');
	var $date_switch_tab = $('#date_switch_tab');
	var $date_year_month = $('#date_year_month');
	var inpuYearMonthArray = $date_year_month.val().split('-');
	
	//var startDate = getWeekStartDate(new Date(inpuYearMonthArray[0],inpuYearMonthArray[1] -1 , 0));
	var nextMonthDate = new Date(inpuYearMonthArray[0],inpuYearMonthArray[1] , 1);
	var startDate = getWeekStartDate(nextMonthDate);
	
	var weekDayArray = getWeekDayArray(startDate.getFullYear(),startDate.getMonth() , startDate.getDate(),'start');
	
	
	var stDay  = startDate.getDay();
	var index = 0;
	var length = $date_switch_tab.find('.date-day-num').length;
	for(var i = 0; i < length ; i ++ ){
		var $target = $date_switch_tab.find('.date-day-num:eq('+i+')');
		$target.attr('day',weekDayArray[i]);
		if(weekDayArray[i] > 20){
			weekDayArray[i] = '';
		}
		$target.text(weekDayArray[i]);
	}
	
	var month = nextMonthDate.getMonth() + 1  ;
	$date_year_month.val(startDate.getFullYear() + '-' + (month < 10 ? '0'+month : month ));
	$date_switch_tab.attr('prevMonth','1');
	$date_switch_tab.attr('nextMonth','0');
	
	dateCheckDay(1);
}

function getWeekStartDate(date,which){
	if(schedule_data_num == 7){
		return new Date(date.getFullYear(),date.getMonth() , date.getDate() + (0 - date.getDay()) );
	}
	if(which == 'prev'){
		return new Date(date.getFullYear(),date.getMonth() , date.getDate() -  6);
	}
	if(which == 'next'){
		return new Date(date.getFullYear(),date.getMonth() , date.getDate() );
	}
	return date;
}

var schedule_data_num= 7;
function getWeekDayArray(year,month,day,direction){
	var date = new Date(year,month ,day);
	var weekDayarray = [];
	switch(direction){
		case 'start' :
			for(var i = 0 ;i < schedule_data_num; i++){
				weekDayarray.push(new Date(date.getFullYear(),date.getMonth() ,day +i ).getDate());
			}
			break;
	}
	return weekDayarray;
	
}