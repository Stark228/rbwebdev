class Book
    attr_accessor :title, :author
    def initialize(title, author)
        @title = title
        @author = author
    end
    def display
        puts ("The Book #{@title} is written by #{@author}")
    end
end

title = "Old"
author = "Henry"
b = Book.new(title, author)
b.display