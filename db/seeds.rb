images = ["https://twitterapp.s3.amazonaws.com/uploads/093e0b4e1ee80ded92c0e7f4aaafa917/bg_bar.jpg",
          "https://twitterapp.s3.amazonaws.com/uploads/53e828b0ece70d4c7b92d95fc86778dc/bg_coffee.jpg", 
          "https://twitterapp.s3.amazonaws.com/uploads/7e0066a3d785c1e850c705c32c332109/bg_restaurant.jpg",
          "https://twitterapp.s3.amazonaws.com/uploads/45fc83a72f2d73ed18182ed13601a785/bg_spa.jpg",
          "https://twitterapp.s3.amazonaws.com/uploads/6af67757c8470fd7a6bdeaab34b6c6ca/bg_gym.jpg", 
          "https://twitterapp.s3.amazonaws.com/uploads/3ff9ec47751a371bd4652e29e2a660c1/bg_hotel.jpg"]
          
images.each do |image_url|
  Image.create!(image_url: image_url)
end