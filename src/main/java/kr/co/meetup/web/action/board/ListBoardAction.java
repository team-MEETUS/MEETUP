package kr.co.meetup.web.action.board;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.BoardCategoryVO;
import kr.co.meetup.web.vo.BoardVO;

public class ListBoardAction implements Action {
	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		BoardDAO dao = new BoardDAO();

		// 게시판 카테고리 리스트 가져오기
		List<BoardCategoryVO> BoardCategoryList = dao.selectAllBoardCategory();
		
		//bc(boardCategory) 값 가져오기
		String bc = req.getParameter("boardCategoryNo");
		
		//cn(crewNo) 값 가져오기
		String cn =req.getParameter("cn");
		int crewNo = 0;
		
		if(cn != null) {
			crewNo =Integer.parseInt(cn);
		} else {
			//  임시 crewNo
			crewNo = 2;
		}
		
		// 총 게시물 수
		int totalCount = dao.selectAllBoardByCrewNoCnt(crewNo);
		
		// 한 페이지당 게시글 수 : 10
		int recordPerPage = 10;
		// 총 페이지 수
		int totalPage = totalCount % recordPerPage == 0 ? totalCount / recordPerPage : totalCount / recordPerPage + 1;

		// 현재 페이지 번호
		String cp = req.getParameter("cp");

		int currentPage = 0;
		if (cp != null) {
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
		if (currentPage <= 5) {
			startPage = 1;
		} else if (currentPage >= 6) {
			startPage = currentPage - 4;
		}
		// 끝페이지를 현재 페이지 기준으로 뒤에 5개만 보여주기
		if (totalPage - currentPage <= 5) {
			endPage = totalPage;
		} else if (totalPage - currentPage > 5) {
			if (currentPage <= 5) {
				if (totalPage > 10) {
					endPage = 10;
				} else {
					endPage = totalPage;
				}
			} else {
				endPage = currentPage - 4;
			}
		}

		// 이전 페이지가 존재하는지 여부
		if (currentPage >= 2) {
			isPrev = true;
		}
		if (currentPage != totalPage) {
			isNext = true;
		}

		//bc 값이 있으면 해당 카테고리의 게시글만 가져오기
		List<BoardVO> boardList;
		if (bc != null) {
			boardList = dao.selectBoardByCategory(Integer.parseInt(bc));
		}else {
		//bc 값이 없으면 모임별 전체 게시글 출력
			boardList = dao.selectBoardAllByCategory();
		}
		System.out.println(boardList.toString());
		req.setAttribute("BoardCategoryList", BoardCategoryList);
		req.setAttribute("boardList", boardList);

		return "board/listBoard.jsp";
	}
}