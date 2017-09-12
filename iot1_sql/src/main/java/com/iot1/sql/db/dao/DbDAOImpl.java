package com.iot1.sql.db.dao;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.metadata.Table;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.iot1.sql.db.controller.DataSourceFactory;
import com.iot1.sql.db.dto.DataBase;
import com.iot1.sql.db.dto.DbInfo;

@Repository
public class DbDAOImpl extends SqlSessionDaoSupport implements DbDAO{
	@Autowired
	DataSourceFactory dsf;
	
	@Override
	public List<DbInfo> selectDbInfoList(DbInfo di){
		return this.getSqlSession().selectList("db.SELECT_DB",di);
	}
	
	@Override
	public DbInfo selectDbInfo(DbInfo di){
		return this.getSqlSession().selectOne("db.SELECT_DB",di);
	}

	@Override
	public boolean isConnecteDB(DbInfo di) throws Exception {
		return dsf.isConnecteDB(di);
	}

	@Override
	public List<DataBase> selectDatabaseList() throws Exception {
		DatabaseMetaData meta = dsf.getSqlSession().getConnection().getMetaData();
		ResultSet ctlgs = meta.getCatalogs();		
		List<DataBase> databaseList = new ArrayList<DataBase>();
		while (ctlgs.next())
		{
			DataBase db = new DataBase();
			db.setDatabase(ctlgs.getString(1));
			databaseList.add(db);
		}
		return databaseList;
	}

	@Override
	public List<Table> selectTableList(DataBase di) throws Exception {
		
		return dsf.getSqlSession().selectList("db.TABLE_SELECT",di);
	}
}
