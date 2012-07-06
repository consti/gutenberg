require 'rdf'
require 'rdf/rdfxml'

module Gutenberg
  module Catalog
    class Parser
      attr_accessor :books

      def initialize(file)
        read_books( RDF::RDFXML::Reader.open(file) )
      end

      protected

      def what_from_predicate(predicate)
        Regexp.new(
            %w(friendlytitle creator title publisher rights).join('$|')).
          match(predicate)
      end

      def book_id_from_subject(subject)
        if m = Regexp.new(/#etext(\d+)/).match(subject)
          m[1]
        end
      end

      private

      def read_books(rdf_reader)
        books_hash = {}
        
        rdf_reader.each_statement do |statement|
          if book_id = book_id_from_subject(statement.subject.to_s)
            books_hash[book_id] ||= Gutenberg::Book.new(book_id)
            if what = what_from_predicate(statement.predicate.to_s)
              books_hash[book_id].send("#{ what }=", statement.object.to_s)
            end
          end
        end
        @books = []
        books_hash.map do |k, book|
          @books << book
        end
      end
    end
  end
end