class MarketHistoryWorker
  include Sidekiq::Worker

  def perform (year, month, delete=false)
    m = MarketHistoryService.new

    if delete == false
      m.export_month(year, month)
    end
  end
end
