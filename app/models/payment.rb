class Payment < ApplicationRecord

  validates :order_id, numericality: {only_integer: true}, presence: true
  validates :customer_id, numericality: {only_integer: true}, presence: true
  validate  :validate_order_id
  validate  :validate_customer_id

  belongs_to :order
  belongs_to :customer

  def self.search(params = {})
    Payment.joins(:customer, :order).select("payments.*, customers.name as customer_name, orders.note as order_node")
      .where(create_conditions(params)).order({id: :desc})
  end

  # raise system exception
  def validate_order_id
    Order.find(order_id) rescue raise SystemError
  end
  # raise system exception
  def validate_customer_id
    Customer.find(customer_id) rescue raise SystemError
    errors.add(:customer_id, "is wrong.") unless Order.find(order_id).customer_id == customer_id
  end

end
