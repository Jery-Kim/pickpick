package net.softsociety.exam.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {
	int rev_num;
	int suk_num;
	/* int res_num; */
	String mem_id;
	int rev_star_clean;
//	int rev_star_access;
//	int rev_star_faci;
//	int rev_star_service;
	String rev_contents;
	String rev_files_orz;
	String rev_files_saved;
	String rev_date;
	
}
