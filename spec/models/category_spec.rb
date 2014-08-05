require 'rails_helper'

RSpec.describe Category, :type => :model do
  subject { Category.new }
  it { should respond_to :name }
end
