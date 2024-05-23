package kr.co.meetup.web.control;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.action.crew.ListAction;
import kr.co.meetup.web.action.crew.WriteAction;
import kr.co.meetup.web.action.crew.WriteFormAction;

@SuppressWarnings("serial")
@WebServlet("/crew")
public class CrewController extends HttpServlet {
	
	private void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		
		String cmd = "";
		String url = "";
		Action action = null;
		
		cmd = req.getParameter("cmd");
		
		if (cmd == null || cmd.equals("list")) {
			System.out.println("list 실행!");
			action = new ListAction();
		} else if (cmd.equals("write")) {
			System.out.println("write 실행!");
			action = new WriteFormAction();
		} 
		
		url = action.execute(req, resp);
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// upload 디렉토리 실제 경로
	    String saveDir = req.getServletContext().getRealPath("/upload");
	    //System.out.println("saveDir : " + saveDir); // 경로 확인용
	    
	    // 최대 파일 크기 지정 
	    int maxFileSize = 1024 * 1024 * 30;
	    
	    try {
	    	// MultipartRequest 객체 생성 
	    	MultipartRequest mr = new MultipartRequest(req, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
	        // cmd 파라미터 값 가져오기
	    	String cmd = mr.getParameter("cmd");
	        // writeOk 라면 파라미터 값 가져오기
	    	if (cmd.equals("writeOk")) {
		        String categoryBigNo = mr.getParameter("categoryBigNo");
				String categorySmallNo = mr.getParameter("categorySmallNo");
				String geoCity = mr.getParameter("geoCity");
				String geoDistrict = mr.getParameter("geoDistrict");
				String crewName = mr.getParameter("crewName");
				String crewMax = mr.getParameter("crewMax");
				String crewContent = mr.getParameter("crewContent");
				
				// 메인 이미지의 원본파일명, 저장파일명
				String crewOriginalImg = mr.getOriginalFileName("crewImg");
				String crewSaveImg = mr.getFilesystemName("crewImg");;
				
				// 배너 이미지의 원본파일명, 저장파일명
				String crewOriginalBanner = mr.getOriginalFileName("crewBanner");
				String crewSaveBanner = mr.getFilesystemName("crewBanner");;
				
				// 속성으로 파라미터 값 부여
				req.setAttribute("categoryBigNo", categoryBigNo);
				req.setAttribute("categorySmallNo", categorySmallNo);
				req.setAttribute("geoCity", geoCity);
				req.setAttribute("geoDistrict", geoDistrict);
				req.setAttribute("crewName", crewName);
				req.setAttribute("crewMax", crewMax);
				req.setAttribute("crewContent", crewContent);
				req.setAttribute("crewOriginalImg", crewOriginalImg);
				req.setAttribute("crewSaveImg", crewSaveImg);
				req.setAttribute("crewOriginalBanner", crewOriginalBanner);
				req.setAttribute("crewSaveBanner", crewSaveBanner);
		        
	            Action action = new WriteAction();
	            
	            String url = action.execute(req, resp);
	            
	            // "redirect:" 문자열 제거하고 리다이렉트
	    		if (url.startsWith("redirect:")) {
	    		    resp.sendRedirect(url.substring(9)); 
	    		} else {
	    		    RequestDispatcher rd = req.getRequestDispatcher(url);
	    		    rd.forward(req, resp);
	    		}
	        } 
	    } catch (IOException e) {
	        System.err.println("IOException: " + e.getMessage());
	        e.printStackTrace();
	    }
	}
	
}
