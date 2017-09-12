package com.iot1.sql.db.dao;

import java.util.List;

import org.apache.ibatis.metadata.Table;

import com.iot1.sql.db.dto.DataBase;
import com.iot1.sql.db.dto.DbInfo;

public interface DbDAO {
	public List<DbInfo> selectDbInfoList(DbInfo di);
	public DbInfo selectDbInfo(DbInfo di);
	public boolean isConnecteDB(DbInfo di) throws Exception;
	public List<DataBase> selectDatabaseList() throws Exception;
	public List<Table> selectTableList(DataBase di) throws Exception;

}
