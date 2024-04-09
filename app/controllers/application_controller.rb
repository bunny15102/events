class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        event_path # Replace 'event_path' with the actual path to your event page
    end
end