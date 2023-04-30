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
end