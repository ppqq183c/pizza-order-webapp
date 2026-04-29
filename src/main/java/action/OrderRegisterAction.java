/**
 * クラス名：	OrderRegisterAction
 * 概要　　：	注文情報登録アクション
 * 作成者名：	大倉
 * 作成日　：	20XX/06/20
 * 修正者名：
 * 修正日　：
 */
package action;
import java.util.ArrayList;

import dao.OrderConfirmDBAccess;
import dao.OrderRegisterDBAccess;
import dao.TaxSearchDBAccess;
import model.OrderDetail;
import model.Tax;
public class OrderRegisterAction {
	
	public ArrayList<OrderDetail> execute(ArrayList<OrderDetail> orderDetailList) throws Exception {
		TaxSearchDBAccess dao = new TaxSearchDBAccess();
		Tax tax=dao.searchCurrentTax();
		
		for(OrderDetail orderDetail:orderDetailList)
		{
		orderDetail.setTax(tax);
		}
		OrderRegisterDBAccess order=new OrderRegisterDBAccess();
		order.registerOrder(orderDetailList);
		int intCustId=orderDetailList.get(0).getCustomer().getCustId();
		
		OrderConfirmDBAccess orderconfirm=new OrderConfirmDBAccess();
		orderDetailList=orderconfirm.searchOrderByCustId(intCustId);
		return orderDetailList;
	}
}
