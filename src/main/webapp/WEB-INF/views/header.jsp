<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.2/anime.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        
        :root {
            --font-size: 16px;
            --background: #ffffff;
            --foreground: oklch(0.145 0 0);
            --card: #ffffff;
            --card-foreground: oklch(0.145 0 0);
            --popover: oklch(1 0 0);
            --popover-foreground: oklch(0.145 0 0);
            --primary: #030213;
            --primary-foreground: oklch(1 0 0);
            --secondary: oklch(0.95 0.0058 264.53);
            --secondary-foreground: #030213;
            --muted: #ececf0;
            --muted-foreground: #717182;
            --accent: #e9ebef;
            --accent-foreground: #030213;
            --destructive: #d4183d;
            --destructive-foreground: #ffffff;
            --border: rgba(0, 0, 0, 0.1);
            --input: transparent;
            --input-background: #f3f3f5;
            --switch-background: #cbced4;
            --font-weight-medium: 500;
            --font-weight-normal: 400;
            --ring: oklch(0.708 0 0);
            --radius: 0.625rem;
            --sidebar: oklch(0.985 0 0);
            --sidebar-foreground: oklch(0.145 0 0);
            --sidebar-primary: #030213;
            --sidebar-primary-foreground: oklch(0.985 0 0);
            --sidebar-accent: oklch(0.97 0 0);
            --sidebar-accent-foreground: oklch(0.205 0 0);
            --sidebar-border: oklch(0.922 0 0);
            --sidebar-ring: oklch(0.708 0 0);
        }

        .dark {
            --background: oklch(0.145 0 0);
            --foreground: oklch(0.985 0 0);
            --card: oklch(0.145 0 0);
            --card-foreground: oklch(0.985 0 0);
            --popover: oklch(0.145 0 0);
            --popover-foreground: oklch(0.985 0 0);
            --primary: oklch(0.985 0 0);
            --primary-foreground: oklch(0.205 0 0);
            --secondary: oklch(0.269 0 0);
            --secondary-foreground: oklch(0.985 0 0);
            --muted: oklch(0.269 0 0);
            --muted-foreground: oklch(0.708 0 0);
            --accent: oklch(0.269 0 0);
            --accent-foreground: oklch(0.985 0 0);
            --destructive: oklch(0.396 0.141 25.723);
            --destructive-foreground: oklch(0.637 0.237 25.331);
            --border: oklch(0.269 0 0);
            --input: oklch(0.269 0 0);
            --ring: oklch(0.439 0 0);
            --sidebar: oklch(0.205 0 0);
            --sidebar-foreground: oklch(0.985 0 0);
            --sidebar-primary: oklch(0.488 0.243 264.376);
            --sidebar-primary-foreground: oklch(0.985 0 0);
            --sidebar-accent: oklch(0.269 0 0);
            --sidebar-accent-foreground: oklch(0.985 0 0);
            --sidebar-border: oklch(0.269 0 0);
            --sidebar-ring: oklch(0.439 0 0);
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--background);
            color: var(--foreground);
        }

        /* Replicating the custom variables used in ParkingSidebar.tsx */
        .base-bg { background-color: var(--background); }
        .sidebar-bg { background-color: var(--sidebar); border-right: 1px solid var(--sidebar-border); }
        .card-bg { background-color: var(--card); border: 1px solid var(--border); }
        .inner-bg { background-color: var(--background); }
        .text-primary { color: var(--foreground); }
        .text-muted { color: var(--muted-foreground); }
        
        .dark .base-bg { background-color: #0b1220; }
        .dark .sidebar-bg { background-color: #111a2e; border-right: 1px solid #1f2a44; }
        .dark .card-bg { background-color: #111a2e; border: 1px solid #1f2a44; }
        .dark .inner-bg { background-color: #0b1220; }
        .dark .text-primary { color: #ffffff; }
        .dark .text-muted { color: #9ca3af; }

        [scrollbar-width:none] {
            scrollbar-width: none;
        }
        [&::-webkit-scrollbar]:hidden::-webkit-scrollbar {
            display: none;
        }

        /* Animation initial state */
        .page-transition-content {
            opacity: 0;
            transform: translateY(10px);
        }
    </style>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        border: "var(--border)",
                        input: "var(--input)",
                        ring: "var(--ring)",
                        background: "var(--background)",
                        foreground: "var(--foreground)",
                        primary: {
                            DEFAULT: "var(--primary)",
                            foreground: "var(--primary-foreground)",
                        },
                        secondary: {
                            DEFAULT: "var(--secondary)",
                            foreground: "var(--secondary-foreground)",
                        },
                        destructive: {
                            DEFAULT: "var(--destructive)",
                            foreground: "var(--destructive-foreground)",
                        },
                        muted: {
                            DEFAULT: "var(--muted)",
                            foreground: "var(--muted-foreground)",
                        },
                        accent: {
                            DEFAULT: "var(--accent)",
                            foreground: "var(--accent-foreground)",
                        },
                        popover: {
                            DEFAULT: "var(--popover)",
                            foreground: "var(--popover-foreground)",
                        },
                        card: {
                            DEFAULT: "var(--card)",
                            foreground: "var(--card-foreground)",
                        },
                    },
                    borderRadius: {
                        lg: "var(--radius)",
                        md: "calc(var(--radius) - 2px)",
                        sm: "calc(var(--radius) - 4px)",
                    },
                }
            }
        }

        // --- GLOBAL TRANSITION LOGIC ---
        window.addEventListener('DOMContentLoaded', () => {
            // Entrance Animation
            const mainContent = document.querySelector('main');
            if (mainContent) {
                mainContent.classList.add('page-transition-content');
                anime({
                    targets: mainContent,
                    opacity: [0, 1],
                    translateY: [10, 0],
                    easing: 'easeOutExpo',
                    duration: 800,
                    delay: 100
                });
            }

            // Exit Animation on link click
            document.body.addEventListener('click', (e) => {
                const link = e.target.closest('a');
                // Only animate internal navigation links, skip anchors/external/blanks/forms
                if (link && 
                    link.href && 
                    link.href.startsWith(window.location.origin) && 
                    !link.href.includes('#') &&
                    link.target !== '_blank' &&
                    !link.hasAttribute('download') &&
                    !link.closest('form')) {
                    
                    e.preventDefault();
                    const destination = link.href;

                    anime({
                        targets: 'main',
                        opacity: 0,
                        translateY: -10,
                        easing: 'easeInExpo',
                        duration: 400,
                        complete: () => {
                            window.location.href = destination;
                        }
                    });
                }
            });
        });
    </script>
</head>
<body class="h-screen overflow-hidden base-bg transition-colors duration-300">
