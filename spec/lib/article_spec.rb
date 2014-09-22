require 'article'
require 'partner'
require 'uri'

describe Article do

	context "#is_third_party?" do
		before(:each) do
			@article = Article.new()
			@article.publisher = Partner.new URI("http://www.od4d.org")
		end

		it "should return FALSE if the partner is OD4D" do
			expect(@article.is_third_party?).to eq(false)
		end

		it "should return TRUE if the partner isn't OD4D" do
			@article.publisher.uri = "http://www.webfoundation.org"
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
				@article.publisher = Partner.new URI("http://www.od4d.org")
			end

			it "should NOT truncate the article's content" do
				@article.summary = "1" * 501

				expect(@article.article_content.size).to eq(501)
			end
		end

	end
	
end