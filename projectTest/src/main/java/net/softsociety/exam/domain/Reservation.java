package net.softsociety.exam.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reservation {
	     int res_num;
	    String mem_id;     //예약한 맴버 아이디
	    int suk_num; 
	    String res_inputdate;
	    String res_resdate;
	    String res_outdate;
	    int res_pop;                      // 묵는 인원수
	    int res_parking;
	    int res_pet;
	    String res_message;
	    int res_price; 
	    int res_state;
	
}
