class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :revenue
end
