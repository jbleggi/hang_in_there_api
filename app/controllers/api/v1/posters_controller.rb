class Api::V1::PostersController < ApplicationController
  def index
    if params[:sort] === 'desc' 
      posters = Poster.all.order("created_at desc")
    elsif params[:sort] === 'asc'
      posters = Poster.all.order("created_at asc")
    else 
      posters = Poster.all
    end

    if params[:name]
      posters_array = [];
      Poster.all.each do |poster|
        if poster.name.downcase().include?(params[:name])
          posters_array.push(poster)
        end
      end
      posters = posters_array.sort_by {|poster| poster.name }
    end

    options = {}
    count = Poster.count
    options[:meta] = { count: count }
    render json: PosterSerializer.new(posters, options)
  end

  def show
    posterById = Poster.find(params[:id])

    render json: {
      type: "poster",
      attributes: {
        name: posterById.name,
        description: posterById.description,
        price: posterById.price,
        year: posterById.year,
        vintage: posterById.vintage,
        img_url: posterById.img_url
      }
    }
  end

  def create
    newPoster = Poster.new(poster_params)

    if newPoster.save
      render json: {
        type: "poster",
        attributes: {
          name: newPoster.name,
          description: newPoster.description,
          price: newPoster.price,
          year: newPoster.year,
          vintage: newPoster.vintage,
          img_url: newPoster.img_url
        }
      }
    end
  end

  def update
    render json: Poster.update(params[:id], poster_params)
  end

  def destroy
    render json: Poster.delete(params[:id])
    head :no_content
  end

  private
    def poster_params
      params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
    end
end

