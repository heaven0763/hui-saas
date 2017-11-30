package ${packageName}.dao.${moduleName};

import ${packageName}.entity.${moduleName}.${ClassName};
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * ${functionName}DAO接口
 * @author ${classAuthor}
 * @version ${classVersion}
 */
public interface ${ClassName}Dao extends BaseRepository<${ClassName}, Long>,PagingAndSortingRepository<${ClassName}, Long>{

}