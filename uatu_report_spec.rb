require 'uatu_report'

class TestReport
  include UatuReport
  def config
    template        :basic
    collections     :deal_import_state
    timestamps      :imported_at
    mode            :count
  end
end

describe 'Uatu Report' do
  let(:database) {TestReport.new.database}

  after(:each) do
    TestReport.new.database.run("TRUNCATE partner, deal_import_state CASCADE")
  end

  it 'generates report' do
    create_partner_sql = "INSERT INTO partner (name, uuid, external_purchase_name, feed_mime_type, transformer_name, feed_url) VALUES ('restaurant.com', 'a20ac53e-0edc-11e5-8be9-00259069bb8a', 'Restaurant.com', 'application/xml', 'restaurant.com', 'test');"
    database.run(create_partner_sql)

    partner_id = database[:partner].map(:id).first
    create_deal_import_state_sql = "INSERT INTO deal_import_state (partner_id, partner_deal_id, groupon_deal_uuid, imported_at) VALUES (#{partner_id}, 'gse_event_57127', 'da568bad-88df-41f6-aeaa-e1cb9f03f340', '2015-05-31 20:32:37.223+00');"
    database.run(create_deal_import_state_sql)

    results = TestReport.new.run

    expect(results.keys.count).to eq(1)
  end
end
