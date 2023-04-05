package net.softsociety.exam.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.exam.dao.DenyDAO;
import net.softsociety.exam.domain.Deny;
import net.softsociety.exam.domain.Deny_Comment;


@Slf4j
@Service
public class DenyServiceImpl implements DenyService {
	@Autowired
	DenyDAO dao;

	@Override
	public int insertDeny(Deny deny) {
		int n=dao.insertDeny(deny);
		return n;
	}
	
	@Override
	public Deny read_deny(int num) {
		
	
		Deny deny = dao.read(num);
		return deny;
	}
	@Override
	public Deny selectDeny(int num) {
		log.debug("서비스 번호 넘어가나 : {}", num);
		Deny deny=dao.read(num);
		return deny;
	}

	@Override
	public ArrayList<Deny_Comment> read_denyReply(int num) {
		ArrayList<Deny_Comment> replylist= dao.read_denyReply(num);
		return replylist;
	}

	@Override
	public ArrayList<Deny> denylist() {
		ArrayList<Deny> denylist = dao.selectDenyList();
		return denylist;
	}

	@Override
	public int writeReply(Deny_Comment deny_Comment) {
		int result = dao.insertReply(deny_Comment);
		return result;
	}

	@Override
	public int deleteReply(Deny_Comment deny_Comment) {
		int result = dao.deleteReply(deny_Comment);
		return result;
	}
	
}
