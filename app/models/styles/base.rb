class Styles::Base

  def self.attr_with_default( attr, default )
    src = <<-END_SRC
      def #{attr}
        @#{attr} || '#{default}'
      end

      def #{attr}=(v)
        @#{attr} = v
      end
    END_SRC

    class_eval src, __FILE__, __LINE__
  end

  def initialize( atts = {} )
    atts.each do |k,v|
      self.send "#{k}=".to_sym, v if v && v != '' && v != self.send( k )
    end
  end

end