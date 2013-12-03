namespace :generator do
  desc "generate random calls"
  task :random_calls => :environment do
    r = Random.new
    call_date =  Time.now.to_date

    if ENV['date']
      call_date = Date.parse(ENV['date'])
    end

    puts "using date: #{call_date}"

    for i in 1..10 do
      CallBox.all.each do |call_box|

        if r.rand(0..1) == 1
          ttime = Time.utc(call_date.year, call_date.month, call_date.day, r.rand(0..23), r.rand(0..59), 0)

          puts "call_box: #{call_box.name} -> #{ttime}"
          call_box_statistic = CallBoxStatistic.new
          call_box_statistic.call_box_id = call_box.id
          call_box_statistic.state = CallBoxStatistic::STATE_DEACTIVATED_BY_CUSTOMER
          call_box_statistic.created_at =ttime
          call_box_statistic.updated_at = ttime
          call_box_statistic.num_call = r.rand(1..3)
          call_box_statistic.save
        end
      end # end of each call_box
    end # end of for
  end
end