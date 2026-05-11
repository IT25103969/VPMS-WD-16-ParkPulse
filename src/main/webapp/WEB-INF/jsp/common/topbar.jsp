<header class="flex items-center justify-between px-7 flex-shrink-0" style="background: #161b27; border-bottom: 1px solid rgba(255,255,255,0.06); height: 58px;">
    <div class="flex items-center gap-2">
        <span style="color: #8b95a8; font-size: 13px;">ParkPulse</span>
        <span style="color: #3f4a5c; font-size: 13px;">/</span>
        <span style="color: #fff; font-size: 13px; font-weight: 500;">
            <c:choose>
                <c:when test="${activePage == 'dashboard'}">Dashboard Overview</c:when>
                <c:when test="${activePage == 'staff'}">Staff Management</c:when>
                <c:otherwise>ParkPulse</c:otherwise>
            </c:choose>
            <c:if test="${not empty title}">
                <span style="color: #3f4a5c; font-size: 13px;"> / </span>
                ${title}
            </c:if>
        </span>
    </div>
    <div class="flex items-center justify-center rounded-full" style="width: 32px; height: 32px; background: #2563eb; color: #fff; font-size: 12px; font-weight: 700;">
        AD
    </div>
</header>
