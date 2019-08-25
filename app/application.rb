class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      searched_item = req.path.split("/items/").last
      if found_item = @@items.find do |indiv_item|
        indiv_item.name == searched_item end
        resp.write found_item.price
      else
        resp.write "Item not found"
        resp.status = 400

      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
