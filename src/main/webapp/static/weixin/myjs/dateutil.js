var Dateutil = function(){
	var _self = {};
	_self.toDate = new Date();
		 //date,这个月的最后一天
	_self.monthMaxDate = new Date(_self.toDate.getFullYear(),_self.toDate.getMonth() + 1,0);
		 //int,今天是星期几，0-6,0代表星期天
	_self.weekDay = _self.toDate.getDay();
		 //date,一周的第一天
	_self.weekFirstDate = new Date(_self.toDate.getFullYear(),_self.toDate.getMonth() ,_self.toDate.getDate() - _self.weekDay );
	_self.weekFirstDay  = common.formatDate(_self.weekFirstDate,'yyyy-MM-dd');
		 //str,今天
	_self.toDay = common.formatDate(_self.toDate,'yyyy-MM-dd');
		 
		 //str,这个月的第一天
	_self.monthFirstDay = common.formatDate(_self.toDate,'yyyy-MM') + '-01';
		 //str,这个月的最后一天
	_self.monthLastDay = common.formatDate(_self.monthMaxDate,'yyyy-MM-dd');
		 
	_self.ys = _self.toDate.getMonth() % 3;
		 switch(_self.ys){
		 case 0 :
			 _self.seasonFirstDate = new Date(_self.toDate.getFullYear(),_self.toDate.getMonth(),1);
			 _self.seasonLastDate = new Date(_self.toDate.getFullYear(),_self.toDate.getMonth() + 2,1);
			 break;
		 case 1 :
			 _self.seasonFirstDate = new Date(_self.toDate.getFullYear(),_self.toDate.getMonth() + -1,1);
			 _self.seasonLastDate = new Date(_self.toDate.getFullYear(),_self.toDate.getMonth() + 1,1);
			 break;
		 case 2 :
			 _self.seasonFirstDate = new Date(_self.toDate.getFullYear(),_self.toDate.getMonth() + -2,1);
			 _self.seasonLastDate = new Date(_self.toDate.getFullYear(),_self.toDate.getMonth(),1);
			 break;
		 default:
			 break;
		 }
    _self.seasonLastDate = new Date(_self.seasonLastDate.getFullYear(),_self.seasonLastDate.getMonth() +1 ,0);
		 
	_self.seasonFirstDay = common.formatDate(_self.seasonFirstDate,'yyyy-MM-dd');
	_self.seasonLastDay = common.formatDate(_self.seasonLastDate,'yyyy-MM-dd');
		 
	_self.yearFirstDay = common.formatDate(_self.toDate,'yyyy') + '-01-01';
	_self.yearLastDate = new Date(_self.toDate.getFullYear() + 1,0,0);
	_self.yearLastDay = common.formatDate(_self.yearLastDate,'yyyy-MM-dd');
		
	_self.week = {};
	_self.week.first = _self.weekFirstDay;
	_self.week.last = common.formatDate(new Date(_self.toDate.getFullYear(),_self.toDate.getMonth(),_self.toDate.getDate() + (6 - _self.weekDay)),'yyyy-MM-dd');
	
	_self.month = {};
	_self.month.first = _self.monthFirstDay;
	_self.month.last = _self.monthLastDay;
	
	_self.season = {};
	_self.season.first = _self.seasonFirstDay;
	_self.season.last = _self.seasonLastDay;
	
	_self.year = {};
	_self.year.first = _self.yearFirstDay;
	_self.year.last = _self.yearLastDay;
	
	return _self;
};

