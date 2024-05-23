package kr.co.meetup.web.action.meeting;

import java.io.IOException;
import java.sql.Timestamp;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.MeetingDAO;
import kr.co.meetup.web.vo.MeetingVO;

@WebServlet("/upload.do")
public class UploadAction extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String saveDir = req.getServletContext().getRealPath("/upload");
		System.out.println("saveDir : " + saveDir);
		 
		// 최대 파일 크기 지정 
	    int maxFileSize = 1024 * 1024 * 30;
	    
	    MultipartRequest mr = new MultipartRequest(req, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());

    	String crewNo = mr.getParameter("crewNo");
		String memberNo = mr.getParameter("memberNo");
		String meetingName = mr.getParameter("meetingName");
		String meetingDay = mr.getParameter("meetingDay");
		String meetingTime1 = mr.getParameter("meetingTime1");
		String meetingTime2 = mr.getParameter("meetingTime2");
		String meetingLoc = mr.getParameter("meetingLoc");
		String meetingPrice = mr.getParameter("meetingPrice");
		String meetingMax = mr.getParameter("meetingMax");
		
		// 메인 이미지의 원본파일명, 저장파일명
		String meetingOriginalImg = mr.getOriginalFileName("meetingImg");
		String meetingSaveImg = mr.getFilesystemName("meetingImg");
		String meetingDate = meetingDay + " " + meetingTime1 + ":" + meetingTime2 + ":00";
		
		System.out.println("crewNo : " + crewNo);
		System.out.println("memberNo : " + memberNo);
		System.out.println("meetingName : " + meetingName);
		System.out.println("meetingLoc : " + meetingLoc);
		System.out.println("meetingPrice : " + meetingPrice);
		System.out.println("meetingMax : " + meetingMax);
		System.out.println("meetingOriginalImg : " + meetingOriginalImg);
		System.out.println("meetingSaveImg : " + meetingSaveImg);
		System.out.println("meetingDate : " + meetingDate);
		
		MeetingDAO dao = new MeetingDAO();
		MeetingVO vo = new MeetingVO();
		// 직접 받아오면 수정
		vo.setCrewNo(1);
		// 직접 받아오면 수정
		vo.setMemberNo(3);
		vo.setMeetingName(meetingName);
		vo.setMeetingDate(Timestamp.valueOf(meetingDay + " " + meetingTime1 + ":" + meetingTime2 + ":00"));
		vo.setMeetingLoc(meetingLoc);
		vo.setMeetingPrice(Integer.parseInt(meetingPrice));
		vo.setMeetingMax(Integer.parseInt(meetingMax));
		vo.setMeetingOriginalImg(meetingOriginalImg);
		vo.setMeetingSaveImg(meetingSaveImg);
		
		dao.addMeeting(vo);
		
		resp.sendRedirect("meeting");
	}
}
