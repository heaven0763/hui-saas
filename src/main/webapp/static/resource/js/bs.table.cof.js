
$(document).ready(function() {
	jQuery.fn.bootstrapTable.defaults.idField = 'id';
	jQuery.fn.bootstrapTable.defaults.pagination = true;
	jQuery.fn.bootstrapTable.defaults.sidePagination = 'server';
	jQuery.fn.bootstrapTable.defaults.smartDisplay = false;
	jQuery.fn.bootstrapTable.defaults.cache = false;
	jQuery.fn.bootstrapTable.defaults.method = 'post';
	jQuery.fn.bootstrapTable.defaults.striped = true;
	jQuery.fn.bootstrapTable.defaults.contentType = 'application/x-www-form-urlencoded';
});