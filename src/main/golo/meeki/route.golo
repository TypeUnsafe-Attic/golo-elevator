module meeki.route

import spark.Spark

function GET    = |uri, handler| -> spark.Spark.get(route(uri, handler))
function POST   = |uri, handler| -> spark.Spark.post(route(uri, handler))
function PUT    = |uri, handler| -> spark.Spark.put(route(uri, handler))
function DELETE = |uri, handler| -> spark.Spark.delete(route(uri, handler))

local function route = |uri, handler| {
  let conf = map[
    ["extends", "spark.Route"],
    ["implements", map[
      ["handle", |this, request, response| {
        return handler(request, response)
      }]
    ]]
  ]
  let Route = AdapterFabric(): maker(conf): newInstance(uri)
  return Route
}