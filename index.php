<?php
// Simple PHP router for static files
$request = $_SERVER['REQUEST_URI'];
$path = parse_url($request, PHP_URL_PATH);

// Remove leading slash
$path = ltrim($path, '/');

// If no path specified, serve index.html
if (empty($path)) {
    $path = 'index.html';
}

// Check if file exists
if (file_exists($path)) {
    // Get file extension
    $ext = pathinfo($path, PATHINFO_EXTENSION);
    
    // Set appropriate content type
    switch ($ext) {
        case 'html':
            header('Content-Type: text/html');
            break;
        case 'css':
            header('Content-Type: text/css');
            break;
        case 'js':
            header('Content-Type: application/javascript');
            break;
        case 'png':
            header('Content-Type: image/png');
            break;
        case 'jpg':
        case 'jpeg':
            header('Content-Type: image/jpeg');
            break;
        case 'svg':
            header('Content-Type: image/svg+xml');
            break;
        case 'ttf':
            header('Content-Type: font/ttf');
            break;
        case 'woff2':
            header('Content-Type: font/woff2');
            break;
        case 'otf':
            header('Content-Type: font/otf');
            break;
        default:
            header('Content-Type: text/plain');
    }
    
    // Serve the file
    readfile($path);
} else {
    // File not found
    http_response_code(404);
    echo "File not found: $path";
}
?>