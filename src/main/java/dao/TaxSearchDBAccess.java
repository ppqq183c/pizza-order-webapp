/**
 * クラス名：	TaxSearchDBAccess
 * 概要　　：	消費税検索DAO
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

import model.Tax;

public class TaxSearchDBAccess extends ControlDBAccess{
	
	public Tax searchCurrentTax() throws Exception {
		
		Connection con=createConnection();
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Tax tax = null;
	    try {
			if(con!=null) {
		String sql="SELECT TAXID,RATE,ENDDATE FROM TAX WHERE ENDDATE IS NULL;";
		pstmt=con.prepareStatement(sql);
		rs=pstmt.executeQuery();      
		if (rs.next()) {  
			int taxId=rs.getInt("TAXID");
			 Double rate =rs.getDouble("RATE");
			 String endDate=rs.getString("ENDDATE");
			 Tax ta=new Tax(taxId,rate,endDate);
			 tax=ta;
	           
		}
			}
	    }catch(Exception e) {
	    	throw new Exception("消費税情報検索処理に失敗しました！\n管理者に連絡してください。");
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
		return tax;
	}
}
