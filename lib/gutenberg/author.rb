module Gutenberg
  class Author
    attr_accessor :author_id
    attr_accessor :birthdate, :deathdate, :name, :webpage, :description, :alias

    def initialize(rdf_reader)
      rdf_reader.each_statement do |statement|
        if statement_is_an_author?(statement)
          parse_author(statement)
        end
      end
    end

    protected

    def statement_is_creator?(statement)
      Regexp.new(
        %w(creator).join('$|')).
      match(statement.predicate.to_s) &&
      Regexp.new(/\/agents\/\d+/).match(statement.subject.to_s)
    end

    def statement_is_an_author?(statement)
      what_from_predicate(statement.predicate.to_s) &&
      Regexp.new(/\/agents\/#{ @author_id }+/).match(statement.subject.to_s)
    end

    def what_from_predicate(predicate)
      Regexp.new(
          %w(birthdate deathdate name webpage alias).join('$|')).
        match(predicate)
    end

    def parse_author(statement)
      if statement_is_creator?(statement)
        @creator = statement.object.to_s
      else
        if what = what_from_predicate(statement.predicate.to_s)
          self.send("#{ what }=", statement.object.to_s)
        end
      end
    end

  end
end