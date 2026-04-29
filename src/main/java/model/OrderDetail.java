/**
 * クラス名：	OrderDetail
 * 概要　　：	注文明細情報
 * 作成者名：
 * 作成日　：
 * 修正者名：
 * 修正日　：
 */

package model;

public class OrderDetail {

	long no;
	Customer customer = new Customer();
	Item item = new Item();
	String orderDate;
	int quantity;
	Tax tax =new Tax();
	int status;
	
	public OrderDetail() {
		
	}
	public OrderDetail(long no, Customer customer, Item item, String orderDate,
			int quantity, Tax tax, int status) {
		setNo(no);
		setCustomer(customer);
		setItem(item);
		setOrderDate(orderDate);
		setQuantity(quantity);
		setTax(tax);
		setStatus(status);
	}

	public void setNo(long no) {
		this.no=no;
	}
	
	public void setCustomer(Customer customer) {
		this.customer=customer;
	}
	
	public void setItem(Item item) {
		this.item=item;
	}
	
	public void setOrderDate(String orderDate) {
		this.orderDate=orderDate;
	}
	
	public void setQuantity(int quantity) {
		this.quantity=quantity;
	}
	
	public void setTax(Tax tax) {
		this.tax=tax;
	}
	
	public void setStatus(int status) {
		this.status=status;
	}
	
	public long getNo() {
		return no;
	}
	
	public Customer getCustomer() {
		return customer;
	}
	
	public Item getItem() {
		return item;
	}
	
	public String getOrderDate() {
		return orderDate;
	}
	
	public int getQuantity() {
		return quantity;
	}

	public Tax getTax() {
		return tax;
	}

	public int getStatus() {
		return status;
	}
	

}
