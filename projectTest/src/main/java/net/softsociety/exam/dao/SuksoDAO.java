package net.softsociety.exam.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import net.softsociety.exam.domain.Member;
import net.softsociety.exam.domain.Reservation;
import net.softsociety.exam.domain.Review;
import net.softsociety.exam.domain.Suk_files;
import net.softsociety.exam.domain.Sukso;
import net.softsociety.exam.domain.Sukso_spec;


@Mapper
public interface SuksoDAO {

	int insertsukso(Sukso sukso);

	Sukso selectSukso(int num);



	int count(HashMap<String, String> map);

	ArrayList<Sukso> selectSuksoList(HashMap<String, String> map, RowBounds rb);

	Member find(String mem_id);

	int writeReview(Review review);

	ArrayList<Review> readReview(int num, RowBounds rb);

	Review readRev(int num);

	int rev_count(int num);

	int insertspec(Sukso_spec spec);

	ArrayList<Suk_files> insertphoto();

	





}
