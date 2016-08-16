require 'pry'

class SongsController < ApplicationController


  get '/songs' do
    erb :'/songs/index'
  end


  get '/songs/new' do
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @message = params[:message]
    #binding.pry
    erb :'/songs/show'
  end

  post '/songs' do
    new_artist = Artist.find_or_create_by(name: params[:artist])
    @new_song = Song.create(params[:song])
    @new_song.artist = new_artist
    @new_song.save
    created_message = "Successfully created song."
    redirect "/songs/#{@new_song.slug}?message=#{created_message}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    #binding.pry
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do
    @edited_song = Song.find_by_slug(params[:slug])
    new_artist = Artist.find_or_create_by(name: params[:artist])
    @edited_song.update(params[:song])
    @edited_song.artist = new_artist
    @edited_song.save
    edited_message = "Successfully updated song."
    redirect "/songs/#{@edited_song.slug}?message=#{edited_message}"
  end
end
