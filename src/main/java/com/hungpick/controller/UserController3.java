package com.hungpick.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hungpick.dto.UserDto;
import com.hungpick.service.IUserService;

@Controller
public class UserController3 {

	@Autowired
	private IUserService userService;

	// 회원조회
	@RequestMapping("userView")
	public void userView(UserDto Dto, Model model) throws Exception {
		List<UserDto> list = userService.sltMulti(Dto);
		model.addAttribute("LIST", list);
	}

	// 회원가입 페이지
	@RequestMapping("userRegist")
	public void userRegist() {
	}

	// 마이 페이지
	@RequestMapping("userPage")
	public void userPage() {
	}

	// 로그아웃
	@RequestMapping("userLogout")
	public String userLogout(HttpSession session) throws Exception {
		userService.userLogout(session);
		return "redirect:/main.jsp";
	}

	// 회원가입
	@RequestMapping("userRegistSubmit")
	public String userRegistSubmit(UserDto Dto) throws Exception {
		userService.userRegist(Dto);
		return "redirect:/main.jsp";
	}

	// 로그인 페이지
	@RequestMapping("userLogin")
	public void userLogin() {
	}

	// 로그인
	@RequestMapping("userLoginTry")
	public ModelAndView userLoginTry(@Param("memberId") String memberId, @Param("memberPw") String memberPw, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		UserDto Dto = userService.userLogin(memberId, memberPw);
		
		if (Dto != null) {
			session.setAttribute("memberDTO", Dto);
			session.setAttribute("memberCode", Dto.getMemberCode());
			session.setAttribute("memberId", Dto.getMemberId());
			session.setAttribute("memberPw", Dto.getMemberPw());
			session.setAttribute("memberName", Dto.getMemberName());
			session.setAttribute("memberNickname", Dto.getMemberNickname());
			session.setAttribute("memberNumber", Dto.getMemberNumber());
			session.setAttribute("memberEmail", Dto.getMemberEmail());
			session.setAttribute("memberDate", Dto.getMemberDate());
			session.setAttribute("holdPoint", Dto.getHoldPoint());
			mav.setViewName("redirect:/main.jsp");
			return mav;
		} else {
			session.setAttribute("loginNotice", "올바른 아이디 혹은 비밀번호를 입력해주세요");
			mav.setViewName("redirect:/userLogin");
			session.setMaxInactiveInterval(1);
			return mav;
		}
	}
	
//	// 로그인 성공
//	public ModelAndView userLoginConfirm(@Param("memberId") String memberId, @Param("memberPw") String memberPw, HttpSession session) throws Exception {
//		ModelAndView mav = new ModelAndView();
//		UserDto Dto = userService.userLogin(memberId, memberPw);
//		System.out.println("ㅇㅇ");
//		if (Dto != null) {
//			// 세션에 값 등록
//			session.setAttribute("memberDTO", Dto);
//			session.setAttribute("memberId", Dto.getMemberId());
//			session.setAttribute("memberPw", Dto.getMemberPw());
//			
//			mav.setViewName("redirect:/main.jsp");
//			System.out.println("TRUE " + session);
//		} else {
//			session.setAttribute("loginNotice", "올바른 아이디 혹은 비밀번호를 입력해주세요");
//			mav.setViewName("redirect:/userLogin");
//			System.out.println("FALSE " + session);
//		}
//		return mav;
//	} 
	
	

	// PW 검사
	@RequestMapping("pwChkCtrl.do")
	@ResponseBody
	public String pwChk(@ModelAttribute("inputPw") @Param("inputPw") String inputPw, HttpSession session)
			throws Exception {
		boolean result = false;
		if (inputPw.equals(session.getAttribute("memberPw"))) {
			result = true;
		} else {
			result = false;
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		String jsonOut = jsonObj.toString();

		return jsonOut;
	}

	// ID 중복검사
	@RequestMapping("idChkCtrl.do")
	@ResponseBody
	public String idChk(@ModelAttribute("id") String memberId) throws Exception {
		String idChk = userService.checkId(memberId);
		boolean result = false;
		if (idChk.equals("0")) {
			result = true;
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		String jsonOut = jsonObj.toString();

		return jsonOut;
	}

	public void userDelete(@Param("memberId") String memberId, @Param("memberPw") String memberPw) throws Exception {
		userService.userDelete(memberId, memberPw);
	}

	// 정보수정
	@RequestMapping("chkNickname.do")
	@ResponseBody
	public String chkNickname(@ModelAttribute("nickname") String memberNickname, UserDto Dto, HttpSession session) throws Exception {
		String chkNickname = userService.checkNickname(memberNickname);
		
		boolean result = false;
		if (chkNickname.equals("0")) {
			Dto = (UserDto) session.getAttribute("memberDTO");
			Dto.setMemberNickname(memberNickname);
			userService.userUpdate(Dto);			
		
			result = true;
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		String jsonOut = jsonObj.toString();

		return jsonOut;
	}
}