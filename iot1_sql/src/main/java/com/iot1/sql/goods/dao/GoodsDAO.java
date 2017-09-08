package com.iot1.sql.goods.dao;

import java.util.List;

import com.iot1.sql.goods.dto.GoodsInfo;

public interface GoodsDAO {
	public GoodsInfo selectGoodsInfo(GoodsInfo gi);
	public List<GoodsInfo> selectGoodsInfoList(GoodsInfo gi);
	public int insertGoodsInfo(GoodsInfo gi);
	public int updateGoodsInfo(GoodsInfo gi);
	public int deleteGoodsInfo(GoodsInfo gi);
}
