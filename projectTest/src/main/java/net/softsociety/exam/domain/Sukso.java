package net.softsociety.exam.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class Sukso {
	int suk_num;
	String mem_id;
	String suk_name;
	String suk_address;
	String suk_location;
	String suk_files_saved;
	String suk_files_orz;
	String suk_nearby;
	int suk_visit;
	int suk_price1;

}
