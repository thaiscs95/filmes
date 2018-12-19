Rails.application.routes.draw do

    get "/cadastro" => "login#cadastro"

    post "/cadastro" => "login#cadastro"
    root "login#acessar"

    get "/acessar" => "login#acessar"

    post "/acessar" => "login#acessar"
    post "/" => "login#acessar"

    get "/filmes" => "films#listar"
    get "/filmes_votados" => "films#votados"

    post "/filmes" => "films#listar"
    get "/sair" => "login#sair"

    get "/detalhes/:id" => "films#detalhes"
end
