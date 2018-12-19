require 'uri'
require 'net/https'
require 'json'
require 'date'
class FilmsController < ApplicationController

    before_action :autenticar

    def listar

        response = curlGet("https://swapi.co/api/films/")

        @films = Array.new
        response["results"].each do |filme| 
            ano = Date.parse filme["release_date"]

            @films << {
                nome: filme["title"],
                episodio: filme["episode_id"],
                diretor: filme["director"],
                ano: ano.year,
                url: filme["url"]
            }
        end

        flash[:error] = nil
        flash[:notice] = nil

        if params[:acao]
            acao = params[:acao]
            nome = params[:nome]
            episodio = params[:episodio]
            diretor = params[:diretor]
            ano = params[:ano]
            url = params[:url]

            filme = Film.find_by(movie_url:url)
            if filme.nil?
                filme = Film.new({
                    movie_url: url,
                    name: nome,
                    episode: episodio,
                    director: diretor,
                    year: ano
                })

                unless filme.valid? && filme.save
                    flash[:error] = filme.errors.full_messages
                else
                    votar(filme, params[:acao])
                end
            else
                votar(filme, params[:acao])
            end
        end

        votos = UserVoto.where(user: $user)
        @votos = Hash.new
        votos.each do |voto|
            filme = Film.find_by(id: voto[:film_id])
            @votos[filme[:movie_url]] = voto[:action]
        end
        render "films/listar"
    end

    def votados
        @filmes = Film.select("*, \"like\" + dislike as votos").all.order("votos desc")

        render "films/votados"
    end

    def detalhes
        filme = params[:id]
        filme = Film.find_by(id: filme)
        if filme.nil?
            flash[:error] = ["Filme não encontrado"]
        else
            flash[:error] = nil
            flash[:notice] = nil
            @personagens = Array.new
            @planetas = Array.new
            @naves = Array.new
            @especies = Array.new
            @veiculos = Array.new
            @detalhes = curlGet(filme[:movie_url])
            
            @detalhes["characters"].each do |url| 
                character = curlGet(url)
                @personagens << character["name"]
            end
            @detalhes["planets"].each do |url| 
                planet = curlGet(url)
                @planetas << planet["name"]
            end
            @detalhes["starships"].each do |url| 
                starship = curlGet(url)
                @naves << starship["name"]
            end
            @detalhes["species"].each do |url| 
                specie = curlGet(url)
                @especies << specie["name"]
            end
            @detalhes["vehicles"].each do |url| 
                vehicle = curlGet(url)
                @veiculos << vehicle["name"]
            end
        end
        
        render "films/detalhes"
    end

    private
    def votar(filme, action)
        ActiveRecord::Base.transaction do
            voto = UserVoto.new({
                film: filme, 
                user: $user,
                action: action
            })
            unless voto.valid? && voto.save
                flash[:error] = voto.errors.full_messages
                ActiveRecord::Rollback
            else
                
                if action == "like" 
                    filme.update_attributes like: filme[:like] +1
                else
                    filme.update_attributes dislike: filme[:dislike] +1
                end 

                if filme.valid? && filme.save
                    flash[:notice] = "Voto realizado com Sucesso!"
                else
                    flash[:error] = filme.errors.full_messages
                    ActiveRecord::Rollback
                end
            end
        end
    end

    def curlGet(url)
        url = URI(url)

        http = Net::HTTP.new(url.host, 443)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)

        response = http.request(request)

        response = JSON.parse response.read_body
    end
end