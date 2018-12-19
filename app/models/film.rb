class Film < ApplicationRecord


    validates :movie_url, presence: {message: "Informe a URL do Filme"}
    validates :movie_url, length: {maximum: 250,  too_long: "A URL não pode ter mais de 250 caracteres"}, if:Proc.new {!self.movie_url.nil?}
    validates :movie_url, uniqueness: {message: "Filme já cadastrado"}, if:Proc.new {!self.movie_url.nil?}
    validates :name, presence: {message: "Informe o nome"}
    validates :year, presence: {message: "Informe o ano"}
    validates :year, length: {maximum: 4,  too_long: "O ano não pode ter mais de 4 digitos"}, if:Proc.new {!self.year.nil?}
    validates :year, numericality: {message: "Ano deve ser numérico"}, if:Proc.new {!self.year.nil?}
    validates :like, numericality: {message: "Like deve ser numérico"}, if:Proc.new {!self.like.nil?}
    validates :dislike, numericality: {message: "Dislike deve ser numérico"}, if:Proc.new {!self.dislike.nil?}
end