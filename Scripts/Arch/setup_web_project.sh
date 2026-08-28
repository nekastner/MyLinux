#!/bin/bash

# check if the project name is given
if [ -z "$1" ]; then
    echo "!!! ERR: Project name required."
    exit 1
fi

# create vite project
npm create vite@latest "$1" --yes -- --template react-ts &
wait $!

# go into project directory
cd "$1" || { echo "!!! ERR: Unable to find project directory '$1'"; exit 1; }

# install tailwind with dependencies
npm install -D tailwindcss @tailwindcss/postcss postcss autoprefixer

# setup postcss.config.js
cat << "EOF" > postcss.config.js
export default {
    plugins: {
	"@tailwindcss/postcss": {},
	autoprefixer: {},
    },
}
EOF

# setup src/tailwind.css
cat << "EOF" > src/tailwind.css
@import "tailwindcss";
EOF

# remove src/index.css
rm src/index.css

# setup src/main.tsx
sed -i "/index\.css/d" src/main.tsx
sed -i "s/'\''/\"/g" src/main.tsx # not working right now

# setup src/App.tsx
cat << "EOF" > src/App.tsx
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
EOF

# remove src/App.css
rm src/App.css

# execute
npm run dev

