package dao;
import java.sql.Connection;
import java.sql.DriverManager;


public class ControlDBAccess {

	protected Connection createConnection() throws Exception {
		Connection con=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection(
					"jdbc:mysql://localhost:65534/KIDDA_LA",
					"user1",
					"pass1");
		}catch(Exception e){
			throw new Exception("DB接続処理に失敗しました!\n管理者に連絡してください");
		}
		return con;
	}

	protected void closeConnection(Connection con) throws Exception{
		try {
			if(con!=null)
			{
				con.close();
			}
		}catch(Exception e) {
			throw new Exception("DB接続処理に失敗しました!\n管理者に連絡してください");
		}
	}

}
