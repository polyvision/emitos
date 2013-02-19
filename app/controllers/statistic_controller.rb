class StatisticController < ApplicationController

  def index

    @start_date= Time.now.to_date.to_s
    @end_date= Time.now.to_date.to_s
    if params[:start_date] && params[:end_date]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
    end


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
end
