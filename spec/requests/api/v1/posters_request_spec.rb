require 'rails_helper'

describe "Posters API", type: :request do
  it "sends a list of posters" do
    Poster.create(
      name: "DETERMINATION",
      description: "Persistence is the key to failure.",
      price: 99.00,
      year: 2020,
      vintage: false,
      img_url: "https://plus.unsplash.com/premium_photo-1679237489023-4d6b9f7e8292"
    )
    Poster.create(
      name: "AMBITION",
      description: "The climb is always steeper than it looks.",
      price: 120.00,
      year: 2019,
      vintage: true,
      img_url: "https://plus.unsplash.com/premium_photo-1672340957102-ecb87429dbf1"
    )
    Poster.create(
      name: "INSPIRATION",
      description: "Dreams are made to be unattainable.",
      price: 85.00,
      year: 2021,
      vintage: false,
      img_url: "https://plus.unsplash.com/premium_photo-1680273494857-a8bf4c7d10e5"
    )

    get '/api/v1/posters'

    expect(response).to be_successful
  end
end