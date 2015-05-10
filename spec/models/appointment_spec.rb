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

    it 'cannot conflict with another start date' do
      appointment = create(:appointment)
      new_appointment = build(:appointment, start: '2014-09-28 21:44:36') # 2 mins after
      new_appointment.valid?.should be_false
    end

     it 'cannot conflict with a prep_duration before the start date' do
       appointment = create(:appointment)
       new_appointment = build(:appointment, start: '2014-09-28 21:40:36') # 2 mins before start
       new_appointment.valid?.should be_false
     end

     it 'cannot conflict with a post_duration after the start date' do
       appointment = create(:appointment)
       new_appointment = build(:appointment, start: '2014-09-28 21:53:36') # 11 mins after start
       new_appointment.valid?.should be_false
     end

     it 'cannot conflict the prep_duration with the post_duration of another' do
       appointment = create(:appointment)
       new_appointment = build(:appointment, start: '2014-09-28 21:56:36') # 14 mins after start
       new_appointment.valid?.should be_false
     end

     it 'can conflict if allow_conflicts is on' do
       appointment = create(:appointment)
       new_appointment = build(:appointment, start: '2014-09-28 21:45:36') # 3 mins after start
       new_appointment.allow_conflict!
       new_appointment.valid?.should be_true
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
