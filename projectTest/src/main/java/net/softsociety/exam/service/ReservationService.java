package net.softsociety.exam.service;

import java.util.ArrayList;

import net.softsociety.exam.domain.Reservation;
import net.softsociety.exam.domain.bookSukso;

public interface ReservationService {

	int insertRes(Reservation res);

	ArrayList<bookSukso> checkbook(String mem_id);

	ArrayList<Reservation> findRes(String mem_id);

	int updateRes(Reservation res);

	int cancer(int num);

	int countRes(String mem_id);

}
