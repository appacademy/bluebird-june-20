require "rails_helper"

# feature is cappy's version of describe
feature "signup" do
    background :each do #same as rspec before each, runs before each scenario block is run
        # debugger
        visit new_user_path # /users/new
        # visit new_user_url # example.com/users/new --> full path
        # both works
    end 

    # scenario is 'it' block equivalent
    scenario "has a user signup page" do
        expect(page).to have_content("Sign Up") #capitalization and spacing matters!!!!
    end

    scenario "takes a username, password, email and age" do
        expect(page).to have_content("Username")
        expect(page).to have_content("Password")
        expect(page).to have_content("Email")
        expect(page).to have_content("Age")
    end

    scenario "redirect to user show page and display username on success" do
        # use fill_in for input tags
        fill_in "Username", with: "dobby"
        fill_in "Email", with: "dobby@adobby.com"
        fill_in "Password", with: "sock4malfoy"
        fill_in "Age", with: 12

        # save_and_open_page 
        # use for debugging
        # opens webpage with snapshot of current state of page aka what cappy is seeing when test is ran

        click_button "signup"
        # save_and_open_page
        expect(page).to have_content("dobby")

        user = User.find_by(username: "dobby")
        expect(current_path).to eq(user_path(user)) 
        # if you used redirect in controller, path whould be /users/:id, so test will pass
        # if you used render instead, path would not have changed, would've been at /users, so test will fail
    end
end