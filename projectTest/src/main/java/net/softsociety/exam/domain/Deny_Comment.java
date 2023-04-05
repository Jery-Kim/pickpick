package net.softsociety.exam.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Deny_Comment {
	int deny_comment_num;             
   int deny_num;
   String deny_comment_contents;   
    String mem_id;
    String deny_comment_date;
    
}