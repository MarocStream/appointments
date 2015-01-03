module AppointmentTypesHelper

  COLORS = %w(aqua black blue fuchsia gray green lime maroon navy olive orange purple red silver teal white yellow).
          map {|c| {c.titleize => c}}.reduce(&:merge)

  def appointment_type_colors
    COLORS
  end

end
