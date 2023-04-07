package net.softsociety.exam.service;

import java.util.ArrayList;

import net.softsociety.exam.domain.Bung;
import net.softsociety.exam.domain.BungComment;

public interface BungService {

	int bungWrite(Bung bung);

	ArrayList<Bung> list();

	int bungWriteComm(BungComment bungComment);

	ArrayList<Bung> bungSearch(String bung_cate);

}
