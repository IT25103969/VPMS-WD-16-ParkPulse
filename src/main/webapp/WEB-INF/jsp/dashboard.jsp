<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="common/head.jsp" />
<body class="flex h-screen w-screen overflow-hidden">
    <jsp:include page="common/sidebar.jsp" />

    <div class="flex flex-col flex-1 overflow-hidden">
        <jsp:include page="common/topbar.jsp" />

        <main class="flex-1 overflow-y-auto" style="background: #0f1117; padding: 28px 32px;">
            <!-- Header -->
            <div class="flex items-start justify-between mb-6">
                <div>
                    <h1 class="text-2xl font-bold text-white">Overview Dashboard</h1>
                    <p style="color: #8b95a8; font-size: 14px; margin-top: 2px;">
                        Manage your parking facility with ease.
                    </p>
                </div>
                <button class="flex items-center gap-2 px-4 py-2 rounded-lg transition-all" style="background: #2563eb; color: #fff; border: none; cursor: pointer; font-size: 14px; font-weight: 500;">
                    <i data-lucide="plus-circle" size="16"></i>
                    New Entry
                </button>
            </div>

            <!-- Stats Cards -->
            <div class="grid grid-cols-4 gap-4 mb-6">
                <div class="rounded-xl p-5" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                    <div class="flex items-center justify-center rounded-lg mb-3" style="width: 38px; height: 38px; background: #1e3a8a">
                        <i data-lucide="parking-square" size="18" color="#60a5fa"></i>
                    </div>
                    <p style="color: #8b95a8; font-size: 13px; margin-bottom: 4px;">Total Slots</p>
                    <p style="color: #fff; font-size: 22px; font-weight: 700;">34</p>
                </div>
                <div class="rounded-xl p-5" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                    <div class="flex items-center justify-center rounded-lg mb-3" style="width: 38px; height: 38px; background: #7c2d12">
                        <i data-lucide="users" size="18" color="#fb923c"></i>
                    </div>
                    <p style="color: #8b95a8; font-size: 13px; margin-bottom: 4px;">Occupied</p>
                    <p style="color: #fff; font-size: 22px; font-weight: 700;">0 / 34</p>
                </div>
                <div class="rounded-xl p-5" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                    <div class="flex items-center justify-center rounded-lg mb-3" style="width: 38px; height: 38px; background: #14532d">
                        <i data-lucide="dollar-sign" size="18" color="#4ade80"></i>
                    </div>
                    <p style="color: #8b95a8; font-size: 13px; margin-bottom: 4px;">Daily Revenue</p>
                    <p style="color: #fff; font-size: 22px; font-weight: 700;">$20.00</p>
                </div>
                <div class="rounded-xl p-5" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                    <div class="flex items-center justify-center rounded-lg mb-3" style="width: 38px; height: 38px; background: #4c1d95">
                        <i data-lucide="clock" size="18" color="#c084fc"></i>
                    </div>
                    <p style="color: #8b95a8; font-size: 13px; margin-bottom: 4px;">Hourly Rate</p>
                    <p style="color: #fff; font-size: 22px; font-weight: 700;">$10.00</p>
                </div>
            </div>

            <!-- Bottom Row -->
            <div class="grid gap-4" style="grid-template-columns: 1fr 340px;">
                <!-- Live Parking Map -->
                <div class="rounded-xl p-5" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                    <h3 class="text-white font-semibold mb-4">Live Parking Map</h3>
                    <div class="flex flex-wrap gap-2">
                        <c:forEach var="i" begin="1" end="34">
                            <div class="flex items-center justify-center rounded-lg cursor-pointer transition-all hover:opacity-80" style="width: 52px; height: 36px; background: #22c55e; color: #fff; font-size: 12px; font-weight: 600;">
                                A${i}
                            </div>
                        </c:forEach>
                    </div>
                    <div class="flex items-center gap-4 mt-4">
                        <div class="flex items-center gap-1.5">
                            <div class="rounded" style="width: 12px; height: 12px; background: #22c55e"></div>
                            <span style="color: #8b95a8; font-size: 12px;">Available</span>
                        </div>
                        <div class="flex items-center gap-1.5">
                            <div class="rounded" style="width: 12px; height: 12px; background: #ef4444"></div>
                            <span style="color: #8b95a8; font-size: 12px;">Occupied</span>
                        </div>
                    </div>
                </div>

                <!-- Live Entry Feed -->
                <div class="rounded-xl p-5" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                    <h3 class="text-white font-semibold mb-4">Live Entry Feed</h3>
                    <div class="flex items-center justify-center rounded-lg" style="background: rgba(255,255,255,0.03); height: 120px; color: #8b95a8; font-size: 14px;">
                        No active sessions
                    </div>
                    <div class="mt-4">
                        <p style="color: #8b95a8; font-size: 12px;">Recent Activity</p>
                        <div class="mt-2 space-y-2">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center gap-2">
                                    <div class="rounded-full" style="width: 8px; height: 8px; background: #22c55e"></div>
                                    <span style="color: #fff; font-size: 13px;">Slot A5</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <span style="color: #4ade80; font-size: 11px; padding: 1px 6px; background: rgba(34,197,94,0.15); border-radius: 4px;">Entry</span>
                                    <span style="color: #8b95a8; font-size: 12px;">09:15 AM</span>
                                </div>
                            </div>
                            <div class="flex items-center justify-between">
                                <div class="flex items-center gap-2">
                                    <div class="rounded-full" style="width: 8px; height: 8px; background: #ef4444"></div>
                                    <span style="color: #fff; font-size: 13px;">Slot A12</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <span style="color: #f87171; font-size: 11px; padding: 1px 6px; background: rgba(239,68,68,0.15); border-radius: 4px;">Exit</span>
                                    <span style="color: #8b95a8; font-size: 12px;">08:42 AM</span>
                                </div>
                            </div>
                            <div class="flex items-center justify-between">
                                <div class="flex items-center gap-2">
                                    <div class="rounded-full" style="width: 8px; height: 8px; background: #22c55e"></div>
                                    <span style="color: #fff; font-size: 13px;">Slot A3</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <span style="color: #4ade80; font-size: 11px; padding: 1px 6px; background: rgba(34,197,94,0.15); border-radius: 4px;">Entry</span>
                                    <span style="color: #8b95a8; font-size: 12px;">08:10 AM</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <script>
        lucide.createIcons();
    </script>
</body>
</html>
