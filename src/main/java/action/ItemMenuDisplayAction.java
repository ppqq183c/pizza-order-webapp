/**
 * クラス名：	ItemMenuDisplayAction
 * 概要　　：	商品情報表示アクション
 * 作成者名：
 * 作成日　：
 * 修正者名：
 * 修正日　：
 */

package action;

import java.util.ArrayList;

import dao.ItemMenuDisplayDBAccess;
import dao.TaxSearchDBAccess;
import model.Item;
import model.OrderControlUtility;
import model.Tax;

public class ItemMenuDisplayAction {

	public String[][] execute()  throws Exception {
		
		ItemMenuDisplayDBAccess imdDao = new ItemMenuDisplayDBAccess();
		ArrayList<Item> list=imdDao.searchAllItem();
		
		TaxSearchDBAccess tsDao = new TaxSearchDBAccess();
		Tax tax = tsDao.searchCurrentTax();
		double taxRate = tax.getRate();
		
		String[][] itemData = OrderControlUtility.itemToArray(list);
		
		for(int i=0; i<itemData.length; i++) {
			String data =itemData[i][4];
			data = Integer.toString((int)(Integer.parseInt(data)*(1+taxRate)));
			StringBuilder buffer = new StringBuilder(data);
			for(int j=data.length()-3;j>0;j=j-3) {
				buffer.insert(j, ",");
			}
			data=buffer.toString();
			itemData[i][4] = data;
		}
		
		return itemData;
	}
}
