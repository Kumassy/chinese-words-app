json.array!(@users) do |user|
	json.extract! user, :id,:email,:encrypted_password,:reset_password_token,:reset_password_sent_at,:remember_created_at,:sign_in_count,:current_sign_in_at,:last_sign_in_at,:current_sign_in_ip,:last_sign_in_ip,:confirmation_token,:confirmed_at,:confirmation_sent_at,:unconfirmed_email,:created_at,:updated_at,:username,:commitment,:role
end