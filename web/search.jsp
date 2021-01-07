<%-- 
    Document   : admin
    Created on : Jun 10, 2020, 7:45:36 PM
    Author     : AVITA
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>Search Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    </head>
    <body>
        <!--         nvar-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Hana Shop</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse d-flex justify-content-between" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item active">
                        <a class="nav-link btn btn-primary text-white" href="search.jsp">Search <span class="sr-only">(current)</span></a>
                    </li>
                </ul>
                <div>
                    <c:if test="${not empty sessionScope.USER}">
                        <font color="red">Welcome, ${sessionScope.USER.name}</font>
                        <a class="btn border btn-light" href="DispatcherController?btAction=LogOut">LogOut</a>
                    </c:if>
                    <c:if test="${sessionScope.USER.role.name == 'User'}">
                        <a class="btn btn-info" href="view">View Cart</a>
                    </c:if>
                    <c:if test="${sessionScope.USER.role.name == 'Admin'}">
                        <a class="btn-primary btn" href="#">Manager Foods</a>        
                    </c:if>
                    <c:if test="${sessionScope.USER.role.name == 'Admin'}">
                        <a class="btn-primary btn" href="createFood.jsp">Create New Food</a>        
                    </c:if>
                    <c:if test="${empty sessionScope.USER}">
                        <a class="btn btn-success" href="login.jsp">Login here!!!</a>
                    </c:if>

                </div>
            </div>
        </nav>
        <c:set var="search" value="${requestScope.SEARCH_RESULT}"/>
        <div class="form-row">
            <div class="container border mt-3 bg-light p-3" style="max-width: 500px;margin-left: 70px "> 
                <form action="DispatcherController" method="POST">
                    <h3 class="text-center mb-4">Search form</h3>
                    <div class="form-row">
                        <div class="col-md-6 mb-2">
                            <input placeholder="Food Name" type="text" class="form-control" name="txtSearchName" value="${param.txtSearchName}" />
                        </div>
                        <div class="col-md-6">
                            <select class="form-control form-control-line" name="txtSearchCategory">
                                <c:set var="listCate" value="${sessionScope.LISTCATE}"/>
                                <c:forEach var="cate" items="${listCate}">
                                    <option value="${cate.id}"
                                            <c:if test="${param.txtSearchCategory eq cate.id}">
                                                selected="selected"
                                            </c:if>>Category : ${cate.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-6 mb-2">
                            <input placeholder="From Price" type="text" class="form-control" name="txtFromPrice" value="${param.txtFromPrice}" />
                        </div>
                        <div class="col-md-6">
                            <input placeholder="To Price" type="text" class="form-control" name="txtToPrice" value="${param.txtToPrice}" />
                        </div>
                    </div> 
                    <div class="form-row">
                        <input class="col-md-12 mt-2 ml-1 btn btn-primary px-5" type="submit" name="btAction" value="Search" />
                    </div>
                </form>

                <c:if test="${not empty search}">
                    <div class="form-row mt-3">
                        <div class="form-row">
                            <p>   Page [ ${param.pageNum} ]: </p>
                            <c:forEach begin="1" end="${requestScope.PAGENUMBER}" varStatus="counter" step="1">
                                <form action="SearchServlet" method="POST">
                                    <input type="hidden" name="txtSearchName" value="${param.txtSearchName}" />
                                    <input type="hidden" name="txtSearchCategory" value="${param.txtSearchCategory}" />
                                    <input type="hidden" name="txtFromPrice" value="${param.txtFromPrice}" />
                                    <input type="hidden" name="txtToPrice" value="${param.txtToPrice}" />
                                    <input type="hidden" name="pageNum" value="${counter.count}" />
                                    <input id="page" class="btn btn-primary ml-2" type="submit" value="${counter.count}"/>
                                </form>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>
            <img class="border rounded mt-3 mr-5" src="img/bg.jpg" width="530" height="320" />
        </div>
        <div class="container mt-5" style="width: 1150px">
            <c:set var="cart" value="${sessionScope.CART}"/>
            <c:if test="${not empty search}">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Food Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Description</th>
                            <th>CreateDate</th>
                            <th>Category</th>
                            <th>Image</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dto" items="${search}" varStatus="counter">
                            <tr>
                                <td>${counter.count} </td>
                                <td>${dto.foodname}</td>
                                <td>${dto.foodprice}</td>
                                <td>${dto.quantity}</td>
                                <td>${dto.description}</td> 
                                <td>${dto.createDate}</td>
                                <td>${dto.getCategoryname(dto.categoriID)}</td>
                                <td>
                                    <img class="border rounded" src="${dto.imageLink}" width="150" height="180"/>
                                </td>
                                <td>
                                    <c:if test="${empty sessionScope.USER || sessionScope.USER.role.name == 'User'}">
                                        <form action="DispatcherController" method="POST">
                                            <input type="hidden" name="foodId" value="${dto.foodId}" />
                                            <input type="hidden" name="txtSearchName" value="${param.txtSearchName}" />
                                            <input type="hidden" name="txtSearchCategory" value="${param.txtSearchCategory}" />
                                            <input type="hidden" name="txtFromPrice" value="${param.txtFromPrice}" />
                                            <input type="hidden" name="txtToPrice" value="${param.txtToPrice}" />
                                            <input type="hidden" name="pageNum" value="${param.page}" />
                                            <input class="btn btn-success" type="submit" name="btAction" value="Add To Cart"/>
                                        </form>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.USER || sessionScope.USER.role.name == 'Admin'}">
                                        <form action="DispatcherController" method="POST">
                                            <input type="hidden" name="foodId" value="${dto.foodId}" />
                                            <input type="hidden" name="txtSearchName" value="${param.txtSearchName}" />
                                            <input type="hidden" name="txtSearchCategory" value="${param.txtSearchCategory}" />
                                            <input type="hidden" name="txtFromPrice" value="${param.txtFromPrice}" />
                                            <input type="hidden" name="txtToPrice" value="${param.txtToPrice}" />
                                            <input type="hidden" name="pageNum" value="${param.page}" />
                                            <a class="btn btn-success" href="DispatcherController?btAction=Edit&ID=${dto.foodId}">Edit</a>
                                            <c:url var="deleteUrl" value="DispatcherController?btAction=Delete">
                                                <c:param name="ID" value="${dto.foodId}"> </c:param>
                                                <c:param name="txtSearchName" value="${param.txtSearchName}"> </c:param>
                                                <c:param name="txtSearchCategory" value="${param.txtSearchCategory}"> </c:param>
                                                <c:param name="txtFromPrice" value="${param.txtFromPrice}"> </c:param>
                                                <c:param name="txtToPrice" value="${param.txtToPrice}"> </c:param>
                                                <c:param name="pageNum" value="${param.page}"> </c:param>
                                            </c:url>
                                            <a class="btn btn-danger" href="${deleteUrl}" onclick="return confirm('Are you sure to Delete Food?');">Delete</a>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${not empty search}">
                    <div class="form-row">
                        <p>   Page (${param.pageNum}) : </p>
                        <c:forEach begin="1" end="${requestScope.PAGENUMBER}" varStatus="counter" step="1">
                            <form action="SearchServlet" method="POST">
                                <input type="hidden" name="txtSearchName" value="${param.txtSearchName}" />
                                <input type="hidden" name="txtSearchCategory" value="${param.txtSearchCategory}" />
                                <input type="hidden" name="txtFromPrice" value="${param.txtFromPrice}" />
                                <input type="hidden" name="txtToPrice" value="${param.txtToPrice}" />
                                <input type="hidden" name="pageNum" value="${counter.count}" />
                                <input id="page" class="btn btn-primary ml-5" type="submit" value="${counter.count}"/>
                            </form>
                        </c:forEach>
                    </div>
                </c:if>
            </c:if>
            <c:if test="${not empty param.txtSearchCategory && empty search}">
                <h5 class="alert alert-danger text-center">Not Found!!!!!</h5>
            </c:if>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
