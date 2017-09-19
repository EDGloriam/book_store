module CheckOutPagesHelper
  def progress_bar
    content_tag(:ul, class: 'steps list-inline') do
      i = 0
      wizard_steps.collect do |every_step|
        i += 1
        class_str = "step"
        class_str.concat(" active")  if every_step == step
        class_str.concat(" done") if past_step?(every_step)
        concat(
          content_tag(:li, class: class_str) do
            link_to wizard_path(every_step) do
              if class_str.include? 'done'
                content_tag(:span, content_tag(:i, '', class: 'fa fa-check step-icon'), class: 'step-number')
              else
                content_tag(:span, i, class: 'step-number')
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

