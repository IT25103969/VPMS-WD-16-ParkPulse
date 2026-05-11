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
                <div class="flex items-center justify-between mb-8">
                    <div>
                        <h1 class="text-2xl font-bold text-white">${staff.id == null ? 'Add New Staff member' : 'Edit Staff Member'}</h1>
                        <p class="text-[#8b95a8] text-sm mt-1">Fill in the details below to ${staff.id == null ? 'register a new staff member' : 'update staff information'}.</p>
                    </div>
                    <a href="/staff" class="text-[#8b95a8] hover:text-white transition-all">
                        <i data-lucide="x" size="24"></i>
                    </a>
                </div>

                <form action="/staff/save" method="POST" class="space-y-6">
                    <input type="hidden" name="id" value="${staff.id}">
                    
                    <div class="grid grid-cols-2 gap-6">
                        <!-- Personal Info -->
                        <div class="space-y-4 rounded-xl p-6" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                            <h3 class="text-white font-semibold flex items-center gap-2 mb-4">
                                <i data-lucide="user" size="18" class="text-[#2563eb]"></i>
                                Personal Information
                            </h3>
                            
                            <div class="space-y-2">
                                <label class="text-[#8b95a8] text-xs font-medium uppercase tracking-wider">Full Name</label>
                                <input type="text" name="name" value="${staff.name}" required placeholder="e.g. Marcus Johnson" class="w-full bg-[#0f1117] border border-[rgba(255,255,255,0.1)] rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-[#2563eb] transition-all">
                            </div>

                            <div class="space-y-2">
                                <label class="text-[#8b95a8] text-xs font-medium uppercase tracking-wider">Role / Position</label>
                                <input type="text" name="role" value="${staff.role}" required placeholder="e.g. Manager" class="w-full bg-[#0f1117] border border-[rgba(255,255,255,0.1)] rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-[#2563eb] transition-all">
                            </div>

                            <div class="grid grid-cols-2 gap-4">
                                <div class="space-y-2">
                                    <label class="text-[#8b95a8] text-xs font-medium uppercase tracking-wider">Shift</label>
                                    <select name="shift" class="w-full bg-[#0f1117] border border-[rgba(255,255,255,0.1)] rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-[#2563eb] transition-all">
                                        <option value="Morning (6AM-2PM)" ${staff.shift == 'Morning (6AM-2PM)' ? 'selected' : ''}>Morning</option>
                                        <option value="Afternoon (2PM-10PM)" ${staff.shift == 'Afternoon (2PM-10PM)' ? 'selected' : ''}>Afternoon</option>
                                        <option value="Night (10PM-6AM)" ${staff.shift == 'Night (10PM-6AM)' ? 'selected' : ''}>Night</option>
                                    </select>
                                </div>
                                <div class="space-y-2">
                                    <label class="text-[#8b95a8] text-xs font-medium uppercase tracking-wider">Status</label>
                                    <select name="status" class="w-full bg-[#0f1117] border border-[rgba(255,255,255,0.1)] rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-[#2563eb] transition-all">
                                        <option value="Active" ${staff.status == 'Active' ? 'selected' : ''}>Active</option>
                                        <option value="Off Duty" ${staff.status == 'Off Duty' ? 'selected' : ''}>Off Duty</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Contact Info -->
                        <div class="space-y-4 rounded-xl p-6" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                            <h3 class="text-white font-semibold flex items-center gap-2 mb-4">
                                <i data-lucide="phone" size="18" class="text-[#2563eb]"></i>
                                Contact Information
                            </h3>

                            <div class="space-y-2">
                                <label class="text-[#8b95a8] text-xs font-medium uppercase tracking-wider">Email Address</label>
                                <input type="email" name="email" value="${staff.email}" required placeholder="name@example.com" class="w-full bg-[#0f1117] border border-[rgba(255,255,255,0.1)] rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-[#2563eb] transition-all">
                            </div>

                            <div class="space-y-2">
                                <label class="text-[#8b95a8] text-xs font-medium uppercase tracking-wider">Phone Number</label>
                                <input type="text" name="phone" value="${staff.phone}" required placeholder="+1 (555) 000-0000" class="w-full bg-[#0f1117] border border-[rgba(255,255,255,0.1)] rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-[#2563eb] transition-all">
                            </div>

                            <div class="space-y-2">
                                <label class="text-[#8b95a8] text-xs font-medium uppercase tracking-wider">Joining Date</label>
                                <input type="date" name="joinDate" value="${staff.joinDate}" required class="w-full bg-[#0f1117] border border-[rgba(255,255,255,0.1)] rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-[#2563eb] transition-all">
                            </div>
                        </div>
                    </div>

                    <div class="grid grid-cols-2 gap-6">
                        <!-- Additional Details -->
                        <div class="space-y-4 rounded-xl p-6 col-span-2" style="background: #1a2035; border: 1px solid rgba(255,255,255,0.06)">
                            <h3 class="text-white font-semibold flex items-center gap-2 mb-4">
                                <i data-lucide="map-pin" size="18" class="text-[#2563eb]"></i>
                                Additional Details
                            </h3>

                            <div class="grid grid-cols-2 gap-6">
                                <div class="space-y-2">
                                    <label class="text-[#8b95a8] text-xs font-medium uppercase tracking-wider">Home Address</label>
                                    <textarea name="address" rows="3" required placeholder="Full street address" class="w-full bg-[#0f1117] border border-[rgba(255,255,255,0.1)] rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-[#2563eb] transition-all">${staff.address}</textarea>
                                </div>
                                <div class="space-y-4">
                                    <div class="space-y-2">
                                        <label class="text-[#8b95a8] text-xs font-medium uppercase tracking-wider">Vehicle Number</label>
                                        <input type="text" name="vehicleNumber" value="${staff.vehicleNumber}" placeholder="e.g. TX-4521" class="w-full bg-[#0f1117] border border-[rgba(255,255,255,0.1)] rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-[#2563eb] transition-all">
                                    </div>
                                    <div class="space-y-2">
                                        <label class="text-[#8b95a8] text-xs font-medium uppercase tracking-wider">Vehicle Type</label>
                                        <input type="text" name="vehicleType" value="${staff.vehicleType}" placeholder="e.g. Sedan" class="w-full bg-[#0f1117] border border-[rgba(255,255,255,0.1)] rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-[#2563eb] transition-all">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="flex items-center justify-end gap-4 pt-4">
                        <a href="/staff" class="px-6 py-2.5 rounded-lg text-white font-medium transition-all hover:bg-[rgba(255,255,255,0.05)]">Cancel</a>
                        <button type="submit" class="px-8 py-2.5 rounded-lg bg-[#2563eb] text-white font-semibold transition-all hover:bg-[#1d4ed8] shadow-lg shadow-blue-500/20">
                            ${staff.id == null ? 'Register Staff' : 'Update Information'}
                        </button>
                    </div>
                </form>
            </div>
        </main>
    </div>
    <script>
        lucide.createIcons();
    </script>
</body>
</html>
