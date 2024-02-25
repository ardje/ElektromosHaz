# ElektromosHaz
Elektromos Ház
# Backgrounds:
* https://www.youtube.com/watch?v=4SXtGIx0x5w (inverter overloads by victron)
* https://www.youtube.com/watch?v=_BOAbYmP1bA (generator optimization)

# Lessons learned from background
* For loads with a cosinus of 0.7, the inverter has to support 200% of that load.
* A single phase motor needs 6x as much starting current as nominal current
* A 3 phase motor needs 3x as much starting current.
* A diesel generator can generate about 3kWh of power per liter when you run it optimally.
* A diesel generator will consume at least 50% of the diesel when idling compared with optimal load.

# Requirements
* Have power for living area
* Always have working power for the building area
* The building area is about 30..70m distance
* Have both: working solutions (diesel generator) and optimisation solutions (diesel to battery and PV)
* Try to have independence of failures

# Available equipment at least
* 6xMPII 48/5000/70
* 3xLynx Distribution
* 1x Cerbo GX

# Specs of MPII 4/5000/70
* Full sustained power at 40C: 16A @ 230V (3.7kW)
* 30m power: 20A @ 230V (5kW)
* Max power: 39A @ 230V for 0.5s (9kW) before overload shutdown
* Minimal current for power assist: 6A
* Max-Current through device and transfer switch: 50A


# Solutions
* Have 2 separate sites with diesel generator (working solution). Very very expensive
* Have 2 separate sites with diesel generator and battery storage for power optimazation.
* Have 2 seperate sites with one diesel generator feeding one and have that site feed the other site.
* Have 1 big site with one diesel generator (3 phase 2 parallel setup, doing 32A sustained per phase)

# Solution
## 2 seperate sites with one diesel and PV generator
For this solution, 2 microgrids are created, with one feeding the other.
### Closet 1
Closet 1 is a minimalist setup: it gets AC-IN, synchronizes with that, feeds the batteries, and does a power assist on the AC-IN.
It can power 3x16A from the batteries on top of the AC-IN.
Closet 1 has 2x300Ah@50V batteries to cope with high battery loads.

### Closet 2
Closet 2 is the primary feed.
AC-IN is connected to a generator for power. The generator should be able to feed at least the lowest PowerAssist level in a 3x2 configuration, which is 12A per phase.
The generator should ideally be at least the size of the inverter setup.
The inverter can charge with around 15A AC or 70A DC per phase. We basically have 6 inverters.
The ideal generator should be one that can generate 10..20kW as optimal condition.
By using a 3x1 setup, we can add AC-PV of around 12kW (1:1 rule).
The AC-PV will be able to directly feed both closet 1 and closet 2.
Next to AC-PV there will be DC-PV that directly feeds into the batteries.
The AC-PV will probably need to be a fronius as the fronius can be controlled through TCP to turn to zero-feed when the generator is also needed, but batteries are close to full.

We need a regular (once a week/month) full charge of the batteries to keep them balanced.
