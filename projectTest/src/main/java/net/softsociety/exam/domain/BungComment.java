package net.softsociety.exam.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BungComment {
	int bung_comm_num;
	String mem_id;
	String bung_comment_contents;
	int bung_num;
	String bung_comm_date;
}
