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
import net.softsociety.exam.domain.Report;
import net.softsociety.exam.domain.Report_Comment;
import net.softsociety.exam.service.ReportService;
import net.softsociety.exam.util.FileService;




@Slf4j
@RequestMapping("report")
@Controller
public class ReportController {
	@Autowired
	ReportService service;
	
	@Value("${spring.servlet.multipart.location}")
	String uploadPath;
	

	@GetMapping("report")
	public String report() {
		return "report/writeForm";
	}
	
	@GetMapping("list")
	public String list(Model model) {
		ArrayList<Report> reportlist = service.list();
		model.addAttribute("reportlist", reportlist);
		return "report/Reportlist";
	}
	
	@PostMapping("/writereport")
	public String writereport(Report report, @AuthenticationPrincipal UserDetails user, MultipartFile upload) {
		
		if(upload!=null && !upload.isEmpty()) {
			String filename=FileService.saveFile(upload, "c:/upload");
			report.setRep_files_orz(upload.getOriginalFilename());
			report.setRep_files_saved(filename);
		}
		log.debug("report:{}", report);
		report.setMem_id(user.getUsername());
		
	
		service.insertReport(report);
		return "redirect:/";
	}
	
	@GetMapping("read")
	public String read(
			@RequestParam(name="num", defaultValue="0") int num, Model model) {
		Report report=service.read(num);
		log.debug("bbbbbbaa:{}", report);
		model.addAttribute("report", report);
    	ArrayList<Report_Comment> Report_Comment=service.readReply(num);
		model.addAttribute("Report_Comment", Report_Comment);
		
		return "report/read";
	}
       
 
	@GetMapping("download")
	public void download(
			@RequestParam(name="num", defaultValue="0") int num
			,HttpServletResponse response) {
		Report report=service.selectReport(num);
		if(report==null || report.getRep_files_saved()==null) {
			
			return ;
		}
	String file= uploadPath + "/" + report.getRep_files_saved();
	FileInputStream in = null;
	ServletOutputStream out = null;
	
	try {
		response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(report.getRep_files_orz(), "UTF-8"));
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
	public String writeReply(Report_Comment report_Comment, @AuthenticationPrincipal UserDetails user) {
		
		report_Comment.setMem_id(user.getUsername());
		log.debug("reply:{}", report_Comment);
		service.writeReply(report_Comment);
		log.debug("{}", report_Comment.getRep_num());
		
		 return "redirect:report/read?num=" + report_Comment.getRep_num();
	}
	
	
	
	@GetMapping("deleteReply")
	public String deleteReply(
			Report_Comment report_Comment
			, @AuthenticationPrincipal UserDetails user) {
		 
		report_Comment.setMem_id(user.getUsername());
		log.debug("삭제할 리플정보 : {}", report_Comment);
		
		int result = service.deleteReply(report_Comment);
		return "redirect:report/read?num=" + report_Comment.getRep_num();
	}
	
	
	
	
	
	
	
	
}
