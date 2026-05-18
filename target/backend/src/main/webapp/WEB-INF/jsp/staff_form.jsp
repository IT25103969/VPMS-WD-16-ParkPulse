<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Staff - ParkPulse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" href="css/theme.css">
    <link rel="stylesheet" href="css/globals.css">
</head>
<body class="flex h-screen w-screen overflow-hidden">
    <!-- Sidebar -->
    <aside id="sidebar" class="flex flex-col h-full flex-shrink-0 transition-all duration-200 border-r" style="width: 230px; background: var(--sidebar); border-color: var(--border);">
        <div class="flex items-center flex-shrink-0 h-[58px] border-b px-3 gap-2" style="border-color: var(--border);">
            <button onclick="toggleSidebar()" class="flex items-center justify-center w-8.5 h-8.5 rounded-lg hover:bg-[var(--hover)] text-[var(--text-sub)] hover:text-[var(--text)] transition-colors">
                <i data-lucide="menu" style="width: 18px; height: 18px;"></i>
            </button>
            <div class="flex items-center gap-2 sidebar-logo-text">
                <div class="flex items-center justify-center w-[30px] h-[30px] rounded-xl bg-[#2563eb]">
                    <i data-lucide="activity" style="width: 15px; height: 15px; color: white;"></i>
                </div>
                <span class="font-bold text-lg text-[var(--text)] whitespace-nowrap">ParkPulse</span>
            </div>
        </div>
        
        <nav class="flex-1 overflow-y-auto py-3 px-2 flex flex-col gap-1">
            <a href="/staff" class="sidebar-nav-item flex items-center gap-2.5 p-2.5 rounded-xl text-sm font-semibold bg-[#2563eb] text-white">
                <i data-lucide="users" style="width: 17px; height: 17px;"></i>
                <span class="sidebar-label">Staff</span>
            </a>
        </nav>

        <div class="flex flex-col gap-1 px-2 py-3 border-t" style="border-color: var(--border);">
            <button onclick="toggleTheme()" class="sidebar-nav-item flex items-center gap-2.5 p-2.5 rounded-xl text-sm text-[var(--text-sub)]">
                <i data-lucide="sun" class="hidden dark:block" style="width: 17px; height: 17px;"></i>
                <i data-lucide="moon" class="block dark:hidden" style="width: 17px; height: 17px;"></i>
                <span class="sidebar-label dark:hidden">Dark Mode</span>
                <span class="sidebar-label hidden dark:inline">Light Mode</span>
            </button>
            <button class="sidebar-nav-item flex items-center gap-2.5 p-2.5 rounded-xl text-sm text-[var(--text-sub)]">
                <i data-lucide="log-out" style="width: 17px; height: 17px;"></i>
                <span class="sidebar-label">Sign Out</span>
            </button>
        </div>
    </aside>

    <div class="flex flex-col flex-1 overflow-hidden">
        <!-- Top bar -->
        <header class="flex items-center justify-between px-7 h-[58px] border-b flex-shrink-0" style="background: var(--topbar); border-color: var(--border);">
            <div class="flex items-center gap-2 text-[13px]">
                <span class="text-[var(--text-sub)]">ParkPulse</span>
                <span class="text-[var(--border-med)]">/</span>
                <a href="/staff" class="text-[var(--text-sub)] hover:text-[var(--text)] transition-colors">Staff Management</a>
                <span class="text-[var(--border-med)]">/</span>
                <span id="breadcrumb-page" class="text-[var(--text)] font-medium">Add Staff Member</span>
            </div>
            <div class="flex items-center justify-center w-8 h-8 rounded-full bg-[#2563eb] text-white text-[12px] font-bold">
                AD
            </div>
        </header>

        <!-- Page content -->
        <main class="flex-1 overflow-hidden bg-[var(--bg)]">
            <div class="flex flex-col h-full overflow-y-auto p-7 md:p-8">
                <div class="max-w-4xl mx-auto w-full">
                    <div class="flex items-center justify-between mb-8">
                        <div>
                            <h1 id="form-title" class="text-2xl font-bold text-[var(--text)] m-0">Add Staff Member</h1>
                            <p class="text-sm text-[var(--text-sub)] mt-1">Enter the details of the new staff member below.</p>
                        </div>
                        <button onclick="window.location.href='/staff'" class="text-[var(--text-sub)] hover:text-[var(--text)] p-2 rounded-lg transition-colors">
                            <i data-lucide="x" style="width: 24px; height: 24px;"></i>
                        </button>
                    </div>

                    <form id="staff-form" class="space-y-6 pb-12">
                        <input type="hidden" id="staff-id" name="id">
                        
                        <!-- Profile Picture Section -->
                        <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                            <h3 class="text-lg font-bold text-[var(--text)] mb-6 flex items-center gap-2">
                                <i data-lucide="image" class="text-[#2563eb]" style="width: 20px; height: 20px;"></i>
                                Profile Picture
                            </h3>
                            <div class="flex items-center gap-6">
                                <div id="avatar-preview" class="flex items-center justify-center rounded-full bg-[var(--hover)] overflow-hidden border-2 border-[var(--border-med)]" style="width: 100px; height: 100px;">
                                    <i data-lucide="user" style="width: 40px; height: 40px; color: var(--text-sub);"></i>
                                </div>
                                <div class="flex-1 space-y-2">
                                    <label class="block text-sm font-semibold text-[var(--text)]">Upload Photo</label>
                                    <input type="file" id="avatar-input" accept="image/*" class="block w-full text-sm text-[var(--text-sub)] file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-[#2563eb] file:text-white hover:file:bg-[#1d4ed8] cursor-pointer">
                                    <p class="text-xs text-[var(--text-sub)]">Recommended: Square image, max 1MB.</p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Basic Info Section -->
                        <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                            <h3 class="text-lg font-bold text-[var(--text)] mb-6 flex items-center gap-2">
                                <i data-lucide="user" class="text-[#2563eb]" style="width: 20px; height: 20px;"></i>
                                Personal Information
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="space-y-2">
                                    <label for="name" class="text-sm font-semibold text-[var(--text)]">Full Name</label>
                                    <input type="text" id="name" name="name" required placeholder="Kasun Perera" class="w-full px-4 py-2.5 rounded-xl bg-[var(--input-bg)] border border-[var(--border-med)] text-[var(--text)] outline-none focus:border-[#2563eb] transition-all">
                                </div>
                                <div class="space-y-2">
                                    <label for="role" class="text-sm font-semibold text-[var(--text)]">Role / Designation</label>
                                    <select id="role" name="role" required class="w-full px-4 py-2.5 rounded-xl bg-[var(--input-bg)] border border-[var(--border-med)] text-[var(--text)] outline-none focus:border-[#2563eb] transition-all">
                                        <option value="Manager">Manager</option>
                                        <option value="Attendant" selected>Attendant</option>
                                        <option value="Security">Security</option>
                                        <option value="Cashier">Cashier</option>
                                        <option value="Supervisor">Supervisor</option>
                                    </select>
                                </div>
                                <div class="space-y-2">
                                    <label for="status" class="text-sm font-semibold text-[var(--text)]">Employment Status</label>
                                    <select id="status" name="status" required class="w-full px-4 py-2.5 rounded-xl bg-[var(--input-bg)] border border-[var(--border-med)] text-[var(--text)] outline-none focus:border-[#2563eb] transition-all">
                                        <option value="Active">Active</option>
                                        <option value="Off Duty">Off Duty</option>
                                    </select>
                                </div>
                                <div class="space-y-2">
                                    <label for="shift" class="text-sm font-semibold text-[var(--text)]">Shift Schedule</label>
                                    <select id="shift" name="shift" required class="w-full px-4 py-2.5 rounded-xl bg-[var(--input-bg)] border border(--border-med)] text-[var(--text)] outline-none focus:border-[#2563eb] transition-all">
                                        <option value="Morning (6AM-2PM)">Morning (6AM-2PM)</option>
                                        <option value="Afternoon (2PM-10PM)">Afternoon (2PM-10PM)</option>
                                        <option value="Night (10PM-6AM)">Night (10PM-6AM)</option>
                                    </select>
                                </div>
                                <div class="space-y-2">
                                    <label for="email" class="text-sm font-semibold text-[var(--text)]">Email Address</label>
                                    <input type="email" id="email" name="email" required placeholder="email@example.com" class="w-full px-4 py-2.5 rounded-xl bg-[var(--input-bg)] border border-[var(--border-med)] text-[var(--text)] outline-none focus:border-[#2563eb] transition-all">
                                </div>
                                <div class="space-y-2">
                                    <label for="phone" class="text-sm font-semibold text-[var(--text)]">Phone Number</label>
                                    <input type="tel" id="phone" name="phone" required placeholder="+94 77 123 4567" class="w-full px-4 py-2.5 rounded-xl bg-[var(--input-bg)] border border-[var(--border-med)] text-[var(--text)] outline-none focus:border-[#2563eb] transition-all">
                                </div>
                                <div class="space-y-2">
                                    <label for="joinDate" class="text-sm font-semibold text-[var(--text)]">Joining Date</label>
                                    <input type="date" id="joinDate" name="joinDate" required class="w-full px-4 py-2.5 rounded-xl bg-[var(--input-bg)] border border-[var(--border-med)] text-[var(--text)] outline-none focus:border-[#2563eb] transition-all">
                                </div>
                                <div class="space-y-2 md:col-span-2">
                                    <label for="address" class="text-sm font-semibold text-[var(--text)]">Full Address</label>
                                    <textarea id="address" name="address" rows="3" required placeholder="Enter complete residential address" class="w-full px-4 py-2.5 rounded-xl bg-[var(--input-bg)] border border-[var(--border-med)] text-[var(--text)] outline-none focus:border-[#2563eb] transition-all resize-none"></textarea>
                                </div>
                            </div>
                        </div>

                        <!-- Vehicle Section -->
                        <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                            <h3 class="text-lg font-bold text-[var(--text)] mb-6 flex items-center gap-2">
                                <i data-lucide="car" class="text-[#2563eb]" style="width: 20px; height: 20px;"></i>
                                Vehicle Information
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="space-y-2">
                                    <label for="vehicleNumber" class="text-sm font-semibold text-[var(--text)]">Vehicle Number</label>
                                    <input type="text" id="vehicleNumber" name="vehicleNumber" required placeholder="WP CAB-0000" class="w-full px-4 py-2.5 rounded-xl bg-[var(--input-bg)] border border-[var(--border-med)] text-[var(--text)] outline-none focus:border-[#2563eb] transition-all">
                                </div>
                                <div class="space-y-2">
                                    <label for="vehicleType" class="text-sm font-semibold text-[var(--text)]">Vehicle Type</label>
                                    <select id="vehicleType" name="vehicleType" required class="w-full px-4 py-2.5 rounded-xl bg-[var(--input-bg)] border border-[var(--border-med)] text-[var(--text)] outline-none focus:border-[#2563eb] transition-all">
                                        <option value="Sedan">Sedan</option>
                                        <option value="SUV">SUV</option>
                                        <option value="Hatchback">Hatchback</option>
                                        <option value="Truck">Truck</option>
                                        <option value="Motorcycle">Motorcycle</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Account Section -->
                        <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                            <h3 class="text-lg font-bold text-[var(--text)] mb-6 flex items-center gap-2">
                                <i data-lucide="lock" class="text-[#2563eb]" style="width: 20px; height: 20px;"></i>
                                System Account Credentials
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="space-y-2">
                                    <label for="username" class="text-sm font-semibold text-[var(--text)]">Username</label>
                                    <input type="text" id="username" name="username" required placeholder="kasun.p" class="w-full px-4 py-2.5 rounded-xl bg-[var(--input-bg)] border border-[var(--border-med)] text-[var(--text)] outline-none focus:border-[#2563eb] transition-all">
                                </div>
                                <div class="space-y-2">
                                    <label for="password" class="text-sm font-semibold text-[var(--text)]">Password</label>
                                    <div class="relative">
                                        <input type="password" id="password" name="password" required placeholder="••••••••" class="w-full px-4 py-2.5 rounded-xl bg-[var(--input-bg)] border border-[var(--border-med)] text-[var(--text)] outline-none focus:border-[#2563eb] transition-all pr-12">
                                        <button type="button" id="toggle-password" class="absolute right-3 top-1/2 -translate-y-1/2 text-[var(--text-sub)] hover:text-[var(--text)] transition-colors">
                                            <i data-lucide="eye" style="width: 18px; height: 18px;"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Form Actions -->
                        <div class="flex items-center justify-end gap-4 pt-4">
                            <button type="button" onclick="window.location.href='/staff'" class="px-8 py-3 rounded-xl text-[var(--text-sub)] font-semibold hover:bg-[var(--hover)] transition-all">
                                Cancel
                            </button>
                            <button type="submit" class="px-10 py-3 rounded-xl bg-[#2563eb] text-white font-bold shadow-lg shadow-blue-500/20 hover:bg-[#1d4ed8] transition-all transform hover:-translate-y-0.5">
                                Save Staff Member
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>

    <script src="js/theme.js"></script>
    <script src="js/sidebar.js"></script>
    <script src="js/staff-data.js"></script>
    <script src="js/staff-form-ui.js"></script>
    <script src="js/icons.js"></script>
</body>
</html>

