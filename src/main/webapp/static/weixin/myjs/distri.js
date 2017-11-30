//property:target,projectId,user.allusers
//method:
var distributionTable = function(op){
	var _self = {};
	_self.target = op.target
	_self.projectId = op.projectId;
	_self.clickAble = true;
	if(op.clickAble == false){
		_self.clickAble = false;
	}
	_self.project = {};
	_self.user = {};
	_self.leftHeader  ={};
	_self.coloClazzPrefix  =  'dis-sta-';
	_self.currColorIndex  =  '00';

	_self.project.states = {
	   '215':'资料提供',
	   '220':'脚本',
	   '230':'模型',
	   '240':'预演',
	   '250':'样片',
	   '260':'成片'
	};

	_self.project.currState = '0';

	_self.user.allusers =  [ ];

	_self.user.checkedItems =  [

	    //信息收集(10)3-15  3-17   张三，李四
	];

	_self.project.getUsingState = function(allstates,currState){
	    return allstates;
	}

	_self.project.usingState = _self.project.getUsingState(_self.project.states,_self.project.currState);


	_self.genLeftHeader = function(){
	    var $leftHeader = _self.leftHeader;
	    var leftHeaderhtml = [];
	    leftHeaderhtml.push( '<table> <tr  class="distribution-lefth-tr-first"><td colspan="2" >岗位分布 </td><tr>');
	    var usingState = _self.project.usingState;
	    var allusers = _self.user.allusers;
	    var allstates = _self.project.states;

	        for(var i in allusers){
	            leftHeaderhtml.push('<tr><td class="distribution-uname">'+allusers[i].name+' </td></tr>');
	        }


	    leftHeaderhtml.push('</table>');
	    // console.log();
	    $leftHeader.html(leftHeaderhtml.join(''));
	    return   $leftHeader;
	}

	_self.genRighTable = function(year_month,leftOrRight,start_day1,date1_last){
	   // var year_month = common.formatDate(date,'yyyy-MM');
	    //var start_day1 = 1;
	    // var date1_last = new Date(date.getFullYear() ,date.getMonth() + 1  ,0).getDate();
		start_day1 = Number(start_day1);
		date1_last = Number(date1_last);
	    var $rightOneTable = $('<div class="distribution-onediv"></div>');
	    if(leftOrRight && leftOrRight =='left'){
	    	 _self.rightTableParent.prepend($rightOneTable);
	    	 //$('#distribution-header-left').after($rightOneTable);
	    }else{
	    	 _self.rightTableParent.append($rightOneTable);
	    	 //$rightOneTable.appendTo(_self.target);
	    }
	   
	    var topheaderHtml = [];
	    topheaderHtml.push('<table id="table-'+year_month+'">');
	    topheaderHtml.push('<tr> <td colspan="'+date1_last+'" class="distribution-header-date">'+year_month+'</td></tr>');
	    topheaderHtml.push('<tr>');
	    var usingState = _self.project.usingState;
	    var allusers = _self.user.allusers;
	    var allstates = _self.project.states;
	    for(var i = start_day1 ;i <= date1_last ; i++){
	        topheaderHtml.push('<td>'+i+'</td>');

	    }
	    topheaderHtml.push('</tr>');

	    //for(var i in usingState){
	        for(var j in allusers){
	            topheaderHtml.push('<tr>');
	            for(var k = start_day1 ;k <= date1_last ;k++){
	                var day = year_month+ '-'+ (k >9? k: '0'+k);
	                topheaderHtml.push('<td sta-old="'+_self.currColorIndex+'" userid="'+allusers[j].id +'" name="'+allusers[j].name+'" date="'+day+'" tid="td-'+day+'" >&nbsp;</td>');
	            }
	            topheaderHtml.push('</tr>');
	        }
	   // }

	    topheaderHtml.push('</table>');

	    $rightOneTable.html(topheaderHtml.join(''));
	    _self.bindRightTableClick($rightOneTable);
	    
	    _self.checkTables($rightOneTable,year_month + '-' +start_day1,year_month + '-' +date1_last);
	    return $rightOneTable;
	}


	_self.checkTables = function($table,stday,endday){
		
	    	$.ajax({
	    		url : common.baseUrl+'/admin/project/manage/scheme/distriItems',
	    		type : 'post',
	    		data : {
	    			projectId : _self.projectId,
	    			stDate : stday,
	    			endDate : endday
	    		},
	    		success : function(res){
	    			if(typeof res == 'string'){
	    				common.alert('获取已选列表出错');
	    				return;
	    			}
	    			_self.user.checkedItems = res; 
	               // _self.init($('#distribution_parent'));
	    			 //_self.checkTables($rightOneTable,_self.user.checkedItems);
	    			var checkItems = _self.user.checkedItems;
	    			//这里将已分配的工作td上分配颜色，而且不是在当前对象的td上。所以要注意的是策划首页也上的table也会分配颜色，但不会减少颜色
	    			for(var i in checkItems){
	    		        var selector = 'td[userid="'+checkItems[i].userid +'"][tid="td-'+checkItems[i].date+'"]';
	    		        _self.target.find(selector).addClass('dis-sta-'+checkItems[i].state)
	    		        .attr('sta-orig',checkItems[i].state).attr('sta-old',checkItems[i].state).attr('sta-new',checkItems[i].state)
	    		        .attr('itemid',checkItems[i].id);
	    		    }
	    			
	    		}
	    	});

		
		
	    
	};

	_self.bindRightTableClick = function($rightOneTable){
		if(!_self.clickAble){
			return;
		}
		$rightOneTable.find('td').each(function(){
			var $this = $(this);
			$this.click(function(){
				if(_self.currColorIndex == '00'){
					return;
				}
				if(!$this.attr('userid')){
					return;
				}
				
				if($this.attr('sta-new') != _self.currColorIndex){	//改变
					
					$this.removeClass(_self.coloClazzPrefix + $this.attr('sta-new'));
					$this.attr('sta-old',$this.attr('sta-new'));
					$this.attr('sta-new',_self.currColorIndex);
					
					$this.addClass(_self.coloClazzPrefix + _self.currColorIndex);
				}
				
			});
			
			$this.mousedown(function(e){ 
		        if(3 == e.which){ 
		        	//_self.currColorIndex = '00';
		        	//$this.trigger('click');
		        	
		        	$this.removeClass(_self.coloClazzPrefix + $this.attr('sta-new'));
					$this.attr('sta-old',$this.attr('sta-new'));
					$this.attr('sta-new','00');
					
					$this.addClass(_self.coloClazzPrefix + '00');
		        }
		    });
			
		    
		});
		
		$rightOneTable.bind("contextmenu",function(e){
	        return false;
	    });
		
		
	};

	_self.getCheckStateObj = function(){
		var checkStateObj = {};
		checkStateObj.delteItemIds = [];
		checkStateObj.delteItemUesrIds = [];
		checkStateObj.newItems = [];
		
		$('#distribution_parent .distribution-onediv').find('td').each(function(){
			var $this = $(this);
			var addFlag = false;
			if($this.attr('sta-orig')){	//旧的
				if($this.attr('sta-new') != $this.attr('sta-orig')){	//旧的记录要删除
					
					checkStateObj.delteItemIds.push($this.attr('itemid'));
					
					//if(checkStateObj.delteItemUesrIds.indexOf(','+ $this.attr('userid'))  == -1){
					checkStateObj.delteItemUesrIds.push($this.attr('userid'));
					//}
					
					if($this.attr('sta-new') != '00'){	//新的加入
						addFlag = true;
					}
				}
				
				
			}else{	//新的
				if($this.attr('sta-new') && $this.attr('sta-new') != '00'){	//新的加入
					addFlag = true;
				}
				
			}
			
			if(addFlag){
				var item = {
						state : $this.attr('sta-new'),
						userid : $this.attr('userid'),
						name : $this.attr('name'),
						date : $this.attr('date'),
						projectId : _self.projectId
					};
				checkStateObj.newItems.push(item);
			}
			
		});
		
		return checkStateObj;
	};


	_self.genPrev = function(){
		var date = _self.minDate;
		date = new Date(date.getFullYear() ,date.getMonth() -1,1);
		_self.minDate=  date;
		_self.genRighTable(date,'left');
	};

	_self.genNext = function(){
		var date = _self.maxDate;
		date = new Date(date.getFullYear() ,date.getMonth()  +1,1);
		_self.maxDate=  date;
		_self.genRighTable(date);
	};

	_self.init = function(){
		op.target.empty();
		_self.user.allusers = op.users;
		_self.currColorIndex  =  op.currColorIndex || '00';
		_self.startDay  =  op.startDay ;
		_self.endDay  =  op.endDay ;
		
	    //_self.target = _self.target;
	    _self.leftHeader = $('<div id="distribution-header-left" class="distribution-header-left" ></div>').appendTo(_self.target);
	    //var date2 = new Date(date1.getFullYear() ,date1.getMonth()  +1,1);

	    _self.rightTableParent = $('<div id="right_table_p" style="font-size:0;overflow-x:auto;max-width:92%;"></div>').appendTo(_self.target);
	    _self.genLeftHeader();

	    var startDate = new Date(_self.startDay);
	    var endDate = new Date(_self.endDay);
	    
	    var startMonth = Number(common.formatDate(startDate,'M'));
	    var diffMonth = Number(common.formatDate(endDate,'M')) - startMonth;
	    var dateTableArray = [];
	    
	    var date = new Date(startDate.getFullYear() ,startDate.getMonth()  ,1);
	    var startDay,endDay;
	    if(diffMonth == 0){ //同一月
	    	startDay = common.formatDate(startDate,'d');
	    	endDay = common.formatDate(endDate,'d');
	    	dateTableArray.push({
	    		month : common.formatDate(startDate,'yyyy-MM'),
	    		startDay : startDay,
	    		endDay : endDay
	    	});
	    }else{	//跨月
	    	for(var i = -1 ; i < diffMonth ; i++){
		    	date = new Date(startDate.getFullYear() ,startDate.getMonth() +i +1 ,1);
		    	if(i == -1){
		    		startDay = common.formatDate(startDate,'d');
		    		endDay = common.formatDate(new Date(startDate.getFullYear() ,startDate.getMonth() +1,0),'d');
		    	}else if(i == diffMonth -1){
		    		startDay = 1;
		    		endDay = common.formatDate(endDate,'d');
		    	}else{
		    		startDay = 1;
		    		endDay = common.formatDate(new Date(startDate.getFullYear() ,startDate.getMonth()+i +2 ,0),'d');
		    	}
		    	dateTableArray.push({
		    		month : common.formatDate(date,'yyyy-MM'),
		    		startDay : startDay,
		    		endDay : endDay
		    	});
		    }
	    }
	    
	    for(var i in dateTableArray){
	    	_self.genRighTable(dateTableArray[i].month,'right',dateTableArray[i].startDay,dateTableArray[i].endDay);
	    }
	    
	   // var $rightOneTable = _self.genRighTable(_self.currDate);

	};
	
	_self.init();
	return _self;
};


