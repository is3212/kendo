package com.iot1.sql.vendor.dao;

import java.util.List;

import com.iot1.sql.vendor.dto.VendorInfo;

public interface VendorDAO {
	public VendorInfo selectVendorInfo(VendorInfo vi);
	public List<VendorInfo> selectVendorInfoList(VendorInfo vi);
	public List<VendorInfo> selectVendorInfoCombo();
	public int insertVendorInfo(VendorInfo vi);
	public int updateVendorInfo(VendorInfo vi);
	public int deleteVendorInfo(VendorInfo vi);

}
