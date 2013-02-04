module BicycleCms
  class Product < ActiveRecord::Base

    # FIXME
    col :product_type, as: :string,     null: false
    col :product_id,   as: :integer # FIXME :primary_key
    acts_as_superclass subtype: 'product_type'

    attr_accessible :product_type, :product_id, as: :admin

  end
end
