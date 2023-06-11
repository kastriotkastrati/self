Set-Location -Path "C:\Users\KastriotKastrati\Desktop\nydogeexchange"
& "venv\nextvenv\scripts\activate"
Set-Location -Path "C:\Users\KastriotKastrati\Desktop\nydogeexchange\client"
code .
Start-Process "http://localhost:3000"
npm run dev
