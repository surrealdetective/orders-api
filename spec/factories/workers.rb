FactoryBot.define do
  factory :worker do
     name { Faker::Name.name }
     company_name { Faker::Lorem.word }
     email { Faker::Internet.email }

     factory :worker_with_work_orders do
       # workers_count is declared as a transient attribute and available in
       # attributes on the factory, as well as the callback via the evaluator
       transient do
         work_orders_workers_count { 6 }
       end

       # the after(:create) yields two values; the work_order instance itself and the
       # evaluator, which stores all values from the factory, including transient
       # attributes; `create_list`'s second argument is the number of records
       # to create and we make sure the work_order is associated properly to the worker
       after(:create) do |worker, evaluator|
         create_list(:work_orders_worker, evaluator.work_orders_workers_count, worker: worker)
       end
     end
  end
end
