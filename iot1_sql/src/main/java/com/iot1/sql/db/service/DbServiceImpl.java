package com.iot1.sql.db.service;

import java.util.List;

import org.apache.ibatis.metadata.Table;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iot1.sql.db.dao.DbDAO;
import com.iot1.sql.db.dto.DataBase;
import com.iot1.sql.db.dto.DbInfo;

@Service
public class DbServiceImpl implements DbService{
	
	@Autowired
	DbDAO dDao;
	
	@Override
	public List<DbInfo> getDbInfoList(DbInfo di){
		return dDao.selectDbInfoList(di);
	}

	@Override
	public List<DataBase> getDataBaseList() throws Exception {
		return dDao.selectDatabaseList();
	}

	@Override
	public boolean isConnecteDB(DbInfo pDi) throws Exception {
		DbInfo di=dDao.selectDbInfo(pDi);
		return dDao.isConnecteDB(di);
	}

	@Override
	public List<Table> getTableList(DataBase di) throws Exception {
		return dDao.selectTableList(di);
	}

}
