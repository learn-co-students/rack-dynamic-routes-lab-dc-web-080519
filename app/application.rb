class Application
    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
####### /items/<ITEM NAME> 
        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            avail = @@items.find{|food| food.name == item_name}
############## user request exists --> item price (string)
            if avail
                resp.write "$#{avail.price}"
############## user request !exist --> status code 400 & "Item not found"
            else
                resp.write "Item not found"
                resp.status = 400
            end
####### all other paths --> 404 "Route not found"
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end