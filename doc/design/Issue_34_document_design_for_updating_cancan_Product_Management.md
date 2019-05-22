## Issue-34-document-design: Compose document design for Product Management

### Update cancan for Product Management

We need to use cancan as a new feature that set the rule for each type of users in Product Management.

What we need
  - Create an ability to set the role for each type of users.
  - Put ability into controls to apply the rule for functions.
  - Put ability into views to apply what user can see.
  - Expect any candidate be able to launch an Public Assessment.

# Models

### Create a file with name: ability.rb in app/models/ability.rb
```ruby
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user_signed_in?
      user_permissions
    else
      cannot :manage, :all
    end
  end

  private
    def user_restaurant_permissions
      can [:create, :read, :update, :destroy], Product
    end

    def user_customer_permissions
      can :read, Product
    end

    def user_permissions
      if user.admin?
        can :manage, :all
      elsif user.restaurant?
        user_restaurant_permissions
      else user.customer?
        user_customer_permissions
      end
    end
end
```

# Controllers

### Update file app/controllers/products_controller.rb
```ruby
  class ProductsController < ApplicationController
    load_and_authorize_resource
    before_action :find_product, only: [:show, :edit, :update, :destroy]

    def index
      respond_to do |format|
        format.html { display_products }
        format.csv { export_products }
      end
    end

    def display_products
      @products = Product.order(created_at: :desc)
    end

    def export_products
      send_data(
        Products::ExportCsv.new(display_products).perform,
        type: 'text/csv',
        filename: 'products.csv',
        disposition: 'attachment'
        )
    end

    def new
      @product = Product.new
    end

    def show;end

    def edit;end

    def create
      @product = Product.new(product_params.merge(user_id: current_user.id))
      redirect_to @product if @product.save
    end

    def update
      if @product.update(product_params)
        redirect_to product_path(@product)
      else
        render 'edit'
      end
    end

    def destroy
      redirect_to products_path if @product.destroy
    end

    private
      def product_params
        params.require(:product).permit(:name, :description, :price, :enabled, :quatity, :user_id, :category_id)
      end

      def find_product
        @product ||= Product.find(params[:id])
      end
  end
```

# View 
  - update cancan for **views/products/index.html.haml**
  - update cancan for **views/products/_table.html.haml**
  - update cancan for **views/product/show.html.haml**

### Update **views/products/index.html.haml**
```ruby
  %h2 List of Products
.text-right
  if can? :create, Product
    = link_to 'New Product', new_product_path, class: 'btn btn-primary'
  = link_to 'Import', product_imports_path, class: 'btn btn-info'
  = link_to 'Export', products_path(format: :csv), class: 'btn btn-info'
%hr
.panel.panel-default
  = render partial: 'table'
```

### Update **views/products/_table.html.haml**
```ruby
  %table.table.table-responsive.table-striped
    %tr
      %th Category
      %th Name
      %th Description
      %th Price
      %th Quatity
      %th Enabled
      %th
    - @products.each do |product|
      %tr
        %td= product.category&.name
        %td= product.name
        %td= product.description
        %td= product.price
        %td= product.quatity
        %td= display_status(product.enabled)
        %td.text-right
          - if can? :update, Product
            = link_to 'Edit', edit_product_path(product), class: 'btn btn-primary'
          - if can? :read, Product
            = link_to 'Show', product_path(product), class: 'btn btn-info'
          - if can? :destroy, Product
            = link_to 'Destroy', product_path(product), method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-danger'
```

### Update **views/products/index.html.haml**
```ruby
  .col-md-8
    .links.btn-group
    if can? :read, Product
      = link_to 'Back To Index', products_path, class: 'btn btn-custom'
      - if can? :update, Product
        = link_to 'Edit', edit_product_path(@product) , class: 'btn btn-custom'
      - if can? :destroy, Product
        = link_to 'Delete', product_path(@product), method: :delete, data: {confirm: 'Are you sure?'} , class: 'btn btn-custom'
    .book-info
      %table.table
        %tr
          %td
            Name: 
          %td
            = @product.name
        %tr
          %td
            Description: 
          %td
            = @product.description
        %tr
          %td
            Description: 
          %td
            = @product.price
        %tr
          %td
            Quatity: 
          %td
            = @product.quatity
        %tr
          %td
            Enabled: 
          %td
            = display_status(@product.enabled)
```

# View: 
  * Admin can manage all features.
  * Restaurant can see index, show Product. Can create, update, destroy Product by the form on views
  * Customer (logged in!): can see list Products, show product's detail, 

### Ability
  When user is an admin
  - Can create, read, update, destroy Product

  When user is restaurant
  - Can create, read, update, destroy Product
  
  When user is customer
  - Can read Products
