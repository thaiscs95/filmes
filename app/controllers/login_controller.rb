require "digest"
class LoginController < ApplicationController

    def acessar
        if params[:submit]
            if params[:email].length == 0 || params[:senha].length == 0
                flash[:error] = "Informe o e-mail e senha!"
            else
                @user = User.find_by(email: params[:email])
                if @user.nil?
                    flash[:error] = "Nenhum usuário encontrado"
                else
                    @senha = Digest::SHA256.hexdigest params[:senha]

                    if @user[:senha] == @senha
                        session[:user_id] = @user[:id] 
                        return redirect_to "/filmes"
                    else
                        flash[:error] = "Usuário inválido"
                    end
                end
            end
        else
            flash[:error] = nil
        end
        render "login/acesso"
    end

    def cadastro
        if params[:submit]
            @user = User.new({nome: params[:nome], email: params[:email], senha: params[:senha]})

            if @user.valid? && @user.save
                flash[:error] = nil
                flash[:notice] = "Usuário criado com sucesso!"
                params[:nome] = nil
                params[:email] = nil
            else
                flash[:error] = @user.errors.full_messages
            end
            
        else
            flash[:error] = nil
            flash[:notice] = nil
        end

        render "login/cadastro"        
    end

    def sair
        session.clear
        redirect_to "/acessar"
    end

end