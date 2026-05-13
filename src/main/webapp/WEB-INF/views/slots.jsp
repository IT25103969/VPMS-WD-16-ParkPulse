<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<div class="flex h-screen overflow-hidden">
    <%@ include file="sidebar.jsp" %>
    
    <main class="flex-1 overflow-y-auto">
        <div class="p-8">
            <div class="flex items-center justify-between mb-6 gap-4 flex-wrap">
                <div>
                    <h1 class="text-primary text-2xl font-semibold">Parking Slots</h1>
                    <p class="text-sm text-muted">Create and manage zones and individual slots.</p>
                </div>
                <div class="flex items-center gap-3 flex-wrap">
                    <div class="relative">
                        <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 size-4 pointer-events-none text-muted"></i>
                        <input
                            type="text"
                            placeholder="Search by plate…"
                            class="pl-9 py-2 rounded-full border border-border bg-background text-sm w-48 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:w-56 transition-all dark:bg-[#0b1220] dark:border-[#1f2a44]"
                        />
                    </div>
                    <button onclick="openZoneModal()" class="flex items-center gap-2 px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-full transition-colors shadow-lg">
                        <i data-lucide="plus" class="size-4"></i>
                        <span class="text-sm">New Zone</span>
                    </button>
                </div>
            </div>

            <div class="rounded-2xl border border-border card-bg p-6">
                <div class="flex items-center justify-between mb-5 flex-wrap gap-3">
                    <h2 class="text-primary text-xl font-semibold">Slot Management</h2>
                    <div class="flex gap-2 flex-wrap" id="zone-tabs">
                        <c:forEach var="zone" items="${zones}">
                            <div class="group flex items-center rounded-lg overflow-hidden transition-colors ${activeZoneId eq zone.id ? 'bg-blue-600' : 'bg-gray-100 dark:bg-[#1a2540] hover:bg-gray-200 dark:hover:bg-[#243154]'}">
                                <a href="/slots?zoneId=${zone.id}" class="px-3 py-1.5 text-sm flex items-center gap-1.5 ${activeZoneId eq zone.id ? 'text-white' : 'text-gray-700 dark:text-gray-300'}">
                                    ${zone.name}
                                    <span class="text-xs px-1.5 py-0.5 rounded-md font-medium ${activeZoneId eq zone.id ? 'bg-white/20 text-white' : 'bg-blue-100 text-blue-600 dark:bg-blue-500/20 dark:text-blue-400'}">
                                        $${zone.pricePerHour}/h
                                    </span>
                                </a>
                                <button onclick="editZone('${zone.id}')" class="px-1.5 py-1.5 ${activeZoneId eq zone.id ? 'text-white/70 hover:text-white' : 'opacity-0 group-hover:opacity-100 text-blue-500'} transition-opacity" title="Edit zone">
                                    <i data-lucide="pencil" class="size-3.5"></i>
                                </button>
                                <form action="/action" method="POST" class="inline">
                                    <input type="hidden" name="action" value="delete_zone">
                                    <input type="hidden" name="zoneId" value="${zone.id}">
                                    <button type="submit" class="px-2 py-1.5 ${activeZoneId eq zone.id ? 'text-white/70 hover:text-white' : 'opacity-0 group-hover:opacity-100 text-red-500'} transition-opacity" title="Delete zone">
                                        <i data-lucide="trash-2" class="size-3.5"></i>
                                    </button>
                                </form>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="flex gap-4 text-xs mb-4 flex-wrap">
                    <div class="flex items-center gap-1.5"><span class="size-3 rounded-sm inline-block bg-emerald-500"></span><span class="text-muted">Available</span></div>
                    <div class="flex items-center gap-1.5"><span class="size-3 rounded-sm inline-block bg-red-500"></span><span class="text-muted">Occupied</span></div>
                    <div class="flex items-center gap-1.5"><span class="size-3 rounded-sm inline-block bg-amber-400"></span><span class="text-muted">Reserved</span></div>
                    <div class="flex items-center gap-1.5"><span class="size-3 rounded-sm inline-block bg-orange-400"></span><span class="text-muted">Maintenance</span></div>
                </div>

                <c:forEach var="zone" items="${zones}">
                    <c:if test="${zone.id eq activeZoneId}">
                        <div class="flex items-center gap-3 flex-wrap mb-4 px-4 py-3 rounded-xl border border-blue-100 bg-blue-50 text-blue-700 dark:bg-blue-500/10 dark:border-blue-500/20 dark:text-blue-300 text-xs">
                            <span class="flex items-center gap-1.5 font-medium"><i data-lucide="dollar-sign" class="size-3.5"></i>$${zone.pricePerHour} / hour</span>
                            <span class="flex items-center gap-1.5"><i data-lucide="tag" class="size-3.5"></i>
                                <c:forEach var="type" items="${zone.allowedVehicleTypes}" varStatus="loop">
                                    ${type}${!loop.last ? ' · ' : ''}
                                </c:forEach>
                            </span>
                        </div>
                    </c:if>
                </c:forEach>

                <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-4">
                    <c:forEach var="slot" items="${slots}">
                        <c:if test="${slot.zoneId eq activeZoneId}">
                            <div class="relative group">
                                <button onclick="handleSlotClick('${slot.id}')" class="w-full h-24 rounded-2xl flex flex-col items-center justify-center text-white shadow-md transition-transform hover:scale-105 
                                    ${slot.status eq 'occupied' ? 'bg-gradient-to-b from-red-500 to-red-600' : 
                                      slot.status eq 'reserved' ? 'bg-gradient-to-b from-amber-400 to-amber-500' : 
                                      slot.status eq 'maintenance' ? 'bg-gradient-to-b from-orange-400 to-orange-500' : 
                                      'bg-gradient-to-b from-emerald-500 to-emerald-600'}">
                                    <c:choose>
                                        <c:when test="${slot.status eq 'occupied'}">
                                            <i data-lucide="car" class="size-5 mb-0.5"></i>
                                            <span class="text-xs font-semibold tracking-wide">${slot.number}</span>
                                        </c:when>
                                        <c:when test="${slot.status eq 'reserved'}">
                                            <i data-lucide="bookmark" class="size-5 mb-0.5"></i>
                                            <span class="text-xs font-semibold tracking-wide">RESERVED</span>
                                        </c:when>
                                        <c:when test="${slot.status eq 'maintenance'}">
                                            <i data-lucide="wrench" class="size-5 mb-0.5"></i>
                                            <span class="text-xs font-semibold tracking-wide">MAINT.</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span>${slot.number}</span>
                                            <span class="text-xs mt-0.5 opacity-90">FREE</span>
                                        </c:otherwise>
                                    </c:choose>
                                </button>
                                <form action="/action" method="POST" class="absolute -top-2 -right-2">
                                    <input type="hidden" name="action" value="delete_slot">
                                    <input type="hidden" name="slotId" value="${slot.id}">
                                    <button type="submit" class="size-6 rounded-full bg-gray-900 text-white opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center shadow-lg hover:bg-red-600" title="Delete slot">
                                        <i data-lucide="x" class="size-3"></i>
                                    </button>
                                </form>
                            </div>
                        </c:if>
                    </c:forEach>

                    <form action="/action" method="POST" class="h-24">
                        <input type="hidden" name="action" value="add_slot">
                        <input type="hidden" name="zoneId" value="${activeZoneId}">
                        <button type="submit" class="w-full h-full rounded-2xl border-2 border-dashed border-gray-300 text-gray-400 hover:border-blue-500 hover:text-blue-500 dark:border-[#1f2a44] dark:text-gray-500 dark:hover:border-blue-500 dark:hover:text-blue-500 flex flex-col items-center justify-center transition-colors">
                            <i data-lucide="plus" class="size-6 mb-1"></i>
                            <span class="text-xs">Add Slot</span>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </main>
</div>
<%@ include file="modals.jsp" %>
<script>
    const zones = ${zonesJson};
    const slots = ${slotsJson};

    window.handleSlotClick = (id) => {
        const slot = slots.find(s => s.id === id);
        openActionModal(slot);
    };

    window.editZone = (id) => {
        const zone = zones.find(z => z.id === id);
        openZoneModal(zone);
    };

    document.addEventListener('DOMContentLoaded', () => { lucide.createIcons(); });
</script>
</body>
</html>
