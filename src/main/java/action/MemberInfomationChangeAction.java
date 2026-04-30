package action;

import javax.servlet.http.HttpServletRequest;

import dao.MemberInfomationChangeDBAccess;
import dao.ValidationCheckDBAccess;
import model.Customer;
import model.OrderControlUtility;

public class MemberInfomationChangeAction {
	public String[] execute(String[] memInfo, Customer customer, HttpServletRequest request) throws Exception{
		
		String error = null;

		ValidationCheckDBAccess duplicateConfirmDao = new ValidationCheckDBAccess();
		
		if (memInfo[1].equals(customer.getCustName()) && memInfo[2].equals(customer.getKana())
				&& memInfo[3].equals(customer.getAccountName()) && memInfo[4].equals(customer.getTel()) && memInfo[5].equals(customer.getAddress())) {
			memInfo[0]="会員情報が変更が行われていません。";
		}

		if(!(memInfo[3].equals(customer.getAccountName()))) {
			
			error=duplicateConfirmDao.duplicateConfirmByAccountName(memInfo[3]);
			if(error!=null && memInfo[0]==null) {
				memInfo[0]=error;
			}
			if (OrderControlUtility.NoControlChar(memInfo[3]) == false && memInfo[0]==null) {
				memInfo[0] = "使用できないアカウント名です。";
			}
		}

		if(!(memInfo[1].equals(customer.getCustName())) || !(memInfo[2].equals(customer.getKana())) || !(memInfo[4].equals(customer.getTel()))) {
			if(!memInfo[1].equals(customer.getCustName())) {
				
				if (memInfo[0]==null && (!customer.getCustName().matches(".*[0-9].*") == false || OrderControlUtility.NoControlChar(memInfo[1]) == false)) {
					memInfo[0] = "使用できない顧客名です。";
				}
			}
			if(!(memInfo[2].equals(customer.getKana()))) {
				
				if (memInfo[0]==null && (customer.getKana().matches("^[ァ-ヴー]+$") == false || OrderControlUtility.NoControlChar(memInfo[2]) == false)) {
					memInfo[0] = "全角カナで入力してください。";
				}
			}
			if(!(memInfo[4].equals(customer.getTel()))) {
				
				if (memInfo[0]==null && (customer.getTel().matches(".*[0-9].*") == false || OrderControlUtility.NoControlChar(memInfo[4]) == false)) {
					memInfo[0] = "使用できない電話番号です。";
				}
			}
			
			error=duplicateConfirmDao.duplicateConfirmByCustNameKanaTel(memInfo[1],memInfo[2],memInfo[4]);
			if(error!=null && memInfo[0]==null) {
				memInfo[0]=error;
			}
		}

		if(!(memInfo[5].equals(customer.getAddress()))) {
			
			if (memInfo[0]==null && OrderControlUtility.NoControlChar(memInfo[5]) == false) {
				memInfo[0] = "使用できない住所です。";
			}
		}

		if(memInfo[0]==null) {
			MemberInfomationChangeDBAccess dao = new MemberInfomationChangeDBAccess();
			int custId=customer.getCustId();
			dao.memberInfomationChange(memInfo, custId);
			
			customer.setCustName(memInfo[1]);
			customer.setKana(memInfo[2]);
			customer.setAccountName(memInfo[3]);
			customer.setTel(memInfo[4]);
			customer.setAddress(memInfo[5]);
		}

		return memInfo;
	}
}
