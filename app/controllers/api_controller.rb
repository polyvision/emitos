class ApiController < ApplicationController
  def callbox_activate
    call_box = CallBox.where(:mac => params[:id]).first

    if call_box
      call_box_statistic = CallBoxStatistic.where("call_box_id=? AND state=?", call_box.id, CallBoxStatistic::STATE_ACTIVE).first

      if !call_box_statistic
        call_box_statistic = CallBoxStatistic.new
        call_box_statistic.call_box_id = call_box.id
        call_box_statistic.state = CallBoxStatistic::STATE_ACTIVE
        call_box_statistic.num_call = 1
        call_box_statistic.save

        call_box.notify # ok, and now lets play the sound of the wicked ones ! ;)
      end
    else
      # no call box got found, so lets create it as unknown device
      call_box = CallBox.new
      call_box.mac = params[:id]
      call_box.name = I18n.t('misc.unknown')
      call_box.save
    end

    if call_box
      render :text => 'TRUE'
    else
      render :text => 'FALSE'
    end
  end

  def callbox_deactivate
    call_box = CallBox.where(:mac => params[:id]).first

    if call_box
      call_box_statistic = CallBoxStatistic.where("call_box_id=? AND state=?", call_box.id, CallBoxStatistic::STATE_ACTIVE).first
      if call_box_statistic
        if params[:cbs_type] != nil && params[:cbs_type].to_i > 1
          call_box_statistic.state = params[:cbs_type].to_i
        else
          call_box_statistic.state = CallBoxStatistic::STATE_DEACTIVATED_BY_CUSTOMER
        end
        call_box_statistic.save
      end
    end

    if call_box
      render :text => 'TRUE'
    else
      render :text => 'FALSE'
    end
  end

  def cycle
    CallBox::cycle()
    MarketingCall::cycle()
    render :text => 'done'
  end
end
