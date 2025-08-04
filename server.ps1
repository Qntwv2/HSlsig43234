# Simple HTTP Server for Static Files
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add('http://localhost:3000/')
$listener.Start()

Write-Host "Server running at http://localhost:3000/"
Write-Host "Press Ctrl+C to stop the server"

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        # Get the requested file path
        $requestedFile = $request.Url.LocalPath.TrimStart('/')
        if ($requestedFile -eq '' -or $requestedFile -eq '/') {
            $requestedFile = 'index.html'
        }
        
        $filePath = Join-Path $PWD $requestedFile
        
        if (Test-Path $filePath -PathType Leaf) {
            # File exists, serve it
            $content = [System.IO.File]::ReadAllBytes($filePath)
            $response.ContentLength64 = $content.Length
            
            # Set content type based on file extension
            $extension = [System.IO.Path]::GetExtension($filePath).ToLower()
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
            
            $response.StatusCode = 200
            $response.OutputStream.Write($content, 0, $content.Length)
        } else {
            # File not found
            $response.StatusCode = 404
            $errorContent = [System.Text.Encoding]::UTF8.GetBytes('404 - File Not Found')
            $response.ContentLength64 = $errorContent.Length
            $response.OutputStream.Write($errorContent, 0, $errorContent.Length)
        }
        
        $response.OutputStream.Close()
        
        Write-Host "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $($request.HttpMethod) $($request.Url.LocalPath) - $($response.StatusCode)"
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)"
} finally {
    $listener.Stop()
    Write-Host "Server stopped."
}