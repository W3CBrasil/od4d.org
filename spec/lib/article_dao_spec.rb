require File.expand_path('../../../app/models/article.rb', __FILE__)
require 'article_dao'

describe ArticleDAO do

  describe "#create_from_hash" do

    it "should convert date published to MM/DD/YYYY format" do
      articleDao = ArticleDAO.new

      article_hash = {
        "url" => "don't care",
        "headline" => "don't care",
        "author" => "don't care",
        "description" => "don't care",
        "articleSection" => "don't care",
        "datePublished" => "2014-07-25T04:13:05+03:00"
      }

      article = articleDao.create_from_hash(article_hash)

      expect(article.datePublished).to eq("07/25/2014")
    end
  end

end
