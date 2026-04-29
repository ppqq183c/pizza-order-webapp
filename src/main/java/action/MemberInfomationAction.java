package action;

import model.Customer;

public class MemberInfomationAction {
	public String[] execute(Customer customer) throws Exception{
		//一つ目のnullは会員情報変更の時のバリデーションチェックに使う。
		String[] memInfo= {null,customer.getCustName(),customer.getKana(),customer.getAccountName(),customer.getTel(),customer.getAddress()};
		return memInfo;
	}
}
