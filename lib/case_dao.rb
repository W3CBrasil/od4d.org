class CaseDAO

    def list_all_cases(base_url)
      [ create_case_one(base_url) ]
    end

    private
    def create_case_one(base_url)
      article = Article.new
      article.title = "Road to Planetary Synapse"
      article.url = "#{base_url}##{article.slug}"
      article.author = "KW Foundation"
      article.datePublished = DateTime.new(2013,9,16)
      article.articleBody = '
        <p>
          KW Foundation is a Family nonprofit that researches and develops knowledge management within a democratic and
          inclusive digital society.
        </p>
        <p>
          We created a conceptual and technological scenario that can align efforts to enable it to any citizen.
          So, he can generate value from open data and web services.
        </p>
        <p>Our most important assumption is that <em>"the final frontier is the planetary synapses"</em>.</p>
        <p>
          Please see this conceptual <a href="http://youtu.be/hx_k9bL99Fs">video</a>  and,
          if you like <a href="http://youtu.be/HzHtIAtxzs4">rock</a>
        </p>
        <p><em>What would we need to generate a synapse planetary and take the next step in human sustainable evolution?</em></p>
      '
      article
    end

end
