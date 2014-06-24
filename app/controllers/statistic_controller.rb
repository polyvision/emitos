class StatisticController < ApplicationController
  before_filter :authenticate_user!

  def index

  end

  def common

    @start_date= Time.now.to_date.to_s
    @end_date= Time.now.to_date.to_s
    if params[:start_date] && params[:end_date]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
    end


    # alle
    @stat_data = Array.new
    CallBox.all.each do |cb|

      # first call
      num_a = CallBoxStatistic.where("call_box_id=? AND num_call=1 AND DATE(created_at) >= ? AND DATE(created_at) <= ?",cb.id,@start_date,@end_date).count
      # second call
      num_b = CallBoxStatistic.where("call_box_id=? AND num_call=2 AND DATE(created_at) >= ? AND DATE(created_at) <= ?",cb.id,@start_date,@end_date).count
      # third call
      num_c = CallBoxStatistic.where("call_box_id=? AND num_call=2 AND DATE(created_at) >= ? AND DATE(created_at) <= ?",cb.id,@start_date,@end_date).count

      t = Hash.new
      t['y'] = cb.name
      t['a'] = num_a
      t['b'] = num_b
      t['c'] = num_c
      @stat_data << t
    end

    respond_to do |format|
      format.html
      format.csv
    end
  end

  def single
    @start_date= Time.now.to_date.to_s
    @end_date= Time.now.to_date.to_s
    if params[:start_date] && params[:end_date]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
    end


    # alle
    @stat_data = Array.new

    params[:callbox] = CallBox.first.id if !params[:callbox]
    @callbox = CallBox.where(:id => params[:callbox]).first

    if @callbox
      cdate = Date.parse(@start_date)
      while(cdate <= Date.parse(@end_date))
        # first call
        num_a = CallBoxStatistic.where("call_box_id=? AND num_call=1 AND DATE(created_at) = ?",@callbox.id,cdate).count
        # second call
        num_b = CallBoxStatistic.where("call_box_id=? AND num_call=2 AND DATE(created_at) = ?",@callbox.id,cdate).count
        # third call
        num_c = CallBoxStatistic.where("call_box_id=? AND num_call=2 AND DATE(created_at) = ?",@callbox.id,cdate).count

        t = Hash.new
        t['y'] = cdate.to_s
        t['a'] = num_a
        t['b'] = num_b
        t['c'] = num_c
        @stat_data << t
        cdate = cdate + 1.day
      end

    end

    respond_to do |format|
      format.html
      format.csv
    end
  end

  def daily
    @start_date= Time.now.to_date.to_s
    @end_date= Time.now.to_date.to_s
    if params[:start_date] && params[:end_date]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
    end

    @callboxes = CallBox.all
    @stat_data = Array.new
    @callboxes.each do |box|

      calls_per_hour = Array.new
      for i in 0..24
        calls_per_hour[i] = 0
      end

      call_count = 1

      CallBoxStatistic.where("call_box_id=? AND num_call=? AND DATE(created_at) >= ? AND DATE(created_at) <= ?",box.id,call_count,@start_date,@end_date).each do |call|
        puts call.created_at.hour
        calls_per_hour[call.created_at.hour] += 1
      end

      # second call
      #num_b = CallBoxStatistic.where("call_box_id=? AND num_call=2 AND DATE(created_at) = ?",@callbox.id,cdate)
      # third call
      #num_c = CallBoxStatistic.where("call_box_id=? AND num_call=2 AND DATE(created_at) = ?",@callbox.id,cdate)

      calls_per_hour.each do |entry|
        t = Hash.new
        t['call_count'] = entry
        t['x'] = box.name
        @stat_data << t
        
      end
    end

  end
end
