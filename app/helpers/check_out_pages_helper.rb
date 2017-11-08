module CheckOutPagesHelper
  def show(obj, attr)
    obj[attr]
  end

  def delivery_price(object)
    return 0 if object[:delivery_id].nil?
    object.delivery.price
  end

  def credit_short(object)
    content_tag(:p, class: 'general-address') do
      concat("**** **** **** #{object.number[12,4]} ")
      concat(content_tag(:a,'edit', href: wizard_path(:payment), class: 'general-edit edit')) if respond_to? :step
      concat(tag :br)
      concat("#{object.mmyy}")
    end
  end

  def shipment_short(object)
    content_tag(:p, class: 'general-address') do
      concat("#{object.method} ")
      concat(content_tag(:a,'edit', href: wizard_path(:delivery), class: 'general-edit edit')) if respond_to? :step
      concat(tag :br)
      concat("#{object.days}")
    end
  end

  def address_short(object)
    content_tag(:p, class: 'general-address') do
      concat("#{object.first_name} #{object.last_name} ")
      concat(content_tag(:a,'edit', href: wizard_path(:address), class: 'general-edit edit')) if respond_to? :step
      concat(tag :br)
      concat("#{object.address}")
      concat(tag :br)
      concat("#{object.city} #{object.zip}")
      concat(tag :br)
      concat("#{object.country}")
      concat(tag :br)
      concat("Phone #{object.phone}")
    end
  end

  def progress_bar
    content_tag(:ul, class: 'steps list-inline') do
      wizard_steps.collect.with_index do |every_step, index|
        class_str = 'step'
        class_str.concat(' active')  if every_step == step
        class_str.concat(' done') if past_step?(every_step)
        concat(
          content_tag(:li, class: class_str) do
            link_to wizard_path(every_step) do
              if class_str.include? 'done'
                content_tag(:span, content_tag(:i, '', class: 'fa fa-check step-icon'), class: 'step-number')
              else
                content_tag(:span, index + 1, class: 'step-number')
              end +
              content_tag(:span, every_step.to_s.capitalize, class: 'step-text hidden-xs')
            end
          end +
          (content_tag(:li, '', class: 'step-divider') unless every_step == :complete)
        )
      end
    end
  end
end

