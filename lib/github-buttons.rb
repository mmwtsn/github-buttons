module GitHub
  class Button
    attr_accessor :user, :repo
    def initialize(user, repo)
      @user = user
      @repo = repo
    end

    def style(type="follow", options={})
      # Available GitHub Button types
      types = ['fork', 'star', 'follow']

      # Ensure argument type is valid
      unless type.is_a? String
        raise ArgumentError, "Expected String, got #{type.class}"
      end

      # Ensure button type exists
      unless types.include? type
        raise ArgumentError, %Q(#{type} button not available. Try "fork", "star" or "follow")
      end

      # If no options are specified, pass none
      if options.empty?
        large = count = nil
      end

      # Format options as URL query parameters for final iFrame
      if options[:large] then size = "&size=large" end
      if options[:count] then count = "&count=true" end

      # Set HTML class for requested button type
      html_class = type

      # Work around bug in GitHub Button repository
      # Requesting "watch" actually returns "star"
      # See: https://github.com/mdo/github-buttons/issues/42#issuecomment-19951052
      if type == 'star'
        type       = 'watch'
        html_class = 'star' # Reset 'watch' to 'star' so user receives expected class
      end

      # Return GitHub Button
      %Q(<iframe class="github-button #{html_class}" src="http://ghbtns.com/github-btn.html?user=#{@user}&repo=#{@repo}&type=#{type}#{size}#{count}" allowtransparency="true" frameborder="0" scrolling="0" width="120" height="30"></iframe>)
    end
  end
end
