# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
users = User.first_or_create([
  {
    username: 'admin',
    email: 'admin@user.com',
    role: 'admin',
    password: 'password',
    password_confirmation: 'password',
    first_name: 'admin',
    last_name: 'user'
  },
  {
    username: 'cashier',
    email: 'cashier@user.com',
    role: 'cashier',
    password: 'password',
    password_confirmation: 'password',
    first_name: 'cashier',
    last_name: 'user'
  },
  {
    username: 'stockman',
    email: 'stockman@user.com',
    role: 'stockman',
    password: 'password',
    password_confirmation: 'password',
    first_name: 'stock',
    last_name: 'man'
  },
])

categories = ['egm wings', 'dahon plates', 'drinks','rice toppings','pizza',
              'finger food','appetizer','rice','alcohol']
categories.each do |category_name|
  Category.first_or_create(name: category_name)
end

products = [
  { name: 'Buffalo Wings (8pcs)', price: 259, category_name: 'egm wings' },
  { name: 'Garlic Parmesan', price: 259, category_name: 'egm wings'  },
  { name: 'CDO Wings', price: 259, category_name: 'egm wings'  },
  { name: 'Salted Egg', price: 259, category_name: 'egm wings'  },
  { name: 'Barbecue', price: 259, category_name: 'egm wings'  },
  { name: '2pcs old fashion fried chicken', price: 219, category_name: 'dahon plates' },
  { name: '2pcs dahon spicy chicken', price: 249, category_name: 'dahon plates' },
  { name: 'CDO Wings', price: 219, category_name: 'dahon plates' },
  { name: 'Pork Katsu', price: 199, category_name: 'dahon plates' },
  { name: 'Pork Sisig', price: 199, category_name: 'dahon plates' },
  { name: 'Inihaw na Liempo', price: 199, category_name: 'dahon plates' },
  { name: 'Beef Bulgogi', price: 249, category_name: 'dahon plates' },
  { name: 'Baby Back Ribs', price: 449, category_name: 'dahon plates' },
  { name: 'Chicken Inasal(PAA/PECHO w/ Java rice)', price: 249, category_name: 'dahon plates' },
  { name: '2PC Pork BBQ (w/ Java Rice)', price: 209, category_name: 'dahon plates' },
  { name: '3PC Boneless Chicken BBQ', price: 319, category_name: 'dahon plates' },
  { name: 'Coke', price: 80, category_name: 'drinks' },
  { name: 'Sprite', price: 80, category_name: 'drinks' },
  { name: 'Royal', price: 80, category_name: 'drinks' },
  { name: 'Del Monte Juice', price: 80, category_name: 'drinks' },
  { name: 'CALI', price: 80, category_name: 'drinks' },
  { name: 'Bottled Water', price: 80, category_name: 'drinks' },
  { name: 'Grilled Chicken', price: 85, category_name: 'rice toppings' },
  { name: 'Grilled Pork', price: 85, category_name: 'rice toppings' },
  { name: 'Beef Bulgogi (Rice Toppings)', price: 85, category_name: 'rice toppings' },
  { name: 'Spinach', price: 599, category_name: 'pizza' },
  { name: 'Chicken BBQ', price: 599, category_name: 'pizza' },
  { name: 'Seafood', price: 599, category_name: 'pizza' },
  { name: 'Hawaiian', price: 599, category_name: 'pizza' },
  { name: 'Nachos', price: 179, category_name: 'finger food' },
  { name: 'Chili Cheese Fries', price: 179, category_name: 'finger food' },
  { name: 'Potato Wedges', price: 179, category_name: 'finger food' },
  { name: 'Cracklings', price: 49, category_name: 'finger food' },
  { name: 'Peanuts', price: 100, category_name: 'finger food' },
  { name: 'Prawn Crackers', price: 139, category_name: 'finger food' },
  { name: 'Ding Dong Mixed Nuts', price: 49, category_name: 'finger food' },
  { name: 'Martys', price: 49, category_name: 'finger food' },
  { name: 'Sizzling Sisig', price: 269, category_name: 'appetizer'},
  { name: 'Sizzling Squid', price: 560, category_name: 'appetizer'},
  { name: 'Kinilaw', price: 279, category_name: 'appetizer'},
  { name: 'Siniglaw', price: 339, category_name: 'appetizer'},
  { name: 'Calamari', price: 269, category_name: 'appetizer'},
  { name: 'Dahon Fried Isaw', price: 149, category_name: 'appetizer'},
  { name: 'Barbecue Isaw', price: 149, category_name: 'appetizer' },
  { name: 'Crispy Pata', price: 899, category_name: 'appetizer' },
  { name: 'Lechon Kawali', price: 490, category_name: 'appetizer'},
  { name: 'Crispy Kangkong', price: 149, category_name: 'appetizer'},
  { name: 'Chicken Skin', price: 159, category_name: 'appetizer'},
  { name: 'Boneless chicken BBQ (3 PCS)', price: 289, category_name: 'appetizer'},
  { name: 'Rice Platter', price: 120, category_name: 'rice' },
  { name: 'Rice Cup', price: 40, category_name: 'rice'},
  { name: 'Java Rice', price: 69, category_name: 'rice'},
  { name: 'Garlic Rice', price: 69, category_name: 'rice'},
  { name: 'Solera', price: 1200, category_name: 'alcohol'},
  { name: 'Fundador Light(1 Liter)', price: 1000, category_name: 'alcohol'},
  { name: 'Fundador Light(700ml)', price: 800, category_name: 'alcohol'},
  { name: 'Double Light(500ml)', price: 500, category_name: 'alcohol'},
  { name: 'Mojitos Gold', price: 800, category_name: 'alcohol'},
  { name: 'Captain Morgan', price: 1000, category_name: 'alcohol'},
  { name: 'Captain Morgan Set', price: 1200, category_name: 'alcohol'},
  { name: 'Bacardi-Gold', price: 1200, category_name: 'alcohol'},
  { name: 'Bacardi-Set', price: 1400, category_name: 'alcohol'},
  { name: 'Bacardi-Black', price: 1339, category_name: 'alcohol'}

  # Add more products as needed
]
products.each do |product_attrs|
  category = Category.where(name: product_attrs[:category_name]).first
  Product.first_or_create(name: product_attrs[:name], price: product_attrs[:price], category_id: category.id)
end