class StatsController < ApplicationController

  def index
    @users_chart    = count_chart_for User
    @forms_chart    = count_chart_for Form
    @messages_chart = count_chart_for Message
  end
  
  private
  
  def count_chart_for( model )
    SmartChart::Line.new :width => 400, :height => 200, 
      :y_min => 0, :y_max => 1000,
      :data => (-39..0).map {|v| model.where( "#{model.table_name}.created_at < ?", Time.now + v.weeks ).count },
      :grid => { :x => { :every => 5 }, :y => { :every => 100 }, :style => :dashed }
  end

end
