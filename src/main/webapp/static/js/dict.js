var dict = dict || {};
var clientData = clientData || {};
dict.jsonList = {};
dict.dataList = {};

dict.init = function(){
	var json = clientData.dictList.rows || clientData.dictList;
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
		
		dict[_thisDict.kind] = new Function('code','row','return dict.jsonList[\''+_thisDict.kind+'\'][code];');
	}
	if(dict.cb){
		dict.cb();
	}
	
};

dict.getDicts = function(){
	EEJ.ajax({
		type : 'get',
		dataType : 'json',
		url : EEJ.basePath+'/framework/dictionary/listAll',
		success: function(result){
			clientData.dictList = result;
			dict.init();
		}
	});
};
