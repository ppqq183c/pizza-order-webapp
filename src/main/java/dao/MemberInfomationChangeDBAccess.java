package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class MemberInfomationChangeDBAccess extends ControlDBAccess{
	
	public void memberInfomationChange(String[] memInfo, int custId) throws Exception{
		Connection con = createConnection();
		PreparedStatement pstmt=null;
		try {
			if(con!=null) {
				String sql= "UPDATE customer SET  CUSTNAME=?, KANA=?, ACCOUNTNAME=?, TEL=?, ADDRESS=? WHERE CUSTID=?;";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1, memInfo[1]);
				pstmt.setString(2, memInfo[2]);
				pstmt.setString(3, memInfo[3]);
				pstmt.setString(4, memInfo[4]);
				pstmt.setString(5, memInfo[5]);
				pstmt.setInt(6, custId);
				pstmt.executeUpdate();
				
			}
		} catch (Exception b) {
			throw new Exception("会員情報変更処理に失敗しました!");
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
	}
}
