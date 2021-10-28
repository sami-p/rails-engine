class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices

  def self.by_page(page = 1, per_page = 20)
    page = 1 if page < 1
    per_page = 20 if per_page < 1
    limit(per_page).offset((page -1) * per_page)
  end

  def self.search_by_name(name)
    where("name ILIKE ?", "%#{name}%").order("name")
  end

  def self.top_merchants_by_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .select('merchants.*,
             SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .where("transactions.result = 'success'")
    .group(:id)
    .order(revenue: :desc)
    .order('name')
    .limit(quantity)
  end
end
