var common = common || {}; 

/**
 * 使用el表达式输出json的值
 * @param {Object} tmpl html元素
 * @param {Object} json json
 */
common.elToJson = function(tmpl,json){
    return tmpl.replace( /\$\{([^\}]*)\}/g,function(m,c){
        var res = '';
        var tel = /^[0-9]{2}$/;
        if(c.indexOf(',')!=-1&&tel.test(c.split(',')[0])){
            var arr=c.split(',');
            var kind = arr[0];
            var code = getAttributeValue(json,arr[1]);
            res = common.trsltDict(kind,code);
        }else{
            res = common.getAttributeValue(json,c);
        }
        if(isBlank(res)){
            res = '';
        }
        return res;
    });
};

/**
 * 可以获取el表达式中json对象包含的对象的值，调用了getListValue(object,attrs)方法
 * 例如${person.id}
 * @param {Object} json json对象
 * @param {Object} attr json对象的值，也可以是它包含的对象
 */
common.getAttributeValue = function(json,attr){
    var result = '';
    var attrs = attr.split('.');
    result = json;
    for(var i in attrs){
        result = getListValue(result,attrs[i]);
    }
    return result;
};

/**
 * 解析字典
 * @param {Object} kind 字典类型
 * @param {Object} code 值
 */
common.trsltDict = function(kind,code){
    var result = '';
    var dictArray = getStorJson('dictArray');
    if(kind<10&&kind.length>1){
        kind = kind.substring(1);
    }
    if(code<10&&code.length>1){
        code = code.substring(1);
    }
    code--;
    if(dictArray[kind][code]){
        result = dictArray[kind][code].detail;
    }
    return result;
};

/**
 * 可以获取el表达式中json对象包含的List对象的值
 * 例如${person.kis[0].id
 * @param {Object} object   json对象
 * @param {Object} attrs    json对象的值，也可以是包含的List对象的值
 */
common.getListValue = function(object,attrs){
    if(attrs.indexOf('[')==-1){
        return object[attrs];
    }
    var objects ='';
    var index = '';
    attrs.replace(/\[([^\}]*)\]/g,function(m,c){
         objects = attrs.substring(0,attrs.indexOf('['));
         index = c;
    });
    return object[objects][index];
};



