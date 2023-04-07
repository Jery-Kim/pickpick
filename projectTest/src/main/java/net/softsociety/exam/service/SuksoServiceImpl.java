package net.softsociety.exam.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.exam.dao.SuksoDAO;
import net.softsociety.exam.domain.Intag;
import net.softsociety.exam.domain.Member;
import net.softsociety.exam.domain.Reservation;
import net.softsociety.exam.domain.Review;
import net.softsociety.exam.domain.Suk_files;
import net.softsociety.exam.domain.Sukso;
import net.softsociety.exam.domain.Sukso_spec;
import net.softsociety.exam.domain.Tags;
import net.softsociety.exam.util.PageNavigator;

@Slf4j
@Service
public class SuksoServiceImpl implements SuksoService {
	@Autowired
	SuksoDAO dao;

	@Override
	public int insertsukso(Sukso sukso) {
		int n = dao.insertsukso(sukso);
		return n;
	}

	@Override
	public Sukso read(int num) {
		Sukso sukso = dao.selectSukso(num);
		return sukso;
	}

	@Override
	public Sukso selectSukso(int num) {
		Sukso sukso = dao.selectSukso(num);
		return sukso;
	}

	@Override
	public PageNavigator getPageNavigator(int pagePerGroup, int countPerPage, int page, String suk_location,
			String suk_nearby) {
		HashMap<String, String> map = new HashMap<>();
		map.put("suk_nearby", suk_nearby);
		map.put("suk_location", suk_location);
		int t = dao.count(map);
		PageNavigator navi = new PageNavigator(pagePerGroup, countPerPage, page, t);
		return navi;
	}

	@Override
	public ArrayList<Sukso> suksolist(int startRecord, int countPerPage, String suk_location, String suk_nearby) {
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		HashMap<String, String> map = new HashMap<>();
		map.put("suk_nearby", suk_nearby);
		map.put("suk_location", suk_location);
		ArrayList<Sukso> list = dao.selectSuksoList(map, rb);
		return list;
	}

	@Override
	public Member find(String mem_id) {
		Member member = dao.find(mem_id);
		return member;
	}

	@Override
	public int writeReview(Review review) {

		log.debug("리뷰 별점 : {}", review.getRev_star_clean());
		int n = dao.writeReview(review);
		return n;
	}

	@Override
	public ArrayList<Review> readReview(int startRecord, int countPerPage, int num) {
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		ArrayList<Review> review = dao.readReview(num, rb);
		log.debug("리뷰 : {}", review);

		return review;
	}

	@Override
	public Review readRev(int num) {
		Review review = dao.readRev(num);
		return review;
	}

	@Override
	public PageNavigator getPageNavigator1(int pagePerGroup, int countPerPage, int page, int num) {
		int t = dao.rev_count(num);
		PageNavigator navi = new PageNavigator(pagePerGroup, countPerPage, page, t);
		return navi;
	}

	@Override
	public int insertspec(Sukso_spec spec) {
		int n = dao.insertspec(spec);
		return n;
	}

	@Override
	public ArrayList<Suk_files> insertphoto() {
		ArrayList<Suk_files> files = dao.insertphoto();
		return files;
	}

	@Override
	public int insert(Tags tags) {
		int n = dao.insert(tags);
		return n;
	}

	@Override
	public int insert2(Intag intag) {
		int n = dao.insert2(intag);
		return n;
	}

}
