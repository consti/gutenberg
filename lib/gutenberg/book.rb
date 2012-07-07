module Gutenberg
  class Book
    attr_accessor :book_id, :creator, :title, :friendlytitle, :publisher, :rights
    attr_reader   :rdf_reader, :downloads, :author

    def initialize(book_id, creator=nil, title=nil, friendlytitle=nil, publisher=nil, rights=nil)
      @creator        = creator
      @title          = title
      @friendlytitle  = friendlytitle
      @publisher      = publisher
      @rights         = rights
      @book_id        = book_id
    end

    def get_data
      @author ||= Gutenberg::Author.new(rdf_reader)

      download_urls = rdf_reader.statements.map { |statement|
        download_link(statement)
      }.compact.uniq

      @downloads = download_urls.map do |download_url|
        Gutenberg::Download.new(rdf_reader, download_url)
      end
    end

    protected

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