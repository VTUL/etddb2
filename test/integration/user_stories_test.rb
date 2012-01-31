require 'test_helper'

class UserStoriesTest < ActionController::IntegrationTest
  fixtures :all
  fixtures :people

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
 test "login and new etd site" do
    # login via https
    #https!
    get "/logout"
    assert_response :redirect    

    open_session do |sess|
      sess.https!
      
      user=Person.find(2)
      user.update_attributes({:password=>'12345789',:password_confirmation=>'12345789'})
      sess.post "http://developer.tower.lib.vt.edu:3000/login", {:person=>{:pid => user.pid, :password => "12345789", :remember_me =>"0"}}
      assert_equal '/login', path.to_s
      
    sess.post "http://developer.tower.lib.vt.edu:3000/etds/new", {:etd=>{\
      :id=>2,\
  	  :title=>'Tesst',\
  	  :abstract=>'This is the second test abstract',\
  	  :availability_id=>1,\
  	  :bound=>false,\
  	  :copyright_statement_id=>1,\
  	  :degree_id=> 2,\
  	  :department_id=> 2,\
  	  :document_type_id=>2,\
  	  :privacy_statement_id=>2,\
  	  :status=>'Submitted',\
      :url=>'http://scholar.lib.vt.edu/theses/available/etd-07292008-13039050/',\
  	  :urn=>'etd-05212008-084627',\
  	  :degree=>'PhD'}}
  	  assert_response :success
      
      
      sess.https!(false)
    end

    #post_via_redirect "/login", :pid => people(:SungHee).pid, :password => people(:SungHee).suffix
    #assert_equal '/pages#home', path
    #assert_equal '/people/sessions#new', path
    #assert_equal 'Welcome shpark!', flash[:notice]

    #get "/logout"
    #assert_response :success
 
    #https!(false)
    #get "/posts/all"
    #assert_response :success
    #assert assigns(:etds)
  end 

  test "submit an existing etd" do
    #etd=Etd.find(1)
    #user.update_attributes({:password=>'12345789',:password_confirmation=>'12345789'})
    post_via_redirect "http:/developer.tower.lib.vt.edu:3000/etds/new", {:etd=>{\
      :id=>2,\
  	  :title=>'Tesst',\
  	  :abstract=>'This is the second test abstract',\
  	  :availability_id=>1,\
  	  :bound=>false,\
  	  :copyright_statement_id=>1,\
  #degree_id: 2
  #department_id: 2
  	  :document_type_id=>2,\
  	  :privacy_statement_id=>2,\
  	  :status=>'Submitted',\
      :url=>'http://scholar.lib.vt.edu/theses/available/etd-07292008-13039050/',\
  	  :urn=>'etd-05212008-084627'}}

  #:etd => {etd(:SungHee).title, : => people(:SungHee).suffix
    assert_equal '/pages#home', path
    #assert_equal '/people/sessions#new', path
    #assert_equal 'Welcome shpark!', flash[:notice]

    #get "/logout"
    #assert_response :success
 
    #https!(false)
    #get "/posts/all"
    #assert_response :success
    #assert assigns(:etds)
  end
  
  
  test "submit an new etd" do
  end
  
end
