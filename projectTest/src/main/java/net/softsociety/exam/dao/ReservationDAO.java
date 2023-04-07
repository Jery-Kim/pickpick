package net.softsociety.exam.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import net.softsociety.exam.domain.Reservation;
import net.softsociety.exam.domain.bookSukso;

@Mapper
public interface ReservationDAO {

	int insertRes(Reservation res);

	ArrayList<bookSukso> checkbook(String mem_id);

	ArrayList<Reservation> findRes(String mem_id);

	int updateRes(Reservation res);

	int deleteRes(int num);

	int countRes(String mem_id);

	Reservation getReservationByMemid(String mem_id);

}
