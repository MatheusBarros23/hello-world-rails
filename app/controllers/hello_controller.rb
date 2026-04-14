class HelloController < ApplicationController
  def index
    render plain: "Hello, World! Running on Kubernetes 🚀 Via Actions!"
  end
end
