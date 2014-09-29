require 'spec_helper'

describe AppointmentType do

  context :validations do

    it 'requires a color class' do
      type = build(:appointment_type, color_class: nil)
      type.valid?
      type.errors.keys.should == [:color_class]
    end

  end

  context :defaults do

    it 'defaults prep_duration to zero' do
      type = build(:blank_appointment_type)
      type.prep_duration.should == 0
    end

    it 'defaults post_duration to zero' do
      type = build(:blank_appointment_type)
      type.post_duration.should == 0
    end

  end

end
