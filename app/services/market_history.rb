class MarketHistoryService
  def process
    export_month
  end

  def export(year, month)
    start_datetime = DateTime.parse("#{year}-#{month}-01 00:00:00")
    end_datetime = start_datetime + 1.months - 1.second

    start_datetime_str = start_datetime.strftime('%Y-%m-%d %H:%M:%S')
    end_datetime_str = end_datetime.strftime('%Y-%m-%d %H:%M:%S')

    export_filename = "#{ENV['MYSQL_EXPORT_PATH']}/market_history_#{start_datetime.strftime('%Y_%m')}.sql"

    cmd = [
      'mysqldump',
      '-h mysql',
      "-u#{ENV['MYSQL_USER']}",
      "-p#{ENV['MYSQL_PWD']}",
      '--compact',
      '--no-create-info',
      '--skip-create-options',
      '--skip-add-drop-table',
      '--skip-add-drop-database',
      "-B #{ENV['MYSQL_DB']}",
      '--tables market_history',
      "--where=\"\\\`timestamp\\\` between '#{start_datetime_str}' and '#{end_datetime_str}'\"",
      "> #{export_filename}"
    ]

    puts "cmd: #{cmd.join(' ')}"
    `#{cmd.join(' ')}`

    cmd = "gzip #{export_filename}"
    puts "cmd: #{cmd}"
    `#{cmd}`
  end

  def delete(year, month)
    start_datetime = DateTime.parse("#{year}-#{month}-01 00:00:00")
    end_datetime = start_datetime + 1.months - 1.second

    start_datetime_str = start_datetime.strftime('%Y-%m-%d %H:%M:%S')
    end_datetime_str = end_datetime.strftime('%Y-%m-%d %H:%M:%S')

    mh = AlbionServer.db.from('market_history')
    ds = mh.where(Sequel.lit("timestamp between ? and ?", start_datetime_str, end_datetime_str))
    ds.delete
  end

  def export_and_delete(year, month)
    export(year, month)
    delete(year, month)
  end
end
