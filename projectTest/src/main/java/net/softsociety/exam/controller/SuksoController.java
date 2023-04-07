package net.softsociety.exam.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
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
import net.softsociety.exam.domain.Intag;
import net.softsociety.exam.domain.Review;
import net.softsociety.exam.domain.Suk_files;
import net.softsociety.exam.domain.Sukso;
import net.softsociety.exam.domain.Sukso_spec;
import net.softsociety.exam.domain.Tags;
import net.softsociety.exam.service.SuksoService;
import net.softsociety.exam.util.FileService;
import net.softsociety.exam.util.PageNavigator;




@Slf4j
@RequestMapping("sukso")
@Controller
public class SuksoController {
	
	@Value("${user.board.page}")
	int countPerPage;
	
	@Value("${user.board.group}")
	int pagePerGroup;
	
	
	@Autowired
	SuksoService service;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public void saveData(List<Integer> dataList) {
	    String sql = "INSERT INTO pp_suk_files () VALUES (?,?,?,?)";
	    jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
	        @Override
	        public void setValues(PreparedStatement ps, int i) throws SQLException {
	            ps.setInt(1, dataList.get(i));
	        }

	        @Override
	        public int getBatchSize() {
	            return dataList.size();
	        }
	    });
	}
	
	@Value("${spring.servlet.multipart.location}")
	String uploadPath;
	
	
	@GetMapping("insertsukso")
	public String insertsukso() {
		return "insertSuk";
	}
	
	@PostMapping("join")
	public String writeform(Suk_files file, Sukso sukso, Sukso_spec spec, Tags tags, Intag intag, @AuthenticationPrincipal UserDetails user, MultipartFile upload, MultipartFile upload1) {
		
		if(upload!=null && !upload.isEmpty()) {
			String filename=FileService.saveFile(upload, "c:/upload");
			sukso.setSuk_files_orz(upload.getOriginalFilename());
			sukso.setSuk_files_saved(filename);
		}
//		if(upload1!=null && !upload1.isEmpty()) {
//			String filename=FileService.saveFile(upload1, "c:/upload");
//			file.setSuk1_files_orz(upload1.getOriginalFilename());
//			file.setSuk1_files_saved(filename);
//		}
		log.debug("sukso1:{}", sukso);
		sukso.setMem_id(user.getUsername());
		log.debug("sukso2:{}", sukso);
		service.insertsukso(sukso);
		log.debug("spec:{}", spec);
		spec.setSuk_num(sukso.getSuk_num());
		service.insertspec(spec);
		service.insert(tags);
		intag.setSuk_num(sukso.getSuk_num());
		intag.setId(tags.getId());
		service.insert2(intag);
//			file.setSuk_num(sukso.getSuk_num());
//			ArrayList<Suk_files> files= service.insertphoto();
		
		
		return "redirect:/";
	}
	
	/*
	 * @GetMapping("list") public String list(Model model) { ArrayList<Sukso>
	 * suksolist = service.suksolist(); model.addAttribute("suksolist", suksolist);
	 * return ""; }
	 */
	
	
	@GetMapping("read")
	public String read(
			@RequestParam(name="num", defaultValue="0") int num, Model model,
			@RequestParam(name="page", defaultValue="1")int page
			) {
		
		PageNavigator navi = 
				service.getPageNavigator1(pagePerGroup, countPerPage, page, num);
	
		Sukso sukso=service.read(num);
		log.debug("bbbbbbaa:{}", sukso);
		model.addAttribute("sukso", sukso);
		ArrayList<Review> review=service.readReview(navi.getStartRecord(), countPerPage, num);
		log.debug("bbbreview:{}", review);
		model.addAttribute("review", review);
		model.addAttribute("navi", navi);
		
		
		
 		
		
		return "suksoInfo3";
	}
       
 
	@GetMapping("download")
	public void download(
			@RequestParam(name="num", defaultValue="0") int num
			,HttpServletResponse response) {
		Sukso sukso=service.selectSukso(num);
		
		if(sukso==null || sukso.getSuk_files_saved()==null) {
			
			return ;
		}
	String file= uploadPath + "/" + sukso.getSuk_files_saved();
	FileInputStream in = null;
	ServletOutputStream out = null;
	
	try {
		response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(sukso.getSuk_files_orz(), "UTF-8"));
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
	
	
	@GetMapping("review/download")
	public void reviewdownload(
			@RequestParam(name="num", defaultValue="0") int num
			,HttpServletResponse response) {
		Review review=service.readRev(num);
		if(review==null || review.getRev_files_saved()==null) {
			
			return ;
		}
	String file= uploadPath + "/" + review.getRev_files_saved();
	FileInputStream in = null;
	ServletOutputStream out = null;
	
	try {
		response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(review.getRev_files_orz(), "UTF-8"));
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
	
	
	
	@PostMapping("/writeReview")
	public String writeReply(Review review, @AuthenticationPrincipal UserDetails user, MultipartFile upload
			//Reservation res, int suk_num, int res_state
			) {
		log.debug("upload:{}", upload.getOriginalFilename());
		if(upload!=null && !upload.isEmpty()) {
			String filename=FileService.saveFile(upload, "c:/upload");
			review.setRev_files_orz(upload.getOriginalFilename());
			review.setRev_files_saved(filename);
		}
//		res.setMem_id(user.getUsername());
//		res.setSuk_num(suk_num);
	
		
		log.debug("리뷰 별점1 : {}", review.getRev_star_clean());
		review.setMem_id(user.getUsername());
		log.debug("reivew:{}", review);
		service.writeReview(review);
		log.debug("{}", review.getRev_num());
		log.debug("리뷰 별점2 : {}", review.getRev_star_clean());
		
		 return "redirect:read?num=" + review.getSuk_num();
	}

	
	
	
}
