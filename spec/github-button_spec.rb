require_relative '../lib/github-buttons.rb'

describe GitHub::Button do
  before(:all) do
    @button = GitHub::Button.new('a-user', 'a-repository')
  end

  describe '#initialize' do
    it 'gets the user name' do
      @button.user.should eql 'a-user'
    end

    it 'gets the repository name' do
      @button.repo.should eql 'a-repository'
    end
  end

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

    # This is a bug in GitHub Buttons
    # Requesting "watch" returns "star"
    # See: https://github.com/mdo/github-buttons/issues/42#issuecomment-19951052
    it 'accepts "star"' do
      @button.style('star').match(%r(watch)).should be_true
    end

    it 'accepts "fork"' do
      @button.style('fork').match(%r(fork)).should be_true
    end

    it 'accepts "follow"' do
      @button.style('follow').match(%r(follow)).should be_true
    end

    it 'does not accept an Integer' do
      expect{@button.style(12)}.to raise_error(ArgumentError)
    end

    it 'does not accept a non-standard String' do
      expect{@button.style('bananas')}.to raise_error(ArgumentError)
    end

    it 'accepts a hash of options for size and count' do
      b = @button.style('star', large: true, count: true)
      b.match(/size=large.*count=true/).should be_true
    end

=begin
      Star Button
      width="62" height="20"

      Fork Button
      width="53" height="20"

      Follow Button
      width="132" height="20"
=end

    it 'returns the correct "star" button dimensions' do
      b = @button.style('star')
      b.match(%r(width="62")).should be_true
      b.match(%r(height="20")).should be_true
    end
  end
end
