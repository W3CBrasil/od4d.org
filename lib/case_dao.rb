class CaseDAO

    def list_all_cases(base_url)
      [ create_case_road_planetary(base_url), create_case_latin_america(base_url), create_case_open(base_url), create_case_brazilian_open(base_url), create_case_apps_for_democracy(base_url) ]
    end

    private
    def create_case_road_planetary(base_url)
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

    def create_case_latin_america(base_url)
      article = Article.new
      article.title = "Developing Latin America 2012"
      article.url = "#{base_url}##{article.slug}"
      article.author = "OD4D"
      article.datePublished = DateTime.new(2012,3,12)
      article.articleBody = '
        <p><img class="case" src="http://blog.zerial.org/wp-content/uploads/2012/11/hackathontop.png"></p>

        <p>The second edition of <a href="http://2012.desarrollandoamerica.org/">Developing Latin America 2012</a>, a regional hackathon
           lasting 36 hours in which 8 countries - <em>Argentina, Bolivia, Brazil, Costa Rica, Chile, Mexico, Peru,
           and Uruguay</em> - participated , was held yesterday.
           The participating countries remained in constant connection via websites and livestreaming throughout the event.
           The <a href="http://2012.desarrollandoamerica.org/aplicaciones-dal2012/apps-costa-rica-2012/">applications</a>
           resulting from the hackathon are now available on the  <a href="http://2012.desarrollandoamerica.org/">DAL2012</a> website.
           Winning applications have already been announced for some of the countries.
        </p>

        <p>
          <a href="http://2012.desarrollandoamerica.org/"Developing Latin America</a> is distinct in that it uses <a href="http://www.od4d.org/en/2012/10/05/what-is-it/"><em>open data</em></a> as the main source of data for the applications,
          with the objective of generating innovative solutions to the social problems shared by many countries in the region.
          Some of the issues highlighted  this year were <em>health , childhood, transport and environmental,</em> among others,
          with each country selecting the three issues most relevant for their specific context.
        </p>
      </div>
      '
      article
    end

    def create_case_open(base_url)
      article = Article.new
      article.title = "Open 311"
      article.url = "#{base_url}##{article.slug}"
      article.author = "OD4D"
      article.datePublished = DateTime.new(2012,11,10)
      article.articleBody = '

      <p><img class="case" src="http://www.od4d.org/wp-content/uploads/2012/10/image-Open-3113.jpg"></p>

      <p>
        3-1-1 is a number well known in some cities of the United States and Canada, where citizens can notify the
        authorities about situations that are not urgent like non working traffic lights, illegal burning, roadway problems, etc.
        The goal is to leave the number 9-1-1 for those emergencies that really need immediate attention.
      </p>

      <p>
        <a href="http://open311.org/">Open 311</a> “provides open channels of communication for issues that concern public space and public services.
        Using a mobile device or a computer, someone can enter information (ideally with a photo) about a problem at a
        given location. This report is then routed to the relevant authority to address the problem.
        What’s different from a traditional 311 report is that this information is available for anyone to see and
        it allows anyone to contribute more information.
        By enabling collaboration on these issues, the open model makes it easier to collect and organize more information
        about important problems.
        By making the information public, it provides transparency and accountability for those responsible for the problem.
        Transparency also ensures that everyone’s voice is heard and in-turn encourages more participation”.
      </p>

      '
      article
    end

    def create_case_brazilian_open(base_url)
      article = Article.new
      article.title = "Brazilian Open Data Portal"
      article.url = "#{base_url}##{article.slug}"
      article.author = "Danielle Pereira"
      article.datePublished = DateTime.new(2012,10,10)
      article.articleBody = '

      <p><img class="case" src="http://www.od4d.org/wp-content/uploads/2012/10/dados1.jpg"></p>

      <p>
        A data repository, the <a href="http://dados.gov.br/">dados.gov.br</a> portal aggregates <a href="http://dados.gov.br/dataset">82 pubic datasets</a> formerly scattered across the Internet.
        Launched by the Ministry of Planning, the project design also had extensive contributions from society.
        Moreover, the website also enables people to suggest new data for opening, to participate in Open Data events and to
        keep up-to-date with the portal’s development initiatives.
      </p>

      <p>
        Users can also check out a few applications developed by communities using data available through the portal.
        One of the applications is the so-called <a href="http://estadaodados.herokuapp.com/html/basometro/">“Basômetro“</a>, a tool that enables measuring parliamentary support to the
        government and monitoring members of parliament’s stances on legislation votes.
        <a href="http://api.dataprev.gov.br/doc/visualizacao-mapa.html">Another application available</a> on the website pinpoints the work accidents between 2002 and 2009 in the map of Brazil.
        Users are able to view accidents by municipality and by type.
      </p>

      <p>
        The dados.gov is part of the National Infrastructure of Open Data (<a href="http://dados.gov.br/instrucao-normativa-da-inda/">INDA</a>), which is a project aimed at setting forth
        technical standards for Open Data, promoting qualification and sharing public information using open formats and
        free software.
      </p>

      '
      article
    end

    def create_case_apps_for_democracy(base_url)
      article = Article.new
      article.title = "Apps for Democracy"
      article.url = "#{base_url}##{article.slug}"
      article.author = "Yaso"
      article.datePublished = DateTime.new(2012,9,10)
      article.articleBody = '

        <p><img class="case" src="http://www.od4d.org/wp-content/uploads/2012/10/appfordemocracy.png"></p>

        <p>
          The idea was born in 2008, due to DC’s government willing to ensure that both society, governments and
          businesses could make good use of DC.gov’s <a href="http://data.octo.dc.gov/">Data Catalog</a> (that provides, for example, public information on
          poverty and crime indicators, in an open format).
        </p>

        <p>
          Therefore, a competition was created to award the <a href="http://www.appsfordemocracy.org/application-directory/">best applications</a> developed based on data from the Catalog.
          The first contest cost Washington DC U$50,000 and produced 47 iPhone, Facebook and web applications with an
          estimated value in excess of U$2,600,000 to the city.
        </p>

        <p>
          The application <a href="http://www.ilive.at/">iLive.at</a> won a gold medal for providing crime, safety and demographic information for those
          looking for a place in DC.
        </p>

        <p>
          Another award-winning project was <a href="http://www.parkitdc.com/index.php">Park It DC</a>, which allows users to check a specific area in the district
          for parking information.
        </p>

      '
      article
    end
end
