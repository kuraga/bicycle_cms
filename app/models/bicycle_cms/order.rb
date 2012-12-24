module BicycleCms
  class OrderItem < Hash
  end

  class Order < ActiveRecord::Base

    col :created_at, as: :timestamp, null: false
    col :name,       as: :string,    null: false
    col :email,      as: :string,    null: false
    col :comment,    as: :text,      null: false, default: ''
    col :data,       as: :text
    store :data, accessors: [ :items ]

    attr_accessible :created_at, :name, :email, :comment, :items, as: [:creator, :admin]
    default_values created_at: -> { DateTime.now }, comment: '', items: {}

    validates :name, presence: true,
               length: { within: 5..50 }
    validates :email, presence: true,
                format: { with: /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }

    def deliver
      OrderMailer.order_message(self).deliver
    end



    def [] product_id
      items[product_id.to_i]
    end

    def add product_or_id, quantity
      product_id = product_or_id.is_a?(Product) ? product_or_id : Product.find(product_or_id).id
      items[product_id] = OrderItem[product_id: product_id, quantity: 0] unless items.has_key? product_id
      items[product_id][:quantity] = items[product_id][:quantity].to_i + quantity.to_i
      items
    end

    def remove product_or_id
      product_id = product_or_id.is_a?(Product) ? product_or_id : Product.find(product_or_id).id
      items.delete product_id
      items
    end

    def product_params product_or_id
      product_id = product_or_id.is_a?(Product) ? product_or_id : Product.find(product_or_id).id
      items.has_key?(product_id) ? items[product_id][:quantity] : 0
    end

    def set_product_param product_or_id, param, value
      product_id = product_or_id.is_a?(Product) ? product_or_id : Product.find(product_or_id).id
      items[product_id].send "#{param}=", value
      items
    end

    def set_product_params product_or_id, params
      product_id = product_or_id.is_a?(Product) ? product_or_id : Product.find(product_or_id).id
      items[product_id].merge! params.symbolize_keys
      items
    end

    def product_quantity product_or_id
      product_id = product_or_id.is_a?(Product) ? product_or_id : Product.find(product_or_id).id
      items.has_key?(product_id) ? items[product_id][:quantity] : 0
    end

    def clean
      items.each do |product_id, product_order_item|
        remove product_id
      end
      items
    end

  end
end
