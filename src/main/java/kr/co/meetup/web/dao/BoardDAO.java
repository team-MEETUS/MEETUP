package kr.co.meetup.web.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.co.meetup.web.vo.BoardCategoryVO;
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

	// 게시판 총 데이터 수 조회
	public int selectTotalCountBoard() {
		SqlSession ss = factory.openSession(true);
		int count = ss.selectOne("kr.co.meetup.web.board.selectTotalCountBoard");
		ss.close();
		return count;
	}
	
	// 모임별 게시판 전체 조회
	public List<BoardVO> selectAllBoardBycrewNo(int crewNo, int boardStartNo, int boardEndNo) {
		SqlSession ss = factory.openSession(true);
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("crewNo", crewNo);
		map.put("boardStartNo", boardStartNo);
		map.put("boardEndNo", boardEndNo);
		List<BoardVO> list = ss.selectList("kr.co.meetup.web.board.selectAllBoardBycrewNo", map);
		ss.close();
		return list;
	}
	
	// 게시판 카테고리 조회
	public List<BoardCategoryVO> selectAllBoardCategory(int boardStartNo, int boardEndNo) {
		SqlSession ss = factory.openSession(true);
		List<BoardCategoryVO> list = ss.selectList("kr.co.meetup.web.board.selectAllBoardCategory");
		ss.close();
		return list;	
	}
	
	// 게시판 카테고리별 게시글 조회
	public List<BoardVO> selectBoardByCategory(int boardCategoryNo, int boardStartNo, int boardEndNo) {
	    SqlSession ss = factory.openSession(true);
	    
	    HashMap<String, Object> map = new HashMap<>();
	    map.put("boardCategoryNo", boardCategoryNo);
	    map.put("boardStartNo", boardStartNo);
	    map.put("boardEndNo", boardEndNo);
	    
	    List<BoardVO> list = ss.selectList("kr.co.meetup.web.board.selectBoardByCategory", map);
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
		
		ss.update("kr.co.meetup.web.board.deleteOneBoard", map);
		
		ss.close();
	}

	// 게시글 조회수 1 증가
	public void raiseHitBoard(int boardNo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.web.board.raiseHitBoard", boardNo);
		ss.close();
	}

}
