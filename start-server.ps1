# Simple HTTP Server for port 3000
Add-Type -AssemblyName System.Net.HttpListener

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add('http://localhost:3000/')
$listener.Start()

Write-Host "Server running on http://localhost:3000"
Write-Host "Press Ctrl+C to stop the server"

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $localPath = $request.Url.LocalPath
        if ($localPath -eq '/') {
            $localPath = '/index.html'
        }
        
        $filePath = Join-Path (Get-Location) $localPath.TrimStart('/')
        
        if (Test-Path $filePath -PathType Leaf) {
            $extension = [System.IO.Path]::GetExtension($filePath)
            switch ($extension) {
                '.html' { $response.ContentType = 'text/html' }
                '.css' { $response.ContentType = 'text/css' }
                '.js' { $response.ContentType = 'application/javascript' }
                '.png' { $response.ContentType = 'image/png' }
                '.jpg' { $response.ContentType = 'image/jpeg' }
                '.jpeg' { $response.ContentType = 'image/jpeg' }
                '.gif' { $response.ContentType = 'image/gif' }
                '.svg' { $response.ContentType = 'image/svg+xml' }
                '.ico' { $response.ContentType = 'image/x-icon' }
                '.woff' { $response.ContentType = 'font/woff' }
                '.woff2' { $response.ContentType = 'font/woff2' }
                '.ttf' { $response.ContentType = 'font/ttf' }
                '.otf' { $response.ContentType = 'font/otf' }
                default { $response.ContentType = 'application/octet-stream' }
            }
            
            $content = [System.IO.File]::ReadAllBytes($filePath)
            $response.ContentLength64 = $content.Length
            $response.OutputStream.Write($content, 0, $content.Length)
        } else {
            $response.StatusCode = 404
            $errorContent = [System.Text.Encoding]::UTF8.GetBytes('404 Not Found')
            $response.OutputStream.Write($errorContent, 0, $errorContent.Length)
        }
        
        $response.OutputStream.Close()
    }
} finally {
    $listener.Stop()
    Write-Host "Server stopped"
}