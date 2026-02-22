/* ============================================
   AJAY SHARMA — GROWTH PM PORTFOLIO
   Main JavaScript Engine
   ============================================ */

document.addEventListener('DOMContentLoaded', () => {
    initThemeToggle();
    initNavbar();
    initHeroCanvas();
    initWordReveal();
    initScrollAnimations();
    initCounters();
    initAccordion();
    initMobileMenu();
    setActiveNavLink();
    initLifecycleDiagram();
});

/* ============================================
   NAVBAR — Scroll State
   ============================================ */
function initNavbar() {
    const navbar = document.querySelector('.navbar');
    if (!navbar) return;

    const onScroll = () => {
        if (window.scrollY > 40) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    };

    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
}

/* ============================================
   ACTIVE NAV LINK
   ============================================ */
function setActiveNavLink() {
    const path = window.location.pathname;
    const links = document.querySelectorAll('.nav-links a:not(.nav-cta)');

    links.forEach(link => {
        const href = link.getAttribute('href');
        if (!href) return;

        const isHome = (href === 'index.html' || href === '/' || href === './');
        const isCurrentHome = (path.endsWith('/') || path.endsWith('index.html') || path === '');

        if (isHome && isCurrentHome) {
            link.classList.add('active');
        } else if (path.endsWith(href)) {
            link.classList.add('active');
        }
    });
}

/* ============================================
   MOBILE MENU
   ============================================ */
function initMobileMenu() {
    const toggle = document.querySelector('.nav-toggle');
    const navLinks = document.querySelector('.nav-links');
    if (!toggle || !navLinks) return;

    toggle.addEventListener('click', () => {
        toggle.classList.toggle('active');
        navLinks.classList.toggle('active');
        document.body.style.overflow = navLinks.classList.contains('active') ? 'hidden' : '';
    });

    // Close on link click
    navLinks.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', () => {
            toggle.classList.remove('active');
            navLinks.classList.remove('active');
            document.body.style.overflow = '';
        });
    });
}

/* ============================================
   HERO CANVAS — Particle Grid Background
   Lightweight animated dot-grid with connections
   ============================================ */
function initHeroCanvas() {
    const canvas = document.getElementById('hero-canvas');
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    let particles = [];
    let animId;
    const PARTICLE_COUNT = 60;
    const CONNECTION_DIST = 120;
    const ACCENT = { r: 62, g: 204, b: 144 };

    function resize() {
        const section = canvas.parentElement;
        canvas.width = section.offsetWidth;
        canvas.height = section.offsetHeight;
    }

    function createParticles() {
        particles = [];
        for (let i = 0; i < PARTICLE_COUNT; i++) {
            particles.push({
                x: Math.random() * canvas.width,
                y: Math.random() * canvas.height,
                vx: (Math.random() - 0.5) * 0.4,
                vy: (Math.random() - 0.5) * 0.4,
                r: Math.random() * 1.5 + 0.5
            });
        }
    }

    function draw() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        // Draw connections
        for (let i = 0; i < particles.length; i++) {
            for (let j = i + 1; j < particles.length; j++) {
                const dx = particles[i].x - particles[j].x;
                const dy = particles[i].y - particles[j].y;
                const dist = Math.sqrt(dx * dx + dy * dy);
                if (dist < CONNECTION_DIST) {
                    const alpha = (1 - dist / CONNECTION_DIST) * 0.15;
                    ctx.beginPath();
                    ctx.moveTo(particles[i].x, particles[i].y);
                    ctx.lineTo(particles[j].x, particles[j].y);
                    ctx.strokeStyle = `rgba(${ACCENT.r},${ACCENT.g},${ACCENT.b},${alpha})`;
                    ctx.lineWidth = 0.5;
                    ctx.stroke();
                }
            }
        }

        // Draw particles
        particles.forEach(p => {
            ctx.beginPath();
            ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
            ctx.fillStyle = `rgba(${ACCENT.r},${ACCENT.g},${ACCENT.b},0.5)`;
            ctx.fill();

            // Move
            p.x += p.vx;
            p.y += p.vy;

            // Wrap
            if (p.x < 0) p.x = canvas.width;
            if (p.x > canvas.width) p.x = 0;
            if (p.y < 0) p.y = canvas.height;
            if (p.y > canvas.height) p.y = 0;
        });

        animId = requestAnimationFrame(draw);
    }

    resize();
    createParticles();
    draw();

    window.addEventListener('resize', () => {
        resize();
        createParticles();
    });
}

/* ============================================
   WORD-BY-WORD HERO REVEAL
   ============================================ */
function initWordReveal() {
    const heading = document.querySelector('.hero-heading');
    if (!heading) return;

    const words = heading.querySelectorAll('.word');
    words.forEach((word, i) => {
        setTimeout(() => {
            word.classList.add('revealed');
        }, 300 + i * 100);
    });
}

/* ============================================
   SCROLL ANIMATIONS — IntersectionObserver
   ============================================ */
function initScrollAnimations() {
    const elements = document.querySelectorAll('.fade-in-up');
    if (!elements.length) return;

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.1,
        rootMargin: '0px 0px -40px 0px'
    });

    elements.forEach(el => observer.observe(el));
}

/* ============================================
   ANIMATED COUNTERS
   ============================================ */
function initCounters() {
    const counters = document.querySelectorAll('[data-count]');
    if (!counters.length) return;

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                animateCounter(entry.target);
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });

    counters.forEach(el => observer.observe(el));
}

function animateCounter(el) {
    const target = parseFloat(el.dataset.count);
    const suffix = el.dataset.suffix || '';
    const isDecimal = target % 1 !== 0;
    const duration = 1500;
    const startTime = performance.now();

    function update(currentTime) {
        const elapsed = currentTime - startTime;
        const progress = Math.min(elapsed / duration, 1);
        // Ease out cubic
        const eased = 1 - Math.pow(1 - progress, 3);
        const current = eased * target;

        if (isDecimal) {
            el.textContent = current.toFixed(1) + suffix;
        } else {
            el.textContent = Math.floor(current) + suffix;
        }

        if (progress < 1) {
            requestAnimationFrame(update);
        }
    }

    requestAnimationFrame(update);
}

/* ============================================
   FAQ ACCORDION
   ============================================ */
function initAccordion() {
    const items = document.querySelectorAll('.faq-item');
    if (!items.length) return;

    items.forEach(item => {
        const question = item.querySelector('.faq-question');
        const answer = item.querySelector('.faq-answer');
        if (!question || !answer) return;

        question.addEventListener('click', () => {
            const isActive = item.classList.contains('active');

            // Close all
            items.forEach(i => {
                i.classList.remove('active');
                const a = i.querySelector('.faq-answer');
                if (a) a.style.maxHeight = '0';
            });

            // Open clicked if was closed
            if (!isActive) {
                item.classList.add('active');
                answer.style.maxHeight = answer.scrollHeight + 'px';
            }
        });
    });
}

/* ============================================
   THEME TOGGLE — Light / Dark Mode
   ============================================ */
/* ============================================
   LIFECYCLE DIAGRAM — Sequential Reveal + Tooltips
   ============================================ */
function initLifecycleDiagram() {
    const svg = document.getElementById('lifecycle-svg');
    if (!svg) return;

    const nodes = svg.querySelectorAll('.lc-node');
    if (!nodes.length) return;

    const maxIdx = Math.max(...Array.from(nodes).map(n => parseInt(n.dataset.idx || '0')));

    function revealSequentially() {
        for (let idx = 0; idx <= maxIdx; idx++) {
            const delay = idx * 200;
            nodes.forEach(n => {
                if (parseInt(n.dataset.idx) === idx) {
                    setTimeout(() => { n.classList.add('active'); }, delay);
                }
            });
        }
        // Start pulse animation after nodes are revealed
        setTimeout(() => startPulseAnimation(svg), (maxIdx + 1) * 200 + 400);
    }

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                revealSequentially();
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.05 });

    observer.observe(svg);

    // Tooltips
    const VB_W = 1400, TIP_W = 260, TIP_H = 28, TIP_PAD = 8;
    svg.addEventListener('mouseover', (e) => {
        const node = e.target.closest('.lc-node[data-tip]');
        if (!node) return;
        svg.querySelectorAll('.lc-hover-tip').forEach(t => t.remove());
        const rect = node.querySelector('rect');
        if (!rect) return;
        let cx = parseFloat(rect.getAttribute('x')) + parseFloat(rect.getAttribute('width')) / 2;
        let bgX = cx - TIP_W / 2;
        let bgY = parseFloat(rect.getAttribute('y')) - 12 - TIP_H;
        if (bgX < TIP_PAD) bgX = TIP_PAD;
        if (bgX + TIP_W > VB_W - TIP_PAD) bgX = VB_W - TIP_PAD - TIP_W;
        if (bgY < TIP_PAD) bgY = parseFloat(rect.getAttribute('y')) + parseFloat(rect.getAttribute('height')) + 8;
        const isDark = document.documentElement.getAttribute('data-theme') !== 'light';
        const bg = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
        bg.setAttribute('x', bgX); bg.setAttribute('y', bgY);
        bg.setAttribute('width', TIP_W); bg.setAttribute('height', TIP_H);
        bg.setAttribute('rx', 6);
        bg.setAttribute('fill', isDark ? 'rgba(13,42,26,0.97)' : 'rgba(255,255,255,0.97)');
        bg.setAttribute('stroke', '#3ECC90'); bg.setAttribute('stroke-width', '0.8');
        bg.classList.add('lc-hover-tip'); svg.appendChild(bg);
        const tip = document.createElementNS('http://www.w3.org/2000/svg', 'text');
        tip.setAttribute('x', bgX + TIP_W / 2); tip.setAttribute('y', bgY + TIP_H / 2 + 4);
        tip.setAttribute('text-anchor', 'middle');
        tip.setAttribute('fill', isDark ? '#3ECC90' : '#1a6b48');
        tip.setAttribute('font-family', 'Inter, sans-serif'); tip.setAttribute('font-size', '10');
        tip.textContent = node.dataset.tip;
        tip.classList.add('lc-hover-tip'); svg.appendChild(tip);
    });
    svg.addEventListener('mouseout', (e) => {
        if (!e.target.closest('.lc-node[data-tip]')) {
            svg.querySelectorAll('.lc-hover-tip').forEach(t => t.remove());
        }
    });
}

/* ============================================
   PULSE ANIMATION ENGINE
   JS-driven pulse traveling along connector paths
   ============================================ */
function startPulseAnimation(svg) {
    // Animation sequence: each phase is an array of {id, reverse?} objects
    // Parallel paths within a phase all animate simultaneously
    const sequence = [
        { paths: ['c-user-idea', 'c-market-idea', 'c-data-idea', 'c-stake-idea', 'c-biz-idea'] },
        { paths: ['c-idea-val'] },
        { paths: ['c-val-road'] },
        { paths: ['c-road-prd'] },
        { paths: ['c-prd-sprint'] },
        { paths: ['c-sprint-test'] },
        { paths: ['c-test-alpha', 'c-test-beta'] },
        { paths: ['c-test-alpha', 'c-test-beta'], reverse: true },
        { paths: ['c-test-gtm'] },
        { paths: ['c-gtm-ab', 'c-ab-data'] },
        { paths: ['c-feedback'] }
    ];

    const SPEED = 120; // SVG units per second
    const MIN_DURATION = 600; // minimum ms per phase
    const PHASE_GAP = 150; // ms gap between phases
    const LOOP_GAP = 800; // ms gap before looping

    function createDot() {
        const c = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
        c.setAttribute('r', '4');
        c.setAttribute('fill', 'var(--lc-accent)');
        c.setAttribute('filter', 'url(#lcGlow)');
        svg.appendChild(c);
        return c;
    }

    function animatePhase(phaseIdx) {
        if (phaseIdx >= sequence.length) {
            setTimeout(() => animatePhase(0), LOOP_GAP);
            return;
        }

        const phase = sequence[phaseIdx];
        const isReverse = phase.reverse || false;
        const pathEls = phase.paths.map(id => svg.getElementById(id)).filter(Boolean);
        if (!pathEls.length) { animatePhase(phaseIdx + 1); return; }

        const lengths = pathEls.map(p => p.getTotalLength());
        const maxLen = Math.max(...lengths);
        const duration = Math.max((maxLen / SPEED) * 1000, MIN_DURATION);

        const dots = pathEls.map(() => createDot());
        const startTime = performance.now();

        function frame(now) {
            const t = Math.min((now - startTime) / duration, 1);

            pathEls.forEach((path, i) => {
                const len = lengths[i];
                const dist = isReverse ? len * (1 - t) : len * t;
                const pt = path.getPointAtLength(dist);
                dots[i].setAttribute('cx', pt.x);
                dots[i].setAttribute('cy', pt.y);
            });

            if (t < 1) {
                requestAnimationFrame(frame);
            } else {
                dots.forEach(d => d.remove());
                setTimeout(() => animatePhase(phaseIdx + 1), PHASE_GAP);
            }
        }

        requestAnimationFrame(frame);
    }

    animatePhase(0);
}

function initThemeToggle() {
    const STORAGE_KEY = 'ajay-theme';
    const html = document.documentElement;

    // Determine initial theme
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved) {
        html.setAttribute('data-theme', saved);
    } else {
        // Respect system preference on first visit
        const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
        html.setAttribute('data-theme', prefersDark ? 'dark' : 'light');
    }

    // Listen for system changes if no saved preference
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
        if (!localStorage.getItem(STORAGE_KEY)) {
            html.setAttribute('data-theme', e.matches ? 'dark' : 'light');
        }
    });

    // Bind toggle buttons (one per page)
    document.querySelectorAll('.theme-toggle').forEach(btn => {
        btn.addEventListener('click', () => {
            const current = html.getAttribute('data-theme') || 'dark';
            const next = current === 'dark' ? 'light' : 'dark';
            html.setAttribute('data-theme', next);
            localStorage.setItem(STORAGE_KEY, next);
        });
    });
}
