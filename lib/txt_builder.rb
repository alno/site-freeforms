require 'iconv'

module ActionView # :nodoc:
  module CompiledTemplates      
    class TxtBuffer
      
      def initialize
        @data = String.new
        @first = true
      end
        
      def << (s)
        @data << "\t" unless @first
        @data << s          
        @first = false
      end
        
      def newline
        @data << 0
        @first = true
      end
        
      def data
        @data
      end
      
    end
  end
  
  module TemplateHandlers
    class TxtBuilder < TemplateHandler
      include Compilable
    
      def self.line_offset
        9
      end
    
      def compile(template)
        <<-EOV
        begin
    
          unless defined?(ActionMailer) && defined?(ActionMailer::Base) && controller.is_a?(ActionMailer::Base)
            controller.response.headers["Content-Type"] ||= 'text/plain'
          end
    
          txt = ::ActionView::CompiledTemplates::TxtBuffer.new
          #{template.source}
          result = txt.data
    
          # Transliterate into the required encoding if necessary
          # TODO: make defaults configurable
          @input_encoding ||= 'UTF-8'
          @output_encoding ||= 'CP1251'
    
          if @input_encoding == @output_encoding
            result
          else
            # TODO: do some checking to make sure iconv works correctly in
            # current environment. See ActiveSupport::Inflector#transliterate
            # definition for details
            #
            # Not using the more standard //IGNORE//TRANLIST because it raises
            # Iconv::IllegalSequence for some inputs
            c = Iconv.new("\#{@output_encoding}//TRANSLIT//IGNORE", @input_encoding)
            c.iconv(result)
          end
    
        rescue Exception => e
          RAILS_DEFAULT_LOGGER.warn("Exception \#{e} \#{e.message} with class \#{e.class.name} thrown when rendering CSV")
          raise e
        end
        EOV
      end
    end
  end
end