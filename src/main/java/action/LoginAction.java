package action;

import dao.LoginDBAccess;
import model.Customer;
import model.OrderControlUtility;

public class LoginAction {
	public Customer execute(String accountName, String password) throws Exception{
		LoginDBAccess dao = new LoginDBAccess();
		//パスワードハッシュ化
		password=OrderControlUtility.toHash(password);
		//ログイン処理
		Customer customer=dao.Login(accountName,password);

		return customer;
	}
}
