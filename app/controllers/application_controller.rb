class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  get '/games' do
    # look up the game in the database using its ID
    games = Game.all.order(:title).limit(10)
    # send a JSON-formatted response of the game data
    games.to_json
  end

  get '/games/:id' do 
    game = Game.find(params[:id])

    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: {only: [:comment, :score], include: {
        user: {only: [:name] }
      } }
    })
  end

end
