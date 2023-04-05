package net.softsociety.exam.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.exam.controller.ReportController;
import net.softsociety.exam.dao.ReportDAO;

import net.softsociety.exam.domain.Report;
import net.softsociety.exam.domain.Report_Comment;

@Slf4j
@Service
public class ReportServiceImpl implements ReportService {
	@Autowired
	ReportDAO dao;

	@Override
	public int insertReport(Report report) {
		int n=dao.insertReport(report);
		return n;
	}
	
	@Override
	public Report read(int num) {
		
	
		Report report = dao.read(num);
		return report;
	}
	@Override
	public Report selectReport(int num) {
		log.debug("서비스 번호 넘어가나 : {}", num);
		Report report=dao.read(num);
		return report;
	}

	@Override
	public ArrayList<Report_Comment> readReply(int num) {
		ArrayList<Report_Comment> replylist= dao.readReply(num);
		return replylist;
	}

	@Override
	public ArrayList<Report> list() {
		ArrayList<Report> list = dao.selectReportList();
		return list;
	}

	@Override
	public int writeReply(Report_Comment report_Comment) {
		int result = dao.insertReply(report_Comment);
		return result;
	}

	@Override
	public int deleteReply(Report_Comment report_Comment) {
		int result = dao.deleteReply(report_Comment);
		return result;
	}
	
}
