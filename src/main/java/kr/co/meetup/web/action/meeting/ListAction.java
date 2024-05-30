package kr.co.meetup.web.action.meeting;

import java.sql.Timestamp;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.MeetingDAO;
import kr.co.meetup.web.vo.MeetingVO;
import kr.co.meetup.web.vo.MemberVO;

public class ListAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		// 현재 로그인한 유저 가져오기
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginMember");
		
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
		
		// 한 페이지 당 모임 수
		int recordPerPage = 8;
		
		// 총 페이지 수 
		int totalPage = (totalCount % recordPerPage == 0) ? totalCount / recordPerPage : totalCount / recordPerPage + 1;
		
		// 현재 페이지
		String cp = req.getParameter("cp");
		int currentPage = 0;
		if (cp != null) {
			currentPage = Integer.parseInt(cp);
		} else {
			currentPage = 1;
		}
		
		// 페이지 시작 모임 번호
		int startNo = (currentPage - 1) * recordPerPage;
		
		// 페이지 끝 모임 번호
		int endNo = currentPage * recordPerPage;
		
		// 한번에 보여줄 페이지 번호 수
		int pageBlock = 5;
		
		// 시작페이지 번호
		int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
		
		// 끝페이지 번호
		int endPage = startPage + pageBlock - 1;
		if (endPage > totalPage) {
		    endPage = totalPage;
		}

		// 이전 페이지가 존재 여부
		boolean isPrev = startPage > 1;
		
		// 다음 페이지가 존재 여부
		boolean isNext = endPage < totalPage;
		

		// 날짜별 정모 가져오기
		List<MeetingVO> meetingList = dao.selectAllMeetingByDate(date, startNo, recordPerPage);
		
		req.setAttribute("meetingList", meetingList);
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
