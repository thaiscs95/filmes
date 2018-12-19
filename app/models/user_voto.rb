class UserVoto < ApplicationRecord
    self.table_name = "uservotos"
    belongs_to :user 
    belongs_to :film

    validates :user, presence: {message: "Usuário inválido"}
    validates :film, presence: {message: "Filme Inválido"}
    validates :action, presence: {message: "Informe a ação"}
    validates :action, inclusion: {in: ["like", "dislike"], message: "Nenhuma ação válida"}, if: Proc.new { !self.action.nil?}

end