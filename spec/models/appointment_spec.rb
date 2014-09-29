require 'spec_helper'

describe Appointment do

  context :validations do

    it 'requires a user' do
      appointment = build(:appointment, user_id: nil)
      appointment.valid?
      appointment.errors.keys.should == [:user]
    end

    it 'requires an appointment type' do
      appointment = build(:appointment, appointment_type: nil)
      appointment.valid?
      appointment.errors.keys.should == [:appointment_type]
    end

    it 'requires a start date' do
      appointment = build(:appointment, start: nil)
      appointment.valid?
      appointment.errors.keys.should == [:start]
    end

  end

end
