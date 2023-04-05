package net.softsociety.exam.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Report {
	int rep_num;
	String mem_id;
	int suk_num;
	String rep_title;
	String rep_contents;
	String rep_files_orz;
	String rep_files_saved;
	String rep_date;
	int res_num;

}
