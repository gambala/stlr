module ScopedEnumerize
  def scoped_enumerize(field, values = self.const_get(field.to_s.pluralize.upcase))
    extend Enumerize

    enumerize field, in: values, default: values.first, scope: true
  end
end
