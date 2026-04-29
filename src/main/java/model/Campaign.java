package model;

public class Campaign {
	int campaignId;
	String campaign_Title;
	String text;
	java.sql.Blob picture;
	public Campaign() {
		
	}
	
	public Campaign(int campaignId, String campaign_Title, String text,java.sql.Blob picture2) {
		setCampaignId(campaignId);
		setCampaign_Title(campaign_Title);
		setText(text);
		setBlob(picture2);
	}
	
	
	public Campaign(int campaignId, String campaign_Title, String text) {
		setCampaignId(campaignId);
		setCampaign_Title(campaign_Title);
		setText(text);
	}
	public void setCampaignId(int campaignId) {
		this.campaignId=campaignId;
	}
	
	public int getCampaignId() {
		return campaignId;
	}
	
	public void setCampaign_Title(String campaign_Title) {
		this.campaign_Title=campaign_Title;
	}
	
	public String getCampaign_Title() {
		return campaign_Title;
	}
    public java.sql.Blob getblob() {
		return picture;
	}
	public void setBlob(java.sql.Blob picture2) {
        this.picture=picture2;
	}
	public void setText(String text) {
		this.text=text;
	}
	
	public String getText() {
		return text;
	}
}


