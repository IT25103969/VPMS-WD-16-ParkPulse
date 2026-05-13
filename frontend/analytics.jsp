<%@ include file="includes/head.jsp" %>
<%@ include file="includes/sidebar.jsp" %>
<main class="flex-1 flex flex-col min-w-0 overflow-hidden">
    <% request.setAttribute("placeholderTitle", "Analytics & Reports"); %>
    <% request.setAttribute("placeholderIcon", "bar-chart-2"); %>
    <%@ include file="includes/placeholder.jsp" %>
</main>
<%@ include file="includes/footer.jsp" %>
