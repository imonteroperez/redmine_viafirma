#####################################################################################
#
# Copyright (C) 2011 Ildefonso Montero Perez
#
# Se permite la libre distribucion y modificacion de este codigo fuente bajo los
# terminos de la licencia GPL siempre que se indique de forma clara
# la autoria de Ildefonso Montero Perez.
#
# Para usos comerciales de este software contacte con ildefonso.montero@gmail.com
#
# This code is free software; you can redistribute it and/or modify it under
# the terms of the GPL GNU General Public License as published by the
# Free Software Foundation; either version 2 of the License, or (at your option)
# any later version. This code is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# See the GNU General Public License for more details.
# For any commercial use of this software contact ildefonso.montero@gmail.com
#
#####################################################################################

require 'dispatcher'
 
module VIAFIRMA
  module AccountControllerPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable
        alias_method_chain :login, :viafirma
      end
    end

    module InstanceMethods
      def login_with_viafirma
        if VIAFIRMA_CONFIG::APP_CONFIG['enabled']
	   if params[:viafirma_user_id] && params[:viafirma_user_info]
 	      @viafirma_user = User.find_by_login params[:viafirma_user_id]
	      @viafirma_user_id = params[:viafirma_user_id]
	      @viafirma_user_info = params[:viafirma_user_info]
              successful_authentication(@viafirma_user)
	   else
	      redirect_to VIAFIRMA_CONFIG::APP_CONFIG['url']
	   end
	else
	  flash[:warning] = "No esta habilitada la autenticacion con viafirma"
        end
	if @viafirma_user_id
	  flash[:notice] = "Datos del certificado: " + @viafirma_user_info
 	end
	return false
      end

    end
  end
end

Dispatcher.to_prepare do
  require_dependency 'account_controller'
  AccountController.send(:include, VIAFIRMA::AccountControllerPatch)
end
