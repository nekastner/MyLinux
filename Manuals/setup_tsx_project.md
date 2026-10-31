# 1. Create Project
```
npm create vite@latest "<project name>" --yes -- --template react-ts
```

# 2. 'cd' into Project
```
cd <project name>
```

# 3. install npm packages
```
npm install -D tailwindcss @tailwindcss/postcss postcss autoprefixer
```

# 4. Write to postcss.config.js
```
export default {
	plugins: {
		"@tailwindcss/postcss": {},
		autoprefixer: {},
	},
}
```

# 5. Write to src/tailwind.css
```
@import "tailwindcss";
```

# 6. Remove src/index.css
```
rm src/index.css
```

# 7. (Optional) Fix coding style in src/main.tsx
```
sed -i "$index\.css/d" src/main.tsx
sed -i "s/'/\"/g` src/main.tsx
```

# 8. Write into src/App.tsx
```
import "./tailwind.css"

function App() {
	return (
		<div className="h-screen bg-red-500 flex items-center justify-center">
			<h1 className="text-white text-5xl font-black uppercase">
				Hello World!
			</h1>
		</div>
	)
}

export default App
```

# 9. Remove src/App.css
```
rm src/App.css
```

# 10. Run
```
npm run dev
```
