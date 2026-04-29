package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Customer;

public class ValidationCheckDBAccess extends ControlDBAccess{
	public String duplicateConfirmByAccountName(Customer customer) throws Exception {
		Connection con = createConnection();
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String error=null;
		try {
			if(con!=null) {
				String accountName=customer.getAccountName();
				
				String sql="SELECT * FROM CUSTOMER WHERE ACCOUNTNAME = ?;";
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1,accountName);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()==true) {
					error="既に存在しているアカウント名です。";
				}
			}
		} catch (Exception b) {
			throw new Exception("重複確認処理に失敗しました!");
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				throw new Exception("DB接続処理に失敗しました!");
			}
		}
		closeConnection(con);
		return error;
	}
	
	public String duplicateConfirmByAccountName(String accountName) throws Exception {
		Connection con = createConnection();
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String error=null;
		try {
			if(con!=null) {
				
				String sql="SELECT * FROM CUSTOMER WHERE ACCOUNTNAME = ?;";
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1,accountName);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()==true) {
					error="既に存在しているアカウント名です。";
				}
			}
		} catch (Exception b) {
			throw new Exception("重複確認処理に失敗しました!");
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				throw new Exception("DB接続処理に失敗しました!");
			}
		}
		closeConnection(con);
		return error;
	}
	
	public String duplicateConfirmByCustNameKanaTel(Customer customer) throws Exception {
		Connection con = createConnection();
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String error=null;
		try {
			if(con!=null) {
				String custName = customer.getCustName();
				String kana = customer.getKana();
				String tel =customer.getTel();
				
				String sql="SELECT * FROM CUSTOMER WHERE CUSTNAME = ? and KANA = ? and TEL = ?;";
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1,custName);
				pstmt.setString(2, kana);
				pstmt.setString(3, tel);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()==true) {
					error="既に登録されている情報です。";
				}
			}
		} catch (Exception b) {
			System.out.println(2);
			throw new Exception("重複確認処理に失敗しました!");
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				throw new Exception("DB接続処理に失敗しました!");
			}
		}
		closeConnection(con);
		return error;
	}
	public String duplicateConfirmByCustNameKanaTel(String custName, String kana, String tel) throws Exception {
		Connection con = createConnection();
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String error=null;
		try {
			if(con!=null) {
				
				String sql="SELECT * FROM CUSTOMER WHERE CUSTNAME = ? and KANA = ? and TEL = ?;";
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1,custName);
				pstmt.setString(2, kana);
				pstmt.setString(3, tel);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()==true) {
					error="既に登録されている情報です。";
				}
			}
		} catch (Exception b) {
			System.out.println(2);
			throw new Exception("重複確認処理に失敗しました!");
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				throw new Exception("DB接続処理に失敗しました!");
			}
		}
		closeConnection(con);
		return error;
	}
}
