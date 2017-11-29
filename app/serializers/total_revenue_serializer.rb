class TotalRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    '%.2f' % (object.to_f / 100)
  end
end
