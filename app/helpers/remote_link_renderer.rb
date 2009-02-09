# http://weblog.redlinesoftware.com/2008/1/30/willpaginate-and-remote-links

class RemoteLinkRenderer < WillPaginate::LinkRenderer
  def prepare(collection, options, template)
    @remote = options.delete(:remote) || {}
    @url_overrides = @remote.delete(:url)
    super
  end

protected
  def page_link(page, text, attributes = {})
    @template.link_to_remote(text, {:url => {:page => page}.merge(@url_overrides), :method => :get}.merge(@remote))
  end
end