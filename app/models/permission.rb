class Permission < Struct.new(:user)
  def initialize(user)          
    allow :folios,          [:index, :new, :create, :show, :destroy, :check_availability, :register_keyword, :deregister_keyword]
    allow :messages,        [:index, :new, :create, :edit, :update, :show, :destroy]
    allow :password_resets, [:new, :create, :edit, :update]
    allow :sessions,        [:create, :destroy, :new]
    allow :users,           [:index, :new, :create]
    allow :static_pages,    [:home, :about, :help]
    allow :verifications,   [:show]
    allow :charges,         [:new, :create]
    allow :inbox,           [:show, :create]
    allow :google_contacts, [:show, :callbacks, :get_client, :get_contacts]
    if user
      allow :albums,        [:index, :new, :create, :edit, :update, :show, :destroy, :get_pics, :get_html_pics]
      allow :users,         [:show]
      allow :users,         [:edit, :update, :destroy] do |u|
        u.id == user.id
      end
      allow_all if user.admin
    end
  end
  
  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions [[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end
  
  def allow_all
    @allow_all = true
  end
  
  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end
end