/**
 * クラス名：	DeliveryCompleteDBAccess
 * 概要　　：	配達完了DAO
 * 作成者名：
 * 作成日　：
 * 修正者名：
 * 修正日　：
 */

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeliveryCompleteDBAccess extends ControlDBAccess {

	public int completeDeliveryByCustId(int custId) throws Exception {
		Connection con = createConnection();
		PreparedStatement pstmt = null;
		int count=0;
		try {
			String sql = "update orderdetail set status=0 where custid=? and status=1;";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, custId);
			count=pstmt.executeUpdate();
		} catch (Exception b) {
			throw new Exception("配達完了処理に失敗しました!\\n管理者に連絡してください。");
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				throw new Exception("DB接続処理に失敗しました!\n管理者に連絡してください。");
			}
		}
		closeConnection(con);
		return count;
	}
}
