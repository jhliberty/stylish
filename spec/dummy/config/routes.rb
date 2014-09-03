Rails.application.routes.draw do
  mount Stylish::Developer.server, at: "/stylish"
end
