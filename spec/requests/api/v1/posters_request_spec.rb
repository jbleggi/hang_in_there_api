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

  it "can create a new poster" do
    poster_params = {
      name: "DETERMINATION",
      description: "Persistence is the key to failure.",
      price: 99.00,
      year: 2020,
      vintage: false,
      img_url: "https://plus.unsplash.com/premium_photo-1679237489023-4d6b9f7e8292"
    }
    
    headers = { "CONTENT_TYPE" => "application/json" }
    # We include this header to make sure that these params are passed as JSON rather than as plain text
    post "/api/v1/posters", headers: headers, params: JSON.generate(poster: poster_params)
    created_poster = Poster.last
  
    expect(response).to be_successful
    expect(created_poster.name).to eq(poster_params[:name])
    expect(created_poster.description).to eq(poster_params[:description])
    expect(created_poster.price).to eq(poster_params[:price])
    expect(created_poster.year).to eq(poster_params[:year])
    expect(created_poster.vintage).to eq(poster_params[:vintage])
    expect(created_poster.img_url).to eq(poster_params[:img_url])
  end

  it "can destroy a poster" do
    poster = Poster.create(
      name: "DETERMINATION",
      description: "Persistence is the key to failure.",
      price: 99.00,
      year: 2020,
      vintage: false,
      img_url: "https://plus.unsplash.com/premium_photo-1679237489023-4d6b9f7e8292"
    ) 
  
    expect(Poster.count).to eq(1)
  
    delete "/api/v1/posters/#{poster.id}"
  
    expect(response).to be_successful
    expect(response).to have_http_status(:no_content) 
    expect(Poster.count).to eq(0)
    expect{ Poster.find(poster.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
