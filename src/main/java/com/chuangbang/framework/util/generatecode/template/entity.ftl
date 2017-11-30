package ${packageName}.entity.${moduleName};

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.chuangbang.framework.entity.IdEntity;

/**
 * ${functionName}Entity
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Entity
@Table(name = "${tableName}")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ${ClassName} extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	<#list properties as prop>  
	<#if prop.annotation??>
	/**
	 * ${prop.annotation}
	 */
	</#if>
	private ${prop.dataType} ${prop.name};  
	
  	</#list>
  <#list properties as prop>  
  
    public ${prop.dataType} get${prop.name?cap_first}(){  
      return ${prop.name};  
    }  
    
    public void set${prop.name?cap_first}(${prop.dataType} ${prop.name}){  
      this.${prop.name} = ${prop.name};  
    }  
  </#list>  
}


