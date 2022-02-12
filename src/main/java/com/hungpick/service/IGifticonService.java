package com.hungpick.service;

import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;

import com.hungpick.dto.GifticonDto;

public interface IGifticonService {

	// 기프티콘 조회
	public String showGifticon(GifticonDto Dto, Model model) throws Exception;
	
	// 기프티콘 등록
	public String insertGifticon(GifticonDto Dto, MultipartFile uploadfile, ModelMap modelMap) throws Exception;
	
	// 기프티콘 삭제
	public String deleteGifticon(GifticonDto Dto, ModelMap modelMap) throws Exception;
}
