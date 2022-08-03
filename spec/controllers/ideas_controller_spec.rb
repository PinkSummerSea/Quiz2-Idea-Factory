require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    describe "#new" do
        context "with signed in user" do
            before do
                session[:user_id] = FactoryBot.create(:user).id
            end

            it "requires a render of a new template" do 
                get(:new)
                expect(response).to(render_template(:new))
            end

            it "requires creation of an instance variable with a new idea" do
                get(:new)
                expect(assigns(:idea)).to(be_a_new(Idea))
            end
        end

        context "without signed in user" do
            it "requires redirection to the log in page" do
                get(:new)
                expect(response).to redirect_to(new_session_path)
            end
        end
    end

    describe "#create" do
        def valid_request
            post(:create, params: {
                idea: FactoryBot.attributes_for(:idea)
            })
        end

        context "with signed in user" do
            before do
                session[:user_id] = FactoryBot.create(:user).id
            end

            context "with valid params" do
                it "requires a new idea record created in the db" do
                    count_before = Idea.count
                    valid_request
                    count_after = Idea.count
                    expect(count_after).to(eq(count_before + 1))
                end

                it "requires redirection to the show page for the new idea" do
                    valid_request
                    idea = Idea.last 
                    expect(response).to(redirect_to(idea_path(idea)))
                end
            end

            context "with invalid params" do
                def invalid_request
                    post(:create, params: {
                        idea: FactoryBot.attributes_for(:idea, title: nil)
                    })
                end

                it "requires the db not save any new record of ideas" do
                    count_before = Idea.count
                    invalid_request
                    count_after = Idea.count
                    expect(count_after).to(eq(count_before))
                end

                it "requires no redirection but rendering of the new page" do 
                    invalid_request
                    expect(response).to(render_template(:new))
                end
            end
        end

        context "without signed in user" do
            it "requires redirection to the log in page" do
                valid_request
                expect(response).to redirect_to(new_session_path)
            end
        end
    end
end
