class ApplicationController < ActionController::Base
    def autenticar
        if session[:user_id].nil?
            flash[:error] = "Acesso não autorizado!"
            render "login/acesso"
        else
           $user = session[:user_id]
           $user = User.find_by(id: $user)
           if $user.nil?
                flash[:error] = "Acesso não autorizado!"
                render "login/acesso"
           end
        end
    end
end
