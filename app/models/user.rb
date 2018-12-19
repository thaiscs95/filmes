require "digest"

class User < ApplicationRecord

    validates :nome, presence: {message:"Informe o nome"}
    validates :email, presence: {message: "Informe o e-mail"}
    validates :email, uniqueness: {message: "E-mail informado já está em uso"}, if:Proc.new {!self.email.nil?}, on: [:create]
    validates :senha, presence: {message: "Informe a senha"}

    before_create :criptografar
    
    def criptografar
        if !self.senha.nil?
            self.senha = Digest::SHA256.hexdigest self.senha
        end
    end
    
end