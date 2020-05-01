# our CLI Controller
class TopNewsD1::CLI

    def call
        TopNewsD1::Scraper.scrape_stories
        list_stories
        menu
    end

    def list_stories
        puts "\nTop Stories:"
        @stories = TopNewsD1::Stories.today
        @stories.each.with_index(1) do |story, x|
            puts "#{x}. '#{story.title}' by #{story.author} - #{story.timestamp}"
        end
    end

    def menu
        input = nil
        while input != "exit"
            puts "\nEnter the number of the article you would like to see, type list to see the list again, or type exit to leave."
            input = gets.strip.downcase

            if input.to_i > 0 && input.to_i < 3
                the_story = @stories[input.to_i-1]
                puts "\n\t'#{the_story.title}' by #{the_story.author} - #{the_story.timestamp}"
                puts "\n\t#{the_story.topic.capitalize!}" if the_story.topic != nil
                puts "\n\t#{the_story.description.capitalize!}" if the_story.description != nil
                if the_story.url 
                    doc = Nokogiri::HTML(open("#{the_story.url}"))
                    story = doc.search("div.article-body p").text
                    puts "\n"
                    puts story
                    puts "\n" 
                    puts the_story.url
                else
                    puts "\nCheck out https://www.espn.com/mens-college-basketball/ for more information!"
                end
            elsif input == 'list'
                list_stories
            elsif input == 'exit'
                goodbye
            else
                puts "\nSorry, I'm not sure what you are asking."
            end
        end
    end

    def goodbye
        puts "\nSee you tomorrow for more news!"
    end
    # binding.pry
end