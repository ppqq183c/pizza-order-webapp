package action;

import java.util.ArrayList;

import dao.Campaign_DesignListDBAccess;
import model.Campaign;

public class Campaign_DesignAction {
	public static  ArrayList<Campaign> action() throws Exception{
		ArrayList<Campaign> arraylist=new ArrayList<Campaign>();
		Campaign_DesignListDBAccess db= new Campaign_DesignListDBAccess();
		 arraylist=db.dao();
		 System.out.println(arraylist);
		return arraylist;
	}
}
