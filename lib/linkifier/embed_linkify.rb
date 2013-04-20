module Linkifier
  module EmbedLinkify
    def embed_linkify(app_resource, options = {})
      linkify_resource_id = app_resource.try(:linkifier_resource).try(:linkify_resource_id)
      return if linkify_resource_id.nil?
      target = options[:target]
      self.render(
        :partial => "linkifier/embed",
        :locals => options.except(:target).merge({
          :src => Requests.linkify_resource_embed_url(linkify_resource_id, target || :_top)
        })
      )
    end

    alias_method :embed_linkifier, :embed_linkify
    alias_method :linkify_embed, :embed_linkify
    alias_method :linkifier_embed, :embed_linkify
  end
end

ActionView::Base.send :include, Linkifier::EmbedLinkify

