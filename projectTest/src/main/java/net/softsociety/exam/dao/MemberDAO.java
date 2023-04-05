package net.softsociety.exam.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import net.softsociety.exam.domain.Member;

/**
 * 회원정보 관련 매퍼
 */
@Mapper
public interface MemberDAO {

	int insertMember(Member member);

	Member select(String mem_id);

	int delete(Map<String, String> map);

	int update(Member member);

	Member select_nickname(String mem_nickname);

	Member select_email(String mem_email);

}
