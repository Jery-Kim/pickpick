package net.softsociety.exam.service;

import java.util.Map;

import net.softsociety.exam.domain.Member;

/** 
 * 회원정보 관련 서비스
 */
public interface MemberService {

	int insertMember(Member member);

	boolean idcheck(String mem_id);

	Member getMember(String mem_id);

	int delete(Map<String, String> map);

	int update(Member member);

	int check(Map<String, String> map);

	boolean nick_namecheck(String mem_nickname);

	boolean email_check(String mem_email);





}
