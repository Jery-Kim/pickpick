package net.softsociety.exam.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.exam.domain.Tags;
import net.softsociety.exam.service.TagService;

@Slf4j
@Controller
public class TagController {
	@Autowired
	TagService tagservice;

	@ResponseBody
	@GetMapping("getTagifyList")
	public ArrayList<String> getTagifyList(String value) {
		log.info("전달된 태그 검색어 : {}", value);

		// service.selectAll을 통해서 모든 데이터를 가져온다.(tag의 내용만 가져온다.)
		// 그걸 통해 리스트 내부를 검색해서 출력해준다.
		
		ArrayList<String> list = new ArrayList<>();
		ArrayList<Tags> Alist = tagservice.selectAll();
		
		for(Tags name : Alist) {
		    list.add(name.getName());
		}
		
		return list;
	}
	
	@ResponseBody
	@GetMapping("sukso/getTagifyList")
	public ArrayList<String> getTagifyList2(String value) {
		log.info("전달된 태그 검색어 : {}", value);

		// service.selectAll을 통해서 모든 데이터를 가져온다.(tag의 내용만 가져온다.)
		// 그걸 통해 리스트 내부를 검색해서 출력해준다.
		
		ArrayList<String> list = new ArrayList<>();
		ArrayList<Tags> Alist = tagservice.selectAll();
		
		for(Tags name : Alist) {
		    list.add(name.getName());
		}
		
		return list;
	}
	
	@PostMapping("tagify2")
	public String tagify2(String tags) {
		log.info("전달된 tags : {}", tags);
		
		String ar[] = tags.split(",");
		for (String s : ar) {
			System.out.println("분리된 문자열:" + s);
			log.debug("전달된 tags : {}", tags);
			
			tagservice.insert(s);
			tagservice.selectOne(s);
//			tagservice.insert2(s);
			log.debug(s);
		}
		
		return "redirect:/";
	}
	
	@PostMapping("sukso/tagify2")
	public String suk_tagify(String tags) {
		log.info("전달된 tags : {}", tags);
		
		String ar[] = tags.split(",");
		for (String s : ar) {
			System.out.println("분리된 문자열:" + s);
			log.debug("전달된 tags : {}", tags);
			
			tagservice.insert(s);		// 태그에 넣는 인서트
			tagservice.selectOne(s);
//			tagservice.insert2(s);		// intag에 넣는 인서트(호스트)
//			tagservice.insert3(s);		// intag에 넣는 인서트(리뷰)
			log.debug(s);
		}
		
		return "redirect:/";
	}
	
}
