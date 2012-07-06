module Gutenberg
  class Book
    attr_accessor :book_id, :creator, :title, :friendlytitle, :publisher, :rights, :rdf_url

    def initialize(book_id, creator=nil, title=nil, friendlytitle=nil, publisher=nil, rights=nil)
      @creator        = creator
      @title          = title
      @friendlytitle  = friendlytitle
      @publisher      = publisher
      @rights         = rights
      @book_id        = book_id
      @rdf_url        = "http://www.gutenberg.org/ebooks/#{ book_id }.rdf"
    end
  end
end