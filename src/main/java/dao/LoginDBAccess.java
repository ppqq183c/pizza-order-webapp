package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Customer;

public class LoginDBAccess extends ControlDBAccess {
	public Customer Login(String accountName, String pass) throws Exception {
		Connection con = createConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Customer customer = null;
		try {
			if (con != null) {
				String sql = "SELECT * FROM CUSTOMER WHERE ACCOUNTNAME = ? AND PASSWORD = ?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, accountName);
				pstmt.setString(2, pass);
				rs = pstmt.executeQuery();
				if (rs.next() == true) {
					int custId = rs.getInt("CUSTID");
					accountName = rs.getString("ACCOUNTNAME");
					String password = rs.getString("PASSWORD");
					String custName = rs.getString("CUSTNAME");
					String kana = rs.getString("KANA");
					String tel = rs.getString("TEL");
					String address = rs.getString("ADDRESS");
					String birthday = rs.getString("BIRTHDAY");
					String joinDay = rs.getString("JOINDAY");
					String cancelDay = rs.getString("CANCELDAY");

					customer = new Customer(custId, accountName, custName, password, kana, tel, address, birthday,
							joinDay, cancelDay);
				} else {
					throw new Exception("1");
				}
			}
		} catch (Exception e) {
			if (e.getMessage().equals("1") == true) {
				throw new Exception("アカウント名またはパスワードが間違っています。");
			} else {
				throw new Exception("ログイン処理に失敗しました！");
			}
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				throw new Exception("DB接続処理に失敗しました!\n管理者に連絡してください。");
			}
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				throw new Exception("DB接続処理に失敗しました!\n管理者に連絡してください。");
			}

		}
		closeConnection(con);
		return customer;
	}
}
