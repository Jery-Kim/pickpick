package net.softsociety.exam.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class bookSukso {
	  int res_num;
	    String mem_id;     //예약한 맴버 아이디
	    int suk_num; 
	  
	    String res_resdate;
	    String res_outdate;
	    int res_pop;                      // 묵는 인원수

	    String res_message;
	    int res_price; 
	    int res_state;
		String suk_name;
		String suk_address;
		String mem_nickname;
	
}
