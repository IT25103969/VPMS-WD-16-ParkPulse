<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../common/head.jsp" />
<body class="flex h-screen w-screen overflow-hidden">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex flex-col flex-1 overflow-hidden">
        <jsp:include page="../common/topbar.jsp" />

        <main class="flex-1 overflow-y-auto" style="background: #0f1117; padding: 32px;">
            <div class="max-w-4xl mx-auto">
                <!-- Back Button -->
                <a href="/staff" class="flex items-center gap-2 text-[#8b95a8] hover:text-white transition-all mb-6 w-fit">
                    <i data-lucide="arrow-left" size="20"></i>
                    <span>Back to Staff List</span>
                </a>

                <div class="rounded-xl overflow-hidden" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                    <!-- Profile Header -->
                    <div class="p-8 flex items-start gap-6" style="border-bottom: 1px solid rgba(255,255,255,0.06)">
                        <div class="w-24 h-24 rounded-full flex items-center justify-center text-3xl font-bold text-white shadow-xl" style="background: #2563eb;">
                            ${staff.name.substring(0,1)}${staff.name.contains(' ') ? staff.name.split(' ')[1].substring(0,1) : ''}
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center justify-between">
                                <div>
                                    <h1 class="text-3xl font-bold text-white">${staff.name}</h1>
                                    <p class="text-[#8b95a8] text-lg mt-1">${staff.role}</p>
                                </div>
                                <div class="flex gap-3">
                                    <a href="/staff/edit/${staff.id}" class="flex items-center gap-2 px-4 py-2 rounded-lg bg-[rgba(37,99,235,0.15)] text-[#60a5fa] border border-[rgba(37,99,235,0.3)] hover:bg-[rgba(37,99,235,0.25)] transition-all">
                                        <i data-lucide="pencil" size="18"></i>
                                        <span>Edit Profile</span>
                                    </a>
                                    <a href="/staff/delete/${staff.id}" onclick="return confirm('Are you sure?')" class="flex items-center gap-2 px-4 py-2 rounded-lg bg-[rgba(239,68,68,0.15)] text-[#f87171] border border-[rgba(239,68,68,0.3)] hover:bg-[rgba(239,68,68,0.25)] transition-all">
                                        <i data-lucide="trash-2" size="18"></i>
                                        <span>Delete</span>
                                    </a>
                                </div>
                            </div>
                            <div class="flex items-center gap-4 mt-4">
                                <span class="px-3 py-1 rounded-full text-xs font-semibold ${staff.status == 'Active' ? 'bg-[rgba(34,197,94,0.15)] text-[#4ade80]' : 'bg-[rgba(239,68,68,0.15)] text-[#f87171]'}">
                                    ${staff.status}
                                </span>
                                <div class="flex items-center gap-2 text-[#8b95a8] text-sm">
                                    <i data-lucide="calendar" size="14"></i>
                                    <span>Joined ${staff.joinDate}</span>
                                </div>
                                <div class="flex items-center gap-2 text-[#8b95a8] text-sm">
                                    <i data-lucide="clock" size="14"></i>
                                    <span>${staff.shift}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Details Grid -->
                    <div class="grid grid-cols-2 gap-px bg-[rgba(255,255,255,0.06)]">
                        <!-- Contact Details -->
                        <div class="p-8 bg-[#1a2035]">
                            <h3 class="text-white font-semibold mb-6 flex items-center gap-2">
                                <i data-lucide="phone" size="18" class="text-[#2563eb]"></i>
                                Contact Details
                            </h3>
                            <div class="space-y-6">
                                <div>
                                    <p class="text-[#8b95a8] text-xs uppercase tracking-wider mb-1">Email Address</p>
                                    <p class="text-white font-medium">${staff.email}</p>
                                </div>
                                <div>
                                    <p class="text-[#8b95a8] text-xs uppercase tracking-wider mb-1">Phone Number</p>
                                    <p class="text-white font-medium">${staff.phone}</p>
                                </div>
                                <div>
                                    <p class="text-[#8b95a8] text-xs uppercase tracking-wider mb-1">Home Address</p>
                                    <p class="text-white font-medium">${staff.address}</p>
                                </div>
                            </div>
                        </div>

                        <!-- Vehicle & Other Details -->
                        <div class="p-8 bg-[#1a2035]">
                            <h3 class="text-white font-semibold mb-6 flex items-center gap-2">
                                <i data-lucide="car" size="18" class="text-[#2563eb]"></i>
                                Vehicle Information
                            </h3>
                            <div class="space-y-6">
                                <div>
                                    <p class="text-[#8b95a8] text-xs uppercase tracking-wider mb-1">Vehicle Number</p>
                                    <p class="text-white font-medium">${staff.vehicleNumber != null ? staff.vehicleNumber : 'Not registered'}</p>
                                </div>
                                <div>
                                    <p class="text-[#8b95a8] text-xs uppercase tracking-wider mb-1">Vehicle Type</p>
                                    <p class="text-white font-medium">${staff.vehicleType != null ? staff.vehicleType : 'N/A'}</p>
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
