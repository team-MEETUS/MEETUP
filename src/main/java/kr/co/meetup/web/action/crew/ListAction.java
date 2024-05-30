package kr.co.meetup.web.action.crew;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CategoryBigVO;
import kr.co.meetup.web.vo.CrewVO;
import kr.co.meetup.web.vo.MemberVO;

public class ListAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		
		// 현재 로그인한 유저 가져오기
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginMember");
		
		CrewDAO dao = new CrewDAO();
		
		// 전체 카테고리 리스트 가져오기
		List<CategoryBigVO> categoryBigList = dao.selectAllCategoryBig();
		
		// 카테고리 값 가져오기
		String ctg = req.getParameter("ctg");
		
		// 형변환 
		int categoryBigNo = 0;
		if (ctg != null) {
			categoryBigNo = Integer.parseInt(ctg);
		}
		
		// 유저 로그인 유무 & 카테고리 값에 따른 모임 수 조회
		int totalCount;
		if (mvo != null && ctg != null) { 			// 회원 O && 카테고리 O
			totalCount = dao.selectAllCrewCntByGeoCategory(mvo.getGeoCode(), categoryBigNo);
		} else if (mvo != null && ctg == null) {		// 회원 O && 카테고리 X
			totalCount = dao.selectAllCrewCntByGeo(mvo.getGeoCode());
		} else if (mvo == null && ctg != null) {		// 회원 X && 카테고리 O
			totalCount = dao.selectAllCrewCntByCategory(categoryBigNo);
		} else {										// 회원 X && 카테고리 X
			totalCount = dao.selectAllCrewCnt();
		}
		
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
		
		// 모임 리스트 가져오기
		List<CrewVO> crewList;
		if (mvo != null && ctg != null) { 			// 회원 O && 카테고리 O
			crewList = dao.selectAllCrewByGeoCategory(mvo.getGeoCode(), categoryBigNo, startNo, recordPerPage);
		} else if (mvo != null && ctg == null) {		// 회원 O && 카테고리 X
			crewList = dao.selectAllCrewByGeo(mvo.getGeoCode(), startNo, recordPerPage);
		} else if (mvo == null && ctg != null) {		// 회원 X && 카테고리 O
			crewList = dao.selectAllCrewByCategory(categoryBigNo, startNo, recordPerPage);
		} else {										// 회원 X && 카테고리 X
			crewList = dao.selectAllCrew(startNo, recordPerPage);
		}
		
		// attribute 에 추가
		req.setAttribute("crewList", crewList);
		req.setAttribute("categoryBigList", categoryBigList);
		req.setAttribute("ctg", ctg);
		req.setAttribute("totalCount", totalCount);
		req.setAttribute("recordPerPage", recordPerPage);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("startNo", startNo);
		req.setAttribute("endNo", endNo);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("isPrev", isPrev);
		req.setAttribute("isNext", isNext);
		req.setAttribute("categoryBigNo", categoryBigNo);
		
		System.out.println("categoryBigNo : " + categoryBigNo == null ? "null" : categoryBigNo);
		
		return "crew/list.jsp";
	}
	
}
