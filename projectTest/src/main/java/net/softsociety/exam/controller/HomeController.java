package net.softsociety.exam.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

import net.softsociety.exam.domain.Sukso;
import net.softsociety.exam.service.SuksoService;
import net.softsociety.exam.util.PageNavigator;



@Slf4j
@Controller
public class HomeController {
	@Autowired
	SuksoService service;
	
	@Value("${user.board.page}")
	int countPerPage;
	
	@Value("${user.board.group}")
	int pagePerGroup;
	

	/**
	 * 메인화면
	 */
	@GetMapping({"", "/"})
	public String home(Model model,
			@RequestParam(name="page", defaultValue="1")int page
			,String suk_nearby
			,String suk_location
			,@AuthenticationPrincipal UserDetails user
			) {
		PageNavigator navi = 
				service.getPageNavigator(pagePerGroup, countPerPage, page, suk_location, suk_nearby);
		
		ArrayList<Sukso> suksolist = service.suksolist(navi.getStartRecord(), countPerPage, suk_location, suk_nearby);
		model.addAttribute("suksolist", suksolist);
		model.addAttribute("navi", navi);
		model.addAttribute("nearby", suk_nearby);
		model.addAttribute("location", suk_location);
		log.debug("navi: {}", navi);
		

		
		return "mainpage";
	}
	
//	@GetMapping("read")
//	public String read(
//			@RequestParam(name="num", defaultValue="0") int num, Model model) {
//		Sukso sukso=service.read(num);
//		log.debug("bbbbbbaa:{}", sukso);
//		model.addAttribute("sukso", sukso);
//    	
//	
//		return "suksoInfo";
//	}
	
	
	
	
	
	
}
