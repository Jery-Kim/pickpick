package net.softsociety.exam.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.exam.dao.BungDAO;
import net.softsociety.exam.dao.SuksoDAO;
import net.softsociety.exam.domain.Bung;
import net.softsociety.exam.domain.BungComment;

@Slf4j
@Service
public class BungServiceImpl implements BungService {
	@Autowired
	BungDAO dao;

	@Override
	public int bungWrite(Bung bung) {

		int result = dao.bungWrite(bung);
		return result;
	}

	@Override
	public ArrayList<Bung> list() {
		ArrayList<Bung> list = dao.list();
		return list;
	}

	@Override
	public int bungWriteComm(BungComment bungComment) {
		int result = dao.bungWriteComm(bungComment);
		return result;
	}

	@Override
	public ArrayList<Bung> bungSearch(String bung_cate) {

		return null;
	}

}
