require 'sinatra'
require 'mongoid'
require 'sinatra/namespace'

Mongoid.configure do |config|
    config.clients.default = {
        database: 'booklist_dev',
      hosts: ['localhost:27017'],
    }
end

# Mongoid.load!("Users/jack.sutton/booklist/mogoid.yml")
class Book 
    include Mongoid::Document

    field :title, type: String
    field :author, type: String
    field :isbn, type: String

    validates :title, presence: true
    validates :author, presence: true
    validates :isbn, presence: true

    index({ title: 'text' })
    index({ isbn:1 }, { unique: true, name: "isbn_index" })

    
end


get '/' do
    'Welcome to BookList!'
end

namespace '/api/v1' do

    before do
        content_type 'application/json'
    end 

    get '/books' do
        Book.all.to_json
    end
end
    
