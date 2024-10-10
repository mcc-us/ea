---
layout: post
title: f843.pdf
---

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

