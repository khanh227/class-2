Issue-34: Update Cancan for Product Management

If user haven't logged in, the webpage just shows products list
If User Logged in, the webpage display product management(product: list, create, edit product, delete product, show product detail).

- Update cancan for Product Management

  + Add ability for user:

    + If user has admin role, they can manage all object.

    + If user has restaurant role, they can see products list, product detail, create product, update product.

    + If user has customer role (logged in), they can see product list, product details, cannot create product, update product. And more function in others object(category, order, total cost)

    + If user is guest user (unlogged in), they just can see product list.

update cancan:
  - In products_controller.rb 
    we have to replace line 2 by method load_and_authorize_resource

  - In ability.rb
    - If user is admin
    can :manage, all

    - If user is restaurant
    can :crud, @product

    - If user is customer
    can [:index, :show], @product


ProductsController

```# products_controller.rb
  class ProductsController < ApplicationController
  load_and_authorize_resources

    def index
      display a list of products
    end

    def new
      a new empty variable @product
    end

    def update
      update a product with fields:
        { name, description, enabled, price, quatity }
    end

    def create
      create a new product
      if success return this product details
      else render new form
    end

    def edit
      render edit form for updating
    end

    def product_params
      require params from form (new, edit)
    end
````

```#update views
----views/products/_table.html.haml
CHANGE
  = link_to 'Edit', edit_product_path(product), class: 'btn btn-primary'
  = link_to 'Show', product_path(product), class: 'btn btn-info'
  = link_to 'Destroy', product_path(product), method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-danger'
TO
  if can? edit
    = link_to 'Edit', edit_product_path(product), class: 'btn btn-primary'
  if can? show
    = link_to 'Show', product_path(product), class: 'btn btn-info'
  if can? delete
    = link_to 'Destroy', product_path(product), method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-danger'
```

```
----views/products/_index.html.haml
CHANGE
  = link_to 'New Product', new_product_path, class: 'btn btn-primary'
  = link_to 'Import', product_imports_path, class: 'btn btn-info'
  = link_to 'Export', products_path(format: :csv), class: 'btn btn-info'
TO
  if can? create
    = link_to 'New Product', new_product_path, class: 'btn btn-primary'
    = link_to 'Import', product_imports_path, class: 'btn btn-info'
    = link_to 'Export', products_path(format: :csv), class: 'btn btn-info'
```
