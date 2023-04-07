package net.softsociety.exam.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import net.softsociety.exam.domain.Tags;

@Mapper
public interface TagDAO {
	
	public int insert(String name);

	public int insert2(String name);
	
	public ArrayList<Tags> selectAll();

	public Tags selectOne(String s);

}
