require 'test_helper'
class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select '.product', 12
    assert_select '.category', 9
  end

  test 'render a list of filtered by category' do
    get products_path(category_id: categories(:videogames))

    assert_response :success
    assert_select '.product', 7
  end

  test 'render a list of filtered by min_price and max_price' do
    get products_path(min_price: 0, max_price: 150)
    assert_response :success
    assert_select '.product', 12
  end

  test 'render a list of filtered by name or description' do
    get products_path(title: 'ps4')
    assert_response :success
    assert_select '.product', 1
  end

  test 'sort product by expensive' do
    get products_path(order_by: 'expensives')
    assert_response :success
    assert_select '.product', 12
    assert_select '.product:first-child h2', 'Seat Panda clásico'
  end

  test 'sort product by cheapest' do
    get products_path(order_by: 'cheapest')
    assert_response :success
    assert_select '.product', 12
    assert_select '.product:first-child h2', 'El hobbit'
  end

  test 'render a detailed product page' do
    get product_path(products(:ps4))
    assert_response :success
    assert_select '.title','PS4 Fat'
    assert_select '.description', 'PS4 en buen estado'
    assert_select '.price', '150$'
  end

  test 'renders a new product form' do
    get new_product_path
    assert_response :success
    assert_select 'form'
  end

  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: 'Test',
        description: 'Test',
        price: 1,
        category_id: categories(:videogames).id
      }
    }

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto se ha creado correctamente'
  end

  test 'does not allow to create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: '',
        description: 'Test',
        price: 1
      }
    }
    assert_response :unprocessable_entity
  end

  test 'render a edit product form' do
    get edit_product_path(products(:ps4))

    assert_response :success
    assert_select 'form'
  end

  test 'allow to edit a product' do
    patch product_path(products(:ps4)), params: {
      product: {
        price: 125
      }
    }

    assert_redirected_to products_path
    assert_equal flash[:notice], 'El producto se ha editado correctamente'
  end

  test 'does not allow to edit a product' do
    patch product_path(products(:ps4)), params: {
      product: {
        price: nil
      }
    }

    assert_response :unprocessable_entity
  end

  test 'can delete a product' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:ps4))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto se ha eliminado correctamente'

  end
end