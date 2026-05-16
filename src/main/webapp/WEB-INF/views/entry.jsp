<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/sidebar.jsp" />

<main class="flex-1 overflow-y-auto bg-background" x-data="entryData()">
    <div class="p-8">
        <div class="max-w-3xl mx-auto">
            <div class="rounded-2xl border border-border bg-card overflow-hidden">
                <div class="bg-gradient-to-br from-blue-600 to-blue-700 p-6 flex items-center gap-4">
                    <div class="size-12 bg-white/20 rounded-xl flex items-center justify-center">
                        <i data-lucide="log-in" class="size-6 text-white"></i>
                    </div>
                    <div>
                        <h1 class="text-xl font-semibold text-white" x-text="isEdit ? 'Edit Vehicle Details' : 'Enter Vehicle Details'"></h1>
                        <p class="text-sm text-blue-100">Slot <span x-text="slotNumber"></span></p>
                    </div>
                </div>
                <form @submit.prevent="submitEntry()" class="p-6 space-y-5">
                    <div class="grid grid-cols-2 gap-5">
                        <div>
                            <label class="block text-sm mb-2 text-muted-foreground">License Plate</label>
                            <div class="relative">
                                <i data-lucide="car" class="absolute left-3 top-1/2 -translate-y-1/2 size-5 text-muted-foreground"></i>
                                <input 
                                    type="text" required x-model="formData.licensePlate"
                                    placeholder="ABC-1234"
                                    class="w-full pl-11 pr-4 py-3 rounded-xl border border-border bg-input-background text-foreground focus:outline-none focus:ring-2 focus:ring-blue-500"
                                >
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm mb-2 text-muted-foreground">Vehicle Type</label>
                            <div class="relative">
                                <i data-lucide="activity" class="absolute left-3 top-1/2 -translate-y-1/2 size-5 text-muted-foreground"></i>
                                <select 
                                    x-model="formData.type"
                                    class="w-full pl-11 pr-4 py-3 rounded-xl border border-border bg-input-background text-foreground focus:outline-none focus:ring-2 focus:ring-blue-500 appearance-none"
                                >
                                    <template x-for="t in vehicleTypes">
                                        <option :value="t" x-text="t"></option>
                                    </template>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div>
                        <label class="block text-sm mb-2 text-muted-foreground">Owner Name</label>
                        <div class="relative">
                            <i data-lucide="user" class="absolute left-3 top-1/2 -translate-y-1/2 size-5 text-muted-foreground"></i>
                            <input 
                                type="text" required x-model="formData.owner"
                                placeholder="John Doe"
                                class="w-full pl-11 pr-4 py-3 rounded-xl border border-border bg-input-background text-foreground focus:outline-none focus:ring-2 focus:ring-blue-500"
                            >
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-5">
                        <div>
                            <label class="block text-sm mb-2 text-muted-foreground">Phone Number</label>
                            <div class="relative">
                                <i data-lucide="phone" class="absolute left-3 top-1/2 -translate-y-1/2 size-5 text-muted-foreground"></i>
                                <input 
                                    type="tel" required x-model="formData.phone"
                                    placeholder="+1 234-567-8900"
                                    class="w-full pl-11 pr-4 py-3 rounded-xl border border-border bg-input-background text-foreground focus:outline-none focus:ring-2 focus:ring-blue-500"
                                >
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm mb-2 text-muted-foreground">Email Address</label>
                            <div class="relative">
                                <i data-lucide="mail" class="absolute left-3 top-1/2 -translate-y-1/2 size-5 text-muted-foreground"></i>
                                <input 
                                    type="email" required x-model="formData.email"
                                    placeholder="owner@example.com"
                                    class="w-full pl-11 pr-4 py-3 rounded-xl border border-border bg-input-background text-foreground focus:outline-none focus:ring-2 focus:ring-blue-500"
                                >
                            </div>
                        </div>
                    </div>
                    <div class="flex gap-3 pt-4">
                        <a href="${pageContext.request.contextPath}/" class="flex-1 py-3 rounded-xl bg-muted text-foreground text-center hover:bg-accent transition-colors">
                            Cancel
                        </a>
                        <button type="submit" class="flex-1 py-3 bg-blue-600 hover:bg-blue-700 text-white rounded-xl transition-colors" x-text="isEdit ? 'Confirm Changes' : 'Confirm Entry'">
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<jsp:include page="common/footer.jsp" />
