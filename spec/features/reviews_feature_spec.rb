feature 'reviewing' do
  before do
    visit '/'
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
  end

  context 'adding reviews' do
    before do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
    end

    scenario 'allows users to leave a review using a form' do
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('so so')
    end

    scenario 'a user cannot review the same restaurant twice' do
      click_link 'Review KFC'
      fill_in "Thoughts", with: "my second review"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(page).not_to have_content("my second review")
      expect(page).to have_content('You cannot review the same restaurant twice')
    end
  end

  context 'deleting restaurants and their reviews' do
    before do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
    end

    scenario 'deleting a restaurant also deletes its reviews' do
      expect(Review.count).to eq 1
      click_link 'Delete KFC'
      expect(Review.count).to eq 0
    end
  end

  scenario 'cannot delete others reviews' do
    sign_up
    click_link 'Delete KFC review'
    expect(page).to have_content("so so")
    expect(page).to have_content("You cannot delete others\' reviews")
  end

  scenario 'cannot delete others reviews' do
    click_link 'Delete KFC review'
    expect(page).not_to have_content("so so")
  end
end
