package kr.co.meetup.web.action.crew;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.dao.GeoDAO;
import kr.co.meetup.web.vo.CrewMemberVO;
import kr.co.meetup.web.vo.CrewVO;
import kr.co.meetup.web.vo.MemberVO;

@WebServlet("/crewWrite")
public class WriteAction extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 현재 로그인한 회원 vo 가져오기
		HttpSession session = req.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("MemberVO");
		
		// 로그인한 회원일 경우
		if (loginMember != null) {
			// 파일 경로 받아오기
			String saveDir = req.getServletContext().getRealPath("/upload");
			
			// 최대 파일 크기 지정 
			int maxFileSize = 1024 * 1024 * 30;
			
			// MultipartRequest 객체 생성 
			MultipartRequest mr = new MultipartRequest(req, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
			
			// MultipartRequest 객체로부터 파라미터 값 가져오기
			String cbn = mr.getParameter("categoryBigNo");
			String csn = mr.getParameter("categorySmallNo");
			String geoCity = mr.getParameter("geoCity");
			String geoDistrict = mr.getParameter("geoDistrict");
			String crewName = mr.getParameter("crewName");
			String cm = mr.getParameter("crewMax");
			String crewContent = mr.getParameter("crewContent");
			
			// 메인 이미지의 원본파일명, 저장파일명
			String crewOriginalImg = mr.getOriginalFileName("crewImg");
			String crewSaveImg = mr.getFilesystemName("crewImg");;
			
			// 배너 이미지의 원본파일명, 저장파일명
			String crewOriginalBanner = mr.getOriginalFileName("crewBanner");
			String crewSaveBanner = mr.getFilesystemName("crewBanner");;
			
			// crewContent 의 첫 줄을 crewIntro 로 저장 
			String crewIntro = "";
			if (crewContent != null && !crewContent.trim().isEmpty()) {
				String[] lines = crewContent.split("\\R");
				if (lines.length > 0) {
					crewIntro = lines[0];
				}
			}
			
			// 해당 시/구 지역코드 가져오기
			GeoDAO gdao = new GeoDAO();
			int geoCode = gdao.selectOneGeoByCity(geoCity, geoDistrict);
			
			// String > int 형변환
			int categoryBigNo = 0;
			int categorySmallNo = 0;
			int crewMax = 0;
			if (cbn != null && !cbn.equals("")) {
				categoryBigNo = Integer.parseInt(cbn);
			}
			if (csn != null && !csn.equals("")) {
				categorySmallNo = Integer.parseInt(csn);
			}
			if (cm != null && !cm.equals("")) {
				crewMax = Integer.parseInt(cm);
			}
			
			CrewDAO dao = new CrewDAO();
			CrewVO vo = new CrewVO();
			CrewMemberVO cmvo = new CrewMemberVO();

			// DB 에 모임 저장
			vo.setGeoCode(geoCode);
			vo.setCategoryBigNo(categoryBigNo);
			if (categorySmallNo != 0) vo.setCategorySmallNo(categorySmallNo);
			else vo.setCategorySmallNo(null);
			vo.setMemberNo(loginMember.getMemberNo());
			vo.setCrewName(crewName);
			vo.setCrewContent(crewContent);
			vo.setCrewIntro(crewIntro);
			vo.setCrewMax(crewMax);
			vo.setCrewOriginalImg(crewOriginalImg);
			vo.setCrewSaveImg(crewSaveImg);
			vo.setCrewOriginalBanner(crewOriginalBanner);
			vo.setCrewSaveBanner(crewSaveBanner);

			int crewNo = dao.addCrew(vo);
			
			// DB 에 모임회원 저장
			cmvo.setCrewNo(crewNo);
			cmvo.setMemberNo(loginMember.getMemberNo());
			cmvo.setCrewMemberStatus(2);
			
			dao.addCrewMember(cmvo);
			
			
			resp.sendRedirect("crew");
		}
		
	}
	
}
