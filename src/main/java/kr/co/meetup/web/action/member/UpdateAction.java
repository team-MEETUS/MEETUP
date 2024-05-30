package kr.co.meetup.web.action.member;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.dao.GeoDAO;
import kr.co.meetup.web.dao.MemberDAO;
import kr.co.meetup.web.vo.GeoVO;
import kr.co.meetup.web.vo.MemberVO;

@WebServlet("/memberUpload")
public class UpdateAction extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String saveDir = req.getServletContext().getRealPath("/upload");
		
		int maxFileSize = 1024 * 1024 * 30;
		
		MultipartRequest mr = new MultipartRequest(req, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
		
		String mno = mr.getParameter("memberNo");
		if(mno != null) {
			int memberNo = Integer.parseInt(mno);
			String memberNickname = mr.getParameter("memberNickname");
			String geoCity = mr.getParameter("geoCity");
			String geoDistrict = mr.getParameter("geoDistrict");
			String memberIntro = mr.getParameter("memberIntro");
			String memberBirth = mr.getParameter("memberBirth");
			String memberGender = mr.getParameter("memberGender");
			
			String removeImg = mr.getParameter("removeImg");
			String memberOriginalImg = null;
			String memberSaveImg = null;
			
			MemberDAO mdao = new MemberDAO();
			MemberVO existingMember = mdao.selectOneMemberByMemberNo(memberNo);
			
			if("true".equals(removeImg)) {
				memberOriginalImg = null;
	            memberSaveImg = null;
			} else {
	            // 이미지를 제거하지 않는 경우, 기존 로직을 유지
	            memberOriginalImg = mr.getOriginalFileName("memberImg");
	            memberSaveImg = mr.getFilesystemName("memberImg");
	            
	            if(memberOriginalImg == null && memberSaveImg == null) {
					memberOriginalImg = existingMember.getMemberOriginalImg();
					memberSaveImg = existingMember.getMemberSaveImg();
				}
	        }
			
			GeoDAO gdao = new GeoDAO();
			int geoCode = gdao.selectOneGeoByCity(geoCity, geoDistrict);
			
			MemberVO vo = new MemberVO();
			
			vo.setMemberNo(memberNo);
			vo.setMemberNickname(memberNickname);
			vo.setGeoCode(geoCode);
			vo.setMemberIntro(memberIntro);
			vo.setMemberBirth(memberBirth);
			vo.setMemberGender(memberGender);
			vo.setMemberOriginalImg(memberOriginalImg);
			vo.setMemberSaveImg(memberSaveImg);
			
			mdao.updateOneMemberByMemberNo(vo);
			
			vo = mdao.selectOneMemberByMemberNo(memberNo);
			GeoVO gvo = gdao.selectOneGeoCityGeoDistrictByGeoCode(geoCode);
			
			HttpSession session = req.getSession();
			session.setAttribute("loginMember", vo);
			session.setAttribute("loginMemberGeo", gvo);
			
//			req.getSession().setAttribute("loginMember", vo);
			
			resp.sendRedirect("member?cmd=myMenu");
		}
		

	}

}
