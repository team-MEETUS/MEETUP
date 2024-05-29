package kr.co.meetup.web.action.member;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.dao.GeoDAO;
import kr.co.meetup.web.dao.MemberDAO;
import kr.co.meetup.web.vo.CrewVO;
import kr.co.meetup.web.vo.GeoVO;
import kr.co.meetup.web.vo.MemberVO;

public class MemberProfileAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		String mno = req.getParameter("memberNo");
		int memberNo = 0;
		if(mno != null) {
			memberNo = Integer.parseInt(mno);
		}
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.selectOneMemberByMemberNo(memberNo);
		GeoDAO gdao = new GeoDAO();
		GeoVO gvo = gdao.selectOneGeoCityGeoDistrictByGeoCode(vo.getGeoCode());
		
		CrewDAO cdao = new CrewDAO();
		List<CrewVO> memberProfileCrewList = cdao.selectAllCrewByMember(vo.getMemberNo());
		
		System.out.println(memberProfileCrewList);
		
		req.setAttribute("otherMember", vo);
		req.setAttribute("GeoVO", gvo);
		req.setAttribute("memberProfileCrewList", memberProfileCrewList);
		
		return "member/memberProfile.jsp";
	}

}
