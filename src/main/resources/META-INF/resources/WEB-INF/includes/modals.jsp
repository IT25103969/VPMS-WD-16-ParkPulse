<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Add Member Modal -->
<div x-show="addOpen" class="fixed inset-0 z-50 flex items-center justify-center p-4" x-cloak>
    <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" @click="addOpen = false"></div>
    <div class="relative border border-white/10 rounded-2xl shadow-2xl w-full max-w-lg overflow-hidden transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235]' : 'bg-white'">
        <div class="flex items-center justify-between px-6 pt-5 pb-4 border-b" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
            <div class="flex items-center gap-2" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">
                <span class="w-6 h-6 rounded-md bg-blue-500/20 flex items-center justify-center"><i data-lucide="plus" class="size-3.5 text-blue-400"></i></span>
                <span class="text-sm font-medium">Add New Member</span>
            </div>
            <button @click="addOpen = false" class="w-7 h-7 rounded-lg bg-white/5 hover:bg-white/10 flex items-center justify-center text-gray-400 hover:text-white transition-colors">
                <i data-lucide="x" class="size-4"></i>
            </button>
        </div>
        
        <div class="px-6 py-4 grid grid-cols-2 gap-4">
            <div class="col-span-2">
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Full Name *</label>
                <input type="text" x-model="form.name" placeholder="e.g. Iroshan Damsara" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white placeholder-gray-600 focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 placeholder-gray-400 focus:border-blue-500'">
                <p x-show="errors.name" class="text-red-400 text-xs mt-1" x-text="errors.name"></p>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Email *</label>
                <input type="email" x-model="form.email" placeholder="damsara@parkpulse.com" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white placeholder-gray-600 focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 placeholder-gray-400 focus:border-blue-500'">
                <p x-show="errors.email" class="text-red-400 text-xs mt-1" x-text="errors.email"></p>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Phone *</label>
                <input type="text" x-model="form.phone" placeholder="e.g. 077 123 4567" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white placeholder-gray-600 focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 placeholder-gray-400 focus:border-blue-500'">
                <p x-show="errors.phone" class="text-red-400 text-xs mt-1" x-text="errors.phone"></p>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Vehicle Type *</label>
                <select x-model="form.vehicle" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 focus:border-blue-500'">
                    <option value="Car">Car</option>
                    <option value="Motorcycle">Motorcycle</option>
                    <option value="Van">Van</option>
                    <option value="SUV">SUV</option>
                    <option value="Other">Other</option>
                </select>
                <p x-show="errors.vehicle" class="text-red-400 text-xs mt-1" x-text="errors.vehicle"></p>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Vehicle Name/Model *</label>
                <input type="text" x-model="form.vehicleModel" placeholder="e.g. Toyota Camry" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white placeholder-gray-600 focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 placeholder-gray-400 focus:border-blue-500'">
                <p x-show="errors.vehicleModel" class="text-red-400 text-xs mt-1" x-text="errors.vehicleModel"></p>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">License Plate *</label>
                <input type="text" x-model="form.licensePlate" placeholder="e.g. ABC-1234" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white placeholder-gray-600 focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 placeholder-gray-400 focus:border-blue-500'">
                <p x-show="errors.licensePlate" class="text-red-400 text-xs mt-1" x-text="errors.licensePlate"></p>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Subscription Plan</label>
                <select x-model="form.plan" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 focus:border-blue-500'">
                    <template x-for="p in plans" :key="p.name">
                        <option :value="p.name" x-text="p.name"></option>
                    </template>
                </select>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Status</label>
                <select x-model="form.status" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 focus:border-blue-500'">
                    <option value="ACTIVE">Active</option>
                    <option value="INACTIVE">Inactive</option>
                    <option value="SUSPENDED">Suspended</option>
                </select>
            </div>
        </div>

        <div class="flex items-center justify-end gap-3 px-6 py-4 border-t" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
            <button @click="addOpen = false" class="px-4 py-2 rounded-lg text-sm border transition-colors" :class="$store.app.isDark ? 'border-white/10 text-gray-300 hover:bg-white/10' : 'border-gray-200 text-gray-600 hover:bg-gray-50'">Cancel</button>
            <button @click="handleAdd()" class="flex items-center gap-2 px-4 py-2 rounded-lg text-sm bg-blue-600 hover:bg-blue-700 text-white transition-colors">
                <i data-lucide="check" class="size-4"></i> Add Member
            </button>
        </div>
    </div>
</div>

<!-- Edit Member Modal -->
<div x-show="editOpen" class="fixed inset-0 z-50 flex items-center justify-center p-4" x-cloak>
    <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" @click="editOpen = false"></div>
    <div class="relative border border-white/10 rounded-2xl shadow-2xl w-full max-w-lg overflow-hidden transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235]' : 'bg-white'">
        <div class="flex items-center justify-between px-6 pt-5 pb-4 border-b" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
            <div class="flex items-center gap-2" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">
                <span class="w-6 h-6 rounded-md bg-blue-500/20 flex items-center justify-center"><i data-lucide="pencil" class="size-3.5 text-blue-400"></i></span>
                <span class="text-sm font-medium">Edit Member — <span x-text="selectedMember?.id"></span></span>
            </div>
            <button @click="editOpen = false" class="w-7 h-7 rounded-lg bg-white/5 hover:bg-white/10 flex items-center justify-center text-gray-400 hover:text-white transition-colors">
                <i data-lucide="x" class="size-4"></i>
            </button>
        </div>
        
        <div class="px-6 py-4 grid grid-cols-2 gap-4">
            <div class="col-span-2">
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Full Name *</label>
                <input type="text" x-model="form.name" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 focus:border-blue-500'">
                <p x-show="errors.name" class="text-red-400 text-xs mt-1" x-text="errors.name"></p>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Email *</label>
                <input type="email" x-model="form.email" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 focus:border-blue-500'">
                <p x-show="errors.email" class="text-red-400 text-xs mt-1" x-text="errors.email"></p>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Phone *</label>
                <input type="text" x-model="form.phone" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 focus:border-blue-500'">
                <p x-show="errors.phone" class="text-red-400 text-xs mt-1" x-text="errors.phone"></p>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Vehicle Type *</label>
                <select x-model="form.vehicle" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 focus:border-blue-500'">
                    <option value="Car">Car</option>
                    <option value="Motorcycle">Motorcycle</option>
                    <option value="Van">Van</option>
                    <option value="SUV">SUV</option>
                    <option value="Other">Other</option>
                </select>
                <p x-show="errors.vehicle" class="text-red-400 text-xs mt-1" x-text="errors.vehicle"></p>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Vehicle Name/Model *</label>
                <input type="text" x-model="form.vehicleModel" placeholder="e.g. Toyota Camry" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white placeholder-gray-600 focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 placeholder-gray-400 focus:border-blue-500'">
                <p x-show="errors.vehicleModel" class="text-red-400 text-xs mt-1" x-text="errors.vehicleModel"></p>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">License Plate *</label>
                <input type="text" x-model="form.licensePlate" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 focus:border-blue-500'">
                <p x-show="errors.licensePlate" class="text-red-400 text-xs mt-1" x-text="errors.licensePlate"></p>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Subscription Plan</label>
                <select x-model="form.plan" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 focus:border-blue-500'">
                    <template x-for="p in plans" :key="p.name">
                        <option :value="p.name" x-text="p.name"></option>
                    </template>
                </select>
            </div>
            <div>
                <label class="text-xs mb-1 block transition-colors" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Status</label>
                <select x-model="form.status" class="w-full border rounded-lg px-3 py-2 text-sm outline-none transition-colors" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white focus:border-blue-500/60' : 'bg-gray-50 border-gray-200 text-gray-800 focus:border-blue-500'">
                    <option value="ACTIVE">Active</option>
                    <option value="INACTIVE">Inactive</option>
                    <option value="SUSPENDED">Suspended</option>
                </select>
            </div>
        </div>

        <div class="flex items-center justify-end gap-3 px-6 py-4 border-t" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
            <button @click="editOpen = false" class="px-4 py-2 rounded-lg text-sm border transition-colors" :class="$store.app.isDark ? 'border-white/10 text-gray-300 hover:bg-white/10' : 'border-gray-200 text-gray-600 hover:bg-gray-50'">Cancel</button>
            <button @click="handleEdit()" class="flex items-center gap-2 px-4 py-2 rounded-lg text-sm bg-blue-600 hover:bg-blue-700 text-white transition-colors">
                <i data-lucide="check" class="size-4"></i> Save Changes
            </button>
        </div>
    </div>
</div>

<!-- Delete Member Modal -->
<div x-show="deleteOpen" class="fixed inset-0 z-50 flex items-center justify-center p-4" x-cloak>
    <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" @click="deleteOpen = false"></div>
    <div class="relative border border-white/10 rounded-2xl shadow-2xl w-full max-w-md overflow-hidden transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235]' : 'bg-white'">
        <div class="flex items-center justify-between px-6 pt-5 pb-4 border-b" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
            <div class="flex items-center gap-2" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">
                <span class="w-6 h-6 rounded-md bg-red-500/20 flex items-center justify-center"><i data-lucide="trash" class="size-3.5 text-red-400"></i></span>
                <span class="text-sm font-medium">Delete Member</span>
            </div>
            <button @click="deleteOpen = false" class="w-7 h-7 rounded-lg bg-white/5 hover:bg-white/10 flex items-center justify-center text-gray-400 hover:text-white transition-colors">
                <i data-lucide="x" class="size-4"></i>
            </button>
        </div>
        
        <div class="px-6 py-5">
            <p class="text-sm" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-600'">Are you sure you want to delete <span class="font-medium" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'" x-text="selectedMember?.name"></span>? This action cannot be undone.</p>
        </div>

        <div class="flex items-center justify-end gap-3 px-6 py-4 border-t" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
            <button @click="deleteOpen = false" class="px-4 py-2 rounded-lg text-sm border transition-colors" :class="$store.app.isDark ? 'border-white/10 text-gray-300 hover:bg-white/10' : 'border-gray-200 text-gray-600 hover:bg-gray-50'">Cancel</button>
            <button @click="handleDelete()" class="flex items-center gap-2 px-4 py-2 rounded-lg text-sm bg-red-600 hover:bg-red-700 text-white transition-colors">
                <i data-lucide="trash" class="size-4"></i> Delete
            </button>
        </div>
    </div>
</div>

<style>
[x-cloak] { display: none !important; }
</style>
