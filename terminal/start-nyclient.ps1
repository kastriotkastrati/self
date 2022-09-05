Set-Location -Path "C:\Users\KastriotKastrati\desktop\nydogeexchange"
& "venv\nextvenv\scripts\activate"
Set-Location -Path "C:\Users\KastriotKastrati\desktop\nydogeexchange\client"
code .
Start-Process "http://localhost:3000"
npm run dev
