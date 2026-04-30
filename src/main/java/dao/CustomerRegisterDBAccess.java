package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.Customer;

public class CustomerRegisterDBAccess extends ControlDBAccess {
	public int customerRegister(Customer customer) throws Exception {
		Connection con = createConnection();
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			if(con!=null) {
				String custName=customer.getCustName();
				String accountName=customer.getAccountName();
				String password=customer.getPassword();
				String kana=customer.getKana();
				String tel=customer.getTel();
				String address=customer.getAddress();
				String birthDay=customer.getBirthDay();
				String joinDay=customer.getJoinDay();

				String sql="INSERT INTO CUSTOMER(CUSTNAME, ACCOUNTNAME, PASSWORD, KANA, TEL, ADDRESS, BIRTHDAY, JOINDAY, CANCELDAY) VALUES(?,?,?,?,?,?,?,?,null);";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1,custName);
				pstmt.setString(2,accountName);
				pstmt.setString(3,password);
				pstmt.setString(4,kana);
				pstmt.setString(5,tel);
				pstmt.setString(6,address);
				pstmt.setString(7,birthDay);
				pstmt.setString(8,joinDay);
				
				count=pstmt.executeUpdate();
				
			}
		} catch (NullPointerException a) {
			throw new NullPointerException();
		} catch (Exception b) {
			throw new Exception("顧客情報登録処理に失敗しました!");
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
		return count;

	}

}
