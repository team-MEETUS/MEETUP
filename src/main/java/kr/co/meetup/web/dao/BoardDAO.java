package kr.co.meetup.web.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.co.meetup.web.vo.BoardCategoryVO;
import kr.co.meetup.web.vo.BoardCommentVO;
import kr.co.meetup.web.vo.BoardVO;

public class BoardDAO {

	public SqlSessionFactory factory;

	public BoardDAO() {
		try {
			Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			factory = builder.build(r);
			r.close();
		} catch (IOException e) {
			System.err.println("config.xml 파일을 찾을 수 없습니다.");
			e.printStackTrace();
		}
	}

	// 모임&카테고리 별 게시판 총 개수 
	public int selectAllBoardCntByCategory(int crewNo, int boardCategoryNo) {
		 SqlSession ss = factory.openSession(true);
		 HashMap<String, Integer> map = new HashMap<String, Integer>();
		 map.put("crewNo", crewNo);
		 map.put("boardCategoryNo", boardCategoryNo);
		 int cnt = ss.selectOne("kr.co.meetup.web.board.selectAllBoardCntByCategory", map);
		 ss.close();
		 return cnt;
	}
	public int selectAllBoardCount(int crewNo) {
		SqlSession ss = factory.openSession(true);
		int count = ss.selectOne("kr.co.meetup.web.board.selectAllBoardCount", crewNo);
		ss.close();
		return count;
	}
	public int selectAllBoardByBoardCategoryNo(int boardCategoryNo, int crewNo) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardCategoryNo", boardCategoryNo);
		map.put("crewNo", crewNo);
		int count = ss.selectOne("kr.co.meetup.web.board.selectAllBoardByBoardCategoryNo", map);
		ss.close();
		return count;
	}

	// 게시판 카테고리 조회
	public List<BoardCategoryVO> selectAllBoardCategory() {
		SqlSession ss = factory.openSession(true);
		List<BoardCategoryVO> list = ss.selectList("kr.co.meetup.web.board.selectAllBoardCategory");
		ss.close();
		return list;
	}

	// 게시판 카테고리별 게시글 조회
	public List<BoardVO> selectBoardByCategory(int bc,int startNo,int recordPerPage, int crewNo) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardCategoryNo", bc);
		map.put("startNo", startNo);
		map.put("recordPerPage", recordPerPage);
		map.put("crewNo", crewNo);
		List<BoardVO> list = ss.selectList("kr.co.meetup.web.board.selectBoardByCategory", map);
		ss.close();
		return list;
	}
	
	//리스트 페이징 처리용
	public List<BoardVO> selectBoardAll(int startNo,int recordPerPage, int crewNo) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("startNo", startNo);
		map.put("recordPerPage", recordPerPage);
		map.put("crewNo", crewNo);
		List<BoardVO> list = ss.selectList("kr.co.meetup.web.board.selectBoardAll",map);
		ss.close();
		return list;
	}

	// 게시글 1건 조회
	public BoardVO selectOneBoard(int boardNo) {
		SqlSession ss = factory.openSession(true);
		BoardVO vo = ss.selectOne("kr.co.meetup.web.board.selectOneBoard", boardNo);
		ss.close();
		return vo;
	}
	
	// 게시글 작성
	public void addOneBoard(BoardVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.insert("kr.co.meetup.web.board.addOneBoard", vo);
		ss.close();
	}

	// 게시글 수정
	public void updateOneBoard(BoardVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.web.board.updateOneBoard", vo);
		ss.close();
	}

	// 게시글 삭제(update)
	public void deleteOneBoard(int boardNo) {
		SqlSession ss = factory.openSession(true);

		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardNo", boardNo);
		map.put("boardStatus", 0);
		ss.update("kr.co.meetup.web.board.deleteOneBoard", map);

		ss.close();
	}

	// 게시글 조회수 1 증가
	public void raiseHitBoard(int boardNo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.web.board.raiseHitBoard", boardNo);
		ss.close();
	}
	
	
	//댓글 작성
	public void addOneComment(BoardCommentVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.insert("kr.co.meetup.web.board.addOneComment", vo);
		ss.close();
	}
	
	//댓글 목록 조회
	public List<BoardCommentVO> selectComment(int boardNo) {
		SqlSession ss = factory.openSession(true);
		List<BoardCommentVO> list = ss.selectList("kr.co.meetup.web.board.selectComment", boardNo);
		ss.close();
		return list;
	}
	
	//댓글 1건 조회
	public BoardCommentVO selectOneBoardComment(int boardCommentNo) {
		SqlSession ss = factory.openSession(true);
		BoardCommentVO vco = ss.selectOne("kr.co.meetup.web.board.selectOneBoardComment", boardCommentNo);
		ss.close();
		return vco;
	}

	
	// 댓글 수정
	public void updateOneBoardComment(BoardCommentVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.web.board.updateOneBoardComment", vo);
		System.out.println(vo.getBoardCommentContent());
		ss.close();
		}

	
	//댓글 삭제(상태 변경)
	public void deleteOneBoardComment(int boardCommentNo) {
	    SqlSession ss = factory.openSession(true);
	    
	    ss.update("kr.co.meetup.web.board.deleteOneBoardComment", boardCommentNo);
	    ss.close();
	}

	

	
}