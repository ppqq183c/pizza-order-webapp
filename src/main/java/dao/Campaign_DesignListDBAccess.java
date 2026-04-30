package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Campaign;

public class Campaign_DesignListDBAccess extends ControlDBAccess{

	public ArrayList<Campaign> dao() throws Exception{
		ArrayList<Campaign> list=new ArrayList<Campaign>();
		String sql="SELECT * FROM campaign";
		 try (Connection con = createConnection();
		         PreparedStatement ps = con.prepareStatement(sql)) {
		        try (ResultSet rs = ps.executeQuery()) {
		            while (rs.next()) {
		            	Campaign campaign=new Campaign();
		            	 campaign.setCampaignId(rs.getInt("idcampaign"));
		                campaign.setCampaign_Title(rs.getString("campaign_title"));
		                campaign.setText(rs.getString("campaign_text"));
		                if(campaign.getCampaignId()!=999) {
		                list.add(campaign);
		                }
		            }
		        }
		 }
		return list;
	}
}
