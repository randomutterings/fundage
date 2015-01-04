module WrappedButton
  def wrapped_button(*args, &block)
    template.content_tag :div, class: "form-actions" do
      submit(*args, &block)
    end
  end
end
SimpleForm::FormBuilder.send :include, WrappedButton
