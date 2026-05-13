<%@ include file="includes/head.jsp" %>
<%@ include file="includes/sidebar.jsp" %>
<main class="flex-1 flex flex-col min-w-0 overflow-hidden">
    <% request.setAttribute("placeholderTitle", "System Settings"); %>
    <% request.setAttribute("placeholderIcon", "settings"); %>
    <%@ include file="includes/placeholder.jsp" %>
</main>
<%@ include file="includes/footer.jsp" %>
