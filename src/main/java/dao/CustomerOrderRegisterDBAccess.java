/**
 * クラス名：	OrderRegisterDBAccess
 * 概要　　：	注文情報登録DAO
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

import model.OrderDetail;

public class CustomerOrderRegisterDBAccess extends ControlDBAccess {
	public void registerOrderByCustomer(ArrayList<OrderDetail> list) throws Exception {//ログインしているとき(Menbership)
		Connection con=createConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		try {
			
			for(OrderDetail orderDetail: list)
			{
				if(con!=null)
				{
						int custId= orderDetail.getCustomer().getCustId();
						
						String itemId= orderDetail.getItem().getItemId();
						int taxId= orderDetail.getTax().getTaxId();
						long no= orderDetail.getNo();
						String date= orderDetail.getOrderDate();
						int quantity= orderDetail.getQuantity();
						int status= orderDetail.getStatus();
						String sql="INSERT INTO ORDERDETAIL VALUES(?,?,null,?,?,?,?,?)";
						pstmt=con.prepareStatement(sql);
						
					    pstmt.setLong(1,no);
					    pstmt.setInt(2,custId);
					    pstmt.setString(3,itemId);
					    pstmt.setString(4,date);
					    pstmt.setInt(5,quantity);
					    pstmt.setInt(6,taxId);
					    pstmt.setInt(7,status);
					    System.out.println(sql);
			      result = pstmt.executeUpdate();
				}
			}
			System.out.println("挿入したレコードの件数:"+result);
			
		}catch(NullPointerException a)
		{
			throw new NullPointerException();
		}
		catch(Exception b) {
	    	throw new Exception("注文登録処理に失敗しました!\n管理者に連絡してください。");
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
	}
	public void registerOrderByGuest(String guestId,ArrayList<OrderDetail> list) throws Exception {//ログインなしで注文するとき(guest)
		Connection con=createConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		try {
			
			for(OrderDetail orderDetail: list)
			{
				if(con!=null)
				{
						String itemId= orderDetail.getItem().getItemId();
						int taxId= orderDetail.getTax().getTaxId();
						long no= orderDetail.getNo();
						String date= orderDetail.getOrderDate();
						int quantity= orderDetail.getQuantity();
						int status= orderDetail.getStatus();
						String sql="INSERT INTO ORDERDETAIL VALUES(?,null,?,?,?,?,?,?)";
						pstmt=con.prepareStatement(sql);
					    pstmt.setLong(1,no);
					    pstmt.setString(2,guestId);
					    pstmt.setString(3,itemId);
					    pstmt.setString(4,date);
					    pstmt.setInt(5,quantity);
					    pstmt.setInt(6,taxId);
					    pstmt.setInt(7,status);
					
			      result = pstmt.executeUpdate();
				}
			}
			System.out.println("挿入したレコードの件数:"+result);
			
		}catch(NullPointerException a)
		{
			throw new NullPointerException();
		}
		catch(Exception b) {
	    	throw new Exception("注文登録処理に失敗しました!\n管理者に連絡してください。");
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
	}
}
