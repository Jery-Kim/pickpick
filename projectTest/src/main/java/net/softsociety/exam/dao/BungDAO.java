package net.softsociety.exam.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import net.softsociety.exam.domain.Bung;
import net.softsociety.exam.domain.BungComment;

@Mapper
public interface BungDAO {

	int bungWrite(Bung bung);

	ArrayList<Bung> list();

	int bungWriteComm(BungComment bungComment);

}
