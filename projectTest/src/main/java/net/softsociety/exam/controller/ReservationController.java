package net.softsociety.exam.controller;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.exam.domain.Reservation;
import net.softsociety.exam.domain.Sukso;
import net.softsociety.exam.domain.bookSukso;
import net.softsociety.exam.service.ReservationService;
import net.softsociety.exam.service.SuksoService;
import net.softsociety.exam.util.FileService;

@Slf4j
@RequestMapping("book")
@Controller

public class ReservationController {
	@Autowired
	ReservationService service;
	@Autowired
	SuksoService suksoService;

	
	@PostMapping("/insertRes")
	public String insertRes(Reservation res, @AuthenticationPrincipal UserDetails user, int qtyInput, int suk_price, String res_resdate, String res_outdate) {
		
        res.setRes_pop(qtyInput);
		
		res.setMem_id(user.getUsername());
	
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate resResDate = LocalDate.parse(res_resdate, formatter);
		LocalDate resOutDate = LocalDate.parse(res_outdate, formatter);

		long days = ChronoUnit.DAYS.between(resResDate, resOutDate);
	
		int date = (int) days;
		log.debug("reservation2:{}", date);
		res.setRes_price(qtyInput*suk_price*date);
	    log.debug("reservation3:{}", res);
	    String mem_id=user.getUsername();
	    // 빼놓는다
//	    if (service.countRes(mem_id)>=1) {
//	    	return "redirect:read?suk_num=" + res.getSuk_num();
//	    }
	    
		service.insertRes(res);
		log.debug("reservation1:{}", res);
		return "redirect:/";
	}
	
	@GetMapping("bookcheck")
	public String bookcheck(ArrayList<bookSukso> bs,  Model model, @AuthenticationPrincipal UserDetails user, String mem_id) {
		mem_id=user.getUsername();
		log.debug("dddddddddd:{}", mem_id);
		ArrayList<Reservation> res=service.findRes(mem_id);
		bs=service.checkbook(mem_id);
		log.debug("res", res);
		model.addAttribute("bs", bs);
		model.addAttribute("res", res);
	
		return "book/bookcheck";
	}
	@GetMapping("read")
	public String read(Model model, @RequestParam(name="num", defaultValue="0") int num) {
		Sukso sukso=suksoService.read(num);
		model.addAttribute("sukso", sukso);
		return "book/sukInfo";
	}
	
	@PostMapping("/updateRes")
	public String updateRes(Reservation res, @AuthenticationPrincipal UserDetails user, int qtyInput, int suk_price, String res_resdate, String res_outdate) {
		
        res.setRes_pop(qtyInput);
		
		res.setMem_id(user.getUsername());
	
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate resResDate = LocalDate.parse(res_resdate, formatter);
		LocalDate resOutDate = LocalDate.parse(res_outdate, formatter);

		long days = ChronoUnit.DAYS.between(resResDate, resOutDate);
	
		int date = (int) days;
		log.debug("reservation2:{}", date);
		res.setRes_price(qtyInput*suk_price*date);
	    log.debug("reservation3:{}", res);
		service.updateRes(res);
		log.debug("reservation1:{}", res);
		return "redirect:/";
	}
	@GetMapping("cancer")
	public String cancer(@RequestParam(name="num", defaultValue="0") int num) {
		log.debug("num:{}", num);
		service.cancer(num);
		
		return "redirect:/";
	}
}
