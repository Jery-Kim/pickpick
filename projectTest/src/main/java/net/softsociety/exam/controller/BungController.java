package net.softsociety.exam.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.exam.domain.Bung;
import net.softsociety.exam.domain.BungComment;
import net.softsociety.exam.domain.Reservation;
import net.softsociety.exam.domain.Sukso;
import net.softsociety.exam.service.BungService;
import net.softsociety.exam.service.ReservationService;
import net.softsociety.exam.service.SuksoService;

@Slf4j
@RequestMapping("bung")
@Controller
public class BungController {
	@Autowired
	BungService bungService;
	@Autowired
	ReservationService reservationService;

	@GetMapping("bung")
	public String bung(Model model) {
		ArrayList<Bung> bungList = bungService.list();
		model.addAttribute("bungList", bungList);
		return "/bung/bung";
	}

	@GetMapping("bungWrite")
	public String bungWrite() {
		return "bung/bungWrite";
	}

	@PostMapping("bungWrite")
	public String bungWrite(Bung bung, @AuthenticationPrincipal UserDetails user, @RequestParam(required = false) Integer res_num, @RequestParam(required = false) Integer suk_num) {
	    Reservation reservation = reservationService.getReservationByMemid(user.getUsername());
	    if (reservation == null) {
	        // 해당 사용자에 대한 예약이 없는 경우, 오류 페이지로 리디렉션
	        return "redirect:/error/reservationNotFound";
	    }
	    bung.setMem_id(user.getUsername());
		bung.setRes_num(reservation.getRes_num());
		bung.setSuk_num(reservation.getSuk_num());
		log.debug("bung {}", bung);
		bungService.bungWrite(bung);
		return "/bung/bung";
	}

	@PostMapping("bungWriteComm")
	public String bungWriteComm(BungComment bungComment, @AuthenticationPrincipal UserDetails user) {

		bungComment.setMem_id(user.getUsername());

		bungService.bungWriteComm(bungComment);
		log.debug("bungComment {}", bungComment);
		return "/bung/bung";
	}

	@PostMapping("bungSearch")
	public String bungSearch(@RequestParam("bung_cate") String bung_cate, Model model) {
		ArrayList<Bung> bung = bungService.bungSearch(bung_cate);
		model.addAttribute("bung", bung);
		log.debug("bung {}", bung);
		return "bung/bung";
	}

}
