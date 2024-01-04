package com.codingdojo.bookclub.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.codingdojo.bookclub.models.Book;
import com.codingdojo.bookclub.models.LoginUser;
import com.codingdojo.bookclub.models.User;
import com.codingdojo.bookclub.services.BookService;
import com.codingdojo.bookclub.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private BookService bookService;

	@GetMapping("/")
	public String index(Model model) {

		// Bind empty User and LoginUser objects to the JSP
		// to capture the form input
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "index.jsp";
	}

	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model,
			HttpSession session) {

		userService.register(newUser, result);
		if (result.hasErrors()) {
			// Be sure to send in the empty LoginUser before
			// re-rendering the page.
			model.addAttribute("newLogin", new LoginUser());
			return "index.jsp";
		}

		// No errors!
		// TO-DO Later: Store their ID from the DB in session,
		// in other words, log them in.
		session.setAttribute("user_id", newUser.getId());
		return "redirect:/books";
	}

	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model,
			HttpSession session) {

		// Add once service is implemented:
		User user = userService.login(newLogin, result);

		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "index.jsp";
		}

		// No errors!
		// TO-DO Later: Store their ID from the DB in session,
		// in other words, log them in.
		session.setAttribute("user_id", user.getId());
		return "redirect:/books";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// Add to Favorites
	@GetMapping("/addToFavList/{id}")
	public String addFav(@PathVariable("id") Long id, HttpSession session) {
		
		// 1. grab the current user from the db
		Long userId = (Long) session.getAttribute("user_id");
		User user = userService.findById(userId);
		
		// 2. grab the book selected from db
		Book book = bookService.findBook(id);
		
		// 3. add the current book to the list of favorites
		user.getFavBooks().add(book);
		
		// 4. save to the db
		userService.updateUser(user);
		
		return "redirect:/books";
	}
	
	// Remove from Favorites
		@GetMapping("/removeFromFavList/{id}")
		public String removeFav(@PathVariable("id") Long id, HttpSession session) {
			
			// 1. grab the current user from the db
			Long userId = (Long) session.getAttribute("user_id");
			User user = userService.findById(userId);
			
			// 2. grab the book selected from db
			Book book = bookService.findBook(id);
			
			// 3. add the current book to the list of favorites
			user.getFavBooks().remove(book);
			
			// 4. save to the db
			userService.updateUser(user);
			
			return "redirect:/books";
		}

}
