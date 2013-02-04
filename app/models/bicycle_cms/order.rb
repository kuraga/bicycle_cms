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

    attr_accessible :created_at, :name, :email, :comment, :items, as: [:user, :guest, :admin]
    # TODO Небезопасно, так как доступео изменение чужих объектов
    default_values created_at: -> { DateTime.now }, comment: '', items: HashWithIndifferentAccess.new

    belongs_to :author, class_name: 'User'

    validates :name, presence: true,
              length: { within: 5..50 }
    validates :email, presence: true,
              format: { with: /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }

    def deliver
      OrderMailer.order_message(self).deliver
    end

    after_initialize do
      @current_order_id = 1
    end


    delegate *(HashWithIndifferentAccess.instance_methods-Object.instance_methods), to: :items

    def <<(order_item)
      items[@current_order_id] = order_item
      @current_order_id += 1
      self
    end

    def items_of(product_id)
      items.select { |order_item_id,order_item| order_item[:product_id].to_i == product_id }
    end

    def delete_product_inclusions(product_id)
      items.delete_if { |order_item_id, order_item| order_item[:product_id]==product_id }
    end

  end
end
