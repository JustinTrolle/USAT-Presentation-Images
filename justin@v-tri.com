<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Build Connections Across the Community - USA Triathlon</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #0C2340 0%, #1a3a5a 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            overflow: hidden;
        }

        .presentation-container {
            width: 90vw;
            max-width: 1600px;
            aspect-ratio: 16/9;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            overflow: hidden;
            position: relative;
        }

        .slide {
            width: 100%;
            height: 100%;
            display: none;
            flex-direction: column;
            position: relative;
        }

        .slide.active {
            display: flex;
        }

        /* Header Section */
        .header {
            background: linear-gradient(135deg, #0C2340 0%, #1a3a5a 100%);
            padding: 3vh 4vw;
            color: white;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 40%;
            height: 200%;
            background: rgba(255, 255, 255, 0.05);
            transform: rotate(-15deg);
        }

        .header-logo-left {
            width: 15vw;
            height: 10vh;
            position: relative;
            z-index: 2;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logo-container {
            width: 8vw;
            height: 8vw;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 3px solid rgba(227, 24, 55, 0.6);
            backdrop-filter: blur(10px);
            box-shadow: 0 0 20px rgba(227, 24, 55, 0.4);
            animation: flipLeftLogo 2s ease-in-out forwards;
        }

        @keyframes flipLeftLogo {
            from {
                transform: rotate(180deg);
            }
            to {
                transform: rotate(0deg);
            }
        }

        .logo-inner {
            width: 6vw;
            height: 6vw;
            background: linear-gradient(135deg, #E31837 0%, #c01530 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5vw;
            font-weight: bold;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            animation: pulse 2s ease-in-out infinite;
        }

        .logo-inner img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            border-radius: 50%;
        }

        .header-content {
            flex: 1;
            text-align: center;
            position: relative;
            z-index: 2;
            padding: 0 2vw;
        }

        .logo-text {
            font-size: 2.2vw;
            font-weight: bold;
            margin-bottom: 0.5vh;
            letter-spacing: 4px;
            text-transform: uppercase;
        }

        .objective-number {
            font-size: 1.3vw;
            color: #E31837;
            font-weight: bold;
            margin-bottom: 0.5vh;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .objective-title {
            font-size: 1.8vw;
            font-weight: 600;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            line-height: 1.3;
        }

        .header-logo-right {
            width: 15vw;
            height: 10vh;
            position: relative;
            z-index: 2;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logo-badge {
            width: 9vw;
            height: 9vw;
            background: linear-gradient(135deg, rgba(75, 124, 155, 0.3) 0%, rgba(75, 124, 155, 0.1) 100%);
            border-radius: 20%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 3px solid rgba(75, 124, 155, 0.6);
            animation: flipRightLogo 2s ease-in-out forwards;
            backdrop-filter: blur(10px);
            box-shadow: 0 0 20px rgba(75, 124, 155, 0.4);
            transform-style: preserve-3d;
        }

        @keyframes flipRightLogo {
            from {
                transform: rotate(-180deg);
            }
            to {
                transform: rotate(0deg);
            }
        }

        .badge-content {
            font-size: 1.2vw;
            font-weight: bold;
            color: white;
            text-align: center;
            line-height: 1.3;
        }

        .badge-content img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            border-radius: 20%;
        }

        .badge-year {
            font-size: 2vw;
            color: #E31837;
            text-shadow: 0 0 10px rgba(227, 24, 55, 0.5);
        }

        /* Content Section */
        .content {
            flex: 1;
            padding: 4vh 5vw;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        /* Slide 1 - Overview */
        .goal-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 3vh 3vw;
            border-radius: 15px;
            border-left: 8px solid #E31837;
            margin-bottom: 3vh;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            animation: slideInLeft 0.8s ease-out;
        }

        .goal-title {
            color: #0C2340;
            font-size: 1.8vw;
            font-weight: bold;
            margin-bottom: 2vh;
        }

        .goal-text {
            color: #333;
            font-size: 1.3vw;
            line-height: 1.6;
        }

        /* Community Network Visualization */
        .network-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2vw;
            margin-top: 3vh;
        }

        .community-node {
            background: white;
            padding: 2vh 1.5vw;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: all 0.4s ease;
            animation: fadeInUp 0.8s ease-out;
            position: relative;
            border: 2px solid transparent;
            cursor: pointer;
        }

        .community-node:nth-child(1) { animation-delay: 0.2s; }
        .community-node:nth-child(2) { animation-delay: 0.4s; }
        .community-node:nth-child(3) { animation-delay: 0.6s; }

        .community-node:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 20px rgba(75, 124, 155, 0.4);
            border-color: #4B7C9B;
        }

        .community-node.activated {
            border-color: #E31837;
            background: linear-gradient(135deg, #ffffff 0%, #fef5f6 100%);
            animation: pulseNode 2s ease-in-out infinite;
        }

        @keyframes pulseNode {
            0%, 100% {
                box-shadow: 0 4px 12px rgba(227, 24, 55, 0.2);
            }
            50% {
                box-shadow: 0 8px 24px rgba(227, 24, 55, 0.4);
            }
        }

        .node-icon {
            font-size: 3vw;
            margin-bottom: 1vh;
            transition: transform 0.3s ease;
        }

        .community-node:hover .node-icon,
        .community-node.activated .node-icon {
            transform: scale(1.15);
        }

        .node-title {
            font-size: 1.4vw;
            font-weight: bold;
            color: #0C2340;
            margin-bottom: 1vh;
        }

        .community-node.activated .node-title {
            color: #E31837;
        }

        .node-description {
            font-size: 1vw;
            color: #666;
            line-height: 1.4;
        }

        /* Navigation */
        .navigation {
            position: absolute;
            bottom: 2vh;
            right: 3vw;
            display: flex;
            gap: 1vw;
            z-index: 10;
        }

        .nav-btn {
            background: #E31837;
            color: white;
            border: none;
            padding: 1vh 2vw;
            font-size: 1.2vw;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(227, 24, 55, 0.3);
        }

        .nav-btn:hover:not(:disabled) {
            background: #c01530;
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(227, 24, 55, 0.5);
        }

        .nav-btn:disabled {
            background: #D6D6D6;
            cursor: not-allowed;
            transform: scale(1);
            box-shadow: none;
            color: #666;
        }

        .slide-indicator {
            position: absolute;
            bottom: 2vh;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 0.5vw;
        }

        .indicator-dot {
            width: 0.8vw;
            height: 0.8vw;
            border-radius: 50%;
            background: #D6D6D6;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .indicator-dot.active {
            background: #E31837;
            transform: scale(1.3);
            box-shadow: 0 0 8px rgba(227, 24, 55, 0.6);
        }

        .indicator-dot:hover:not(.active) {
            background: #4B7C9B;
            transform: scale(1.15);
        }

        /* Animations */
        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        /* Slide 2 - Key Measurements */
        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 2vw;
            margin-top: 2vh;
        }

        .kpi-card {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            padding: 2.5vh 2vw;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-top: 5px solid #4B7C9B;
            animation: fadeInUp 0.8s ease-out;
            transition: all 0.4s ease;
            cursor: pointer;
            border: 2px solid transparent;
        }

        .kpi-card:nth-child(1) { animation-delay: 0.1s; }
        .kpi-card:nth-child(2) { animation-delay: 0.2s; }
        .kpi-card:nth-child(3) { animation-delay: 0.3s; }
        .kpi-card:nth-child(4) { animation-delay: 0.4s; }

        .kpi-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(75, 124, 155, 0.3);
            border-color: #4B7C9B;
        }

        .kpi-card.activated {
            border-color: #E31837;
            border-top-color: #E31837;
            background: linear-gradient(135deg, #fef5f6 0%, #ffffff 100%);
            animation: pulseKPI 2s ease-in-out infinite;
        }

        @keyframes pulseKPI {
            0%, 100% {
                box-shadow: 0 4px 12px rgba(227, 24, 55, 0.2);
            }
            50% {
                box-shadow: 0 8px 24px rgba(227, 24, 55, 0.4);
            }
        }

        .kpi-value {
            font-size: 3vw;
            font-weight: bold;
            color: #4B7C9B;
            margin-bottom: 1vh;
            transition: color 0.3s ease;
        }

        .kpi-card.activated .kpi-value {
            color: #E31837;
        }

        .kpi-label {
            font-size: 1.1vw;
            color: #0C2340;
            line-height: 1.4;
        }

        /* Slide 3 - Strategic Focus */
        .strategy-section {
            margin-top: 2vh;
        }

        .strategy-card {
            background: white;
            padding: 2vh 2vw;
            border-radius: 12px;
            margin-bottom: 2vh;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            border-left: 6px solid #4B7C9B;
            animation: slideInLeft 0.8s ease-out;
            transition: all 0.4s ease;
            cursor: pointer;
            border-top: 2px solid transparent;
            border-right: 2px solid transparent;
            border-bottom: 2px solid transparent;
        }

        .strategy-card:nth-child(1) { animation-delay: 0.1s; }
        .strategy-card:nth-child(2) { animation-delay: 0.3s; }

        .strategy-card:hover {
            box-shadow: 0 6px 16px rgba(75, 124, 155, 0.3);
            transform: translateX(5px);
        }

        .strategy-card.activated {
            border-left-color: #E31837;
            border-top-color: #E31837;
            border-right-color: #E31837;
            border-bottom-color: #E31837;
            background: linear-gradient(135deg, #fef5f6 0%, #ffffff 100%);
            animation: pulseStrategy 2s ease-in-out infinite;
        }

        @keyframes pulseStrategy {
            0%, 100% {
                box-shadow: 0 3px 10px rgba(227, 24, 55, 0.2);
            }
            50% {
                box-shadow: 0 6px 20px rgba(227, 24, 55, 0.4);
            }
        }

        .strategy-title {
            font-size: 1.5vw;
            font-weight: bold;
            color: #0C2340;
            margin-bottom: 1vh;
        }

        .strategy-card.activated .strategy-title {
            color: #E31837;
        }

        .strategy-text {
            font-size: 1.1vw;
            color: #555;
            line-height: 1.5;
        }

        .highlight {
            color: #4B7C9B;
            font-weight: bold;
        }

        .strategy-card.activated .highlight {
            color: #E31837;
        }

        /* Responsive adjustments */
        @media (max-width: 1200px) {
            .logo-text { font-size: 2vw; }
            .pillar-title { font-size: 1.5vw; }
            .objective-title { font-size: 3vw; }
            .goal-title { font-size: 2vw; }
            .goal-text { font-size: 1.5vw; }
            .node-title { font-size: 1.6vw; }
            .node-description { font-size: 1.2vw; }
        }
    </style>
</head>
<body>
    <div class="presentation-container">
        <!-- Slide 1: Overview -->
        <div class="slide active" id="slide1">
            <div class="header">
                <div class="header-logo-left">
                    <div class="logo-container">
                        <div class="logo-inner">
                            <!-- To use a PNG image, replace the number with: <img src="path/to/your/logo.png" alt="Logo"> -->
                            1
                        </div>
                    </div>
                </div>
                <div class="header-content">
                    <div class="logo-text">USA TRIATHLON</div>
                    <div class="objective-number">Objective 1:</div>
                    <div class="objective-title">Build Connections Across the Community</div>
                </div>
                <div class="header-logo-right">
                    <div class="logo-badge">
                        <div class="badge-content">
                            <!-- To use a PNG image, replace the text with: <img src="path/to/your/badge.png" alt="Badge"> -->
                            <div class="badge-year">2026</div>
                            <div>Business Plan</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content">
                <div class="goal-card">
                    <div class="goal-title">2026 Goal</div>
                    <div class="goal-text">
                        Foster stronger relationships and collaboration among race directors, coaches, and clubs to cultivate a more unified, informed, and engaged multisport community.
                    </div>
                </div>
                <div class="network-container">
                    <div class="community-node">
                        <div class="node-icon">🏃</div>
                        <div class="node-title">Race Directors</div>
                        <div class="node-description">Event organizers driving quality experiences</div>
                    </div>
                    <div class="community-node">
                        <div class="node-icon">👥</div>
                        <div class="node-title">Coaches</div>
                        <div class="node-description">Certified professionals developing athletes</div>
                    </div>
                    <div class="community-node">
                        <div class="node-icon">🤝</div>
                        <div class="node-title">Clubs</div>
                        <div class="node-description">Community hubs fostering participation</div>
                    </div>
                </div>
            </div>
            <div class="slide-indicator">
                <div class="indicator-dot active"></div>
                <div class="indicator-dot"></div>
                <div class="indicator-dot"></div>
            </div>
            <div class="navigation">
                <button class="nav-btn" onclick="previousSlide()" disabled>← Previous</button>
                <button class="nav-btn" onclick="nextSlide()">Next →</button>
            </div>
        </div>

        <!-- Slide 2: Key Measurements -->
        <div class="slide" id="slide2">
            <div class="header">
                <div class="header-logo-left">
                    <div class="logo-container">
                        <div class="logo-inner">
                            <!-- To use a PNG image, replace the number with: <img src="path/to/your/logo.png" alt="Logo"> -->
                            1
                        </div>
                    </div>
                </div>
                <div class="header-content">
                    <div class="logo-text">USA TRIATHLON</div>
                    <div class="objective-number">Objective 1:</div>
                    <div class="objective-title">Key Performance Indicators</div>
                </div>
                <div class="header-logo-right">
                    <div class="logo-badge">
                        <div class="badge-content">
                            <!-- To use a PNG image, replace the text with: <img src="path/to/your/badge.png" alt="Badge"> -->
                            <div class="badge-year">2026</div>
                            <div>Business Plan</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content">
                <div class="kpi-grid">
                    <div class="kpi-card">
                        <div class="kpi-value">425</div>
                        <div class="kpi-label">Paid Endurance Exchange Attendees</div>
                    </div>
                    <div class="kpi-card">
                        <div class="kpi-value">$284K</div>
                        <div class="kpi-label">Endurance Exchange Revenue Target</div>
                    </div>
                    <div class="kpi-card">
                        <div class="kpi-value">75%</div>
                        <div class="kpi-label">Coach Retention Across All Levels</div>
                    </div>
                    <div class="kpi-card">
                        <div class="kpi-value">90%</div>
                        <div class="kpi-label">Event & Club Retention Rate</div>
                    </div>
                    <div class="kpi-card">
                        <div class="kpi-value">340</div>
                        <div class="kpi-label">Certified Race Directors (from 260)</div>
                    </div>
                    <div class="kpi-card">
                        <div class="kpi-value">75%</div>
                        <div class="kpi-label">Race Directors Complete State of Sport Survey</div>
                    </div>
                </div>
            </div>
            <div class="slide-indicator">
                <div class="indicator-dot"></div>
                <div class="indicator-dot active"></div>
                <div class="indicator-dot"></div>
            </div>
            <div class="navigation">
                <button class="nav-btn" onclick="previousSlide()">← Previous</button>
                <button class="nav-btn" onclick="nextSlide()">Next →</button>
            </div>
        </div>

        <!-- Slide 3: Strategic Focus -->
        <div class="slide" id="slide3">
            <div class="header">
                <div class="header-logo-left">
                    <div class="logo-container">
                        <div class="logo-inner">
                            <!-- To use a PNG image, replace the number with: <img src="path/to/your/logo.png" alt="Logo"> -->
                            1
                        </div>
                    </div>
                </div>
                <div class="header-content">
                    <div class="logo-text">USA TRIATHLON</div>
                    <div class="objective-number">Objective 1:</div>
                    <div class="objective-title">Strategic Focus Areas</div>
                </div>
                <div class="header-logo-right">
                    <div class="logo-badge">
                        <div class="badge-content">
                            <!-- To use a PNG image, replace the text with: <img src="path/to/your/badge.png" alt="Badge"> -->
                            <div class="badge-year">2026</div>
                            <div>Business Plan</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content">
                <div class="strategy-section">
                    <div class="strategy-card">
                        <div class="strategy-title">🎯 Endurance Exchange as Marquee Event</div>
                        <div class="strategy-text">
                            Leverage our in-person conference to drive the highest level of <span class="highlight">education, networking, and collaboration</span> among multisport leaders. Package Race Director sessions as CEUs and coaching content into specialization courses (3-8 CEUs each).
                        </div>
                    </div>
                    <div class="strategy-card">
                        <div class="strategy-title">🌐 Year-Round Engagement</div>
                        <div class="strategy-text">
                            Create alternative opportunities throughout the year leveraging Endurance Exchange content. Distribute recorded sessions, host virtual webinars, and build <span class="highlight">recertification pathways</span> for Certified Race Directors.
                        </div>
                    </div>
                    <div class="strategy-card">
                        <div class="strategy-title">👨‍🏫 Coach Mentorship Program</div>
                        <div class="strategy-text">
                            Launch structured mentorship combining USAT-led theoretical content with one-on-one practical mentorship. Offer <span class="highlight">CEU incentives</span> and accelerated certification pathways for program participants.
                        </div>
                    </div>
                </div>
            </div>
            <div class="slide-indicator">
                <div class="indicator-dot"></div>
                <div class="indicator-dot"></div>
                <div class="indicator-dot active"></div>
            </div>
            <div class="navigation">
                <button class="nav-btn" onclick="previousSlide()">← Previous</button>
                <button class="nav-btn" onclick="nextSlide()" disabled>Next →</button>
            </div>
        </div>
    </div>

    <script>
        let currentSlide = 1;
        const totalSlides = 3;

        function showSlide(n) {
            const slides = document.querySelectorAll('.slide');
            const indicators = document.querySelectorAll('.indicator-dot');
            
            slides.forEach(slide => slide.classList.remove('active'));
            indicators.forEach(dot => dot.classList.remove('active'));
            
            slides[n - 1].classList.add('active');
            indicators[n - 1].classList.add('active');
            
            // Update navigation buttons
            const prevBtns = document.querySelectorAll('.nav-btn:first-child');
            const nextBtns = document.querySelectorAll('.nav-btn:last-child');
            
            prevBtns.forEach(btn => {
                btn.disabled = (n === 1);
            });
            
            nextBtns.forEach(btn => {
                btn.disabled = (n === totalSlides);
            });
        }

        function nextSlide() {
            if (currentSlide < totalSlides) {
                currentSlide++;
                showSlide(currentSlide);
            }
        }

        function previousSlide() {
            if (currentSlide > 1) {
                currentSlide--;
                showSlide(currentSlide);
            }
        }

        // Keyboard navigation
        document.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowRight') nextSlide();
            if (e.key === 'ArrowLeft') previousSlide();
        });

        // Initialize
        showSlide(currentSlide);

        // Add click handlers for community nodes
        document.addEventListener('DOMContentLoaded', () => {
            // Community nodes activation
            const communityNodes = document.querySelectorAll('.community-node');
            communityNodes.forEach(node => {
                node.addEventListener('click', function() {
                    this.classList.toggle('activated');
                });
            });

            // KPI cards activation
            const kpiCards = document.querySelectorAll('.kpi-card');
            kpiCards.forEach(card => {
                card.addEventListener('click', function() {
                    this.classList.toggle('activated');
                });
            });

            // Strategy cards activation
            const strategyCards = document.querySelectorAll('.strategy-card');
            strategyCards.forEach(card => {
                card.addEventListener('click', function() {
                    this.classList.toggle('activated');
                });
            });

            // Indicator dots click navigation
            const indicatorDots = document.querySelectorAll('.indicator-dot');
            indicatorDots.forEach((dot, index) => {
                dot.addEventListener('click', () => {
                    currentSlide = index + 1;
                    showSlide(currentSlide);
                });
            });
        });
    </script>
</body>
</html>
