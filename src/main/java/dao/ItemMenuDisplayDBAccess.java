/**
 * クラス名：	ItemMenuDisplayDBAccess
 * 概要　　：	商品情報表示DAO
 * 作成者名：
 * 作成日　：
 * 修正者名：
 * 修正日　：
 */

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Item;

public class ItemMenuDisplayDBAccess extends ControlDBAccess{

	public ArrayList<Item> searchAllItem() throws Exception {
		Connection con = createConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			if(con!=null) {
				String sql = "select * from item;";
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()==true) {
					String itemId=rs.getString("ITEMID");
					String itemName=rs.getString("ITEMNAME");
					String size=rs.getString("SIZE");
					int price=rs.getInt("PRICE");
					Item item=new Item(itemId, itemName, size, price);
					list.add(item);
				}
			}
		} catch(SQLException e) {
			throw new Exception("商品情報検索処理に失敗しました！\n管理者に連絡してください。");
			
		} finally {
			try {
				if(rs!=null) {
					rs.close();
				}
			} catch(SQLException e) {
				throw new Exception("DB接続処理に失敗しました!\n管理者に連絡してください。");
			}
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
			} catch(SQLException e) {
				throw new Exception("DB接続処理に失敗しました!\n管理者に連絡してください。");
			}
		}
		closeConnection(con);
		return list;
		
	}
}
