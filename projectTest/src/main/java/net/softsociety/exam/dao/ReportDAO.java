package net.softsociety.exam.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import net.softsociety.exam.domain.Report;
import net.softsociety.exam.domain.Report_Comment;

@Mapper
public interface ReportDAO {

	int insertReport(Report report);

	Report read(int num);

	ArrayList<Report_Comment> readReply(int num);

	ArrayList<Report> selectReportList();

	int insertReply(Report_Comment report_Comment);

	int deleteReply(Report_Comment report_Comment);

}
