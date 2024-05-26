package common;

import java.security.Key;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.net.util.Base64;



public class AES128 {
	private String ips;
	private Key keySpec;
	
	// 전달받은 키를 암호화 로직에 적용
	public AES128(String key) {
		try {
			byte[] keyBytes = new byte[16];
			byte[] b = key.getBytes("UTF-8");
			System.arraycopy(b, 0, keyBytes, 0, keyBytes.length);
			SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
			this.ips = key.substring(0, 16);
			this.keySpec = keySpec;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 암호화 하기
	@SuppressWarnings("deprecation")
	public String encrypt(String str) {
		Cipher cipher;
		try {
			cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(ips.getBytes()));
			
			byte[] encrypted = cipher.doFinal(str.getBytes("UTF-8"));
			String Str = new String(Base64.encodeBase64String(encrypted));
			
			return Str;
		} catch (Exception e) {
			return null;
		}
	}
	
	// 암호화 풀기
	@SuppressWarnings("deprecation")
	public String decrypt(String str) {
		try {
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(ips.getBytes("UTF-8")));
			
			byte[] byteStr = Base64.decodeBase64(str.getBytes());
			String Str = new String(cipher.doFinal(byteStr));
			
			return Str;
		} catch (Exception e) {
			return null;
		}
	}

}
