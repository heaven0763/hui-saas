package com.chuangbang.js.web.account;

import java.beans.PropertyEditorSupport;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.utils.Collections3;

import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.service.account.UserService;
import com.google.common.collect.Lists;


/**
 * 用于转换用户表单中复杂对象Group的checkbox的关联。
 * 
 * @author Heaven
 */
@Component
public class GroupPersListEditor extends PropertyEditorSupport {

	@Autowired
	private UserService accountManager;

	/**
	 * Back From Page
	 */
	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		String[] ids = StringUtils.split(text, ",");
		List<Group> groups = new ArrayList<Group>();
		for (String id : ids) {
			Group group = accountManager.getGroup(Long.valueOf(id));
			groups.add(group);
		} 
		this.setValue(groups);
	}

	/**
	 * Set to page
	 */
	@Override
	public String getAsText() {
		return Collections3.extractToString((List) getValue(), "id", ",");
	}
	
	@Override
	public void setValue(Object value) {
		if (value == null) {
			super.setValue(Lists.newArrayList());
		} else {
			super.setValue(value);
		}
	}
}
