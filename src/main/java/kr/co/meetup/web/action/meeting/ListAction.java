package kr.co.meetup.web.action.meeting;

import java.sql.Timestamp;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.MeetingDAO;
import kr.co.meetup.web.vo.MeetingVO;

public class ListAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		// 파라미터 date 값 가져오기
		String date = req.getParameter("date");
		// date가 null이면 오늘 날짜로 초기화
		if (date == null) {
			Timestamp today = new Timestamp(System.currentTimeMillis());
			date = today.toLocalDateTime().toLocalDate().toString();
		}
		MeetingDAO dao = new MeetingDAO();
		// 총 게시물 수
		int totalCount = dao.selectAllMeetingByMeetingDateCnt(date);
		// 한 페이지당 게시물 수 : 6
		int recordPerPage = 6;
		// 총 페이지 수
		int totalPage =  totalCount % recordPerPage == 0 
								? totalCount / recordPerPage
								: totalCount / recordPerPage + 1;
		// 현재 페이지 번호
		String cp = req.getParameter("cp");
		
		int currentPage = 0;
		if(cp != null) {
			currentPage = Integer.parseInt(cp);
		} else {
			currentPage = 1;
		}
		
		// 시작번호
		int startNo = (currentPage - 1) * recordPerPage;
		// 시작페이지 번호
		int startPage = 1;
		// 끝페이지 번호
		int endPage = totalPage;
		// 이전페이지가 존재
		boolean isPrev = false;
		// 다음페이지가 존재
		boolean isNext = false;
		
		// 시작페이지를 현재 페이지 기준으로 앞에 5개만 보여주기
		if(currentPage <= 5) { 
			startPage = 1;
		} else if(currentPage >= 6) {
			startPage = currentPage - 4;
		}
		// 끝페이지를 현재 페이지 기준으로 뒤에 5개만 보여주기
		if(totalPage - currentPage <= 5) {
			endPage = totalPage;
		} else if(totalPage - currentPage > 5) {
			if(currentPage <= 5) {
				if(totalPage > 10) {
					endPage = 10;
				} else {
					endPage = totalPage;
				}
			} else {
				endPage = currentPage - 4;
			}
		}
		
		// 이전 페이지가 존재하는지 여부
		if(currentPage >= 2) {
			isPrev = true;
		}
		if(currentPage != totalPage) {
			isNext = true;
		}
		

		// 날짜별 정모 가져오기
		List<MeetingVO> list = dao.selectAllMeetingByDate(date, startNo, recordPerPage);
		
		req.setAttribute("list", list);
		req.setAttribute("totalCount", totalCount);
		req.setAttribute("recordPerPage", recordPerPage);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("startNo", startNo);
		req.setAttribute("recordPerPage", recordPerPage);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("isPrev", isPrev);
		req.setAttribute("isNext", isNext);
		
		return "meeting/list.jsp";
	}

}
