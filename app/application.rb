require './config/environment.rb'
class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      price = Item.all.map{|item| item.price if item.name == item_name}.first || -1
      if price < 0
        resp.status = 400
        resp.write "Item not found"
      elsif price >= 0
        resp.write price
      end
    else
      resp.status = 404
      resp.write "404 Route not found"
    end

    resp.finish
  end
end
