package com.iot1.sql.vendor.service;

import java.util.List;

import com.iot1.sql.vendor.dto.VendorInfo;

public interface VendorService {
	public VendorInfo getVendorInfo(VendorInfo vi);
	public List<VendorInfo> getVendorInfoList(VendorInfo vi);
	public List<VendorInfo> getVendorInfoCombo();
	public int insertVendorInfoList(VendorInfo[] vi);
	public int insertVendorInfo(VendorInfo vi);
	public int updateVendorInfo(VendorInfo vi);
	public int deleteVendorInfo(VendorInfo vi);
	
}
