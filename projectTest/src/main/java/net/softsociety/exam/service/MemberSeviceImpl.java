package net.softsociety.exam.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import net.softsociety.exam.dao.MemberDAO;
import net.softsociety.exam.domain.Member;

@Service
public class MemberSeviceImpl implements MemberService {
	@Autowired
	MemberDAO dao;
	 @Autowired
	 PasswordEncoder passwordEncoder;
	@Override
	public int insertMember(Member member) {
		System.out.println(member);
		String encodedPassword = passwordEncoder.encode(member.getMem_password());
		member.setMem_password(encodedPassword);
		int n = dao.insertMember(member);
		return n;
	}
	@Override
	public boolean idcheck(String mem_id) {
		Member member=dao.select(mem_id);
		return member!=null;
		
	}
	@Override
	public Member getMember(String mem_id) {
		Member member=dao.select(mem_id);
		return member;
	}
	@Override
	   public int delete(Map<String, String> map) {
	      String mem_id = map.get("mem_id");
	      Member member = dao.select(mem_id);
	      
	      String mem_password = map.get("mem_password");
	      String pw_amho = member.getMem_password();
	      
	      // 사용자가 입력한 암호와 DB에 저장되어 있던 암호화된 암호를 비교
	      boolean match = passwordEncoder.matches(mem_password, pw_amho);
	      
	      if(match == true) {
	         int res = dao.delete(map);
	         
	         return res;
	         
	      } else {
	         return 0;
	         
	      }   
	}
	   
	@Override
	public int update(Member member) {
		if(member.getMem_password() != null && member.getMem_password().length() !=0) {
			String pw=passwordEncoder.encode(member.getMem_password());
			member.setMem_password(pw);
		}
		int n =dao.update(member);
		return n;

	}
	@Override
	public int check(Map<String, String> map) {
		 String mem_id = map.get("mem_id");
	      Member member = dao.select(mem_id);
	      
	      String mem_password = map.get("mem_password");
	      String pw_amho = member.getMem_password();
	      
	      // 사용자가 입력한 암호와 DB에 저장되어 있던 암호화된 암호를 비교
	      boolean match = passwordEncoder.matches(mem_password, pw_amho);
	      
	      if(match == true) {
	         
	         return 1;
	         
	      } else {
	         return 0;
	         
	      }   
	}
	@Override
	public boolean nick_namecheck(String mem_nickname) {
		Member member=dao.select_nickname(mem_nickname);
		return member!=null;
	}
	@Override
	public boolean email_check(String mem_email) {
		Member member=dao.select_email(mem_email);
		return member!=null;
	}
	
		
	

	}
