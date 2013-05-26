class ExampleController < ApplicationController
  def index
    expires_in 10.minutes, public: true

    render json: {
      version: '3.2.19'
    }
  end
end
