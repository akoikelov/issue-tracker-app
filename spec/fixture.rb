module FixtureHelper

  def get_test_img
    Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/lib/fake_data/images/test.jpg')))
  end

end