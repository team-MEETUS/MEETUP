package kr.co.meetup.web.action.crew;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;

public class DeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		// crewNo 가져오기
		String cn = req.getParameter("crewNo");
		
		// 형변환
		int crewNo = 0;
		if (cn != null) {
			crewNo = Integer.parseInt(cn);
		}
		
		// DAO 객체 생성
		CrewDAO dao = new CrewDAO();
		
		// 모임 삭제
		dao.deleteCrew(crewNo);
		
		return "crew?cmd=list";
	}

}
