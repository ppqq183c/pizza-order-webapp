package action;

import java.util.ArrayList;

import dao.SearchAllMenuDBAccess;
import model.Item;
public class SearchAllMenuAction {

	public static  ArrayList<Item> menu(String ID,String name) throws Exception{
		
		if (ID != null) ID = ID.replace(" ", "").replace("　", "");;
		if (name != null) name =name.replace(" ", "").replace("　", "");;	
		SearchAllMenuDBAccess db= new SearchAllMenuDBAccess();
		ArrayList<Item> arraylist=new ArrayList<Item>();
	        if (ID != null && !ID.isEmpty() && (name == null || name.isEmpty())) {
	        	
	        	arraylist=db.searchItemByItemid(ID);
	        }
	        else if ((ID == null || ID.isEmpty()) && name != null && !name.isEmpty()) {
	        	arraylist=db.searchItemByName(name);
	        }
	        else if (ID != null && !ID.isEmpty() && name != null && !name.isEmpty()) {
	        	arraylist=db.searchItem(ID, name);
	        }
	        else {
	     arraylist=db.searchAllItem();
	        }
return arraylist;
	}
	
	public static  ArrayList<Item> menu() throws Exception{
		ArrayList<Item> arraylist=new ArrayList<Item>();
		SearchAllMenuDBAccess db= new SearchAllMenuDBAccess();
		 arraylist=db.searchAllItem();
		return arraylist;
	}
	}
