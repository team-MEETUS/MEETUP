package common;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class fileLoader {

	 private static Properties properties = new Properties();

	    static {
	        try (InputStream input = fileLoader.class.getClassLoader().getResourceAsStream("config/file.properties")) {
	            if (input == null) {
	                System.out.println("unable to find config.properties");
	            }
	            properties.load(input);
	        } catch (IOException ex) {
	            ex.printStackTrace();
	        }
	    }

	    public static String getProperty(String key) {
	        return properties.getProperty(key);
	    }
	
}