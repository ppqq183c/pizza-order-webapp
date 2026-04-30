package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.Guest;

public class GuestRegisterDBAccess extends ControlDBAccess {
	public int guestRegister(Guest guest) throws Exception {
		Connection con = createConnection();
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			if(con!=null) {
				String guestId=guest.getGuestId();
				String guestName=guest.getGuestName();
				String kana=guest.getKana();
				String tel=guest.getTel();
				String address=guest.getAddress();

				String sql="INSERT INTO GUEST(GUESTID,GUESTNAME, KANA, TEL, ADDRESS) VALUES(?,?,?,?,?);";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, guestId);
				pstmt.setString(2,guestName);
				pstmt.setString(3,kana);
				pstmt.setString(4,tel);
				pstmt.setString(5,address);
				System.out.println(guestId);
				count=pstmt.executeUpdate();
				
			}
		} catch (NullPointerException a) {
			throw new NullPointerException();
		} catch (Exception b) {
			throw new Exception("ゲスト情報登録処理に失敗しました!");
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
