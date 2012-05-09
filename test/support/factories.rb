module Support
  module Factories
    def generate_unique_email
      @@email_count ||= 0
      @@email_count += 1
      "test#{@@email_count}@example.com"
    end

    def valid_attributes(attributes={})
      { :username => "usertest",
        :email => generate_unique_email,
        :password => '123456',
        :password_confirmation => '123456' }.update(attributes)
    end

    def create_admin(attributes={})
      valid_attributes = valid_attributes(attributes)
      valid_attributes.delete(:username)
      Admin.create!(valid_attributes)
    end
  end
end