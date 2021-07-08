# frozen_string_literal: true

module PostsHelper
  def post_excerpt(post)
    "#{truncate_string(post.content.to_plain_text, 800)} [#{link_to('Read full post', post, class: 'post-detail-link')}]"
  end
end
