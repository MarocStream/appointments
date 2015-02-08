module DateParse
  extend ActiveSupport::Concern

  module ClassMethods
    # Rails aparently forces the european format on everyone...
    # Only way I could find to change the date format, all other suggested methods
    # online did not work, theres gotta be a better way...
    # Example format: 2015-02-08T04:30:00.744Z
    def reformat_date field, format = nil
      define_method "#{field}=" do |d|
        if d.blank?
          self[field] = nil
        else
          args = [d]
          args += [format] unless format.nil?
          begin
            self[field] = DateTime.strptime(*args)
          rescue ArgumentError => e
            puts "unable to parse Date.strptime(*#{args.inspect}) => #{e.message}"
            puts "#{e.backtrace.join("\n")}"
            self[field] = Date.parse(d) rescue nil
            puts "parsed? #{self[field]}"
          end
        end
      end
    end
  end

end
