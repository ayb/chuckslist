# app/views/ads/feed.atom.builder
atom_feed do |feed|
	feed.title "Latest Ads"
	feed.updated((@ads.last.created_at))
	
	for a in @ads
		feed.entry(a) do |entry|
			entry.title(a.title)
			entry.content(a.ad, :type => 'html')
			entry.author do |author|
				author.name(SITE_NAME)
			end
		end
	end
end