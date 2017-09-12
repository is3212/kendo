package com.iot1.sql.db.service;

import java.util.List;

import org.apache.ibatis.metadata.Table;

import com.iot1.sql.db.dto.DataBase;
import com.iot1.sql.db.dto.DbInfo;

public interface DbService {
	public List<DbInfo> getDbInfoList(DbInfo di);
	public List<DataBase> getDataBaseList() throws Exception;
	public boolean isConnecteDB(DbInfo pDi) throws Exception;
	public List<Table> getTableList(DataBase di) throws Exception;

}
