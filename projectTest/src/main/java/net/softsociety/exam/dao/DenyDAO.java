package net.softsociety.exam.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import net.softsociety.exam.domain.Deny;
import net.softsociety.exam.domain.Deny_Comment;


@Mapper
public interface DenyDAO {

	int insertDeny(Deny deny);

	Deny read(int num);

	ArrayList<Deny> selectDenyList();

	int insertReply(Deny_Comment deny_Comment);

	int deleteReply(Deny_Comment deny_Comment);

	ArrayList<Deny_Comment> read_denyReply(int num);




}
