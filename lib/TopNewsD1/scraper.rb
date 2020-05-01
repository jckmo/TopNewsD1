class TopNewsD1::Scraper
    @doc = Nokogiri::HTML(open("https://www.espn.com/mens-college-basketball/"))

     def self.scrape_stories
        self.scrape_espn_headline
        self.scrape_espn_story_one
        # go to espn, find the defined porperties, instantiate stories
    end

    def self.scrape_espn_headline
        # 1
        story = TopNewsD1::Stories.new

        story.title = @doc.search("div.contentItem__titleWrapper h1")[0].text
        story.description = "Visit ESPN's NCAAM Homepage for more information! \nhttps://www.espn.com/mens-college-basketball/" if @description != nil
        story.description = @doc.search("div.contentItem__titleWrapper p")[0].text
        story.author = "ESPN" if @author == nil
        story.author = @doc.search("div.contentItem__contentWrapper.contentItem__contentWrapper--videoCaption span.contentMeta__author").text
        story.timestamp = "Less than a week ago" if @timestamp == nil
        story.timestamp = @doc.search("div.contentItem__contentWrapper.contentItem__contentWrapper--videoCaption span.contentMeta__timestamp").text
        story.url = "Visit ESPN's NCAAM Homepage for more information! \nhttps://www.espn.com/mens-college-basketball/" if @url == nil
        story.url = "https://espn.com" + @doc.search("section.contentItem__content.contentItem__content--fullWidth.contentItem__content--enhanced.contentItem__content--hero.has-image.contentItem__content--story a[href]")[0]['href']
    end

    def self.scrape_espn_story_one
        # 2
        story = TopNewsD1::Stories.new

        story.title = @doc.search("div.contentItem__titleWrapper h1")[2].text
        story.topic = "Visit ESPN's NCAAM Homepage for more information! \nhttps://www.espn.com/mens-college-basketball/" if @topic == nil
        story.topic = @doc.search("div.contentItem__header__headings h1")[1].text
        story.author = "ESPN" if @author == nil
        story.author = @doc.search("div.contentItem__contentMeta.contentItem__contentMeta--bottom span.contentMeta__author")[2].text
        story.timestamp = "Less than a week ago" if @timestamp == nil
        story.timestamp = @doc.search("div.contentItem__contentMeta.contentItem__contentMeta--bottom span.contentMeta__timestamp")[1].text
        story.url = "Visit ESPN's NCAAM Homepage for more information! \nhttps://www.espn.com/mens-college-basketball/" if @url == nil
        story.url = "https://espn.com" + @doc.search("section.contentItem__content.contentItem__content--story.has-image.contentItem__content--enhanced.contentItem__content--fullWidth a[href]")[1]['href']
    end
end