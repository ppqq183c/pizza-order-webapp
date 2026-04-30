package dao;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Item;

public class SearchAllMenuDBAccess extends ControlDBAccess{

	public ArrayList<Item> searchAllItem() throws Exception {
		Connection con = createConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			if(con!=null) {
				String sql =
					    "SELECT i.* " +
					    "FROM item i " +
					    "JOIN ( " +
					    "  SELECT ITEMNAME, MIN(PRICE) AS MIN_PRICE " +
					    "  FROM item " +
					    "  WHERE DELETEFLG = 0 " +
					    "  GROUP BY ITEMNAME " +
					    ") m " +
					    "  ON i.ITEMNAME = m.ITEMNAME " +
					    " AND i.PRICE = m.MIN_PRICE " +
					    "WHERE i.DELETEFLG = 0 " +
					    "ORDER BY " +
					    "  CASE " +
					    "    WHEN i.ITEMID LIKE 'p%' THEN 1 " +
					    "    WHEN i.ITEMID LIKE 's%' THEN 2 " +
					    "    WHEN i.ITEMID LIKE 'd%' THEN 3 " +
					    "    ELSE 4 " +
					    "  END, " +
					    "  i.ITEMNAME";
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					String itemId=rs.getString("ITEMID");
					String itemName=rs.getString("ITEMNAME");
					String size=rs.getString("SIZE");
					int price=rs.getInt("PRICE");
					Blob picture=rs.getBlob("blob_column");
					int deleteflg=rs.getInt("DELETEFLG");
					if(size==null)
					{
						size=" ";
					}
					if(deleteflg==0)
					{
					Item item=new Item(itemId, itemName, size, price,picture);
					list.add(item);
					}
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
	
	public ArrayList<Item> searchItemByItemid(String itemid)throws Exception
	{
		Connection con=createConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<Item>list=new ArrayList<Item>();
		try {
			if(con!=null) {
				String sql="SELECT * FROM ITEM WHERE ITEMID=?;";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1,itemid);
				rs=pstmt.executeQuery();
				while(rs.next())
				{
					String ItemID=rs.getString("ITEMID") ;
					String ItemName=rs.getString("ITEMNAME") ;
					String size=rs.getString("SIZE") ;
					int price=rs.getInt("PRICE") ;
					int deleteflg=rs.getInt("DELETEFLG");
					if(size==null)
					{
						size=" ";
					}
					if(deleteflg==0)
					{
					Item bean = new Item(ItemID,ItemName,size,price);
					list.add(bean);
					}
				}
			}
		}catch(SQLException e)
		{
			throw new Exception("顧客情報検索処理に失敗しました！\n管理者に連絡してください。");
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
	
	public ArrayList<Item>searchItemByName(String itemName)throws Exception
	{
		Connection con=createConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<Item>list=new ArrayList<Item>();
		try {
			if(con!=null) {
				String sql="SELECT * FROM ITEM WHERE ITEMNAME LIKE ?;";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+itemName+"%");
				rs=pstmt.executeQuery();
				while(rs.next())
				{
					String ItemID=rs.getString("ITEMID") ;
					String ItemName=rs.getString("ITEMNAME") ;
					String size=rs.getString("SIZE") ;
					int price=rs.getInt("PRICE") ;
					int deleteflg=rs.getInt("DELETEFLG");
					if(size==null)
					{
						size=" ";
					}
					if(deleteflg==0)
					{
					Item bean = new Item(ItemID,ItemName,size,price);
					list.add(bean);
					}
				}
			}
		}catch(SQLException e)
		{
			throw new Exception("顧客情報検索処理に失敗しました！\n管理者に連絡してください。");
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

	public ArrayList<Item>searchItem(String itemid,String itemname)throws Exception
	{
		Connection con=createConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<Item>list=new ArrayList<Item>();
		try {
			if(con!=null) {
				String sql="SELECT * FROM ITEM WHERE ITEMID=? AND ITEMNAME like ?;";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1,itemid);
				pstmt.setString(2,"%"+itemname+"%");
				rs=pstmt.executeQuery();
				while(rs.next()==true)
				{
					String ItemID=rs.getString("ITEMID") ;
					String ItemName=rs.getString("ITEMNAME") ;
					String size=rs.getString("SIZE") ;
					int price=rs.getInt("PRICE") ;
					int deleteflg=rs.getInt("DELETEFLG");
					if(size==null)
					{
						size=" ";
					}
					if(deleteflg==0)
					{
					Item bean = new Item(ItemID,ItemName,size,price);
					list.add(bean);
					}
				}
			}
		}catch(SQLException e)
		{
			throw new Exception("顧客情報検索処理に失敗しました！\n管理者に連絡してください。");
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
	
	public ArrayList<Item> searchItemByMinPrice(String itemid)throws Exception
	{
		Connection con=createConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		PreparedStatement minPstmt=null;
		ArrayList<Item>list=new ArrayList<Item>();
		try {
			if(con!=null) {
				String sql="SELECT * FROM ITEM WHERE ITEMID=?;";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1,itemid);
				rs=pstmt.executeQuery();
				while(rs.next())
				{
					String ItemID=rs.getString("ITEMID") ;
					String ItemName=rs.getString("ITEMNAME") ;
					String size=rs.getString("SIZE") ;
					int price=rs.getInt("PRICE");
					int deleteflg=rs.getInt("DELETEFLG");
					if(size==null)
					{
						size=" ";
					}
					if(deleteflg==0)
					{
					Item bean = new Item(ItemID,ItemName,size,price);
					list.add(bean);
					}
				}
			}
		}catch(SQLException e)
		{
			throw new Exception("顧客情報検索処理に失敗しました！\n管理者に連絡してください。");
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

