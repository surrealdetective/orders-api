FactoryBot.define do
  factory :work_orders_worker do
     association :work_order
     association :worker
  end
end
