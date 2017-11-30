var dict = dict || {};
//var clientData = clientData || {};
dict.jsonList = {};	//dict.jsonList[kind][code]
dict.dataList = {};	//data:dict.dataList['01']

dict.init = function(){
	var json = common.getstorJson('dictJson');
	if(json && json.length > 0){
		dict.initJson(json);
		return;
	}
	$.ajax({
		type : 'get',
		dataType : 'json',
		url : common.ctx+'/framework/dictionary/listAll',
		success: function(result){
			//clientData.dictList = result;
			var json = result.rows || result;
			common.setstorJson('dictJson',json);
			dict.initJson(json);
		}
	});
	
};

dict.initJson = function(json){
	var json = json || common.getStorJson('dictJson');
	for(var i in json){
		var _thisDict = json[i];
		if(!dict.jsonList[_thisDict.kind]){
			dict.jsonList[_thisDict.kind] = new Object();
			dict.dataList[_thisDict.kind] = [];
		} 
		dict.dataList[_thisDict.kind].push({
			value : _thisDict.code,
			text :_thisDict.detail
		});
		dict.jsonList[_thisDict.kind][_thisDict.code] = _thisDict.detail;
		//function,formatter:dict['01']
		var _fn = 'if(!code){return ""}var res = []; var codes = code.split(","); for(var i in codes){res.push(dict.jsonList[\''+_thisDict.kind+'\'][codes[i]] || codes[i])} return res.join(",");';
		var fnName = 'fn'+_thisDict.kind;
		dict[fnName] = new Function('code','row',_fn);
		
		if(typeof template !='undefined'){
			template.helper('tp_'+fnName, dict[fnName]);
		}
	}
};
dict.trsltDict= function(kind,code){
	var json = json || JSON.parse(window.localStorage.dictJson);
	for(var i in json){
		var _thisDict = json[i];
		if(_thisDict.kind==kind&&_thisDict.code==code){
			return _thisDict.detail;
		}
	}
}
dict.bindCheckItem = function($dom){
	var kind = $dom.attr('dkind');
	var dname = $dom.attr('dname');
	var dicts = dict.dataList[kind];
	var html = [];
	//html.push('<label><input type="radio" name="'+dname+'"'+'value="" />不限</label>');
	for(var i in dicts){
		html.push('<button type="button" class="btn1 btn-outline" dval="'+dicts[i].value+'">'+dicts[i].text+'</button>');
	}
	$dom.html(html.join(''));
};


dict.initSelectData = function($parent){
	$parent.find('select[dictkind]').each(function(){
		var $this = $(this);
		common.bindSelData({
			selector : $this,
			data : dict.dataList[$this.attr('dictkind')]
		});
	});
};

/**
 * selector:jquery对象
 * data	:数组
 */
common.bindSelData = function(op){
	var $target = op.selector;
	var html = [];
	var rows = op.data;
	var val = $target.attr('value');
	if($target.attr('plsel') != 0){
		html.push('<option value="">请选择</option>');
	}
	for(var i in rows){
		var row = rows[i];
		var itemIndex = 0;
		for(var item in row){
			if(itemIndex % 2 == 0){
				html.push('<option value="'+row[item] +'" ');
				if(row[item] == val){
					html.push(' selected="selected" ');
				}
				html.push('>');
			}else{
				html.push(row[item] + '</option>"'  );
			}
			itemIndex++;
		}
	}
	$target.html(html.join(''));
};

dict.initCheckItems = function(){
	$('[dkind]').each(function(){
		var $this = $(this);
		dict.bindCheckItem($this);
		var $btns = $this.find('button');
		$btns.click(function(){
			var $btn = $(this);
			$btns.removeClass('active');
			$btn.addClass('active');
			$('input[name="'+$this.attr('dname')+'"]').val($btn.attr('dval'));
			
		});
		
	});
};

dict.getStagePercent = function (currStage){
	var statges = dict.dataList['100100'];
	var index = -1;
	for(var i = 0 ; i< statges.length ; i++){
		if(statges[i].value == currStage){
			index =  i;
			break;
		}
	}
	if(index > -1){
		index ++;
	}else{
		index = 0;
	}
	var res = index/statges.length * 100;
	res = common.fmDouble(res);
	return res;
}

dict.fmStagePercent = function (value){
	var statge = dict.getStagePercent(value);
	
	var html  = '<div class="progress"> '
				  +' <div class="progress-bar progress-bar-danger progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:'+statge+'%;">'
				  + statge+'%'
				  +'</div>'
			     +'</div>'
	
	return html;
};

dict.getNextStage = function(index){
	var stages = dict.prostage;
	var stage = '';
	for(var i in stages){
		if(stages[i].index > index ){
			stage = stages[i];
			break;
		}
	}
	return stage;
};
dict.prostage = {
	 'XMKS':{
		index : 10,
		text: '项目开始'
	 },        
     'XXSJ':{
    	 index : 20,
    	 text: '信息收集'
     },        
     'CQGT':{
    	 index : 30,
    	 text: '初期沟通'
     },        
     'KHBF':{
    	 index : 40,
    	 text: '客户拜访'
     },        
     'FAZZ':{
    	 index : 110,
    	 text: '方案制作'
     },        
     'FAYT':{
    	 index : 120,
    	 text: '方案预提'
     },        
     'FAHB':{
    	 index : 130,
    	 text: '方案汇报'
     },        
     'HTQY':{
    	 index : 210,
    	 text: '合同签约'
     },        
     'ZZJB':{
    	 index : 220,
    	 text: '制作脚本'
     },        
     'ZZMX':{
    	 index : 230,
    	 text: '制作模型'
     },        
     'MXYY':{
    	 index : 240,
    	 text: '模型预演'
     },        
     'ZZYP':{
    	 index : 250,
    	 text: '制作样片'
     },        
     'CPJF':{
    	 index : 260,
    	 text: '成片交付'
     },        
     'XMZJ':{
    	 index : 550,
    	 text: '项目总结'
     }        
};
dict.huiCommissionStatus = {"00":"未返佣","01":"待返佣","02":"已对账","03":"已开票","04":"已领票","05":"已开票","06":"已开票","07":"已收款"}
dict.commissionStatus = function(type,code){
	var x = "";
	if(type==="HOTEL"){
		switch (code){
			case "00":
			  x="未返佣";
			  break;
			case "01":
			  x="待返佣";
			  break;
			case "02":
			  x="已对账";
			  break;
			case "03":
			  x="已对账";
			  break;
			case "04":
			  x="已对账";
			  break;
			case "05":
			  x="已收票";
			  break;
			case "06":
			  x="已付款";
			  break;
			case "07":
			  x="已付款";
			  break;
		}
	}else{
		switch (code){
			case "00":
			  x="未返佣";
			  break;
			case "01":
			  x="待返佣";
			  break;
			case "02":
			  x="已对账";
			  break;
			case "03":
			  x="已开票";
			  break;
			case "04":
			  x="已开票";
			  break;
			case "05":
			  x="已开票";
			  break;
			case "06":
			  x="已开票";
			  break;
			case "07":
			  x="已收款";
			  break;
		}
	}
	return x;
}
