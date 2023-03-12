class MarketHistoryWorker
  include Sidekiq::Worker

  def perform (year, month, delete=false)
    m = MarketHistoryService.new
    m.export_and_delete(year, month)
  end
end
