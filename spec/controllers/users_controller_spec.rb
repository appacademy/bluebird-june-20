require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "GET #new" do
        it "renders the new user template" do
            get :new #this is the controller verb and action
            expect(response).to render_template(:new) #this :new is the template name
        end
    end

    describe "POST #create" do
        let(:user_params) do
            { # this should match your strong params in UsersControllers
                user: { # user is the key we're nesting out user params under
                    username: "snape",
                    email: "snep@aa.io",
                    age: 100,
                    password: "ilovelily"
                }
            }
        end

        context "with valid params" do
            it "logs in the user" do
                post :create, params: user_params
                user = User.find_by(username: "snape")
                expect(session[:session_token]).to eq(user.session_token)
            end

            it "redirects to user show page" do
                post :create, params: user_params
                user = User.find_by(username: "snape")
                expect(response).to redirect_to(user_url(user))
            end
        end

        context "with invalid params" do
            it "validates the presence of password and renders the new template with errors" do
                post :create, params: {
                    user: {
                        username: "hagrid",
                        email: "hagrid@hogwarts.com",
                        password: "" #use empty string to simulate empty password field
                    }
                }
                expect(response).to render_template(:new)
                expect(flash[:errors]).to be_present 
            end
        end
    end
end