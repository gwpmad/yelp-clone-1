describe User, type: :model do
  it { is_expected.to have_many :restaurants }
end