package ${packageName}.service.${moduleName};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import ${packageName}.entity.${moduleName}.${ClassName};
import ${packageName}.dao.${moduleName}.${ClassName}Dao;

/**
 * ${functionName}Service
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Component
@Transactional(readOnly = true)
public class ${ClassName}Service extends BaseService<${ClassName},${ClassName}Dao> {

	@Autowired
	private ${ClassName}Dao ${className}Dao;
	
	public ${ClassName} getEntity(Long id) {
		return ${className}Dao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void save${ClassName}(${ClassName} ${className}) {
		${className}Dao.save(${className});
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		${className}Dao.delete(id);
	}
	
}
