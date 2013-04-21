class AddCampaignIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :campaign_id, :string
    add_column :messages, :msisdn, :string
    add_column :messages, :carrier, :string
    add_column :messages, :message, :text
    add_column :messages, :image_url, :string
  end
end
