module ViewsHelper
  def rb_yne(form_label)
    answers = %w(y n eq)
    tags = html_escape('')
    tags << label_tag(:form_label, I18n.t("guided.form.#{form_label.to_s}"))
    tags << '<br/>'.html_safe
    answers.each { |answer|
      tags <<  radio_button_tag(form_label, answer.to_s);
      tags << I18n.t("guided.form.answers.#{answer}");
      tags << '<p/>'.html_safe;
    }
    tags
  end
end
