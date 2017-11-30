package com.chuangbang.js.web.account;

import java.beans.PropertyEditorSupport;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.utils.Collections3;

import com.chuangbang.js.entity.account.Menu;
import com.chuangbang.js.service.account.MenuService;


@Component
public class MenuListEditor extends PropertyEditorSupport {
	@Autowired
	private MenuService menuService;

	/**
	 * Back From Page
	 */
	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		String[] ids = StringUtils.split(text, ",");
		List<Menu> menus = new ArrayList<Menu>();
		for (String id : ids) {
			System.out.println(">>>>>>>>>>>>"+id);
			if(StringUtils.isNotBlank(id)){
				Menu menu = menuService.getMenu(Long.valueOf(id));
				menus.add(menu);
			}
		}
		setValue(menus);
	}

	/**
	 * Set to page
	 */
	@Override
	public String getAsText() {
		return Collections3.extractToString((List) getValue(), "id", ",");
	}
}
