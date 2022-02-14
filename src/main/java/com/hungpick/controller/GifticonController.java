package com.hungpick.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.hungpick.dto.GifticonDto;
import com.hungpick.service.IGifticonService;

@Controller
public class GifticonController {
	
	@Autowired
	private IGifticonService gifticonService;
	
	/*--------------------- 기프티콘 조회 ---------------------*/
	public void giftconsltMulti(GifticonDto Dto, Model model) throws Exception {
		gifticonService.showGifticon(Dto, model);
	}
	
	/*--------------------- 기프티콘 조회 페이지 ---------------------*/
	@RequestMapping("gifticonList")
	public void giftiConList(GifticonDto Dto, Model model) throws Exception {
		giftconsltMulti(Dto, model);
	}
	
	/*--------------------- 기프티콘 등록 페이지 ---------------------*/
	@RequestMapping("gifticonInsert")
	public void gifticonInsert() {
	}
	
	/*--------------------- 기프티콘 수정 페이지 ---------------------*/
	@RequestMapping("gifticonUpdate")
	public void gifticonUpdate(GifticonDto Dto, Model model) throws Exception {
		giftconsltMulti(Dto, model);
	}
	
	/*--------------------- 기프티콘 삭제 페이지 ---------------------*/
	@RequestMapping("gifticonDelete")
	public void gifticonDelete(GifticonDto Dto, Model model) throws Exception{
		giftconsltMulti(Dto, model);
	}
	
	/*--------------------- 기프티콘 삭제 완료 눌렀을 때 ---------------------*/
	@RequestMapping("gifticonDeleteSubmit")
	public String gifticonDeleteSubmit(GifticonDto Dto) throws Exception {
		String view = gifticonService.deleteGifticon(Dto);
		return view;
	}
	
	/*--------------------- 기프티콘 등록 완료 눌렀을 때 ---------------------*/
	@RequestMapping("gifticonInsertSubmit")
	public String gifticonInsertSubmit(GifticonDto Dto) throws Exception {
		String view = gifticonService.insertGifticon(Dto);
		return view;
	}
	
	/*--------------------- 기프티콘 수정 완료 눌렀을 때 ---------------------*/
	@RequestMapping("gifticonUpdateSubmit")
	public String gifticonUpdateSubmit(GifticonDto Dto, MultipartFile uploadfile, ModelMap modelMap, String fileLoc) throws Exception {
		return null;
	}
	

}
