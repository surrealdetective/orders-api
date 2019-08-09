# README

## About
Orders API is a backend API that lets you track work orders and assign workers to complete them. You can assign upto 5 workers to complete each work order. For example, you could assign the work order of "Fix pothole" to Cal, Trish, and Sam.

## Setup
### Dependencies overview
This app runs on:
* Ruby 2.6.3
* Rails 5.2.3
* Postgres

### Run app locally
Assuming you have Ruby, Rails, and Postgres installed, do the following to run the app locally:

* Configure database.yml
Adjust the configuration username and password as needed to get the database created on your local system.

* Install and run tests
```
bundle install
rake db:create
rake db:migrate
rake db:test:prepare
rspec
```

* Populate the database and run the server
```
rails s
```

* Test that it works (I use httpie as my http client( https://httpie.org/))

```
# Create Worker
http POST :3000/workers name=Dio company_name=Starship email=dio@starship.com

# Delete Worker
http DELETE :3000/workers/1

# Create Work Order
http POST :3000/work_orders title=Learn description=Elixir deadline=’2030-10-15’

# Delete Work Order
http DELETE :3000/work_orders/1

# Create Work Order, Worker, and Assign Worker to Work Order
http POST :3000/work_orders title=Learn description=Elixir deadline=’2030-10-15’
http POST :3000/workers name=Dio company_name=Starship email=dio@starship.com
http POST :3000/assignments worker_id=2 work_order_id=2

# View work orders by worker
http :3000/work_orders worker_id==2

# Assign another work order to a worker
http POST :3000/work_orders title=Learn description=Javascript deadline=’2020-10-15’
http POST :3000/assignments worker_id=2 work_order_id=3

# View all work orders
http :3000/work_orders

# View work orders by deadline in ascending order
http :3000/work_orders deadline==true

# View all workers
http :3000/workers
```
(For the above, note that when you view work orders by worker, work orders are returned by deadline in ascending order. You can return work orders by id with the following: `http :3000/work_orders worker_id==2 deadline==false`)

* Test the app in production (current as of Aug 8, 2019), on https://aa-orders-api.herokuapp.com, you can use commands similar to above but replace `:3000` with this url, and keep track of the worker_id and work_order_id as needed.

* Note that this app returns results in groups of 20. If there are more than 20 items returned, please use the page attribute to see more responses

```
# Seed Database
rake db:seed

http :3000/work_orders page==1
http :3000/work_orders page==2
```
