package kr.co.meetup.web.action.crew;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.dao.GeoDAO;
import kr.co.meetup.web.vo.CrewMemberVO;
import kr.co.meetup.web.vo.CrewVO;

@SuppressWarnings("serial")
@WebServlet("/crewUpdate")
public class UpdateAction extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파일 경로 받아오기
		String saveDir = req.getServletContext().getRealPath("/upload");
		
		// 최대 파일 크기 지정 
		int maxFileSize = 1024 * 1024 * 30;
		
		// MultipartRequest 객체 생성 
		MultipartRequest mr = new MultipartRequest(req, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
		
		// MultipartRequest 객체로부터 파라미터 값 가져오기
		String cn = mr.getParameter("crewNo");
		String cbn = mr.getParameter("categoryBigNo");
		String csn = mr.getParameter("categorySmallNo");
		String geoCity = mr.getParameter("geoCity");
		String geoDistrict = mr.getParameter("geoDistrict");
		String crewName = mr.getParameter("crewName");
		String cm = mr.getParameter("crewMax");
		String crewContent = mr.getParameter("crewContent");
		
		// 메인 이미지의 원본파일명, 저장파일명
		String crewOriginalImg = null;
		String crewSaveImg = null;
		
		// 배너 이미지의 원본파일명, 저장파일명
		String crewOriginalBanner = null;
		String crewSaveBanner = null;
		
		// 이미지 삭제 여부 확인
	    String crewImgDeleted = mr.getParameter("crewImgDeleted");
	    String crewBannerDeleted = mr.getParameter("crewBannerDeleted");
		
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
		int crewNo = 0;
		int categoryBigNo = 0;
		int categorySmallNo = 0;
		int crewMax = 0;
		if (cn != null && !cn.equals("")) {
			crewNo = Integer.parseInt(cn);
		}
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
	    CrewVO existingCrew = dao.selectOneCrew(crewNo);
	    
	    if("true".equals(crewImgDeleted)) {
	    	crewOriginalImg = null;
	    	crewSaveImg = null;
	    } else {
	    	crewOriginalImg = mr.getOriginalFileName("crewImg");
	    	crewSaveImg = mr.getFilesystemName("crewImg");
	    	
	    	if (crewOriginalImg == null && crewSaveImg == null) {
	    		crewOriginalImg = existingCrew.getCrewOriginalImg();
	    		crewSaveImg = existingCrew.getCrewSaveImg();
	    	}
	    }
	    
	    if("true".equals(crewBannerDeleted)) {
	    	crewOriginalBanner = null;
	    	crewSaveImg = null;
	    } else {
	    	crewOriginalBanner = mr.getOriginalFileName("crewBanner");
	    	crewSaveBanner = mr.getFilesystemName("crewBanner");
	    	
	    	if (crewOriginalBanner == null && crewSaveBanner == null) {
	    		crewOriginalBanner = existingCrew.getCrewOriginalBanner();
	    		crewSaveBanner = existingCrew.getCrewSaveBanner();
	    	}
	    }
		
		CrewVO vo = new CrewVO();

		// DB 에 모임 수정
		vo.setCrewNo(crewNo);
		vo.setGeoCode(geoCode);
		vo.setCategoryBigNo(categoryBigNo);
		if (categorySmallNo != 0) vo.setCategorySmallNo(categorySmallNo);
		else vo.setCategorySmallNo(null);
		vo.setCrewName(crewName);
		vo.setCrewContent(crewContent);
		vo.setCrewIntro(crewIntro);
		vo.setCrewMax(crewMax);
		vo.setCrewOriginalImg(crewOriginalImg);
        vo.setCrewSaveImg(crewSaveImg);
        vo.setCrewOriginalBanner(crewOriginalBanner);
        vo.setCrewSaveBanner(crewSaveBanner);
		
		dao.updateCrew(vo);
		
		resp.sendRedirect("crew?cmd=detail&crewNo=" + crewNo);
	}
	
}
