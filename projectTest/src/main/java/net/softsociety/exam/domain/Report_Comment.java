package net.softsociety.exam.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Report_Comment {
	int rep_comment_num;             
   int rep_num;
   String rep_comment_contents;   
    String mem_id;
    String rep_comment_date;
    
}