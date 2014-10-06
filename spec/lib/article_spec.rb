require 'article'
require 'partner'
require 'uri'

describe Article do

	context "#is_third_party?" do
		before(:each) do
			@article = Article.new()
			@article.publisher = Partner.new URI("http://platform.od4d.org")
		end

		it "should return FALSE if the partner is OD4D" do
			expect(@article.is_third_party?).to eq(false)
		end

		it "should return TRUE if the partner isn't OD4D" do
			@article.publisher = Partner.new URI("http://www.webfoundation.org")
			expect(@article.is_third_party?).to eq(true)
		end

	end

	context "#article_content" do

		before(:each) do
			@article = Article.new()
			@article.summary = "This is the article's summary"
			@article.description = "This is the article's description"
			@article.publisher = Partner.new URI("http://www.webfoundation.org")
		end

		context "given a third-party article" do

			it "should return a content 500 chars long for a 501 chars long summary" do
				@article.summary = "1" * 501

				expect(@article.article_content.size).to eq(500)
			end

			it "should return a content 1 chars long for a 1 chars long summary" do
				@article.summary = "1"

				expect(@article.article_content.size).to eq(1)
			end

			it "should return the summary, if any available" do
				expect(@article.article_content).to eq("This is the article's summary")
			end

			it "should return the description, if any available and no summary" do
				@article.summary = ""
				expect(@article.article_content).to eq("This is the article's description")
			end

		end

		context "given a OD4D article" do
			before(:each) do
				@article = Article.new()
				@article.summary = "This is the article's summary"
				@article.description = "This is the article's description"
				@article.publisher = Partner.new URI("http://platform.od4d.org")
			end

			it "should NOT truncate the article's content" do
				@article.summary = "1" * 501

				expect(@article.article_content.size).to eq(501)
			end
		end

	end

	describe "#get_html_tokenized_about" do
		context "given an article with no about" do
			it "should return an empty string" do
				article = Article.new
				article.about = []

				result = article.get_html_tokenized_about

				expect(result).to eq("")
			end
		end

		context "given an article with an about" do
			it "should return the about wrapped with <a> and <span>" do
				article = Article.new
				article.about = ["about"]

				result = article.get_html_tokenized_about

				expect(result).to eq('<a href="/articles/filter/about/about"><span class="semiboldfont" property="schema:about">about</span></a>')
			end
		end

		context "given an article with many abouts" do
			it "should return each about wrapped with <a> and <span> and comma separated" do
				article = Article.new
				article.about = ["about","another_about"]

				result = article.get_html_tokenized_about

				first_about = "<a href=\"/articles/filter/about/about\"><span class=\"semiboldfont\" property=\"schema:about\">about</span></a>"
				separator = ", "
				second_about = "<a href=\"/articles/filter/about/another_about\"><span class=\"semiboldfont\" property=\"schema:about\">another_about</span></a>"
				expect(result).to eq(first_about + separator + second_about)
			end
		end
	end
	
end