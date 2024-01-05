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
<title>Details Page for Viewer</title>
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
			<h1>
				<c:out value="${book.title }"></c:out>
			</h1>
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
				Last Updated on:
				<fmt:formatDate value="${book.updatedAt}"
					pattern="MMM dd, yyyy 'at' h:mm a" />
			</p>
			<p>
				Description:
				<c:out value="${book.description }"></c:out>
			</p>
		</div>
		<div>
			<h1>Users Who Like This Book: </h1>
			<div>
				<c:forEach items="${book.readers}" var="reader">
					<ul>
						<li><c:out value="${reader.firstname}"></c:out> <c:out
								value="${reader.lastname}"></c:out></li>
					</ul>
				</c:forEach>
				<c:if test="${book.readers.contains(user) eq false }">
					<a href="/addToFavList/${book.id }">Add to Favorites</a>
				</c:if>
				<c:if test="${book.readers.contains(user)}">
					<a href="/removeFromFavList/${book.id }">Un-Favorite</a>
				</c:if>
			</div>
		</div>
	</main>
</body>
</html>

