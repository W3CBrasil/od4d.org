class String
  def make_urls_line_breakable
    self.gsub(/\//,"/\u{200B}")
  end
end
