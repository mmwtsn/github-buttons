require_relative '../lib/github-buttons.rb'

describe GitHub::Button do
  # Instantiate a new mock button before every test is run
  before(:all) do
    @button = GitHub::Button.new('a-user', 'a-repository')
  end

  # #
  # Does the Button class initialize as expected?
  #
  describe '#initialize' do
    it 'gets the user name' do
      @button.user.should eql 'a-user'
    end

    it 'gets the repository name' do
      @button.repo.should eql 'a-repository'
    end
  end

  # #
  # Tests the method that builds and returns the button
  #
  describe '#style' do
    it 'returns a correct string' do
      @button.style.class.should eql String
    end

    it 'returns the correct string' do
      @button.style.should eql %Q(<iframe src="http://ghbtns.com/github-btn.html?user=a-user&repo=a-repository&type=follow" allowtransparency="true" frameborder="0" scrolling="0" width="132" height="20"></iframe>)
    end

    it 'contains the user name' do
      @button.style.match(%r(a-user)).should be_true
    end

    it 'contains the repo name' do
      @button.style.match(%r(a-repository)).should be_true
    end

    # #
    # Only accept three button styles supported by @mdo's API
    #
    # This is a bug in GitHub Buttons
    # Requesting "watch" returns "star"
    # See: https://github.com/mdo/github-buttons/issues/42#issuecomment-19951052
    it 'accepts "star" and does not return "star", "follow" or "fork"' do
      b = @button.style('star')
      b.match(%r(watch)).should be_true
      b.match(/star.*follow.*fork/).should be_false
    end

    it 'accepts "fork" and does not return "star", "watch" or  "follow"' do
      b = @button.style('fork')
      b.match(%r(fork)).should be_true
      b.match(/star.*watch.*follow/).should be_false
    end

    it 'accepts "follow" and does not return "star", "watch" or "fork"' do
      b = @button.style('follow')
      b.match(%r(follow)).should be_true
      b.match(/star.*watch.*fork/).should be_false
    end

    it 'does not accept an Integer' do
      expect{@button.style(12)}.to raise_error(ArgumentError)
    end

    it 'does not accept a non-standard String' do
      expect{@button.style('bananas')}.to raise_error(ArgumentError)
    end

    # Tests optional configuration hash
    it 'accepts a hash of options for size and count' do
      b = @button.style('star', large: true, count: true)
      b.match(/size=large.*count=true/).should be_true
    end

    # Tests button dimensions
    it 'returns the correct "small star" button dimensions' do
      b = @button.style('star')
      b.match(%r(width="62")).should be_true
      b.match(%r(height="20")).should be_true
    end

    it 'returns the correct "small fork" button dimensions' do
      b = @button.style('fork')
      b.match(%r(width="53")).should be_true
      b.match(%r(height="20")).should be_true
    end

    it 'returns the correct "small follow" button dimensions' do
      b = @button.style('follow')
      b.match(%r(width="132")).should be_true
      b.match(%r(height="20")).should be_true
    end
  end
end
