
该框架的主要特色：
1、将easyui的tab,panel,dialog都用面向对象思想进行封装，并提供api
2、该框架的使用与原生easyui框架无冲突
3、有效防止多个tab的id冲突

使用简介：
1、需要管理多个tab？   var mainTabs = new EEJ.tabs('navTab');
2、需要打开一个tab？   mainTabs.open({url:'${ctx}/portal/index',title:'首页',closable:false});
3、需要打开一个dialog？ var dialog = EEJ.openDialog(op);


1、EEJ.tabs  = function(tabsId)  //使用该方法new一个管理多个tab的对象，该对象是完全自定义的

方法：
getTab = function()  //返回当前选中的tab
find = function(selector)  //等于在当前tab使用jquery的find方法
bindRightClick = function()	//绑定右键弹出关闭等选项卡
open = function(tabOption)	//打开一个新的tab,根据title,如果存在则只刷新

2、EEJ.openDialog = function(op)   //打开一个dialog，并返回该dialog的jquery对象

3、EEJ.DWZ.ListPanel = function()  //一般在list.jsp使用，通过new这个来获取新打开的list.jsp的对象，该对象是完全自定义的

属性：

jqdiv //该页面所在的div的jquery对象
parent //打开这个panel所在的父panel的jquery对象，相应的，父panel的child就是该panel的jquery对象
datagrid //该页面内id为dg的table的jquery对象
dgDiv //该页面内id为dgDiv的div的jquery对象
searchForm //该页面内id为searchForm的form的jquery对象

方法：

bindDWZEvent = function()	//绑定dwz的事件，包括查询datagrid和<a target="dialog"/>这种事件

search = function() //datagrid的查询，会自动获取searchForm里的条件进行查询

4、EEJ.DWZ.Dialog  = function() //一般在form.jsp使用，通过new这个来获取新打开的form.jsp的对象，该对象是完全自定义的

属性：
jqdiv //该页面所在的div的jquery对象
parent //打开这个dialog所在的父panel的jquery对象，相应的，父panel的child就是该dialog的jquery对象
subForm //该页面内id为subForm的form的jquery对象

方法：

/**
 * 提交表单后的回调方法，已经写好的默认的是如果操作成功则弹出提示、关闭该dialog并刷新datagrid
 * 根据需求可以自行覆写该方法，ex : 
 * var _self = new EEJ.DWZ.Dialog();
 * _self.submitSuccessCb = fucntion(json){
 * 
 * }
 * PS：这样覆写只会改变当前dialog的submitSuccessCb()方法，不会影响其它dailog
 */
submitSuccessCb = function(json) 

close = function() //关闭该dialog



5、EEJ  //（不需要new）
静态属性：
keyCode //键盘的keycode
statusCode //后台返回的statusCode

静态方法：
bindSearchEvent : function(listObj) //绑定查询事件
bindTargetEvent : function(panelObj) //绑定<a target="dialog"/>这种事件
bindFormEvent : function(formObj)	//绑定表单的校验与提交事件





