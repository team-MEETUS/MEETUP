package kr.co.meetup.web.action.crew;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CategoryBigVO;
import kr.co.meetup.web.vo.CrewVO;

public class ListAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		
CrewDAO dao = new CrewDAO();
		
		// 전체 카테고리 리스트 가져오기
		List<CategoryBigVO> categoryBigList = dao.selectAllCategoryBig();
		
		// 카테고리 값 가져오기
		String ctg = req.getParameter("ctg");
		
		// 카테고리 값이 있으면 해당 카테고리의 모임리스트 & 수 가져오기
		int totalCount;
		if (ctg != null) {
			totalCount = dao.selectAllCrewByCategoryCnt(Integer.parseInt(ctg));
		} else {
			totalCount = dao.selectAllCrewCnt();
		}
		
		// 한 페이지 당 모임 수
		int recordPerPage = 4;
		
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
		if (ctg != null) {			
			crewList = dao.selectCrewByCategory(Integer.parseInt(ctg), startNo, recordPerPage);	// 카테고리 별
		} else {						
			crewList = dao.selectAll(startNo, recordPerPage);									// 전체
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
		
		return "crew/list.jsp";
	}
	
}
