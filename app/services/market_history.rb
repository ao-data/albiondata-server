class MarketHistoryService
  def process
    export_month
  end

  def export_month(year, month)
    start_datetime = DateTime.parse("#{year}-#{month}-01 00:00:00")
    end_datetime = start_datetime + 1.months - 1.second

    start_datetime_str = start_datetime.strftime('%Y-%m-%d %H:%M:%S')
    end_datetime_str = end_datetime.strftime('%Y-%m-%d %H:%M:%S')

    cmd = [
      'mysqldump',
      '-h mysql',
      "-u#{ENV['DB_USER']}",
      "-p#{ENV['DB_PASS']}",
      '--compact',
      '--no-create-info',
      '--skip-create-options',
      '--skip-add-drop-table',
      "-B #{ENV['DB_NAME']}",
      '--tables market_history',
      "--where=\"\\\`timestamp\\\` between '#{start_datetime_str}' and '#{end_datetime_str}'\"",
      "> #{ENV['MYSQL_EXPORT_PATH']}/market_history_#{start_datetime.strftime('%Y_%m')}.sql"
    ]

    puts "cmd: #{cmd.join(' ')}"
    `#{cmd.join(' ')}`
  end
end
