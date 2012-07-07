module Gutenberg
  class Book
    attr_accessor :book_id, :creator, :title, :friendlytitle, :publisher, :rights, :license, :issued, :language
    attr_reader   :rdf_reader, :downloads, :author

    def initialize(book_id)
      @book_id = book_id
    end

    def get_data
      @author ||= Gutenberg::Author.new(rdf_reader)
      @creator = @author.name

      download_urls = []

      rdf_reader.each_statement do |statement|
        download_urls << download_link(statement)
        if statement_is_book?(statement)
          parse_book(statement)
        end
      end

      @downloads = download_urls.compact.uniq.map do |download_url|
        Gutenberg::Download.new(rdf_reader, download_url)
      end
    end

    protected

     def parse_book(statement)
      if what = what_from_predicate(statement.predicate.to_s)
        self.send("#{ what }=", statement.object.to_s)
      end
    end

    def statement_is_book?(statement)
      what_from_predicate(statement.predicate.to_s) &&
      Regexp.new(/\/ebooks\/#{ @book_id }/).match(statement.subject.to_s)
    end

    def what_from_predicate(predicate)
      Regexp.new(
          %w(rights publisher license title issued language).join('$|')).
        match(predicate)
    end

    def download_link(statement)
      return unless Regexp.new(/isFormatOf$/).match(statement.predicate.to_s)
      statement.subject.to_s
    end

    def rdf_reader
      @rdf_reader ||= RDF::RDFXML::Reader.open(rdf_url)
    end

    def rdf_url
      "http://www.gutenberg.org/ebooks/#{ @book_id }.rdf"
    end

  end
end