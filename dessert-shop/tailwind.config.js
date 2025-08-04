// tailwind.config.js
module.exports = {
    // This 'content' array tells Tailwind to scan these files for utility classes.
    // The glob patterns must be correct for your project structure.
    content: [
        './index.html',
        './src/**/*.{js,jsx,ts,tsx}', // Make sure this is correct for your files.
        // The previous code had './src/**/*.{js,jsx}', which should be fine,
        // but I've expanded it to be more comprehensive.
    ],
    theme: {
        extend: {
            colors: {
                'primary-cream': '#fffaf7',
                'primary-orange': '#c64b38',
                'secondary-orange': '#d7673c',
                'gray-text': '#4a4a4a',
                'light-gray-text': '#8c8c8c',
                'border-orange': '#ffe2d4',
            },
        },
    },
    plugins: [],
};