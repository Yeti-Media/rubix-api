require 'spec_helper'

describe "home" do  
  	
  	
   it "displays home" do  
   	visit 'home/index'  
      page.should have_content("Anakin")  
   end    

end

describe "login" do
	
  before do
		@user = FactoryGirl.create(:user)
	end
 	
  context "when a user succesfully sign in" do  
    it "shows welcome message" do 
      user_login(@user)
      #save_and_open_page
    	page.should have_content("Logged in as #{@user.email}")  
      page.should have_content("Signed in successfully.")  
    end  
  end 

  context "when a user fails to sign in" do
  	it "should warn the user" do
  		@user.password = "wrong_pass"
  		user_login(@user)
      #save_and_open_page
    	page.should_not have_content("Logged in as #{@user.email}")
      page.should have_content("Invalid email or password.") 
  	end
  end

end

describe "logout" do

  before do
    @user = FactoryGirl.create(:user)
  end

  context "when a user logout" do
    it "should logout successfully" do
      user_login(@user)
      click_link "Logout"
      #save_and_open_page
      page.should have_content("Signed out successfully.")
    end
  end

end

describe "edit" do

  before do
    @user = FactoryGirl.create(:user)
  end

  context "when a user goes to edit his/her account" do
    it "should enter the form page with the user email already set" do
      user_edit(@user)
      #save_and_open_page
      page.should have_content("Edit User")
      page.should have_field('user_email', with: @user.email)
    end
  end

  context "when a user edit his/her password correctly" do
    it "should go back to home page with an everything went ok alert" do
      user_edit_with_values(@user,
                            { password_new: "newpassword",
                              password_confirmation: "newpassword",
                              password_current: @user.password
                            })
      #save_and_open_page
      page.should have_content("You updated your account successfully.")
      page.should have_content("Logged in as #{@user.email}")
    end
  end

  context "when a user edit his/her account with wrong password confirmation" do
    it "should warn user that new password and password confirmation doesn't match" do
      user_edit_with_values(@user,
                            { password_new: "newpassword",
                              password_confirmation: "newpasswor",
                              password_current: @user.password
                            })
      #save_and_open_page
      page.should_not have_content("You updated your account successfully.")
      page.should have_content("1 error prohibited this user from being saved:")
      page.should have_content("Password confirmation doesn't match Password")
    end
  end

  context "when a user edit his/her account with wrong current password" do
    it "should warn user that current password is wrong" do
      user_edit_with_values(@user,
                            { password_new: "newpassword",
                              password_confirmation: "newpassword",
                              password_current: @user.password < "X"
                            })
      #save_and_open_page
      page.should_not have_content("You updated your account successfully.")
      page.should have_content("1 error prohibited this user from being saved:")
      page.should have_content("Current password is invalid")
    end
  end

  context "when a user edit his/her account with a short (less than 8 characters) new password" do
    it "should warn user that new password is to short" do
      user_edit_with_values(@user,
                            { password_new: "new",
                              password_confirmation: "new",
                              password_current: @user.password
                            })
      #save_and_open_page
      page.should_not have_content("You updated your account successfully.")
      page.should have_content("1 error prohibited this user from being saved:")
      page.should have_content("Password is too short (minimum is 8 characters)")
    end
  end

  context "when a user edit his/her account with wrong current password and wrong confirmation password" do
    it "should warn user that current password is wrong and password confirmation doesn't match new password" do
      user_edit_with_values(@user,
                            { password_new: "newpassword",
                              password_confirmation: "newpasswor",
                              password_current: @user.password < "X"
                            })
      #save_and_open_page
      page.should_not have_content("You updated your account successfully.")
      page.should have_content("2 errors prohibited this user from being saved:")
      page.should have_content("Password confirmation doesn't match Password")
      page.should have_content("Current password is invalid")
    end
  end 

  context "when a user edit his/her account with another users password" do
    it "should warn that the new email is already taken" do
      user2 = FactoryGirl.create(:user)
      user_edit_with_values(@user,
                            { email: user2.email,
                              password_current: @user.password
                            })
      #save_and_open_page
      page.should_not have_content("You updated your account successfully.")
      page.should have_content("1 error prohibited this user from being saved:")
      page.should have_content("Email has already been taken")
    end
  end

  context "when a user edit his/her password correctly" do
    it "should be able to login with the new password" do
      user_edit_with_values(@user,
                            { password_new: "newpassword",
                              password_confirmation: "newpassword",
                              password_current: @user.password
                            })
      #save_and_open_page
      @user.password = "newpassword"
      click_link "Logout"
      user_login(@user)
      page.should have_content("Logged in as #{@user.email}")
    end
  end

  context "when a user edit his/her password correctly" do
    it "he/she shouldn't be able to login with the old password" do
      old_password = @user.password
      user_edit_with_values(@user,
                            { password_new: "newpassword",
                              password_confirmation: "newpassword",
                              password_current: @user.password
                            })
      #save_and_open_page
      @user.password = old_password
      click_link "Logout"
      user_login(@user)
      page.should_not have_content("Logged in as #{@user.email}")
      page.should have_content("Invalid email or password.") 
    end
  end

  context "when a user edit his/her email correctly" do
    it "he/she shouldn't be able to login with the old email" do
      old_email = @user.email
      new_mail = old_email + ".new"
      user_edit_with_values(@user,
                            { email: new_mail,
                              password_current: @user.password
                            })
      #save_and_open_page
      @user.email = old_email
      click_link "Logout"
      user_login(@user)
      page.should_not have_content("Logged in as #{@user.email}")
      page.should have_content("Invalid email or password.") 
    end
  end

end  

describe "delete" do

  before do
    @user = FactoryGirl.create(:user)
  end

  context "when a user deletes his account" do
    it "should receive an account deleted alert", :js => true do
      user_delete(@user, true)
      page.should have_content("Bye! Your account was successfully cancelled. We hope to see you again soon.")
    end
  end


end

describe "reset password" do

  before do
    @user = FactoryGirl.create(:user)
  end

  context "when user correctly resets password" do
    it "should be able to login with the new one", js: true do
      current = page.driver.browser.get_window_handle
      user_forgot_password(@user, {password_new: "newpassword",
                                   password_confirmation: "newpassword"
                                   }, false)
      page.should have_content("Your password was changed successfully. You are now signed in.")
      page.should have_content("Logged in as #{@user.email}")
      @user.password = "newpassword"
      click_link "Logout"
      within_window(current) do
            user_login(@user, true)
            page.should have_content("Logged in as #{@user.email}")
      end
    end
  end

end
