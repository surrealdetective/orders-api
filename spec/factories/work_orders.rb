FactoryBot.define do
  factory :work_order do
     title { Faker::Lorem.word }
     description { Faker::Lorem.word }
     deadline { '2030-10-25' }

     factory :work_order_with_workers do
       # workers_count is declared as a transient attribute and available in
       # attributes on the factory, as well as the callback via the evaluator
       transient do
         work_orders_workers_count { 5 }
       end

       # the after(:create) yields two values; the work_order instance itself and the
       # evaluator, which stores all values from the factory, including transient
       # attributes; `create_list`'s second argument is the number of records
       # to create and we make sure the work_order is associated properly to the worker
       after(:create) do |work_order, evaluator|
         create_list(:work_orders_worker, evaluator.work_orders_workers_count, work_order: work_order)
       end
     end
  end

end
