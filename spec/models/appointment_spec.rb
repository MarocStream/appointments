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

  context :scopes do

    describe '#for_user' do

      before :each do
        @appointment = create(:appointment)
      end

      it 'passed in nil' do
        expect { Appointment.for_user(nil).find(@appointment.id) }.to raise_error
      end

      it 'passed in a patient who owns the appointment' do
        Appointment.for_user(@appointment.user).find(@appointment.id).should_not be_nil
      end

      it 'passed in a patient who doesnt own the appointment' do
        expect { Appointment.for_user(create(:user)).find(@appointment.id) }.to raise_error
      end

      it 'passed in an admin' do
        Appointment.for_user(create(:admin)).find(@appointment.id).should_not be_nil
      end

    end

  end

end
