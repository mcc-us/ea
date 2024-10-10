---
layout: post
title: f843.pdf
---

.pdf-container {
    width: 100%;
    height: auto;
    max-width: 100%;
    overflow: hidden;
}

.pdf-container iframe {
    width: 100%;
    height: 100%;
    border: none;
}

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const iframe = document.querySelector(".pdf-container iframe");
        const containerWidth = document.querySelector(".pdf-container").offsetWidth;

        iframe.addEventListener('load', function() {
            iframe.contentWindow.document.body.style.zoom = (containerWidth / iframe.contentWindow.document.body.scrollWidth);
        });
    });
</script>

<div class="pdf-container">
    <iframe src="/ea/assets/pdfs/f843.pdf" height="600" width="100%" allowFullScreen="true"></iframe>
</div>

