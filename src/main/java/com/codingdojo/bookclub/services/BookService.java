package com.codingdojo.bookclub.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.bookclub.models.Book;
import com.codingdojo.bookclub.repositories.BookRepository;

@Service
public class BookService {

	@Autowired
	private BookRepository bookRepo;

	// Get all books
	public List<Book> getAllBooks() {
		return bookRepo.findAll();
	}

	// Create a book
	public Book createBook(Book b) {
		return bookRepo.save(b);
	}

	// Get a book by Id
	public Book findBook(Long id) {
		Optional<Book> maybeBook = bookRepo.findById(id);
		if (maybeBook.isPresent()) {
			return maybeBook.get();
		} else {
			return null;
		}
	}

	// Update a book
	public Book updateBook(Book b) {
		return bookRepo.save(b);
	}

	// Delete a book
	public void deleteBook(Long id) {
		bookRepo.deleteById(id);
	}
}
