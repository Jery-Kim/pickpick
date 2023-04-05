package net.softsociety.exam.service;

import java.util.ArrayList;

import net.softsociety.exam.domain.Deny;
import net.softsociety.exam.domain.Deny_Comment;


public interface DenyService {

	ArrayList<Deny> denylist();

	int insertDeny(Deny deny);

	Deny read_deny(int num);

	ArrayList<Deny_Comment> read_denyReply(int num);

	Deny selectDeny(int num);

	int writeReply(Deny_Comment deny_Comment);

	int deleteReply(Deny_Comment deny_Comment);

	

	

}
