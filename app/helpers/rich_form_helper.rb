module RichFormHelper
  def rich_form_for(record, options = {}, &block)
    form_for(record, options.merge(builder: RichFormBuilder), &block)
  end
end
