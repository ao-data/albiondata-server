class SleepWorker
    include Sidekiq::Worker
  
    def perform
      sleep 10
    end
  end
  