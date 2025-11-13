import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import { visualizer } from 'rollup-plugin-visualizer'

// https://vite.dev/config/
export default defineConfig(({ mode }) => ({
  plugins: [
    react(),
    tailwindcss(),
    // Bundle analyzer (only in analyze mode)
    mode === 'analyze' && visualizer({
      filename: 'dist/bundle-analysis.html',
      open: true,
      gzipSize: true,
      brotliSize: true,
    }),
  ].filter(Boolean),
  build: {
    // Increase chunk size warning limit
    chunkSizeWarningLimit: 1000,

    // Optimize chunk splitting
    rollupOptions: {
      output: {
        manualChunks: (id) => {
          // Three.js core - separate from addons
          if (id.includes('three/build/three.module.js') || id.includes('three/src/')) {
            return 'three-core';
          }

          // Three.js addons (controls, loaders, etc.)
          if (id.includes('three/examples/jsm/') || id.includes('three/addons/')) {
            return 'three-addons';
          }

          // React Three Fiber and Drei
          if (id.includes('@react-three/fiber') || id.includes('@react-three/drei')) {
            return 'react-three';
          }

          // GSAP libraries
          if (id.includes('gsap') || id.includes('@gsap/react')) {
            return 'gsap-vendor';
          }

          // React ecosystem
          if (id.includes('react') || id.includes('react-dom') || id.includes('scheduler')) {
            return 'react-vendor';
          }

          // Tailwind and CSS utilities
          if (id.includes('tailwindcss') || id.includes('@tailwindcss')) {
            return 'tailwind-vendor';
          }

          // Other node_modules
          if (id.includes('node_modules')) {
            return 'vendor';
          }
        },

        // Optimize chunk file names
        chunkFileNames: (chunkInfo) => {
          const facadeModuleId = chunkInfo.facadeModuleId
            ? chunkInfo.facadeModuleId.split('/').pop().replace('.jsx', '').replace('.js', '')
            : 'chunk';
          return `assets/${facadeModuleId}-[hash].js`;
        },

        // Optimize asset file names
        assetFileNames: (assetInfo) => {
          const info = assetInfo.name.split('.');
          const extType = info[info.length - 1];
          if (/\.(png|jpe?g|svg|gif|tiff|bmp|ico)$/i.test(assetInfo.name)) {
            return `assets/images/[name]-[hash][extname]`;
          }
          if (/\.(css)$/i.test(assetInfo.name)) {
            return `assets/css/[name]-[hash][extname]`;
          }
          return `assets/${extType}/[name]-[hash][extname]`;
        },

        // Optimize entry file names
        entryFileNames: 'assets/[name]-[hash].js',
      }
    },

    // Enable source maps for production debugging (only in analyze mode)
    sourcemap: mode === 'analyze',

    // Optimize build
    minify: 'terser',
    terserOptions: {
      compress: {
        drop_console: mode === 'production',
        drop_debugger: mode === 'production',
      },
    },

    // Target modern browsers for smaller bundles
    target: 'esnext',

    // Enable CSS code splitting
    cssCodeSplit: true,
  },

  // Optimize dependencies
  optimizeDeps: {
    include: [
      'three',
      '@react-three/fiber',
      '@react-three/drei',
      'gsap',
      '@gsap/react'
    ],
    exclude: []
  },

  // Server configuration for development
  server: {
    host: true,
    port: 5173,
    open: true
  }
}))
