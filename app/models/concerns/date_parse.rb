module DateParse
  extend ActiveSupport::Concern

  module ClassMethods
    # Rails aparently forces the european format on everyone...
    # Only way I could find to change the date format, all other suggested methods
    # online did not work, theres gotta be a better way...
    def reformat_date field
      define_method "#{field}=" do |d|
        self[field] = Date.strptime(d, "%m/%d/%Y") unless d.blank?
      end
    end
  end

end
