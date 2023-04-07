package net.softsociety.exam.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.exam.dao.ReservationDAO;
import net.softsociety.exam.domain.Reservation;
import net.softsociety.exam.domain.bookSukso;

@Slf4j
@Service
public class ReservationServiceImpl implements ReservationService {
	@Autowired
	ReservationDAO dao;

	@Override
	public int insertRes(Reservation res) {
		int n = dao.insertRes(res);
		return n;
	}

	@Override
	public ArrayList<bookSukso> checkbook(String mem_id) {

		ArrayList<bookSukso> n = dao.checkbook(mem_id);
		log.debug("bs:{}", n);
		return n;
	}

	@Override
	public ArrayList<Reservation> findRes(String mem_id) {
		ArrayList<Reservation> res = dao.findRes(mem_id);
		return res;
	}

	@Override
	public int updateRes(Reservation res) {
		int n = dao.updateRes(res);
		return n;
	}

	@Override
	public int cancer(int num) {
		int n = dao.deleteRes(num);
		return n;
	}

	@Override
	public int countRes(String mem_id) {
		int n = dao.countRes(mem_id);
		return n;
	}

	@Override
	public Reservation getReservationByMemid(String mem_id) {
		Reservation reservation = dao.getReservationByMemid(mem_id);
		return reservation;
	}

}
