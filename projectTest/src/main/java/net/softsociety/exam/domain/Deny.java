package net.softsociety.exam.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Deny {
	String mem_id;
	int deny_num;
	String deny_title;
	String deny_contents;
	String deny_files_orz;
	String deny_files_saved;
	String deny_date;
}
