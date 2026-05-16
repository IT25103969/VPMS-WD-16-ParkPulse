<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Add Member Modal -->
<div x-show="addOpen" class="fixed inset-0 z-50 flex items-center justify-center p-4" x-cloak>
    <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" @click="addOpen = false"></div>
    <div class="relative border border-white/10 rounded-2xl shadow-2xl w-full max-w-lg overflow-hidden transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235]' : 'bg-white'">
        <div class="flex items-center justify-between px-6 pt-5 pb-4 border-b" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
            <span class="text-sm font-medium" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">Add New Member</span>
            <button @click="addOpen = false" class="text-gray-400 hover:text-white transition-colors"><i data-lucide="x" class="size-4"></i></button>
        </div>
        
        <div class="px-6 py-4 grid grid-cols-2 gap-4">
            <div class="col-span-2">
                <label class="text-xs mb-1 block" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Full Name</label>
                <input type="text" x-model="form.name" class="w-full border rounded-lg px-3 py-2 text-sm outline-none" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white' : 'bg-gray-50 border-gray-200 text-gray-800'">
            </div>
            <div>
                <label class="text-xs mb-1 block" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Email</label>
                <input type="email" x-model="form.email" class="w-full border rounded-lg px-3 py-2 text-sm outline-none" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white' : 'bg-gray-50 border-gray-200 text-gray-800'">
            </div>
            <div>
                <label class="text-xs mb-1 block" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Phone</label>
                <input type="text" x-model="form.phone" class="w-full border rounded-lg px-3 py-2 text-sm outline-none" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white' : 'bg-gray-50 border-gray-200 text-gray-800'">
            </div>
        </div>

        <div class="flex items-center justify-end gap-3 px-6 py-4 border-t" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
            <button @click="addOpen = false" class="px-4 py-2 rounded-lg text-sm border" :class="$store.app.isDark ? 'border-white/10 text-gray-300' : 'border-gray-200 text-gray-600'">Cancel</button>
            <button @click="handleAdd()" class="px-4 py-2 rounded-lg text-sm bg-blue-600 text-white">Add Member</button>
        </div>
    </div>
</div>

<!-- Edit Member Modal -->
<div x-show="editOpen" class="fixed inset-0 z-50 flex items-center justify-center p-4" x-cloak>
    <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" @click="editOpen = false"></div>
    <div class="relative border border-white/10 rounded-2xl shadow-2xl w-full max-w-lg overflow-hidden transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235]' : 'bg-white'">
        <div class="flex items-center justify-between px-6 pt-5 pb-4 border-b" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
            <span class="text-sm font-medium" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">Edit Member</span>
            <button @click="editOpen = false" class="text-gray-400 hover:text-white transition-colors"><i data-lucide="x" class="size-4"></i></button>
        </div>
        
        <div class="px-6 py-4 grid grid-cols-2 gap-4">
            <div class="col-span-2">
                <label class="text-xs mb-1 block" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'">Full Name</label>
                <input type="text" x-model="form.name" class="w-full border rounded-lg px-3 py-2 text-sm outline-none" :class="$store.app.isDark ? 'bg-[#13151f] border-white/10 text-white' : 'bg-gray-50 border-gray-200 text-gray-800'">
            </div>
        </div>

        <div class="flex items-center justify-end gap-3 px-6 py-4 border-t" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-100'">
            <button @click="editOpen = false" class="px-4 py-2 rounded-lg text-sm border" :class="$store.app.isDark ? 'border-white/10 text-gray-300' : 'border-gray-200 text-gray-600'">Cancel</button>
            <button @click="handleEdit()" class="px-4 py-2 rounded-lg text-sm bg-blue-600 text-white">Save Changes</button>
        </div>
    </div>
</div>

<!-- Delete Member Modal -->
<div x-show="deleteOpen" class="fixed inset-0 z-50 flex items-center justify-center p-4" x-cloak>
    <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" @click="deleteOpen = false"></div>
    <div class="relative border border-white/10 rounded-2xl shadow-2xl w-full max-w-md overflow-hidden transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235]' : 'bg-white'">
        <div class="px-6 py-5 text-center">
            <p class="text-sm" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-600'">Are you sure you want to delete <span class="font-medium" x-text="selectedMember?.name"></span>?</p>
            <div class="flex items-center justify-center gap-3 mt-6">
                <button @click="deleteOpen = false" class="px-4 py-2 rounded-lg text-sm border" :class="$store.app.isDark ? 'border-white/10 text-gray-300' : 'border-gray-200 text-gray-600'">Cancel</button>
                <button @click="handleDelete()" class="px-4 py-2 rounded-lg text-sm bg-red-600 text-white">Delete</button>
            </div>
        </div>
    </div>
</div>

<style>[x-cloak] { display: none !important; }</style>
