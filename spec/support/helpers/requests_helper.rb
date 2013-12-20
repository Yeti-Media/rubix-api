module Helpers

	module Request
		
		def user_login(user, start_with_separator=false)
			if start_with_separator
				visit '/home/index'
			else
				visit 'home/index'
			end
      		click_link "Login" 
      		fill_in "user_email", :with => user.email
      		fill_in "user_password", :with => user.password  
      		click_button "Sign in"
		end

		def user_edit(user, start_with_separator=false)
			user_login(user) if !start_with_separator
			user_login(user, true) if start_with_separator
			click_link "Edit profile"
		end

		def user_edit_with_values(user, values, start_with_separator=false)
			user_edit(user) if !start_with_separator
			user_edit(user, true) if start_with_separator
			fill_in "user_email", :with => values[:email] if values.has_key? :email
      		fill_in "user_current_password", :with => values[:password_current] if values.has_key? :password_current
      		fill_in "user_password", :with => values[:password_new] if values.has_key? :password_new
      		fill_in "user_password_confirmation", :with => values[:password_confirmation] if values.has_key? :password_confirmation
			click_button "Update"
		end

		def user_delete(user, start_with_separator=false)
			user_edit(user) if !start_with_separator
			user_edit(user, true) if start_with_separator
			click_button "Cancel my account"
			page.driver.browser.accept_js_confirms
		end

		def user_forgot_password(user, values, start_with_separator=false)
			if start_with_separator
				visit '/home/index'
			else
				visit 'home/index'
			end
			click_link "Login"
			click_link "Forgot your password?"
			page.fill_in "user_email", :with => user.email
			click_button "Send me reset password instructions"
			within_window(page.driver.browser.get_window_handles.last) do
      			click_link "Change my password"
      			fill_in "user_password", :with => values[:password_new] if values.has_key? :password_new
      			fill_in "user_password_confirmation", :with => values[:password_confirmation] if values.has_key? :password_confirmation
      			click_button "Change my password"
      		end
		end

	end

end