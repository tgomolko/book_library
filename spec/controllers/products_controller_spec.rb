require 'rails_helper'

RSpec.describe ProductsController do

  describe "#index" do
    context "as an authenticated user admin" do
      before do
        @admin_user = FactoryBot.create(:admin_user)
      end

      it "responds successfully" do
        sign_in @admin_user
        get :index
        expect(response).to be_success
      end

      it "returns a 200 response" do
        sign_in @admin_user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "as an authenticated user user" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "redirects to the root path" do
        sign_in @user
        get :index
        expect(response).to redirect_to root_path
      end

      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end
    end

    context "as an unauthenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#create" do
    context "as an authenticated user admin" do
      before do
        # @admin_user = FactoryBot.create(:admin_user)
        # #product = FactoryBot.create(:product)
        # result = instance_double(Interactor::Context)
        # pr = class_double(Product)
        # binding.pry
        # allow(result).to receive(:success?).and_return true
        # allow(CreateProduct).to receive(:call).and_return result
        # allow(result).to receive(:product).and_return pr

      end

      it "redirects to product path" do
        # sign_in @admin_user

        # post :create, params: { product: { name: "dsds", product_type: "dsre" } }
        # expect(CreateProduct).to have_received(:call)
      end
    end

    describe "#show" do
      context "as an authorized user admin" do
        before do
          @admin_user = FactoryBot.create(:admin_user)
          @product = FactoryBot.create(:product)
        end

        it "response successfully" do
          sign_in @admin_user
          get :show, params: { id: @product.id }
          expect(response).to be_success
        end
      end

      context "as an authorized user user" do
        before do
          @user = FactoryBot.create(:user)
          @product = FactoryBot.create(:product)
        end

        it "redirects to root path" do
          sign_in @user
          get :show, params: { id: @product.id }
          expect(response).to redirect_to root_path
        end
      end

      context "as an unauthorized user" do
        before do
          @product = FactoryBot.create(:product)
        end

        it "redirects to sing up path" do
          get :show, params: { id: @product.id }
          expect(response).to redirect_to new_user_session_path
        end

        it "returns a 302 response" do
          get :show, params: { id: @product.id }
          expect(response).to have_http_status "302"
        end
      end
    end
  end
end
