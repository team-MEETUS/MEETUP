package kr.co.meetup.web.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GeoVO {
	private int geoCode;
	private String geoCity;
	private String geoDistrict;
}
