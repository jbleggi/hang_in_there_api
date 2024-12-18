class Api::V1::PostersController < ApplicationController
  def index
    posters = Poster.all

    render json: posters.map { |poster|
      {
        id: poster.id.to_s,
        type: "poster",
        attributes: {
          name: poster.name,
          description: poster.description,
          price: poster.price,
          year: poster.year,
          vintage: poster.vintage,
          img_url: poster.img_url
        }
      }
    }
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

    # render json: {
    #   type: "poster",
    #   attributes: {
    #     name: newPoster.name,
    #     description: newPoster.description,
    #     price: newPoster.price,
    #     year: newPoster.year,
    #     vintage: newPoster.vintage,
    #     img_url: newPoster.img_url
    #   }
    # }
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

  def destroy
    render json: Poster.delete(params[:id])
    head :no_content
  end

  private
    def poster_params
      params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
    end
end

