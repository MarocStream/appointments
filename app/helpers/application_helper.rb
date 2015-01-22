module ApplicationHelper
  def resource_name
   :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def alert_class_for flash_type
    case flash_type
      when 'success'
        "alert-success"
      when 'error'
        "alert-danger"
      when 'alert'
        "alert-warning"
      when 'notice'
        "alert-info"
      else
        flash_type.to_s
    end
  end

  [:link, :button].each do |kind|
    define_method "#{kind}_to_add_fields" do |name, f, association, opts = {}, &block|
      opts, association, f, name = association, f, name, block if block_given? || block.is_a?(Proc)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
        render(opts.delete(:partial) || "#{association.to_s.singularize}_fields", :f => builder)
      end
      if block_given? || block.is_a?(Proc)
        send "#{kind}_to", "javascript:void(0);", {onclick: h("add_fields(#{opts.delete(:selector) || 'this'}, \"#{association}\", \"#{escape_javascript(fields)}\", #{opts.delete(:wrap).try(:inspect) || 'null'})")}.merge(opts), &block
      else
        send "#{kind}_to", name, "javascript:void(0);", {onclick: h("add_fields(#{opts.delete(:selector) || 'this'}, \"#{association}\", \"#{escape_javascript(fields)}\", #{opts.delete(:wrap).try(:inspect) || 'null'})")}.merge(opts)
      end
    end

    define_method "#{kind}_to_destroy_fields" do |name, f, opts = {}, &block|
      opts, f, name = f, name, block if block_given? || block.is_a?(Proc)
      link = if block_given? || block.is_a?(Proc)
        send "#{kind}_to", "javascript:void(0);", {onclick: h("destroy_fields(#{opts.delete(:selector) || 'this'})")}.merge(opts), &block
      else
        send "#{kind}_to", name, "javascript:void(0);", {onclick: h("destroy_fields(#{opts.delete(:selector) || 'this'})")}.merge(opts)
      end
      link + f.hidden_field(:_destroy)
    end
  end

end
