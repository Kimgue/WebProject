package com.hungpick.controller;


import java.util.List;



import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hungpick.dto.MenuVo;
import com.hungpick.dto.ReviewRankingVo;
import com.hungpick.service.IBrandService;
import com.hungpick.service.IMenuService;
import com.hungpick.service.IReviewService;

@Controller
public class UserController2 {


	/*------------------------정진욱------------------------*/
	@Autowired
	private IBrandService brandService;

	@Autowired
	private IMenuService menuService;

	@Autowired
	private IReviewService reviewService;
	
	private static final Logger logger = LoggerFactory.getLogger(UserController2.class);


	/*------------------------정진욱------------------------*/
	@RequestMapping("brand")
	public void brand(Model model) throws Exception {
		logger.info("brand called ========");
		model.addAttribute("brand", brandService.sltMulti());
	}

	//메뉴 페이지
	@RequestMapping("menu")
	public void menu(Model model) throws Exception {
		logger.info("menu called ========");
		model.addAttribute("menu", menuService.sltMulti());
		List<ReviewRankingVo> list = reviewService.sltReviewRanking();
		
		model.addAttribute("reviewRanking", list);
	}
	
	//메뉴 조건검색한 페이지
	@ResponseBody
	@RequestMapping("menuResult.do")
	public List<MenuVo> menuResult(
			@RequestBody Map<String, Object> map,
			Model model) throws Exception {
		
		logger.info("menuVo called ========");
		String brandName = (String) map.get("brandName");
		String menuPrice = (String) map.get("menuPrice");
		String menuIngredients = (String) map.get("menuIngredients");
		String menuName = (String) map.get("menuName");
		System.out.println(brandName + " " + menuPrice + " " + menuIngredients + " " + menuName );
		List<MenuVo> menuVo = menuService.sltSearch(brandName, menuPrice, menuIngredients, menuName);
		System.out.println(menuVo);
		
		return menuVo;
			
//		String ResultMsg; 프론트에서 하기`-
//		if (list.size() > 0) {
//			ResultMsg = "정상 조회되었습니다.";
//		} else {
//			ResultMsg = "죄송합니다. 해당되는 상품이 없습니다.";
//		}
//		
		
		//ajax에서는 리턴값만 전달되기 때문에 모델이 전달 되지 않는다.
		//model.addAttribute("ResultMsg", ResultMsg);
		//model.addAttribute("menuVo", menuService.sltSearch(brandName, menuPrice, menuIngredients, menuName));
		
	}
	
	//상품의 리뷰 페이지
	@RequestMapping("review")
	public void review(
			@RequestParam String brandCode, 
			@RequestParam String menuCode, 
			String menuName, 
			Model model)
			throws Exception {
		logger.info("review called ========");
		model.addAttribute("menuName", menuName);
		model.addAttribute("review", reviewService.sltReviewList(brandCode, menuCode));
	}
	
	//상세리뷰 페이지
	@RequestMapping("reviewLookup")
	public void reviewLookup(
			@RequestParam String brandCode, 
			@RequestParam String menuCode,
			@RequestParam String reviewCode, 
			@RequestParam String memberCode, 
			Model model) throws Exception {

		logger.info("reviewLookup called =======");
		
		model.addAttribute("Lookup", reviewService.sltLookUp(brandCode, menuCode, reviewCode, memberCode));
	}
	
	@RequestMapping("reviewWrite")
	public void reviewWrite(
			@RequestParam String brandCode, 
			@RequestParam String menuCode, 
			@RequestParam String menuName,
			HttpServletRequest request,
			Model model) throws Exception {
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("memberCode") == null) {
			String msg = "리뷰 작성시 로그인이 필요합니다.";
			String url = "userLogin";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return;
		}
		logger.info("reviewWrite called ========");
		model.addAttribute("brandCode", brandCode);
		model.addAttribute("menuCode", menuCode);
		model.addAttribute("menuName", menuName);

	}
	
	//리뷰 작성 페이지
	@RequestMapping("reviewWriteSubmit")
	public String reviewWriteSubmit(
			@RequestParam String brandCode, 
			@RequestParam String menuCode, 
			@RequestParam double reviewScore,
			@RequestParam String reviewContent, 
			@RequestParam String reviewImg1,
			@RequestParam String reviewImg2, 
			HttpServletRequest request,
			Model model) throws Exception {
		
		HttpSession session = request.getSession();
		String memberCode = (String) session.getAttribute("memberCode");
		
		reviewService.insertReview(brandCode, menuCode, memberCode, reviewScore, reviewContent, reviewImg1, reviewImg2);

		logger.info("reviewWriteSubmit called =======");
		
		
		return "review";
	
	}
}