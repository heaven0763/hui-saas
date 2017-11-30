package com.chuangbang.framework.util.hibernate.dialect;

import java.sql.Types;

import org.hibernate.dialect.function.NoArgSQLFunction;
import org.hibernate.type.StandardBasicTypes;


/**
 * @author denggeng
 * 覆盖原来的方言，改变对应的字段类型
 */
public class SQLServer2008Dialect extends org.hibernate.dialect.SQLServer2008Dialect {
	public SQLServer2008Dialect() {
		registerColumnType( Types.DATE, "date" );
		registerColumnType( Types.TIME, "time" );
		registerColumnType( Types.TIMESTAMP, "datetime" );
		//注册默认String类型的数据库类型
		registerColumnType( Types.VARCHAR, 4000, "nvarchar($l)" );
		//注册hibernate转换类型
		registerHibernateType(Types.NVARCHAR, "string");

		registerFunction(
				"current_timestamp", new NoArgSQLFunction( "current_timestamp", StandardBasicTypes.TIMESTAMP, false )
		);
	}
}
