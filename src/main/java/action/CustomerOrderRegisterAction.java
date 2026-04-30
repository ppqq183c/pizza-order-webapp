package action;

import java.util.ArrayList;
import java.util.UUID;

import dao.CustomerOrderRegisterDBAccess;
import dao.GuestOrderConfirmDBAccess;
import dao.GuestRegisterDBAccess;
import dao.OrderConfirmDBAccess;
import dao.TaxSearchDBAccess;
import model.Guest;
import model.OrderDetail;
import model.Tax;

public class CustomerOrderRegisterAction {
	public ArrayList<OrderDetail> execute(ArrayList<OrderDetail> orderDetailList) throws Exception {
		TaxSearchDBAccess dao = new TaxSearchDBAccess();
		Tax tax = dao.searchCurrentTax();

		for (OrderDetail orderDetail : orderDetailList) {
			orderDetail.setTax(tax);
		}
		int intCustId = orderDetailList.get(0).getCustomer().getCustId();

		if (intCustId != 0) {
			CustomerOrderRegisterDBAccess order = new CustomerOrderRegisterDBAccess();
			order.registerOrderByCustomer(orderDetailList);
			
			OrderConfirmDBAccess orderconfirm = new OrderConfirmDBAccess();
			orderDetailList = orderconfirm.searchOrderByCustId(intCustId);
			
		} else {
			//ゲスト情報登録
			String guestId = UUID.randomUUID().toString().replace("-", "");
			GuestRegisterDBAccess guestRegister =new GuestRegisterDBAccess();
			Guest guest = new Guest(guestId,orderDetailList.get(0).getCustomer().getCustName(),orderDetailList.get(0).getCustomer().getKana(),orderDetailList.get(0).getCustomer().getTel(),orderDetailList.get(0).getCustomer().getAddress());
			guestRegister.guestRegister(guest);
			System.out.println(guestId);
			CustomerOrderRegisterDBAccess order = new CustomerOrderRegisterDBAccess();
			order.registerOrderByGuest(guestId,orderDetailList);
			
			GuestOrderConfirmDBAccess orderconfirm = new GuestOrderConfirmDBAccess();
			orderDetailList = orderconfirm.searchOrderByCustId(intCustId);
		}
		return orderDetailList;
	}
}
