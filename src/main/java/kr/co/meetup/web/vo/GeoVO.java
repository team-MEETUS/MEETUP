package kr.co.meetup.web.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class GeoVO implements Serializable {
	private int geoCode;
	private String geoCity;
	private String geoDistrict;
}
