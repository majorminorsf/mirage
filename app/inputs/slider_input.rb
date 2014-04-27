class SliderInput < SimpleForm::Inputs::StringInput
  def input

    value = object.send(attribute_name) if object.respond_to? attribute_name
    input_html_options[:value] ||= value if value.present?
    input_html_options[:type] = 'text'
    
    input_html_options['data-slider-id'] ||= "task_loadSlider"
    input_html_options['data-slider-min'] ||= 1
    input_html_options['data-slider-max'] ||= 32
    input_html_options['data-slider-step'] ||= 1
    input_html_options['data-slider-value'] ||= value.present? ? value : 4
    
    template.content_tag :div, class: 'slide-wrapper' do
      input = super # leave StringInput do the real rendering

      input
    end
  end
end

#class DatetimePickerInput < SimpleForm::Inputs::StringInput
#  def input
#    value = object.send(attribute_name) if object.respond_to? attribute_name
#    # text_field_options['data-date-format'] = I18n.t('date.datepicker')
#    input_html_options[:value] ||= I18n.localize(value, :format => '%Y/%m/%d %R') if value.present?
#    input_html_classes << "datetimepicker"
#
#    super # leave StringInput do the real rendering
#  end
#end