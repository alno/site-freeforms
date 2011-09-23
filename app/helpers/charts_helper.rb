module ChartsHelper

  def chart_for( model, units )
    if model.is_a? Proc
      data = (-11..0).map {|v| model.call( Time.now + v.send( units ) ).count }
    else
      data = (-11..0).map {|v| model.where( "#{model.table_name}.created_at < ?", Time.now + v.send( units ) ).count }
    end

    min = data.min - data.min % 50
    max = data.max + 50 - data.max % 50
    avg = (min + max) / 2

    SmartChart::Line.new :width => 400, :height => 200,
      :y_min => min, :y_max => max,
      :data => data,
      :grid => { :x => { :every => 3 }, :y => { :every => (max-min) / 10 }, :style => :dashed },
      :axis => { :left => { :color => 'DDDDDD', :ticks => 'DDDDDD', :labels => { min => min, avg => avg, max => max } } }
  end

  def pie_chart( data )
    SmartChart::Pie.new :width => 400, :height => 200, :rotate => 45, :data => data  # degrees from vertical (start of first slice)
  end

end
