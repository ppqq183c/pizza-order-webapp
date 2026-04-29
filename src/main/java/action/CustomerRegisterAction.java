package action;

import dao.CustomerRegisterDBAccess;
import dao.ValidationCheckDBAccess;
import model.Customer;
import model.OrderControlUtility;

public class CustomerRegisterAction {

	public String[] execute(Customer customer) throws Exception {

		String[] count = { "0", null };
		
		String error = null;

		ValidationCheckDBAccess duplicateConfirmDao = new ValidationCheckDBAccess();
		//アカウント名の既存チェック
		error=duplicateConfirmDao.duplicateConfirmByAccountName(customer);
		if(error!=null) {
			count[1]=error;
		}
		//同一顧客情報の既存チェック
		error=duplicateConfirmDao.duplicateConfirmByCustNameKanaTel(customer);
		if(error!=null && count[1]==null) {
			count[1]=error;
		}

		//アカウント名のバリデーションチェック(制御文字不可)
		if (OrderControlUtility.NoControlChar(customer.getAccountName()) == false && count[1]==null) {
			count[1] = "使用できないアカウント名です。";
		}

		//パスワードのバリデーションチェック(英数字混在,8文字以上,制御文字不可)
		String password = customer.getPassword();
		if (count[1]==null && (password.matches("(?=.*[A-Za-z])(?=.*\\d).*") == false || password.length() < 8
				|| OrderControlUtility.NoControlChar(customer.getPassword()) == false)) {
			count[1] = "使用できないパスワードです。";
		}

		//パスワードハッシュ化
		password = OrderControlUtility.toHash(password);
		customer.setPassword(password);

		//顧客名のバリデーションチェック(数字不可,制御文字不可)
		if (count[1]==null && (!customer.getCustName().matches(".*[0-9].*") == false || OrderControlUtility.NoControlChar(customer.getCustName()) == false)) {
			count[1] = "使用できない顧客名です。";
		}

		//カナのバリデーションチェック(カナのみ,制御文字不可)
		if (count[1]==null && (customer.getKana().matches("^[ァ-ヴー]+$") == false || OrderControlUtility.NoControlChar(customer.getKana()) == false)) {
			count[1] = "全角カナで入力してください。";
		}

		//電話番号のバリデーションチェック(数字のみ,制御文字不可)
		if (count[1]==null && (customer.getTel().matches(".*[0-9].*") == false || OrderControlUtility.NoControlChar(customer.getTel()) == false)) {
			count[1] = "使用できない電話番号です。";
		}

		//住所のバリデーションチェック(制御文字不可)
		if (count[1]==null && OrderControlUtility.NoControlChar(customer.getAddress()) == false) {
			count[1] = "使用できない住所です。";
		}

		if (count[1] == null) {
			customer.setJoinDay(OrderControlUtility.getDate());
			//顧客登録
			CustomerRegisterDBAccess customerRegisterDao = new CustomerRegisterDBAccess();
			count[0] = Integer.toString(customerRegisterDao.customerRegister(customer));
		}
		
		return count;
	}
}
