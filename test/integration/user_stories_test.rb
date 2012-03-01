require 'test_helper'

class UserStoriesTest < ActionController::IntegrationTest

  test "setup" do
    open_session do |sess|
      sess.https!
      
      user=Person.find(2)
      user.update_attributes({:password=>'12345789',:password_confirmation=>'12345789'})
      sess.post "/login", {:person=>{:pid => user.pid, :password => "12345789", :remember_me =>"0"}}
      assert_equal '', path.to_s
    end
  	  		
  end

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

 test "login, new an etd, new committee members, and new contents" do
    # login via https
    #https!
    get "/logout"
    assert_response :redirect    

    open_session do |sess|
      sess.https!
      
      user=Person.find(2)
      user.update_attributes({:password=>'12345789',:password_confirmation=>'12345789'})
      sess.post "/login", {:person=>{:pid => user.pid, :password => "12345789", :remember_me =>"0"}}
      assert_equal '/login', path.to_s
      
      sess.post "/etds", {:etd=>{:id=>2,
  	  		:title=>'Tesst',
  	  		:abstract=>'This is the second test abstract',
  	  		:availability_id=>1,
  	  		:bound=>false,
  	  		:copyright_statement_id=>1,
  	  		:degree_id=> 2,
  	  		:department_ids=> [2],
  	  		:document_type_id=>2,
  	  		:privacy_statement_id=>2,
  	  		:status=>'Submitted',
      		:url=>'http://scholar.lib.vt.edu/tehses/available/etd-07292008-13039050/',
  	  		:urn=>'etd-05212008-084627'}}
      
  	  if (assert_response :redirect)
  	  	sess.post("/contents", {:id=>2, :content=>{:id=>1, :uploaded=>File.new(Rails.root + 'app/assets/images/body_bg2.jpg')}}})
  	  	assert_response :redirect
        sess.delete "/contents/1"
        if (assert_response :success)
          puts "I am happy:)"
        else 
          puts "I am not happy, too :("
        end
      else 
		puts "I am not happy:("		
	  end
  	  if (assert_response :success)
  	  	sess.post("/people", {:etd_id=>2, :lname=>'weeks'})
  	  	assert_equal '/people', path.to_s
  	  else 
		puts "I am not happy:("
	  end	  
      sess.https!(false)
    end # open_session

  end 

  test "submit an existing etd" do
    user=Person.find(2)
    user.update_attributes({:password=>'12345789',:password_confirmation=>'12345789'})
    post_via_redirect "/login", {:person=>{:pid => user.pid, :password => "12345789", :remember_me =>"0"}}
    post_via_redirect "/etds", {:etd=>{:id=>2,
  	  		:title=>'Tesst',
  	  		:abstract=>'This is the second test abstract',
  	  		:availability_id=>1,
  	  		:bound=>false,
  	  		:copyright_statement_id=>1,
  	  		:degree_id=> 2,
  	  		:department_ids=> [2],
  	  		:document_type_id=>2,
  	  		:privacy_statement_id=>2,
  	  		:status=>'Submitted',
      		:url=>'http://scholar.lib.vt.edu/theses/available/etd-07292008-13039050/',
  	  		:urn=>'etd-05212008-084627'}}
  	 assert_response :success
  end
    
  test "authorization" do
  	
  end
end
