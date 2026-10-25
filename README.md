# Sunset Simulator 1.0-dev — B
Manual 30-minute Windows test candidate. Play starts at yellow; 10 min orange; 20 min red; 30 min dark red. Colors interpolate continuously. Pause freezes elapsed time and keeps the glow; Play resumes. Stop removes the overlay and resets to yellow. At completion dark red remains until Stop. A new Play restarts at yellow.
No evening schedule or automatic start. Language and strength can be saved. Existing 1.0 settings are preserved separately. Portable executable requires Windows .NET Framework 4.x. Secure desktops and some exclusive fullscreen content may not show the overlay.
Build: B/source/build.ps1. Start: B/windows/Sunset Simulator.exe. See B/windows/verification.txt for checks and limits. Candidate B is not an approved stable release.
Test — 3 minutes and Test 2 — 30 seconds restart the full color sequence at the selected speed. Pause/resume works in both tests. Stop restores the default 30-minute session.
