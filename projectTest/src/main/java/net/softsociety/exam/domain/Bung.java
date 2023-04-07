package net.softsociety.exam.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Bung {
	int bung_num;
	String bung_title;
	String bung_contents;
	String mem_id;
	int res_num;
	int suk_num;
	String bung_inputdate;
	String bung_cate;
}
