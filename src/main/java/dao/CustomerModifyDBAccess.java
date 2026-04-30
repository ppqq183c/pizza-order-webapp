/**
 * クラス名：	CustomerModifyDBAccess
 * 概要　　：	顧客情報変更DAO
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

import model.Customer;

public class CustomerModifyDBAccess extends ControlDBAccess{

	public int modifyCustomer(Customer customer) throws Exception {
		Connection con=createConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			if (con != null) {
			int custId=customer.getCustId();
			String custName=customer.getCustName();
			String custKana=customer.getKana();
			String custTel=customer.getTel();
			String custAddress=customer.getAddress();
			String sql="UPDATE CUSTOMER SET CUSTNAME = ? ,KANA = ? ,TEL = ? , ADDRESS = ? WHERE CUSTID = ?";
			pstmt=con.prepareStatement(sql);
			
		    
		    pstmt.setString(1,custName);
		    pstmt.setString(2,custKana);
		    pstmt.setString(3,custTel);
		    pstmt.setString(4,custAddress);
		    pstmt.setInt(5,custId);
		 
		    count = pstmt.executeUpdate();
			}
		   
		}catch(NullPointerException a)
		{
			throw new NullPointerException();
		}
		catch(Exception b) {
	    	throw new Exception("顧客情報更新処理に失敗しました！\\n管理者に連絡してください。");
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
		return count;
	}
	
}
