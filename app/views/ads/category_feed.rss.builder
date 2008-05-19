xml.instruct! :xml, :version => "1.0"
xml.rss(:version => "2.0") {
	xml.channel {
		xml.title("Latest Ads For Category ")
		xml.link(SITE_URL)
		xml.description("The latest ads posted on " + SITE_NAME + ".")
		xml.language('en-us')
			for a in @ads
				xml.item do
					xml.title(a.title)
					xml.description(a.ad)
					xml.author(a.email)
					xml.pubDate(a.created_at.strftime("%a %d %b %Y %H:%M:%S %z"))
					xml.link(url_for(:controller => 'ads', 
						:action => 'show', :host => DOMAIN,
						:id => a.id, :only_path => false))
					xml.guid(url_for(:controller => 'ads',
						:action => 'show', :host => DOMAIN,
						:id => a.id, :only_path => false))
				end
			end
	}
}