/**
 * クラス名：	Item
 * 概要　　：	商品情報
 * 作成者名：	
 * 作成日　：	
 * 修正者名：
 * 修正日　：
 */

package model;

public class Item {
	String itemId;
	String itemName;
	String size;
	int price;
	java.sql.Blob picture;
	public Item() {
		
	}
	
	public Item(String itemId, String itemName, String size, int price,java.sql.Blob picture2) {
		setItemId(itemId);
		setItemName(itemName);
		setSize(size);
		setPrice(price);
		setBlob(picture2);
	}
	
	
	public Item(String itemId, String itemName, String size, int price) {
		setItemId(itemId);
		setItemName(itemName);
		setSize(size);
		setPrice(price);
	}
	public void setItemId(String itemId) {
		this.itemId=itemId;
	}
	
	public String getItemId() {
		return itemId;
	}
	
	public void setItemName(String itemName) {
		this.itemName=itemName;
	}
	public java.sql.Blob getblob() {
		return picture;
	}
	public void setBlob(java.sql.Blob picture2) {
        this.picture=picture2;
	}
	public String getItemName() {
		return itemName;
	}

	public void setSize(String size) {
		this.size=size;
	}
	
	public String getSize() {
		return size;
	}

	public void setPrice(int price) {
		this.price=price;
	}
	
	public int getPrice() {
		return price;
	}
	
	


}

