package net.softsociety.exam.service;

import java.util.ArrayList;

import net.softsociety.exam.domain.Report;
import net.softsociety.exam.domain.Report_Comment;

public interface ReportService {

	int insertReport(Report report);

	Report read(int num);



	ArrayList<Report_Comment> readReply(int num);

	ArrayList<Report> list();

	Report selectReport(int num);

	int writeReply(Report_Comment report_Comment);

	int deleteReply(Report_Comment report_Comment);

	

}
