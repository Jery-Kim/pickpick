package net.softsociety.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class mapController {
	@GetMapping("aj4")
	   public String aj4() {
	      return "/aj4";
	   }
	   
	   @GetMapping("aj3")
	   public String aj3() {
	      return "/aj3";
	   }

}
