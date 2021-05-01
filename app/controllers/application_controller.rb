class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource_or_scope)
    # resource_or_scope.is_a? => deviseのモデルが複数ある場合に使用
    if resource_or_scope.is_a?(AdminUser)
        root_path
    else
        customer_path(current_customer)
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    return new_admin_user_session_path if resource_or_scope == :admin_user
    root_path
  end

end
