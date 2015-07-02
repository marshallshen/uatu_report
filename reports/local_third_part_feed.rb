require 'daily_report'

class LocalThirdPartyFeedReport
  include UatuReport

  def config
    template        :basic
    collections     :deal_import_state, :product_import_state   # db tables to inspect on
    items           :created                                    # created_at, deleted_at, updated_at timestamp
    interval        :daily                                      # how often does it run
    mode            :count
  end
end

