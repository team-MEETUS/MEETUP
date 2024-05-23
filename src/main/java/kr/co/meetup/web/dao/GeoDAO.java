package kr.co.meetup.web.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.co.meetup.web.vo.GeoVO;

public class GeoDAO {
	private SqlSessionFactory factory;
	
	public GeoDAO() {
		try {
			Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			factory = builder.build(r);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public List<GeoVO> selectAllGeo() {
		SqlSession ss = factory.openSession(true);
		List<GeoVO> list = ss.selectList("kr.co.meetup.geo.selectAllGeo");
		
		ss.close();
		return list;
	}
	
	public int selectOneGeoByCity(String geoCity, String geoDistrict) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("geoCity", geoCity);
		map.put("geoDistrict", geoDistrict);
		
		int geoCode = ss.selectOne("kr.co.meetup.geo.selectOneGeoByCity", map);
		
		ss.close();
		return geoCode;
	}
	
	public List<String> selectAllGeoCity() {
		SqlSession ss = factory.openSession(true);
		List<String> list = ss.selectList("kr.co.meetup.geo.selectAllGeoCity");
		ss.close();
		
		return list;
	}
	
	public List<String> selectAllGeoDistrictByGeoCity(String geoCity) {
		SqlSession ss = factory.openSession(true);
		List<String> list = ss.selectList("kr.co.meetup.geo.selectAllGeoDistrictByGeoCity", geoCity);
		ss.close();
		
		return list;
	}
	
	public GeoVO selectOneGeoCityGeoDistrictByGeoCode(int geoCode) {
		SqlSession ss = factory.openSession(true);
		GeoVO vo = ss.selectOne("kr.co.meetup.geo.selectOneGeoCityGeoDistrictByGeoCode", geoCode);
		ss.close();
		
		return vo;
	}
}
