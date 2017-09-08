package com.iot1.sql.vendor.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iot1.sql.vendor.dao.VendorDAO;
import com.iot1.sql.vendor.dto.VendorInfo;
import com.iot1.sql.vendor.service.VendorService;

@Controller
public class VendorController {
	
	@Autowired
	VendorService vs;
	@Autowired
	VendorDAO vDao;
	
	@RequestMapping(value="/vendor/list", method=RequestMethod.POST)
	public @ResponseBody List<VendorInfo> getVendorInfoList(VendorInfo vi){
		return vs.getVendorInfoList(vi);
	}
	
	@RequestMapping(value="/vendor/combo",method=RequestMethod.GET)
	public String getVendorInfoCombo(Model model, HttpServletRequest request){
		List <VendorInfo> vendorList=vs.getVendorInfoCombo();
		
		List<Map<String,Object>> result=new ArrayList<Map<String,Object>>();
		
		for(VendorInfo vi:vendorList){
			Map<String,Object> hm=new HashMap<String,Object>();
			hm.put("value",vi.getViNum());
			hm.put("text", vi.getViName());
			result.add(hm);
		}
		model.addAttribute("vendors",result);
		String url=request.getParameter("url");
		if(url==null || url.equals("")){
		return "goods/goods_list_incell";
				}
		return url;
	}
	@RequestMapping(value="/vendor/create",method=RequestMethod.POST)
	public@ResponseBody List<VendorInfo> insertVendorInfoList(@RequestBody VendorInfo[] vendorList,VendorInfo vi){
		vs.insertVendorInfoList(vendorList);
		return vs.getVendorInfoList(vi);
	}
	
	@RequestMapping(value="/vendor/update",method=RequestMethod.POST)
	public @ResponseBody List<VendorInfo> updateVendorInfoList(@RequestBody VendorInfo[] vendorList,VendorInfo vi){
		for(VendorInfo vi2 : vendorList){
			vDao.updateVendorInfo(vi2);
		}
		return vs.getVendorInfoList(vi);
	}
	
	@RequestMapping(value="/vendor/delete",method=RequestMethod.POST)
	public @ResponseBody List<VendorInfo> deleteVendorInfoList(@RequestBody VendorInfo[] vendorList,VendorInfo vi){
		for(VendorInfo vi2 : vendorList){
			vDao.deleteVendorInfo(vi2);
		}
		return vs.getVendorInfoList(vi);
	}
	
}


