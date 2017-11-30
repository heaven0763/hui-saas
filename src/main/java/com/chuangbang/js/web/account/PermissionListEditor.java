package com.chuangbang.js.web.account;

import java.beans.PropertyEditorSupport;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.utils.Collections3;

import com.chuangbang.js.entity.account.Permission;
import com.chuangbang.js.service.account.PermissionService;


@Component
public class PermissionListEditor extends PropertyEditorSupport {
	@Autowired
	private PermissionService permissionService;

	/**
	 * Back From Page
	 */
	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		String[] ids = StringUtils.split(text, ",");
		List<Permission> permissions = new ArrayList<Permission>();
		for (String id : ids) {
			if(Long.valueOf(id)>450){
				Permission permission = permissionService.getPermission(Long.valueOf(id));
				permissions.add(permission);
			}
		}
		setValue(permissions);
	}

	/**
	 * Set to page
	 */
	@Override
	public String getAsText() {
		return Collections3.extractToString((List) getValue(), "id", ",");
	}
}
