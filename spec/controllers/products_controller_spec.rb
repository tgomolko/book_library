require 'rails_helper'

RSpec.describe ProductsController do
  let(:admin_user) { create(:admin_user) }
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:product_params) { attributes_for(:product) }

  describe "#index" do
    context "as an authenticated user admin" do
      before do
        sign_in admin_user
        get :index
      end

      it "responds successfully" do
        expect(response).to be_successful
      end

      it "returns a 200 response" do
        expect(response).to have_http_status "200"
      end
    end

    context "as an authenticated user user" do
      before do
        sign_in user
        get :index
      end

      it "redirects to the root path" do
        expect(response).to redirect_to root_path
      end

      it "returns a 302 response" do
        expect(response).to have_http_status "302"
      end
    end

    context "as an unauthenticated user" do
      before do
        get :index
      end

      it "returns a 302 response" do
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#create" do
    before do
      expect(CreateProduct).to receive(:call).and_return(context)
      sign_in admin_user
    end

    context "when successfull" do
      let(:context) { double(:context, success?: true, product: product, message: "hii") }

      it "redirects to product path" do
        post :create, params: { product: product_params }
        expect(response).to redirect_to product_path(context.product)
      end

      it "sets flash notice" do
        expect {
          post :create, params: { product: product_params }
        }.to change {
          flash[:notice]
        }.from(nil).to("Product was successfully created")
      end
    end

    context "when unsuccessful" do
      let(:context) { double(:context, success?: false, message: "message") }

      it "renders new template" do
         post :create, params: { product: product_params }
        expect(response).to render_template :new
      end

      it "sets flash notice" do
        expect {
          post :create, params: { product: product_params }
        }.to change {
          flash[:alert]
        }.from(nil).to("message")
      end
    end
  end

  describe "#show" do
    context "as an authorized user admin" do
      before do
        sign_in admin_user
        get :show, params: { id: product.id }
      end

      it "response successfully" do
        expect(response).to be_successful
      end
    end

    context "as an authorized user user" do
      before do
        sign_in user
        get :show, params: { id: product.id }
      end

      it "redirects to root path" do
        expect(response).to redirect_to root_path
      end
    end

    context "as an unauthorized user" do
      before do
        get :show, params: { id: product.id }
      end

      it "redirects to sing up path" do
        expect(response).to redirect_to new_user_session_path
      end

      it "returns a 302 response" do
        expect(response).to have_http_status "302"
      end
    end
  end
end
