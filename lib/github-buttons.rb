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

      # Pass dimensions to iFrame based on requested style
      case type
      when 'star'
        width, height = 62, 20
      when 'fork'
        width, height = 53, 20
      when 'follow'
        width, height = 132, 20
      end

      # Format options as URL query parameters for final iFrame
      if options[:large] then size = "&size=large" end
      if options[:count] then count = "&count=true" end

      # Work around bug in GitHub Button repository
      # Requesting "watch" actually returns "star"
      # See: https://github.com/mdo/github-buttons/issues/42#issuecomment-19951052
      if type == 'star'
        type = 'watch'
      end

      # Return GitHub Button
      %Q(<iframe class="github-button #{type}" src="http://ghbtns.com/github-btn.html?user=#{@user}&repo=#{@repo}&type=#{type}#{size}#{count}" allowtransparency="true" frameborder="0" scrolling="0" width="#{width}" height="#{height}"></iframe>)
    end
  end
end
