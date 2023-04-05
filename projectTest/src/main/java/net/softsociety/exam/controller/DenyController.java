package net.softsociety.exam.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.exam.domain.Deny;
import net.softsociety.exam.domain.Deny_Comment;
import net.softsociety.exam.service.DenyService;
import net.softsociety.exam.util.FileService;




@Slf4j
@RequestMapping("deny")
@Controller
public class DenyController {
	@Autowired
	DenyService service;
	
	@Value("${spring.servlet.multipart.location}")
	String uploadPath;
	

	@GetMapping("write_deny")
	public String write_deny() {
		return "deny/writeDeny";
	}
	
	@GetMapping("read_deny")
	public String read_deny(Model model) {
		ArrayList<Deny> denylist = service.denylist();
		model.addAttribute("denylist", denylist);
		return "deny/DenyList";
	}
	
	@PostMapping("/writedeny")
	public String writedeny(Deny deny, @AuthenticationPrincipal UserDetails user, MultipartFile upload) {
		
		if(upload!=null && !upload.isEmpty()) {
			String filename=FileService.saveFile(upload, "c:/upload");
			deny.setDeny_files_orz(upload.getOriginalFilename());
			deny.setDeny_files_saved(filename);
		}
		log.debug("deny:{}", deny);
		deny.setMem_id(user.getUsername());
		
	
		service.insertDeny(deny);
		return "redirect:/";
	}
	
	@GetMapping("read")
	public String read(
			@RequestParam(name="num", defaultValue="0") int num, Model model) {
		Deny deny=service.read_deny(num);
		log.debug("bbbbbbaa:{}", deny);
		model.addAttribute("deny", deny);
    	ArrayList<Deny_Comment> Deny_Comment=service.read_denyReply(num);
		model.addAttribute("Deny_Comment", Deny_Comment);
		
		return "deny/readDeny";
	}
       
 
	@GetMapping("download")
	public void download(
			@RequestParam(name="num", defaultValue="0") int num
			,HttpServletResponse response) {
		Deny deny=service.selectDeny(num);
		if(deny==null || deny.getDeny_files_saved()==null) {
			
			return ;
		}
	String file= uploadPath + "/" + deny.getDeny_files_saved();
	FileInputStream in = null;
	ServletOutputStream out = null;

	try {
		response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(deny.getDeny_files_orz(), "UTF-8"));
		in=new FileInputStream(file);
		out = response.getOutputStream();
		FileCopyUtils.copy(in,out);
		in.close();
		out.close();
	}
catch(IOException e){
		
	}
	return ;
	}
	
	@PostMapping("/writeReply")
	public String writeReply(Deny_Comment deny_Comment, @AuthenticationPrincipal UserDetails user) {
		
		deny_Comment.setMem_id(user.getUsername());
		log.debug("reply:{}", deny_Comment);
		service.writeReply(deny_Comment);
		log.debug("{}", deny_Comment.getDeny_num());
		
		 return "redirect:deny/read?num=" + deny_Comment.getDeny_num();
	}
	
	
	
	@GetMapping("deleteReply")
	public String deleteReply(
			Deny_Comment deny_Comment
			, @AuthenticationPrincipal UserDetails user) {
		 
		deny_Comment.setMem_id(user.getUsername());
		log.debug("삭제할 리플정보 : {}", deny_Comment);
		
		int result = service.deleteReply(deny_Comment);
		return "redirect:deny/read?num=" + deny_Comment.getDeny_num();
	}
	
	
	
	
	
	
	
	
}
