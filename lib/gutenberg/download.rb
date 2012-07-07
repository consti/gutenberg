module Gutenberg
  class Download
    attr_accessor :url
    attr_accessor :modified, :extent

    def initialize(rdf_reader, url)
      @url = url
      rdf_reader.each_statement do |statement|
        if statement_is_a_download?(statement)
          parse_download(statement)
        end
      end
    end

    protected

    def statement_is_a_download?(statement)
      what_from_predicate(statement.predicate.to_s) &&
      @url == statement.subject.to_s
    end

    def what_from_predicate(predicate)
      Regexp.new(
          %w(modified extent).join('$|')).
        match(predicate)
    end

    def parse_download(statement)
      if what = what_from_predicate(statement.predicate.to_s)
        self.send("#{ what }=", statement.object.to_s)
      end
    end

  end
end