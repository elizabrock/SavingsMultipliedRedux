class CollectionSizeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.count < options[:minimum]
      message = options[:message] || "must select at least #{options[:minimum]}."
      record.errors.add(attribute, message)
    end
  end
end
