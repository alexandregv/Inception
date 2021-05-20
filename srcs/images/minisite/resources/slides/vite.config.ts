import { defineConfig } from 'vite'

export default defineConfig({
	build: {
		rollupOptions: {
			output: {
				entryFileNames: `[name].js`,
				chunkFileNames: `[name].js`,
				assetFileNames: `[name].[ext]`,
			},
		},
		rollupOutputOptions: {
			entryFileNames: `[name].js`,
			chunkFileNames: `[name].js`,
			assetFileNames: `[name].[ext]`,
		},
	},
})
