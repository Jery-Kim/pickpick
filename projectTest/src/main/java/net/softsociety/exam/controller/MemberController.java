package net.softsociety.exam.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.exam.domain.Member;
import net.softsociety.exam.service.MemberService;

/**
 * 회원 정보 관련 콘트롤러
 */

@Slf4j
@RequestMapping("member")
@Controller
public class MemberController {
	@Autowired
	MemberService service;
	
	@GetMapping("join")
	public String join() {
		return "member/joinForm";
	}
	@PostMapping("join")
	public String join(Member member) {
		log.debug("가입정보 : {}", member);
		int result = service.insertMember(member);
		
		return "redirect:/";
	}
	
	
	@GetMapping("idcheck")
	public String idcheck() {
		return "member/idcheck";
	}
	
	@GetMapping("nickname_check")
	public String nickname_check() {
		return "member/nickname_check";
	}
	@GetMapping("email_check")
	public String email_check() {
		return "member/email_check";
	}
	
	@PostMapping("nickname_check")
	public String nickname_check(String mem_nickname, Model model) {
		log.debug("mem_nickname:{}",mem_nickname);

		boolean res = service.nick_namecheck(mem_nickname);
		model.addAttribute("search_nickname", mem_nickname);
		model.addAttribute("result", res);
		return "member/nickname_check";
	}
	@PostMapping("idcheck")
	public String idcheck(String mem_id, Model model) {
		log.debug("mem_id:{}",mem_id);

		boolean res = service.idcheck(mem_id);
		model.addAttribute("searchID", mem_id);
		model.addAttribute("result", res);
		return "member/idcheck";
	}

	@PostMapping("email_check")
	public String email_check(String mem_email, Model model) {
		log.debug("mem_email:{}",mem_email);
		boolean res = service.email_check(mem_email);
		model.addAttribute("search_email", mem_email);
		model.addAttribute("result", res);
		return "member/email_check";
	}
	
	
	@GetMapping("/login")
    public String login() {
	
        return "member/loginForm";
    }
	@GetMapping("quit")
	public String quit(@AuthenticationPrincipal UserDetails user, Model model) {
		log.debug("인증정보 : {}", user.getUsername());
		String mem_id = user.getUsername();
		model.addAttribute("mem_id", mem_id);
		return "member/quit";
	}
	@PostMapping("quit")
	   public String quit(
	         @AuthenticationPrincipal UserDetails user
	         , String mem_password
	         , Model model) {
	      
	      Map<String, String> map = new HashMap<>();
	      String mem_id = user.getUsername();
	      
	      map.put("mem_id", mem_id);
	      map.put("mem_password", mem_password);

	      int res = service.delete(map);
	      
	      if(res == 0) {
	         model.addAttribute("mem_id", mem_id);
	         return "member/quit";
	      }
	      
	      return "redirect:/member/logout";
	      // 로그아웃 시켜주면서 마무리
	   }
	
	@GetMapping("check")
	public String check (@AuthenticationPrincipal UserDetails user, Model model) {
		log.debug("인증정보 : {}", user.getUsername());
		Member member = service.getMember(user.getUsername());
		model.addAttribute("member", member);
		return "member/check";
	}

	@PostMapping("check")
	   public String check(
	         @AuthenticationPrincipal UserDetails user
	         , String mem_password
	         , Model model) {
	      
	      Map<String, String> map = new HashMap<>();
	      String mem_id = user.getUsername();
	      
	      map.put("mem_id", mem_id);
	      map.put("mem_password", mem_password);

	      int res = service.check(map);
	      
	      if(res == 0) {
	         model.addAttribute("mem_id", mem_id);
	         return "member/check";
	      }
	      Member member = service.getMember(user.getUsername());
		  model.addAttribute("member", member);
	      
	      return "member/updateMember";
	      
	   }

	
//	@GetMapping("update")
//	public String update (@AuthenticationPrincipal UserDetails user, Model model) {
//		log.debug("인증정보 : {}", user.getUsername());
//		Member member = service.getMember(user.getUsername());
//		model.addAttribute("member", member);
//		return "update_member";
//	}
	
	
	
	
	@PostMapping("update")
	public String update(Member member, @AuthenticationPrincipal UserDetails user) {
		member.setMem_id(user.getUsername());
		service.update(member);
		log.debug("인증정보 : {}", member);
		return "redirect:/";
	}
	
	@GetMapping("/profile")
    public String profile(@AuthenticationPrincipal UserDetails user, Model model) {
		Member member = service.getMember(user.getUsername());
		model.addAttribute("member", member);
        return "member/profile1";
    }
	
	
	
	}


