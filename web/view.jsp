<%-- 
    Document   : viewCart
    Created on : Jun 20, 2020, 1:11:04 PM
    Author     : USER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    </head>
    <body>
        <jsp:include page="navbar.jsp"/>
        <div class="container">
            <h1>Your Cart Includes</h1>
            <div class="form-row mb-2">
                <div class="col-md-3">
                    <a href="search" class="btn btn-primary">Add More Items To Cart</a>
                </div>
            </div>

            <c:set var="cart" value="${sessionScope.CART}"></c:set>
            <c:set var="mapTravelTour" value="${cart.travelTour}"></c:set>
            <c:set var="confirmError" value="${requestScope.CONFIRM_ERROR}"/>
            <c:if test="${not empty confirmError}">
                <p class="alert alert-danger">
                    <c:forEach var="item" items="${confirmError}">
                        <font color="red">${item}<br/></font>
                    </c:forEach>
                </p>
            </c:if>

            <c:if test="${not empty cart}">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>TourName</th>
                            <th>Price</th>
                            <th>FromDate</th>
                            <th>ToDate</th>
                            <th>ImageLink</th>
                            <th>Amount</th>
                            <th>Total</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cart.items}" varStatus="counter" >
                        <form action="updateTour" >
                            <tr>
                                <c:set var="foodId" value="${item.key}"/>
                                <c:set var="amount" value="${item.value}"></c:set>
                                <c:set var="travelTourDTO" value="${mapTravelTour.get(tourId)}" ></c:set>
                                <td>${counter.count}</td>
                                <td>${travelTourDTO.tourName}</td>
                                <td>${cart.getPriceDisplay(tourId)}</td>
                                <td>${travelTourDTO.fromDate}</td>
                                <td>${travelTourDTO.toDate}</td>
                                <td><img src="${travelTourDTO.imageLink}" width="150"/></td> 
                                <td><input class="form-control" type="text" name="txtAmount" value="${amount}" /></td>
                                <td>${cart.getPriceOfEachItemDisplay(tourId)}</td>
                                <td>
                                    <input type="hidden" name="txtTourId" value="${tourId}" />
                                    <input class="btn btn-info" type="submit" value="Update" />
                                </td>
                                <td>
                                    <c:url var="deleteUrl" value="deleteTour">
                                        <c:param name="txtTourId" value="${tourId}"> </c:param>
                                    </c:url>
                                    <a class="btn btn-danger" href="${deleteUrl}" onclick="return confirm('Are you sure to remove item?');">Delete</a>
                                </td>
                            </tr>
                        </form>
                    </c:forEach>
                    <tr>
                        <td colspan="5"></td>
                        <td> Discount Percent: ${cart.discountPercent} (%)</td>
                        <td>- ${cart.discountValueDisplay}</td>
                        <td>Total Price: ${cart.totalPriceDisplay}</td>
                        <td colspan="2">                    
                            <form action="confirm-booking" method="GET">
                                <input class="btn btn-success" type="submit" value="Confirm Booking" onclick="return confirm('Are you sure to continue?');"/>         
                            </form> 
                        </td>
                    </tr>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty cart}">
                <h2>Cart does not exist</h2>
            </c:if>
        </div>
    </body>
    <c:if test="${not empty cart}">
        <jsp:include page="footer.jsp"/>
    </c:if>
    
</html>
