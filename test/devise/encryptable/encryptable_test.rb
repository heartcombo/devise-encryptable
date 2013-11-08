require "test_helper"

class EncryptableTest < ActiveSupport::TestCase
  include Support::Assertions
  include Support::Factories
  include Support::Swappers

  def encrypt_password(admin, pepper=Admin.pepper, stretches=Admin.stretches, encryptor=Admin.encryptor_class)
    encryptor.digest('123456', stretches, admin.password_salt, pepper)
  end

  test 'should generate salt while setting password' do
    assert create_admin.password_salt.present?
  end

  test 'should not change password salt when updating' do
    admin = create_admin
    salt = admin.password_salt
    admin.expects(:password_salt=).never
    admin.save!
    assert_equal salt, admin.password_salt
  end

  test 'should generate a base64 hash using SecureRandom for password salt' do
    swap_with_encryptor Admin, :sha1 do
      # Devise 3.1+ uses a different method to generate friendly tokens,
      # when we drop support for Devise 2 we can remove this hack.
      # https://github.com/plataformatec/devise/commit/4048545151fe467c9d8c8c6fce164788bb36e25f.
      expected_method = Devise::VERSION >= '3.1.0' ? :urlsafe_base64 : :base64

      SecureRandom.expects(expected_method).with(15).returns('01lI').once
      salt = create_admin.password_salt
      assert_not_equal '01lI', salt
      assert_equal 4, salt.size
    end
  end

  test 'should not generate salt if password is blank' do
    assert create_admin(:password => nil).password_salt.blank?
    assert create_admin(:password => '').password_salt.blank?
  end

  test 'should encrypt password again if password has changed' do
    admin = create_admin
    encrypted_password = admin.encrypted_password
    admin.password = admin.password_confirmation = 'new_password'
    admin.save!
    assert_not_equal encrypted_password, admin.encrypted_password
  end

  test 'should respect encryptor configuration' do
    swap_with_encryptor Admin, :sha512 do
      admin = create_admin
      assert_equal admin.encrypted_password, encrypt_password(admin, Admin.pepper, Admin.stretches, Devise::Encryptable::Encryptors::Sha512)
    end
  end

  test 'should not validate password when salt is nil' do
    admin = create_admin
    admin.password_salt = nil
    admin.save
    assert_not admin.valid_password?('123456')
  end

  test 'required_fields should contain the fields that Devise uses' do
    assert_same_content Devise::Models::Encryptable.required_fields(Admin), [
      :password_salt
    ]
  end
end
