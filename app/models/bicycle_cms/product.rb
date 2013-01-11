module BicycleCms
  class Product < ActiveRecord::Base

    col :product_type, as: :string,     null: false
#    col :product_id,   as: :primary_key

    acts_as_superclass subtype: 'product_type'

  end
end
