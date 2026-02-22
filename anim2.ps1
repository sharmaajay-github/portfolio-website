# Animation 2: Replace about page SVG with full Product Lifecycle diagram
$file = "Portfolio/about.html"
$c = Get-Content $file -Raw

$oldSvg = '(?s)<div class="hero-image-placeholder fade-in-up">.*?</div>'
$newSvg = @'
<div class="hero-image-placeholder fade-in-up">
                    <svg id="lifecycle-svg" viewBox="0 0 800 1200" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:100%;height:auto;max-width:800px;">
                        <style>
                            #lifecycle-svg { --lc-accent: #3ECC90; --lc-fill: #0F1A14; --lc-stroke: rgba(62,204,144,0.3); --lc-text: #EAEDE8; --lc-muted: rgba(62,204,144,0.15); --lc-primary-fill: #0D2A1A; }
                            [data-theme="light"] #lifecycle-svg { --lc-fill: #FFFFFF; --lc-text: #1a1a1a; --lc-primary-fill: #e8f5f0; --lc-stroke: rgba(62,204,144,0.4); }

                            .lc-node { opacity: 0; transition: opacity 0.8s ease, filter 0.3s ease; }
                            .lc-node.active { opacity: 1; }
                            .lc-connector { stroke-dasharray: 1000; stroke-dashoffset: 1000; transition: stroke-dashoffset 0.8s ease; }
                            .lc-connector.drawn { stroke-dashoffset: 0; }

                            .lc-node:hover rect, .lc-node:hover { filter: drop-shadow(0 0 8px rgba(62,204,144,0.5)); cursor: pointer; }

                            .lc-input rect { fill: var(--lc-fill); stroke: rgba(62,204,144,0.2); stroke-width: 1; }
                            .lc-standard rect { fill: var(--lc-fill); stroke: var(--lc-stroke); stroke-width: 1.5; }
                            .lc-primary rect { fill: var(--lc-primary-fill); stroke: var(--lc-accent); stroke-width: 2; }
                            .lc-node text { fill: var(--lc-text); font-family: Inter, sans-serif; font-size: 12px; }
                            .lc-primary text { font-weight: 700; font-size: 14px; }

                            /* Tooltip */
                            .lc-tooltip { opacity: 0; transition: opacity 0.3s ease; pointer-events: none; }
                            .lc-node:hover + .lc-tooltip, .lc-node:hover ~ .lc-tooltip { opacity: 1; }

                            /* Roadmap glow */
                            @keyframes roadmapGlow { 0%,100% { filter: drop-shadow(0 0 4px rgba(62,204,144,0.2)); } 50% { filter: drop-shadow(0 0 10px rgba(62,204,144,0.5)); } }
                            .lc-roadmap { animation: roadmapGlow 3s ease-in-out infinite; }

                            /* Pulse dot */
                            @keyframes lcPulseTravel { 0% { offset-distance: 0%; } 100% { offset-distance: 100%; } }
                            .lc-pulse-dot { offset-path: path('M400,68 L400,130 L400,210 L400,300 L400,390 L400,490 L400,570 L400,650 L400,740 L320,820 M400,740 L480,820 M400,740 L400,830 L400,920 L320,1000 M400,920 L480,1000'); animation: lcPulseTravel 8s linear infinite; opacity: 0.8; }
                        </style>

                        <defs>
                            <filter id="lcGlow"><feGaussianBlur stdDeviation="3" result="blur"/><feMerge><feMergeNode in="blur"/><feMergeNode in="SourceGraphic"/></feMerge></filter>
                        </defs>

                        <!-- ========== LAYER 1: INPUT NODES ========== -->
                        <!-- Business -->
                        <g class="lc-node lc-input" data-idx="0" data-tip="Strategic objectives driving product direction">
                            <rect x="30" y="30" width="100" height="36" rx="10"/>
                            <text x="80" y="53" text-anchor="middle">Business</text>
                        </g>
                        <!-- Stakeholders -->
                        <g class="lc-node lc-input" data-idx="1" data-tip="Internal and external stakeholder requirements">
                            <rect x="180" y="30" width="110" height="36" rx="10"/>
                            <text x="235" y="53" text-anchor="middle">Stakeholders</text>
                        </g>
                        <!-- Data -->
                        <g class="lc-node lc-input" data-idx="2" data-tip="Analytics, metrics, and behavioral insights">
                            <rect x="345" y="30" width="100" height="36" rx="10" id="data-input-node"/>
                            <text x="395" y="53" text-anchor="middle">Data</text>
                        </g>
                        <!-- Users -->
                        <g class="lc-node lc-input" data-idx="3" data-tip="User research, interviews, and feedback signals">
                            <rect x="500" y="30" width="100" height="36" rx="10"/>
                            <text x="550" y="53" text-anchor="middle">Users</text>
                        </g>
                        <!-- Market -->
                        <g class="lc-node lc-input" data-idx="4" data-tip="Competitive landscape and market trends">
                            <rect x="660" y="30" width="100" height="36" rx="10"/>
                            <text x="710" y="53" text-anchor="middle">Market</text>
                        </g>

                        <!-- Layer 1 → Layer 2 connectors -->
                        <path class="lc-connector" data-idx="5" d="M80,66 Q80,100 400,130" stroke="var(--lc-stroke)" stroke-width="1" fill="none"/>
                        <path class="lc-connector" data-idx="5" d="M235,66 Q235,100 400,130" stroke="var(--lc-stroke)" stroke-width="1" fill="none"/>
                        <path class="lc-connector" data-idx="5" d="M395,66 L400,130" stroke="var(--lc-stroke)" stroke-width="1" fill="none"/>
                        <path class="lc-connector" data-idx="5" d="M550,66 Q550,100 400,130" stroke="var(--lc-stroke)" stroke-width="1" fill="none"/>
                        <path class="lc-connector" data-idx="5" d="M710,66 Q710,100 400,130" stroke="var(--lc-stroke)" stroke-width="1" fill="none"/>

                        <!-- ========== LAYER 2: IDEATION ========== -->
                        <g class="lc-node lc-standard" data-idx="6" data-tip="Brainstorming and idea generation from all inputs">
                            <rect x="330" y="130" width="140" height="40" rx="10"/>
                            <text x="400" y="155" text-anchor="middle">Ideation</text>
                        </g>
                        <path class="lc-connector" data-idx="7" d="M400,170 L400,210" stroke="var(--lc-stroke)" stroke-width="1.5" fill="none"/>

                        <!-- ========== LAYER 3: VALIDATION ========== -->
                        <g class="lc-node lc-standard" data-idx="8" data-tip="Hypothesis testing and user validation">
                            <rect x="330" y="210" width="140" height="40" rx="10"/>
                            <text x="400" y="235" text-anchor="middle">Validation</text>
                        </g>
                        <path class="lc-connector" data-idx="9" d="M400,250 L400,300" stroke="var(--lc-stroke)" stroke-width="1.5" fill="none"/>

                        <!-- ========== LAYER 4: PRIORITIZATION ========== -->
                        <g class="lc-node lc-standard" data-idx="10" data-tip="Scoring and ranking features by impact and effort">
                            <rect x="320" y="300" width="160" height="40" rx="10"/>
                            <text x="400" y="325" text-anchor="middle">Prioritization</text>
                        </g>
                        <path class="lc-connector" data-idx="11" d="M400,340 L400,390" stroke="var(--lc-stroke)" stroke-width="1.5" fill="none"/>

                        <!-- ========== LAYER 5: PRODUCT ROADMAP ========== -->
                        <g class="lc-node lc-primary lc-roadmap" data-idx="12" data-tip="The strategic roadmap — the north star of execution">
                            <rect x="300" y="390" width="200" height="48" rx="10"/>
                            <text x="400" y="420" text-anchor="middle">Product Roadmap</text>
                        </g>
                        <path class="lc-connector" data-idx="13" d="M400,438 L400,490" stroke="var(--lc-accent)" stroke-width="1.5" fill="none" opacity="0.6"/>

                        <!-- ========== LAYER 6: EXECUTION CHAIN ========== -->
                        <!-- PRDs -->
                        <g class="lc-node lc-standard" data-idx="14" data-tip="Product requirement documents defining what to build">
                            <rect x="340" y="490" width="120" height="40" rx="10"/>
                            <text x="400" y="515" text-anchor="middle">PRDs</text>
                        </g>
                        <path class="lc-connector" data-idx="15" d="M400,530 L400,570" stroke="var(--lc-stroke)" stroke-width="1.5" fill="none"/>

                        <!-- Product Backlog -->
                        <g class="lc-node lc-standard" data-idx="16" data-tip="Ordered list of features and tasks to build">
                            <rect x="320" y="570" width="160" height="40" rx="10"/>
                            <text x="400" y="595" text-anchor="middle">Product Backlog</text>
                        </g>
                        <path class="lc-connector" data-idx="17" d="M400,610 L400,650" stroke="var(--lc-stroke)" stroke-width="1.5" fill="none"/>

                        <!-- Sprints -->
                        <g class="lc-node lc-standard" data-idx="18" data-tip="Time-boxed development cycles for iterative delivery">
                            <rect x="340" y="650" width="120" height="40" rx="10"/>
                            <text x="400" y="675" text-anchor="middle">Sprints</text>
                        </g>
                        <path class="lc-connector" data-idx="19" d="M400,690 L400,730" stroke="var(--lc-stroke)" stroke-width="1.5" fill="none"/>

                        <!-- ========== LAYER 7: TESTING ========== -->
                        <g class="lc-node lc-standard" data-idx="20" data-tip="Quality assurance across alpha and beta stages">
                            <rect x="340" y="730" width="120" height="40" rx="10"/>
                            <text x="400" y="755" text-anchor="middle">Testing</text>
                        </g>
                        <!-- Branch to Alpha and Beta -->
                        <path class="lc-connector" data-idx="21" d="M370,770 L310,810" stroke="var(--lc-stroke)" stroke-width="1" fill="none"/>
                        <path class="lc-connector" data-idx="21" d="M430,770 L490,810" stroke="var(--lc-stroke)" stroke-width="1" fill="none"/>

                        <!-- Alpha -->
                        <g class="lc-node lc-input" data-idx="22" data-tip="Internal testing with controlled user group">
                            <rect x="260" y="810" width="100" height="36" rx="10"/>
                            <text x="310" y="833" text-anchor="middle">Alpha</text>
                        </g>
                        <!-- Beta -->
                        <g class="lc-node lc-input" data-idx="22" data-tip="External testing with broader user base">
                            <rect x="440" y="810" width="100" height="36" rx="10"/>
                            <text x="490" y="833" text-anchor="middle">Beta</text>
                        </g>

                        <!-- Alpha & Beta reconnect to main flow -->
                        <path class="lc-connector" data-idx="23" d="M310,846 Q310,880 400,890" stroke="var(--lc-stroke)" stroke-width="1" fill="none"/>
                        <path class="lc-connector" data-idx="23" d="M490,846 Q490,880 400,890" stroke="var(--lc-stroke)" stroke-width="1" fill="none"/>

                        <!-- Merge point to GTM -->
                        <path class="lc-connector" data-idx="24" d="M400,890 L400,920" stroke="var(--lc-stroke)" stroke-width="1.5" fill="none"/>

                        <!-- ========== LAYER 8: GTM ========== -->
                        <g class="lc-node lc-standard" data-idx="25" data-tip="Go-to-market strategy and launch execution">
                            <rect x="350" y="920" width="100" height="40" rx="10"/>
                            <text x="400" y="945" text-anchor="middle">GTM</text>
                        </g>
                        <!-- Branch to A/B Testing and Data -->
                        <path class="lc-connector" data-idx="26" d="M370,960 L310,1000" stroke="var(--lc-stroke)" stroke-width="1" fill="none"/>
                        <path class="lc-connector" data-idx="26" d="M430,960 L490,1000" stroke="var(--lc-stroke)" stroke-width="1" fill="none"/>

                        <!-- A/B Testing -->
                        <g class="lc-node lc-input" data-idx="27" data-tip="Controlled experiments to optimize conversion">
                            <rect x="250" y="1000" width="120" height="36" rx="10"/>
                            <text x="310" y="1023" text-anchor="middle">A/B Testing</text>
                        </g>
                        <!-- Data (output) -->
                        <g class="lc-node lc-input" data-idx="27" data-tip="Performance data feeding back into the cycle">
                            <rect x="430" y="1000" width="120" height="36" rx="10"/>
                            <text x="490" y="1023" text-anchor="middle">Data</text>
                        </g>

                        <!-- ========== LAYER 9: FEEDBACK MERGE ========== -->
                        <!-- A/B Testing and Data merge into a line -->
                        <path class="lc-connector" data-idx="28" d="M310,1036 Q310,1070 400,1080" stroke="var(--lc-accent)" stroke-width="1" fill="none"/>
                        <path class="lc-connector" data-idx="28" d="M490,1036 Q490,1070 400,1080" stroke="var(--lc-accent)" stroke-width="1" fill="none"/>

                        <!-- Feedback badge on merge line -->
                        <rect x="365" y="1068" width="70" height="24" rx="12" fill="var(--lc-accent)" opacity="0.15" class="lc-node" data-idx="29"/>
                        <text x="400" y="1085" text-anchor="middle" fill="var(--lc-accent)" font-family="JetBrains Mono, monospace" font-size="10" font-weight="600" letter-spacing="1" class="lc-node" data-idx="29" opacity="0.9">Feedback</text>

                        <!-- Feedback loop: curved dashed line back to Data input node in Layer 1 -->
                        <path class="lc-connector" data-idx="30" d="M400,1092 Q400,1130 730,1130 Q780,1130 780,900 Q780,300 780,50 Q780,20 710,48" stroke="var(--lc-accent)" stroke-width="1.5" stroke-dasharray="6 4" fill="none" opacity="0.5"/>
                        <!-- Arrow at feedback endpoint -->
                        <polygon points="714,42 706,50 710,54" fill="var(--lc-accent)" opacity="0.5" class="lc-node" data-idx="30"/>

                        <!-- Feedback loop label -->
                        <text x="790" y="600" text-anchor="middle" fill="var(--lc-accent)" font-family="JetBrains Mono, monospace" font-size="8" letter-spacing="1" opacity="0.4" transform="rotate(90 790 600)" class="lc-node" data-idx="30">FEEDBACK LOOP</text>

                        <!-- Traveling pulse dot (main path) -->
                        <circle r="4" fill="var(--lc-accent)" filter="url(#lcGlow)" class="lc-pulse-dot" id="lc-main-pulse"/>
                    </svg>
                </div>
'@

$c = [regex]::Replace($c, $oldSvg, $newSvg, [System.Text.RegularExpressions.RegexOptions]::Singleline)
Set-Content $file $c -NoNewline
Write-Host "about.html lifecycle SVG replaced"
