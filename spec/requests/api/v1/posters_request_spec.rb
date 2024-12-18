# bundle exec rspec ./spec/requests/api/v1/posters_request_spec.rb

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

    posters = JSON.parse(response.body, symbolize_names: true)

    expect(posters.count).to eq(3)

    posters.each do |poster|
      expect(poster).to have_key(:id)
      expect(poster[:id]).to be_a(String)

      expect(poster[:attributes]).to have_key(:name)
      expect(poster[:attributes][:name]).to be_a(String)

      expect(poster[:attributes]).to have_key(:description)
      expect(poster[:attributes][:description]).to be_a(String)

      expect(poster[:attributes]).to have_key(:price)
      expect(poster[:attributes][:price]).to be_a(Float)      

      expect(poster[:attributes]).to have_key(:year)
      expect(poster[:attributes][:year]).to be_an(Integer)

      expect(poster[:attributes]).to have_key(:img_url)
      expect(poster[:attributes][:img_url]).to be_a(String)
    end
  end

  it "can get one poster by its id" do
    id = Poster.create(
      name: "DETERMINATION",
      description: "Persistence is the key to failure.",
      price: 99.00,
      year: 2020,
      vintage: false,
      img_url: "https://plus.unsplash.com/premium_photo-1679237489023-4d6b9f7e8292"
    ).id

    get "/api/v1/posters/#{id}"

    poster = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(poster[:attributes]).to have_key(:name)
    expect(poster[:attributes][:name]).to be_a(String)

    expect(poster[:attributes]).to have_key(:description)
    expect(poster[:attributes][:description]).to be_a(String)

    expect(poster[:attributes]).to have_key(:price)
    expect(poster[:attributes][:price]).to be_a(Float)      

    expect(poster[:attributes]).to have_key(:year)
    expect(poster[:attributes][:year]).to be_an(Integer)

    expect(poster[:attributes]).to have_key(:img_url)
    expect(poster[:attributes][:img_url]).to be_a(String)
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

  it "can update an existing poster" do
    id = Poster.create(
      name: "DETERMINATION",
      description: "Persistence is the key to failure.",
      price: 99.00,
      year: 2020,
      vintage: false,
      img_url: "https://plus.unsplash.com/premium_photo-1679237489023-4d6b9f7e8292"
    ).id
    previous_name = Poster.last.name
    poster_params = { name: "PERSEVERENCE" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/posters/#{id}", headers: headers, params: JSON.generate({poster: poster_params})
    poster = Poster.find_by(id: id)

    expect(response).to be_successful
    expect(poster.name).to_not eq(previous_name)
    expect(poster.name).to eq("PERSEVERENCE")
  end
end
