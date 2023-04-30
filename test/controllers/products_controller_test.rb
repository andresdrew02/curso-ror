require 'test_helper'
class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select '.product', 2
  end

  test 'render a detailed product page' do
    get product_path(products(:one))
    assert_response :success
    assert_select '.title','MyString'
    assert_select '.description', 'MyText'
    assert_select '.price', '1$'
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
        price: 1
      }
    }

    assert_redirected_to products_path
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
end