# Animation 1: Replace hero funnel SVG with Discovery→Delivery→Distribution cascade
$file = "Portfolio/index.html"
$c = Get-Content $file -Raw

$oldSvg = '(?s)<!-- Funnel Illustration SVG -->.*?</svg>'
$newSvg = @'
<!-- PM Pipeline: Discovery → Delivery → Distribution -->
                        <svg class="hero-pipeline-svg" viewBox="0 0 400 520" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <style>
                                .hero-pipeline-svg { --pm-accent: #3ECC90; --pm-fill: #0F1A14; --pm-text: #EAEDE8; --pm-muted: rgba(62,204,144,0.4); }
                                [data-theme="light"] .hero-pipeline-svg { --pm-fill: #FFFFFF; --pm-text: #1a1a1a; }

                                /* Sequential glow */
                                @keyframes nodeGlow1 { 0%,100% { opacity: 0.35; } 10%,30% { opacity: 1; } }
                                @keyframes nodeGlow2 { 0%,100% { opacity: 0.35; } 40%,60% { opacity: 1; } }
                                @keyframes nodeGlow3 { 0%,100% { opacity: 0.35; } 70%,90% { opacity: 1; } }
                                @keyframes labelFade1 { 0%,100% { opacity: 0; } 10%,30% { opacity: 0.7; } }
                                @keyframes labelFade2 { 0%,100% { opacity: 0; } 40%,60% { opacity: 0.7; } }
                                @keyframes labelFade3 { 0%,100% { opacity: 0; } 70%,90% { opacity: 0.7; } }
                                @keyframes pulseTravel { 0% { offset-distance: 0%; opacity: 0; } 5% { opacity: 1; } 95% { opacity: 1; } 100% { offset-distance: 100%; opacity: 0; } }

                                .pm-stage-1 { animation: nodeGlow1 6s ease-in-out infinite; }
                                .pm-stage-2 { animation: nodeGlow2 6s ease-in-out infinite; }
                                .pm-stage-3 { animation: nodeGlow3 6s ease-in-out infinite; }
                                .pm-label-1 { animation: labelFade1 6s ease-in-out infinite; }
                                .pm-label-2 { animation: labelFade2 6s ease-in-out infinite; }
                                .pm-label-3 { animation: labelFade3 6s ease-in-out infinite; }

                                .pm-pulse { offset-path: path('M200,95 C200,95 200,140 200,140 C200,180 200,200 200,260 C200,300 200,320 200,320 C200,360 200,400 200,430'); animation: pulseTravel 3s linear infinite; }
                            </style>

                            <!-- Subtle grid background -->
                            <defs>
                                <pattern id="heroGrid" width="30" height="30" patternUnits="userSpaceOnUse">
                                    <path d="M 30 0 L 0 0 0 30" fill="none" stroke="var(--pm-accent)" stroke-width="0.12" opacity="0.2"/>
                                </pattern>
                                <filter id="glowFilter">
                                    <feGaussianBlur stdDeviation="4" result="blur"/>
                                    <feMerge><feMergeNode in="blur"/><feMergeNode in="SourceGraphic"/></feMerge>
                                </filter>
                            </defs>
                            <rect width="400" height="520" fill="url(#heroGrid)" opacity="0.5"/>

                            <!-- ====== CONNECTING PATH ====== -->
                            <path d="M200 95 L200 200" stroke="var(--pm-accent)" stroke-width="1" stroke-dasharray="4 4" opacity="0.2">
                                <animate attributeName="stroke-dashoffset" values="0;-16" dur="1.5s" repeatCount="indefinite"/>
                            </path>
                            <path d="M200 260 L200 370" stroke="var(--pm-accent)" stroke-width="1" stroke-dasharray="4 4" opacity="0.2">
                                <animate attributeName="stroke-dashoffset" values="0;-16" dur="1.5s" begin="0.5s" repeatCount="indefinite"/>
                            </path>

                            <!-- Traveling pulse dot along full path -->
                            <circle r="4" fill="var(--pm-accent)" class="pm-pulse" filter="url(#glowFilter)"/>

                            <!-- ====== NODE 1: DISCOVERY ====== -->
                            <g class="pm-stage-1">
                                <rect x="75" y="40" width="250" height="55" rx="27" fill="var(--pm-fill)" stroke="var(--pm-accent)" stroke-width="1.5" opacity="0.9"/>
                                <!-- Magnifying glass icon -->
                                <circle cx="120" cy="67" r="9" stroke="var(--pm-accent)" stroke-width="1.2" fill="none" opacity="0.8"/>
                                <line x1="127" y1="74" x2="133" y2="80" stroke="var(--pm-accent)" stroke-width="1.2" opacity="0.8"/>
                                <!-- Label -->
                                <text x="210" y="72" text-anchor="middle" fill="var(--pm-text)" font-family="Inter, sans-serif" font-size="16" font-weight="600">Discovery</text>
                            </g>
                            <!-- Micro-label -->
                            <text x="200" y="118" text-anchor="middle" fill="var(--pm-accent)" font-family="JetBrains Mono, monospace" font-size="8" letter-spacing="0.5" class="pm-label-1">Problem Space · User Research · Opportunity</text>

                            <!-- ====== ARROW 1→2 ====== -->
                            <polygon points="195,195 200,205 205,195" fill="var(--pm-accent)" opacity="0.4"/>

                            <!-- ====== NODE 2: DELIVERY ====== -->
                            <g class="pm-stage-2">
                                <rect x="75" y="205" width="250" height="55" rx="27" fill="var(--pm-fill)" stroke="var(--pm-accent)" stroke-width="1.5" opacity="0.9"/>
                                <!-- Rocket icon -->
                                <path d="M118 225 L125 240 L122 240 L122 248 L114 248 L114 240 L111 240 Z" fill="var(--pm-accent)" opacity="0.6"/>
                                <!-- Label -->
                                <text x="210" y="237" text-anchor="middle" fill="var(--pm-text)" font-family="Inter, sans-serif" font-size="16" font-weight="600">Delivery</text>
                            </g>
                            <!-- Micro-label -->
                            <text x="200" y="283" text-anchor="middle" fill="var(--pm-accent)" font-family="JetBrains Mono, monospace" font-size="8" letter-spacing="0.5" class="pm-label-2">Build · Iterate · Ship</text>

                            <!-- ====== ARROW 2→3 ====== -->
                            <polygon points="195,362 200,372 205,362" fill="var(--pm-accent)" opacity="0.4"/>

                            <!-- ====== NODE 3: DISTRIBUTION ====== -->
                            <g class="pm-stage-3">
                                <rect x="75" y="375" width="250" height="55" rx="27" fill="var(--pm-fill)" stroke="var(--pm-accent)" stroke-width="1.5" opacity="0.9"/>
                                <!-- Signal/broadcast icon -->
                                <circle cx="118" cy="402" r="4" fill="var(--pm-accent)" opacity="0.7"/>
                                <path d="M108 392 A14 14 0 0 1 108 412" fill="none" stroke="var(--pm-accent)" stroke-width="1" opacity="0.4"/>
                                <path d="M103 387 A20 20 0 0 1 103 417" fill="none" stroke="var(--pm-accent)" stroke-width="1" opacity="0.25"/>
                                <path d="M128 392 A14 14 0 0 0 128 412" fill="none" stroke="var(--pm-accent)" stroke-width="1" opacity="0.4"/>
                                <path d="M133 387 A20 20 0 0 0 133 417" fill="none" stroke="var(--pm-accent)" stroke-width="1" opacity="0.25"/>
                                <!-- Label -->
                                <text x="210" y="407" text-anchor="middle" fill="var(--pm-text)" font-family="Inter, sans-serif" font-size="16" font-weight="600">Distribution</text>
                            </g>
                            <!-- Micro-label -->
                            <text x="200" y="453" text-anchor="middle" fill="var(--pm-accent)" font-family="JetBrains Mono, monospace" font-size="8" letter-spacing="0.5" class="pm-label-3">GTM · Growth · Feedback Loop</text>

                            <!-- Corner brackets -->
                            <path d="M15 15 L15 5 L25 5" stroke="var(--pm-accent)" stroke-width="0.5" opacity="0.2"/>
                            <path d="M385 505 L385 515 L375 515" stroke="var(--pm-accent)" stroke-width="0.5" opacity="0.2"/>

                            <!-- Bottom annotation -->
                            <text x="200" y="500" text-anchor="middle" fill="var(--pm-accent)" font-family="JetBrains Mono, monospace" font-size="6.5" letter-spacing="2" opacity="0.2">PRODUCT MANAGEMENT PIPELINE</text>
                        </svg>
'@

$c = [regex]::Replace($c, $oldSvg, $newSvg)
Set-Content $file $c -NoNewline
Write-Host "index.html hero SVG replaced"
