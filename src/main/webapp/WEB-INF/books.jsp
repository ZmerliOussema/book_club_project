<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Formatting (dates) -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Club</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/main.css">
<!-- change to match your file/naming structure -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/app.js"></script>
<!-- change to match your file/naming structure -->
</head>
<body>
	<!-- NavBar -->
	<nav
		class="navbar navbar-expand-lg navbar-light bg-light d-flex justify-content-between px-3">
		<h1>
			Welcome,
			<c:out value="${user.firstname }"></c:out>
			!
		</h1>
		<a href="/logout">Log Out</a>
	</nav>
	<!-- Main -->
	<main class="d-flex justify-content-around">
		<div>
			<h1>Add a New Book</h1>
			<form:form action="/books" method="post" modelAttribute="book"
				class="py-3">
				<p class="form-group">
					<form:label path="title">Title: </form:label>
					<form:errors path="title" class="text-danger" />
					<form:input path="title" class="form-control" />
				</p>
				<p class="form-group">
					<form:label path="description">Description: </form:label>
					<form:errors path="description" class="text-danger" />
					<form:textarea path="description" class="form-control" />
				</p>
				<input type="submit" value="Add" class="btn btn-primary" />
			</form:form>
		</div>
		<div>
			<h1>All Books</h1>
			<c:forEach items="${books }" var="book">
				<ul>
					<li>
						<p>
							<a href="books/${book.id }"><c:out value="${book.title }"></c:out></a><br>
							(added by
							<c:out value="${book.user.firstname }"></c:out> <c:out value="${book.user.lastname }"></c:out>
							) <br>
							<c:if test="${book.readers.contains(user) eq false }">
								<a href="/addToFavList/${book.id }">Add to Favorites</a>
							</c:if>
							<c:if test="${book.readers.contains(user)}">
								<p>this is one of your favorites</p>
							</c:if>
						</p>
					</li>
				</ul>
			</c:forEach>
		</div>
	</main>
</body>
</html>