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
<!-- fmt:formatDate tag to format the date according to the specified pattern -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Details Page for Creator</title>
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
			<form:form action="/books/${book.id }" method="put"
				modelAttribute="book" class="py-3 form-inline">
				<p class="form-group">
					<form:errors path="title" class="text-danger" />
					<form:input path="title" class="form-control" />
				</p>
				<p>
					Added by:
					<c:out value="${book.user.firstname }"></c:out>
					<c:out value="${book.user.lastname }"></c:out>
				</p>
				<p>
					Added on:
					<fmt:formatDate value="${book.createdAt}"
						pattern="MMM dd, yyyy 'at' h:mm a" />
				</p>
				<p>
					Last update on:
					<fmt:formatDate value="${book.updatedAt}"
						pattern="MMM dd, yyyy 'at' h:mm a" />
				</p>
				<p class="form-group">
					<form:label path="description">Description: </form:label>
					<form:errors path="description" class="text-danger" />
					<form:textarea path="description" class="form-control" />
				</p>
				<input type="submit" value="Update" class="btn btn-primary" />
			</form:form>
			<form action="/books/${book.id}" method="post" class="me-5">
				<input type="hidden" name="_method" value="delete"> <input
					type="submit" value="Delete" class="btn btn-danger">
			</form>
		</div>
		<div>
			<h1>Users Who Like This Book</h1>
			<c:forEach items="${book.readers }" var="reader">
				<ul>
					<li><c:out value="${reader.firstname}"></c:out> <c:out
							value="${reader.lastname}"></c:out></li>
				</ul>
			</c:forEach>
		</div>
	</main>
</body>
</html>

