module FriendlyId
  def should_not_generate_new_friendly_id_unless_new_record_and_blank_slug!
    define_method :should_generate_new_friendly_id? do
      new_record? and try(friendly_id_config.slug_column).try(:blank?)
    end
  end
end
