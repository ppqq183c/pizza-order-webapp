package dao;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetImageDBAcess extends ControlDBAccess {

	public byte[] getImage(String itemId)   throws Exception{
	Blob blob_image=null;
	byte[] bytes=null;
		Connection con=createConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			if(con!=null) {
				String sql="SELECT blob_column FROM ITEM WHERE ITEMID=?;";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1,itemId);
				rs=pstmt.executeQuery();
				while(rs.next())
				{
					blob_image=rs.getBlob("blob_column");
				}
				bytes = blob_image.getBytes(1, (int) blob_image.length());
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
return bytes;
	}

}
