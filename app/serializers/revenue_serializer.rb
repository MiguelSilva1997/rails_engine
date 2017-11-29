class RevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    '%.2f' % (object.to_f / 100)
  end
end
