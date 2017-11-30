package ${packageName}.web.${moduleName};

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chuangbang.framework.web.BaseController;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import ${packageName}.entity.${moduleName}.${ClassName};
import ${packageName}.service.${moduleName}.${ClassName}Service;

/**
 * ${functionName}Controller
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Controller
@RequestMapping(value = "${moduleName}/${urlPrefix}")
public class ${ClassName}Controller extends BaseController {

	@Autowired
	private ${ClassName}Service ${className}Service;
	
	@ModelAttribute("${className}")
	public ${ClassName} get${ClassName}(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return ${className}Service.getEntity(id);
		}
		return new ${ClassName}();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "${moduleName}/${className}Form";
	}
	
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "${moduleName}/${className}Form";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(${ClassName} ${className}) {
		${className}Service.save${ClassName}(${className});
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<${ClassName}> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<${ClassName}> page = ${className}Service.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		${ClassName} ${className} = ${className}Service.getEntity(id);
		model.addAttribute("${className}", ${className});
		return new ModelAndView("${moduleName}/${className}Form");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		${className}Service.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
