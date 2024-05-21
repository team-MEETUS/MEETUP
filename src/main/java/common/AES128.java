package common;

import java.security.Key;

public class AES128 {
	private String ips;
	private Key keySpec;
	
	public AES128(String key) {
		byte[] keyBytes = new byte[16];
		byte[] b = key.getBytes("UTF-8");
	}

}
