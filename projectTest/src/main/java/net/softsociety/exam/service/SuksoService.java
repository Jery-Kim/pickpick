package net.softsociety.exam.service;

import java.util.ArrayList;

import net.softsociety.exam.util.PageNavigator;
import net.softsociety.exam.domain.Intag;
import net.softsociety.exam.domain.Member;
import net.softsociety.exam.domain.Reservation;
import net.softsociety.exam.domain.Review;
import net.softsociety.exam.domain.Suk_files;
import net.softsociety.exam.domain.Sukso;
import net.softsociety.exam.domain.Sukso_spec;
import net.softsociety.exam.domain.Tags;

public interface SuksoService {

	int insertsukso(Sukso sukso);

	Sukso read(int num);

	Sukso selectSukso(int num);

	PageNavigator getPageNavigator(int pagePerGroup, int countPerPage, int page, String suk_location,
			String suk_nearby);

	ArrayList<Sukso> suksolist(int startRecord, int countPerPage, String suk_location, String suk_nearby);

	Member find(String mem_id);

	int writeReview(Review review);

	ArrayList<Review> readReview(int startRecord, int countPerPage, int num);

	Review readRev(int num);

	PageNavigator getPageNavigator1(int pagePerGroup, int countPerPage, int page, int num);

	int insertspec(Sukso_spec spec);

	ArrayList<Suk_files> insertphoto();

	public int insert(Tags tags);

	public int insert2(Intag intag);


}
