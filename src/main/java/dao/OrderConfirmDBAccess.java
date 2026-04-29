/**

* クラス名：	OrderConfirmDBAccess

* 概要　　：	注文情報確認DAO

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
import java.util.ArrayList;

import model.Customer;
import model.Item;
import model.OrderDetail;
import model.Tax;
 
public class OrderConfirmDBAccess extends ControlDBAccess {
 
	public ArrayList<OrderDetail> searchOrderByCustId(int custId) throws Exception {
 
		Connection con = createConnection();

		PreparedStatement pstmt = null;

		ResultSet rs = null;

		Customer customer = null;

		ArrayList<OrderDetail> list = new ArrayList<OrderDetail>();

		try {

			if (con != null) {

				PreparedStatement customerpstmt = null;

				ResultSet customerrs = null;

				String sql2 = "SELECT *  FROM CUSTOMER WHERE CUSTID=?";

				customerpstmt = con.prepareStatement(sql2);

				customerpstmt.setInt(1, custId);

				customerrs = customerpstmt.executeQuery();

				if (customerrs.next() == true) {

					custId=customerrs.getInt("CUSTID") ;

					String accountName=customerrs.getString("ACCOUNTNAME");

					String password=customerrs.getString("PASSWORD");

					String custName=customerrs.getString("CUSTNAME");

					String kana=customerrs.getString("KANA");

					String tel=customerrs.getString("TEL") ;

					String address=customerrs.getString("ADDRESS");

					String birthday=customerrs.getString("BIRTHDAY");

					String joinDay=customerrs.getString("JOINDAY");

					String cancelDay=customerrs.getString("CANCELDAY");

					customer = new Customer(custId, accountName,password,custName, kana, tel, address,birthday,joinDay,cancelDay);

				}

			}
 
			if (con != null) {

				String sql = "SELECT NO,ITEMID,ORDERDATE,QUANTITY,TAXID,STATUS FROM ORDERDETAIL WHERE CUSTID=? and STATUS=1";

				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, custId);

				rs = pstmt.executeQuery();

				while (rs.next() == true) {

					int no = rs.getInt("NO");

				String itemid = rs.getString("ITEMID");

					Item item = null;

					Tax tax = null;

					if (con != null) {

						PreparedStatement itempstmt = null;

						ResultSet itemrs = null;

						String itemsql = "SELECT ITEMID,ITEMNAME,SIZE,PRICE  FROM ITEM WHERE ITEMID=?";

						itempstmt = con.prepareStatement(itemsql);

						itempstmt.setString(1, itemid);

						itemrs = itempstmt.executeQuery();

						if (itemrs.next() == true) {

							String itemId = itemrs.getString("ITEMID");

							String itemName = itemrs.getString("ITEMNAME");

							String size = itemrs.getString("SIZE");

							int price = itemrs.getInt("PRICE");
 
							Item itemId2 = new Item(itemId, itemName, size, price);

							item = itemId2;

						}

					}
 
					String orderdate = rs.getString("ORDERDATE");

					int quantity = rs.getInt("QUANTITY");

					int taxid = rs.getInt("TAXID");
 
					if (con != null) {

						PreparedStatement taxpstmt = null;

						ResultSet taxrs = null;

						String taxsql = "SELECT TAXID,RATE,ENDDATE  FROM tax WHERE TAXID=?";

						taxpstmt = con.prepareStatement(taxsql);

						taxpstmt.setInt(1, taxid);

						taxrs = taxpstmt.executeQuery();

						if (taxrs.next() == true) {

							int taxId = taxrs.getInt("TAXID");

							Double rate = taxrs.getDouble("RATE");

							String endDate = taxrs.getString("ENDDATE");
 
							Tax tax2 = new Tax(taxId, rate, endDate);

							tax = tax2;

						}

					}
 
					int status = rs.getInt("STATUS");

					OrderDetail orderdetail = new OrderDetail(no, customer, item, orderdate, quantity, tax, status);

					list.add(orderdetail);
 
				}

			}

		} catch (Exception e) {

			throw new Exception("配達情報検索処理に失敗しました！管理者に連絡してください。");

		} finally {

			try {

				if (rs != null) {

					rs.close();

				}

			} catch (SQLException e) {

				throw new Exception("DB接続処理に失敗しました!管理者に連絡してください。");

			}

			try {

				if (pstmt != null) {

					pstmt.close();

				}

			} catch (SQLException e) {

				throw new Exception("DB接続処理に失敗しました!管理者に連絡してください。");

			}

		}

		closeConnection(con);

		return list;

	}

}

 