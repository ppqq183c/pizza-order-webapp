package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ItemDAO extends ControlDBAccess {

	public List<Map<String, Object>> getSizesByItemId(String itemId) throws Exception {
	    List<Map<String, Object>> list = new ArrayList<>();

	    String sql = 
	        "SELECT size, price " +
	        "FROM item " +
	        "WHERE itemname = (" +
	        "  SELECT itemname FROM item WHERE itemid = ?" +
	        ")";

	    try (Connection con = createConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, itemId);

	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                Map<String, Object> map = new HashMap<>();
	                map.put("size", rs.getString("size"));
	                map.put("price", rs.getInt("price"));
	                list.add(map);
	            }
	        }
	    }
	    return list;
	}

}

