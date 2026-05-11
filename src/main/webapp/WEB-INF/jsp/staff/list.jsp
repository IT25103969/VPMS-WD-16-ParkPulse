<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../common/head.jsp" />
<body class="flex h-screen w-screen overflow-hidden">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex flex-col flex-1 overflow-hidden">
        <jsp:include page="../common/topbar.jsp" />

        <main class="flex-1 overflow-y-auto" style="background: #0f1117; padding: 28px 32px;">
            <!-- Header -->
            <div class="flex items-start justify-between mb-6">
                <div>
                    <h1 class="text-2xl font-bold text-white">Staff Management</h1>
                    <p style="color: #8b95a8; font-size: 14px; margin-top: 2px;">
                        Manage your parking facility staff members.
                    </p>
                </div>
                <a href="/staff/add" class="flex items-center gap-2 px-4 py-2 rounded-lg transition-all" style="background: #2563eb; color: #fff; font-size: 14px; font-weight: 500;">
                    <i data-lucide="plus-circle" size="16"></i>
                    Add Staff
                </a>
            </div>

            <!-- Stats Cards -->
            <div class="grid grid-cols-4 gap-4 mb-6">
                <div class="rounded-xl p-5" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                    <div class="flex items-center justify-center rounded-lg mb-3" style="width: 38px; height: 38px; background: #1e3a8a">
                        <i data-lucide="users" size="18" color="#60a5fa"></i>
                    </div>
                    <p style="color: #8b95a8; font-size: 13px; margin-bottom: 4px;">Total Staff</p>
                    <p style="color: #fff; font-size: 22px; font-weight: 700;">${totalCount}</p>
                </div>
                <div class="rounded-xl p-5" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                    <div class="flex items-center justify-center rounded-lg mb-3" style="width: 38px; height: 38px; background: #14532d">
                        <i data-lucide="user-check" size="18" color="#4ade80"></i>
                    </div>
                    <p style="color: #8b95a8; font-size: 13px; margin-bottom: 4px;">Active Now</p>
                    <p style="color: #fff; font-size: 22px; font-weight: 700;">${activeCount}</p>
                </div>
                <div class="rounded-xl p-5" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                    <div class="flex items-center justify-center rounded-lg mb-3" style="width: 38px; height: 38px; background: #7c2d12">
                        <i data-lucide="user-x" size="18" color="#fb923c"></i>
                    </div>
                    <p style="color: #8b95a8; font-size: 13px; margin-bottom: 4px;">Off Duty</p>
                    <p style="color: #fff; font-size: 22px; font-weight: 700;">${offDutyCount}</p>
                </div>
                <div class="rounded-xl p-5" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                    <div class="flex items-center justify-center rounded-lg mb-3" style="width: 38px; height: 38px; background: #4c1d95">
                        <i data-lucide="clock" size="18" color="#c084fc"></i>
                    </div>
                    <p style="color: #8b95a8; font-size: 13px; margin-bottom: 4px;">Avg Shift Hrs</p>
                    <p style="color: #fff; font-size: 22px; font-weight: 700;">8h</p>
                </div>
            </div>

            <!-- Staff List Panel -->
            <div class="rounded-xl flex-1" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06); overflow: hidden;">
                <!-- Panel header -->
                <div class="flex items-center justify-between px-5 py-4" style="border-bottom: 1px solid rgba(255,255,255,0.06)">
                    <div class="flex items-center gap-3">
                        <h3 class="text-lg font-semibold text-white">Staff List</h3>
                        <div class="flex items-center gap-1" style="background: rgba(255,255,255,0.05); border-radius: 8px; padding: 3px">
                            <a href="/staff?tab=all&search=${search}" class="px-[10px] py-[3px] rounded-[6px] text-[12px] transition-all ${activeTab == 'all' ? 'bg-[#2563eb] text-white font-semibold' : 'text-[#8b95a8]'}">All</a>
                            <a href="/staff?tab=active&search=${search}" class="px-[10px] py-[3px] rounded-[6px] text-[12px] transition-all ${activeTab == 'active' ? 'bg-[#2563eb] text-white font-semibold' : 'text-[#8b95a8]'}">Active</a>
                            <a href="/staff?tab=offduty&search=${search}" class="px-[10px] py-[3px] rounded-[6px] text-[12px] transition-all ${activeTab == 'offduty' ? 'bg-[#2563eb] text-white font-semibold' : 'text-[#8b95a8]'}">Off Duty</a>
                        </div>
                    </div>
                    <div class="flex items-center gap-2 px-3 py-2 rounded-lg" style="background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.08)">
                        <i data-lucide="search" size="13" color="#8b95a8"></i>
                        <form id="searchForm" action="/staff" method="GET" class="flex items-center">
                            <input type="hidden" name="tab" value="${activeTab}">
                            <input type="text" id="searchInput" name="search" placeholder="Search staff..." value="${search}" class="bg-transparent border-none outline-none text-white text-[13px] w-[140px]">
                        </form>
                    </div>
                </div>

                <!-- Staff cards grid -->
                <div class="p-4" id="staffGridContainer">
                    <c:choose>
                        <c:when test="${empty staffList}">
                            <div class="flex flex-col items-center justify-center rounded-xl" style="height: 200px; color: #8b95a8; font-size: 14px">
                                <i data-lucide="users" size="32" style="margin-bottom: 10px; opacity: 0.4"></i>
                                ${not empty search ? 'No staff matching your search.' : 'No staff members yet.'}
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="grid gap-3" style="grid-template-columns: repeat(auto-fill, minmax(220px, 1fr))">
                                <c:forEach var="staff" items="${staffList}">
                                    <div class="staff-card rounded-xl p-4 flex flex-col gap-3 group transition-all" 
                                         data-name="${staff.name.toLowerCase()}" 
                                         data-role="${staff.role.toLowerCase()}"
                                         style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.07);">
                                        <div class="flex items-start gap-3">
                                            <div class="flex items-center justify-center rounded-full flex-shrink-0 w-10 h-10 text-white font-bold text-sm" style="background: #2563eb;">
                                                ${staff.name.substring(0,1)}${staff.name.contains(' ') ? staff.name.split(' ')[1].substring(0,1) : ''}
                                            </div>
                                            <div class="flex-1 min-w-0">
                                                <a href="/staff/${staff.id}" class="text-white text-sm font-semibold truncate leading-tight hover:underline">${staff.name}</a>
                                                <p class="text-[#8b95a8] text-xs">${staff.role}</p>
                                            </div>
                                            <span class="px-2 py-[2px] rounded-full text-[11px] font-semibold whitespace-nowrap ${staff.status == 'Active' ? 'bg-[rgba(34,197,94,0.15)] text-[#4ade80]' : 'bg-[rgba(239,68,68,0.15)] text-[#f87171]'}">
                                                ${staff.status}
                                            </span>
                                        </div>

                                        <div class="space-y-1.5">
                                            <div class="flex items-center gap-2">
                                                <i data-lucide="clock" size="11" color="#8b95a8"></i>
                                                <span class="text-[#8b95a8] text-[11px]">${staff.shift}</span>
                                            </div>
                                            <div class="flex items-center gap-2">
                                                <i data-lucide="mail" size="11" color="#8b95a8"></i>
                                                <span class="text-[#8b95a8] text-[11px] truncate">${staff.email}</span>
                                            </div>
                                            <div class="flex items-center gap-2">
                                                <i data-lucide="phone" size="11" color="#8b95a8"></i>
                                                <span class="text-[#8b95a8] text-[11px]">${staff.phone}</span>
                                            </div>
                                            <div class="flex items-center gap-2">
                                                <i data-lucide="calendar" size="11" color="#8b95a8"></i>
                                                <span class="text-[#8b95a8] text-[11px]">Joined ${staff.joinDate}</span>
                                            </div>
                                        </div>

                                        <div class="pt-[10px]" style="border-top: 1px solid rgba(255,255,255,0.06)">
                                            <div class="flex items-center gap-2">
                                                <a href="/staff/edit/${staff.id}" class="flex items-center gap-1.5 px-3 py-1.5 rounded-lg flex-1 justify-center transition-all bg-[rgba(37,99,235,0.15)] text-[#60a5fa] border border-[rgba(37,99,235,0.3)] hover:bg-[rgba(37,99,235,0.25)] text-xs">
                                                    <i data-lucide="pencil" size="11"></i> Edit
                                                </a>
                                                <a href="/staff/delete/${staff.id}" onclick="return confirm('Are you sure you want to delete this staff member?')" class="flex items-center gap-1.5 px-3 py-1.5 rounded-lg flex-1 justify-center transition-all bg-[rgba(239,68,68,0.15)] text-[#f87171] border border-[rgba(239,68,68,0.3)] hover:bg-[rgba(239,68,68,0.25)] text-xs">
                                                    <i data-lucide="trash-2" size="11"></i> Delete
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>
    <script>
        lucide.createIcons();

        // Client-side live search for immediate feedback
        const searchInput = document.getElementById('searchInput');
        const staffCards = document.querySelectorAll('.staff-card');

        searchInput.addEventListener('input', (e) => {
            const query = e.target.value.toLowerCase();
            staffCards.forEach(card => {
                const name = card.getAttribute('data-name');
                const role = card.getAttribute('data-role');
                if (name.includes(query) || role.includes(query)) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });
        });

        // Submit form on enter (default behavior) but we also want to keep server-side sync
        searchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                document.getElementById('searchForm').submit();
            }
        });
    </script>
</body>
</html>
