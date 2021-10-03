# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@test.com',
  password: 'adminpass'
  )
  
Genre.create!(
  [
    {
      name: '焼き菓子'
    },
    {
      name: 'ケーキ'
    },
    {
      name: 'プリン'
    },
    {
      name: 'キャンディ'
    }
    ]
  )
  
Item.create!(
          genre_id: '1',
          image: File.open('./app/assets/images/eclair-3366430_1920.jpg'),
    			name: "エクレア",
    			description: "エクレアです",
    			price_without_tax: 150,
    			is_sale: true
      )
      
Item.create!(
          genre_id: '2',
          image: File.open('./app/assets/images/muffin-1390368_1920 (1).jpg'),
    			name: "りんごのマフィン",
    			description: "りんごのマフィンです。",
    			price_without_tax: 230,
    			is_sale: true
      )
      
Item.create!(
          genre_id: '3',
          image: File.open('./app/assets/images/caramel-1958358_1920.jpg'),
    			name: "生乳プリン",
    			description: "新鮮生乳プリンです。",
    			price_without_tax: 200,
    			is_sale: true
      )
      
Item.create!(
          genre_id: '2',
          image: File.open('./app/assets/images/cake-219595_1920 (1).jpg'),
    			name: "いちごのロールケーキ",
    			description: "いちごロールケーキです。",
    			price_without_tax: 300,
    			is_sale: true
      )