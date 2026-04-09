class HelloController < ApplicationController
  def index
    render plain: "Hello, World! Running on Kubernetes 🚀"
  end
end
