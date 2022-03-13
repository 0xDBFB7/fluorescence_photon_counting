---
bibliography: ../../documents/references.bib
---

-   [Amplification-free fluorescent nucleic acid detection via
    synchronous photon
    counting](#amplification-free-fluorescent-nucleic-acid-detection-via-synchronous-photon-counting)
-   [This document currently lives at
    GitHub.](#this-document-currently-lives-at-github.)
    -   [Executive summary](#executive-summary)
    -   [Initial state](#initial-state)
    -   [Review](#review)
    -   [Flurophore](#flurophore)
    -   [Simple CMOS image stacking
        detection](#simple-cmos-image-stacking-detection)
    -   [Photomultiplier photon wavelength
        discrimination](#photomultiplier-photon-wavelength-discrimination)
    -   [Possible artifacts and deficiencies in
        ](#possible-artifacts-and-deficiencies-in)
    -   [Preparation and use](#preparation-and-use)
    -   [Cuvette](#cuvette)
    -   [Light source](#light-source)
        -   [Diode laser tests](#diode-laser-tests)
    -   [Filters](#filters)
        -   [Excitation filter used](#excitation-filter-used)
        -   [Emission filters used](#emission-filters-used)
        -   [Gel filter](#gel-filter)
    -   [Electronics](#electronics)
    -   [Time-domain or time-correlated photon
        counting](#time-domain-or-time-correlated-photon-counting)
    -   [Performance and
        characteristics](#performance-and-characteristics)
    -   [Literature review](#literature-review)

# Amplification-free fluorescent nucleic acid detection via synchronous photon counting

# [This document currently lives at GitHub.](https://github.com/0xDBFB7/fluorescence_photon_counting/releases/download/v0.01/fluorescence.pdf)

![image](fluorescence/fluro_1){width="\\textwidth"}

Please pardon the crudity of assembly.

![Pardon the mess.](fluorescence/fluro_2){width="\\textwidth"}

![image](fluorescence/light_source){width="\\textwidth"}

![image](fluorescence/fiber_optic){width="\\textwidth"}

![image](fluorescence/comparator){width="\\textwidth"}

Quartus Prime 18.1 Lite edition

## Executive summary

Cuvette should be opaque or white to avoid autofluro;

## Initial state

real-time

After the dismal failure of luminescent infectivity quantification, and
the lack of success in infecting phage due to the small sample volumes
in use and the wrong phage type. The plaque assay took too long.

\"The excited state lifetime of PG in buffer is very short,
$4 \pm 3 \text{ps}$, but in complex with DNA it increases almost
1000-fold, reaching a value of $4.4 \pm 0.01 \text{ns}$.\"

No provision for magnetic shielding of the PMT was made.

As with many other experiments in this project, many negative results
reported were tainted by the use of such a low sample volume.

The typical method to detect. A quantitative PCR

Such a device is known in biology as a plate reader.

Nanodrop, using 280 nm absorbance. They're also \$10,000.

A crucial advantage. Contrary to luminescence: you have control over
when the excitation and emission light turns on.

Error in luminescence can occur due to variation in detector \"dark
counts\" (a problem that plagued luminescence tests),

Error in fluorescence

This doesn't subtract effects like the excitation light from filter
leakage

Conveniently, T4r has an extraordinarily large genome of approximately
172 kBp dsDNA[@Structure2014]; each virion therefore For comparison, a
fingerprint has between 0.042 and 0.14 ng of DNA [@DNA2019].

While these quantities may sound small, they are not particularly
challenging to detect, and it is not our intention to suggest that this
is a good design that should be replicated. We are simply reporting on
the system that was found to be functional. Designs for systems with
comparable performance and even simpler are reported. Despite the
extremely high detector sensitivity introduced by photon-counting,
similar sensitivity is found. This is probably due to the small
light-collecting area due to the objective, and

## Review

quantifies adenovirus titer with a ssDNA 4.7 kbase genome.

With a GelRed dye and 528/20 (note: BioTek filters are specified as
center wavelength / FWHM).

[@SYBR2012] offer excellent

[@Characterization2010]

Biotium GelGreen has a very specific advantage for this specific
application. To increase the safety of the dye, two flurophore monomers
have been connected into a dimer with a long backbone \"bridge\", all
but preventing it from diffusing through membranes or capsids.

> \"On average, these dimeric dyes have a molecular weight at least 2-3
> times that of SYBR Safe or SYBR Green I and bear two positive charges
> as opposed to only one positive charge for SYBR Safe, for example. The
> much larger sizes as well as the higher charge of GelRed and GelGreen
> render them difficult to cross the cell membranes, thus denying the
> opportunity for the dyes to interfere with any intracellular
> activities, including activities associated with genomic DNA.
> Consequently, GelRed and GelGreen are not only nonmutagenic but also
> noncytotoxic within the dye concentration range normally used for
> nucleic acid gel staining. Furthermore, dimeric dyes such as GelRed
> and GelGreen exhibit exceptional signal-to-noise ratio because the
> dyes self-quench in the absence of nucleic acids to result in very low
> background fluorescence.\"

[@Methods2014]

This has the side effect of making the fluorescence intensity strictly
related to the quantity of genomic material dispersed in the solvent,
not within intact virions.

It is a shame to

I was not able to find information on the thermal degradation of these
dyes, in case it was desired tot inactivate after adding the
fluorophore.

A similar method (using fluroescence microscopy rather than fluorometry
and photon counting) was also used by [@AC2017], and is generally a
common practice in the bioeffects field.

Somewhat more challenging than viewing PCR output on a gel, since the
total quantity of DNA involved is quite low

::: autem
extra credit: how many photons are released?
:::

Unlike luminescence techniques, lock-in is possible

## Flurophore

Luckily, a recent paper has the answer: direct fluorescent detection of
DNA in solution, outside using dyes that bind to (intercalate into) DNA.

the prototypical stain is Ethidium Bromide, but is challenging to obtain
outside certain laboratories. GelGreen is safe, very stable against
photobleaching and long-term storage, inexpensive, and readily
available. GelGreen is an Acridine orange (N-alkylacridinium) dye with a
similar spectra to green fluorescent protein.

the base had integral overcurrent protection, which was triggered a few
times during development - a very useful

For one thing, GelGreen appears to be eminiently stable - samples can be
stored for long periods of time, pre-mixed batches.

bleaching was not obviously an issue. A calibration sample was stored in
a dark area with the dye bound to DNA for several months with less than
4% decay observed[^1].

A surplus Hammamatsu R4220 with HC123 current-limiting base at maximum
sensitivity was used. A low-voltage silicon photomultiplier like ON
Semi's C-Series SiPMs will probably be sufficient in most cases. Unlike
avalanche photodetectors, SPADs and SiPMs have similar gain properties
to PMTs,

(Phi6 uses an RNA - many dyes have different responses to
single-stranded (ss)DNA, dsDNA, or

As noted by \[xi?\], this is a saturating effect; if too many
flurophores intercalate into the DNA the fluorescence is weaker.

GelGreen is also sensitive to ssDNA and ssRNA but with 5 times lower
efficiency. GelGreen absorbs maximally at 272 nm and 507 nm and emits
maximally at 528 nm.[@GelGreen]

![Biotium GelRed/GelGreen fluorescence spectra. Credit Biotium Inc,
reproduced without permission.](gelred_gelgreen){width="50%"}

## Simple CMOS image stacking detection

florescein An f1.2 lens is used.

Notably, contrary to most arrangements, the excitation light was input
through the transparent bottom of the sample holders. They report that
\"the limiting factor is the \[filter leakage; in their paper they refer
to this as noise, distinct from image sensor noise\]\".

An incidental advantage is that a color filter makes it easy to diagnose
issues with the light path. It is clear whether background,

::: toolchain
Lesson learned: color feedback
:::

a 30-s exposure on a cheap camera also almost got there.

An ELP-brand camera USB100W05MT (a common choice in industrial systems)
with an OV9712 sensor was used. guvcview to capture.

From luminescent techniques reported previously, DSLR sensors with long
exposure times are sensitive

from \[\], using ImageJ [@NIH2012] to stack. works great on cheap cmos
cameras - interestingly doesn't work at all on more expensive cameras. -
almost good enough - great for diagnostics

interestingly, the fact that the camera has color is quite valuable;
filtering the green out can increase sensitivity a lot

## Photomultiplier photon wavelength discrimination

Anyone familiar with photomultiplier tube use with

lest you think I know what I'm talking about, I laboured under the
assumption that the pulse height somehwo

[@PMT2007] \"The photomultiplier tube outputs an electrical charge in
proportion to the amount of this scintllation, as a result, the output
pulse height from the photomultiplier \"

\"Does anyone know of a circuit that can discriminate color PMT\"?

only works if scintillator

THE pulse height is equal to the input energy! The PMT can be made
color-sensitive; just subtract

I thought the pulse height

three counters? one above, one at? a lock-in amp would be better\...

fast diode thresholding might work

use one of the stm32f0 boards with comparators

## Possible artifacts and deficiencies in 

This arrangement is patently unsuitable for producing scientific
results, as it has not even been calibrated against a DNA ladder.
Positive control samples were generated by cracking phage capsids of a
known titer in an autoclave and then mixing 1:1 with 1/4000 GelGreen. If
some other process

The sample passed through a microfludic channel [^2]. Adsorption

Instruments should not produce a continuous stream of results.

## Preparation and use

Undiluted GelGreen fluorophore (delivered at 10,000x concentration in a
neat little screw-cap) was kept at room temperature as advised (to
prevent crystallization or precipitation)[^3]. The fluorophore stock
solution was prepared by diluting 2.5 microliters of GelGreen in 10 mL
distilled water in a 15 mL screw-cap Falcon tube (McMaster-Carr
#7979T33) producing a weakly orange solution of \"1/4000\" dilution and
stored at room temperature. Both were kept in light-tight metallized
bags when not in use.

solution of GG in distilled water mixed 50/50 with the sample ("1/8000")
worked great in our case.

The autosampler withdrew approximately 50 microliters of mixed solution
from the 0.4 mL stock tube (referred to as PG1), which was then injected
into an empty 1.5 mL empty sample tube. quantified.

## Cuvette

The custom 1 microliter slide cuvette used for initial testing was CNC
machined from 3 mm transparent Lexan-brand polycarbonate[^4]. After much
mystified head-scratching, it was found that the Lexan substrate was
very highly auto-fluorescent and completely overwhelmed the meagre DNA
signal. This occurred with a separate coupon of Lexan, but was not
observed with clear acrylic or polycarbonate. . That said, it has been
reported that polycarbonate does not auto-fluoresce significantly more
than acrylic [@autofluorescence2006], so it is possible that some other
effect led to this result.

1.5 mL Eppendorf-type clear polypropylene microcentrifuge tubes
(Carolina Premium Sterile Centrifuge tubes, 215245, believed to be MTC
Biotech SureSeal S).

Microwell plates used for luminescence are usually opaque white to
reflect the few precious photons: fluorescence plates are typically
opaque black.

::: toolchain
Lesson learned: beware autofluorescence
:::

## Light source

Argon-gas lasers emit several closely-spaced lines in the visible
spectrum, the most prominent of which is at 488 nm.

Cyan diode lasers emitting at 488 nm can be found on surplus markets.
Modules using SHARP GH04850B2G diode are available, although this
appears to be obsolete.

Due to their coherent emission, eye protection or suitable interlocks
are important when working with lasers. (Are tightly filtered LEDs
coherent?)

lasers are available.

[@Pulsed2010] recommends

### Diode laser tests

Various impromptu tests were made with a 2.5W 445 nm laser cutter.
Commodity blue 445 nm emitters only barely clip the absorption spectrum
of GelGreen, leading to a much lower fluorescence signal and
signal-to-background than higher wavelengths. These observations were
tainted by a very poor optical arrangement and were largely
inconclusive; the 445 nm laser diode alone was never tested with the
final optical arrangement, and may well have proved sufficient. This may
allow the elimination of the excitation filter.

(Note that inexpensive laser cutter modules are often intensity
modulated via PWM rather than via analog current; this can cause great
confusion if not accounted for).

gel doc papers use leds without filters, and paper says narrow leds
exist, talk about results with leds

Blue LEDs \[Cree XLamp XP-E2 Blue Starboard\] are then sufficient for
excitation (though high CRI white LEDs emit more 480 nm blue, green
leakage is too high).

Cree recommends staying below 300% of the continuous power when
modulating an LED.

A white LED with a high color-rendering index (DK) seemed to have more
power in the blue passband; however, green leakage around the filter was
too strong.

Arranging the light source physically at right angles can be
challenging. Using a plastic fiber optic assists in positioning
\"because of the small numerical aperture\". The fiber optic
[@vurek1982nanoliter]

Even a blue LED is visibly green through a

Arranging the light source and detector optical paths at right angles is
the first line of defense against excitation light bleed-through. In
testing, is echoed by [@Optical2011]

> Finally, it is possible to excite a sample from one side and collect
> the fluorescence from the opposite side (Fig. 2.4.3D). While some
> instruments, such as microplate readers, use this approach, it is rare
> because it is difficult to completely prevent scattered excitation
> light from reaching the detector.
>
> Even when thin-film filters with extremely high blocking are used,
> high-angle scattered light can make it through the emission filter,
> since, as shown below, the spectrum of the filter shifts to shorter
> wavelengths for light at higher angles of incidence, thus causing the
> shifted emitter band to overlap with the excitation wavelength band.

[@Optical2011] \"These filters should also be specified to have very low
ripple in the passband, since the narrow laser lines of some lasers
(especially semiconductor diode lasers) can drift over time or with
changing environmental conditions, thus resulting in fluctuations of the
filtered laser power.\"

## Filters

Certainly the most critical aspect of any fluorescence technique is the
filter set used.

Important characteristics include transmission % inside the passband,
optical density outside the passband, and sharp edges without long tails
crossing the so-called Stokes shift[@Stokes2021] between absorption and
emission. Some filters have ripple far from the edge of interest which
must be taken into account when assessing the overall filtering
performance.

[@reichman2000handbook]

[@Optical2011] contributes additional information

Half-inch diameter laser line filters were used here for reasons of
cost. As of this writing, a set of quality GFP filters costs about 4
times as much as a laser line set. Due to narrower pass-bands, perhaps
1/8 optical performance can be expected; in a photon-counting mode,
however, there appears to be ample sensitivity remaining.

Superior filters can almost certainly be found; these were chosen for
convenience.

Gel-docs , with spectra specified using the Wratten scale. These filters
alone do not seem to have optical density values sufficient for
amplification-free quantitation at these levels.

Most commercial microscopes use dichroic beamsplitters, allowing the
excitation and emission beam to go through the same objective, a
technique known as epifluorescence (epi- means same-side). The dichroic
only removes the excitation to the 1% level - you still need the
dielectric filters, and they're really expensive. With fiber optic
excitation at right angles to the objective, excitation scattering was
low enough that the dichroic was unnecessary.

The microscope itself was largely incidental, providing only a base. The
small focal length and aperture of the

A 10/0.25 (10x magnification, 0.25 numerical aperture) objective was
used.

Units reported as AU

### Excitation filter used

One filter, an

::: center
:::

(486 nm is the $n=4$ Balmer line for hydrogen).

(note; this was a limited-stock clearance item that has since been
discontinued. Equivalent filters are readily available from other
suppliers, such as the ThorLabs FL05488-10 or Newport 05LF10-488).

The anti-reflective side faced the LED; the reflective side faced the
fiber optic.

This does mean is filtered before entering the fiber optic. If some
component of the fiber optic assembly were fluorescent, this would
contribute to a background.

ThorLabs FGB7 emission filter superficially looks satisfactory, but the
tails are believed to be too long to be useable.

### Emission filters used

Two filters in series, one:

::: center
:::

Note the confusion that can occur when specifying passband width as
$\pm$ versus FWHM.

This is a long-pass edgepass filter. This is known as a Wratten or Gel
filter; the #16 is known as the Wratten number. [@lide2004crc] has a
table of Wratten filter spectra; the cut-on wavelength (wavelength of
50% transmission) is 530 nm for the #15 and 540 nm for the #16 ($\pm$
circa 3 nm), with 90% maximum transmission. One layer of Kapton tape was
wrapped around the filter to protect other optics from the sharp edges.

Tiffen-brand filters consist of two glass panes sandwiching a plastic
membrane that contains the dye proper. They can be cut to size

The 10 nm FWHM emission filter is much narrower than professional GFP
filters, especially the super-wide edge-pass ones; a lot of photons are
lost that way, decreasing efficiency. However, it still appears to be
more than sufficient.

manuals for gel-docs typically suggest #16 or #15. SYBR recommends #15.

For an even lower-cost system, orange or amber acrylic sheets (typically
used for UV filtering) with similar filtering spectra (e.g. Acrylite
408-5) also exist; such a filter is used on the Carolina gel-doc, for
instance.

::: center
:::

in series with

In general, gel filters appear to have a softer taper

ThorLabs has series of colored glass (\"schott glass\") filters

### Gel filter

Unlike gels or plastic-glass sandwiches, thin-film filters have the
property that the pass-band depends greatly on the angle of incidence as
$$\lambda_{\text{shifted}} = \lambda \sqrt{1-\sin(\theta)^2}$$

The wavelength shifts shorter (bluer) as $\theta$ increases. This can be
a helpful property for creating tunable filters, but is a nuisance here.
This isn't an issue for the excitation filter, but is an issue for the.

Thin-film dielectric filters also age; ThorLabs considers filters to
have a lifetime of 2 years.

Noncollimated light, the the band of a dielectric interference bandpass
filter shifts = $488 * (sqrt(1-(sin(45 deg)/2.08)^2)) = 458$; it only
shortens in wavelength. This would be a problem for the emission filter,
except we're using a colored-glass filter for that side.

Since the LEDs and flurophore emissions are not naturally collimated,
this poses a little bit of an issue. The microscope objective seems to
provide sufficient collimation for the emission filter.

The Edmund filter was unmounted glass. Also, these thin-film filters do
not extend to the edge of the glass. Edge-blackening (\"inked\") filters

The wavelength can also be shifted by a few nm over temperature.

The LED was about 3 cm away, and put through a  3 mm aperture in a piece
of PVC pipe. The output from the filter was directly into the 1 mm
fiber, itself improving the bandpass.

## Electronics

![image](fluorescence/PMT){width="\\textwidth"}

Monitoring the output with a photodiode [^5], a 100 ns switching time
was typical. A modulation frequency of 1 MHz was achievable, but no

While drift in the power supply does not affect the background lock-in,
it can affect run-to-run repeatability.

::: toolchain
Running FPGA designs at varying speeds helps to debug race-condition
related bugs. [^6]
:::

[@Highspeed] [@273337]

take note of potentiometer positions

sketches of light source in inkscape

Atmospheric pressure glow discharge (APGD) plasma generation and surface
modification of aluminum and silicon si (100)

huh! basic Argon discharge emits sharply at 488 nm - with a good fiter,
might work out!

man, most white LEDs just have a notch taken out at 488! That's so
strange!

The problem with lasers is that the only ones with power in the right
spectrum are from china or really expensive.

Noncollimated light, the the band of a dielectric interference bandpass
filter shifts = $488 * (sqrt(1-(sin(45 deg)/2.08)^2)) = 458$; it only
shortens in wavelength. This would be a problem for the emission filter,
except we're using a colored-glass filter for that side.

In fact, if we use a bunch of LEDs, this'll help to

the CRI of the LED determines the amount of cyan light

Clearance section at Edmund Optics is pretty great

dichroic not needed - only does a first order-of-magnitude cut, mainly
important

custom acrylic lightpipe?

## Time-domain or time-correlated photon counting

An even better Phase-shift time domain fluorimetry. Iwata use a 20 MHz
DSO to measure a 5 ns $\tau$ fluorophore. However, this involves a light
source with a fast modulation bandwidth; and in the implementation they
describe, the PMT must be in the voltage mode.

Called time-correlated photon counting.

Another neat technique is to add I/Q

Then your

While there are ways to deconvolve a slow falling edge, there's another
problem: per time interval, the time spent in the excitation-off,
flurophore exponential decay time is proportional to the frequency of
the excitation light. If you're only getting 1000 photons from the
sample per second, the dye lifetime is 5 ns, and you're turning the
light on and off at 1 MHz, you're only getting a \[\] photons from the
exponential decay region. Even with a long exposure, that doesn't seem
to be enough to pick up the decay.

It is also possible to perform flashbulb. [@Instrument1957] abuse of
pmts. Note that as long as average current limits are obeyed, PMTs are
happy to endure very high pulse currents, like flashbulbs for exciting;
no shutters or anything required. Gating the photomultiplier HV is
another technique. Figure out the average current limit for your PMT,
the expected voltage based on your load resistor value and watch that it
never exceeds it.

Another way to pick up this phase shift is to make your lock-in
amplifier phase-sensitive - very simple (a 2x clock put into a flip-flop
divider, then the middle). This also wasn't nearly good enough,
completely useless.

quadrature input

gel tampering

[@Measurement1966]

One might expect, given that white noise has an expectation value of
zero, that this technique would average out to 0, and the signal would
be linearly proportional to time. However, a 1-dimensional random walk
with a uniform step size of 1 is expected to end up $\sqrt{N}$ units
away from the origin after N steps. In the same time, a fluorophore
emitting at a rate of $r=1$ counts per step has an expected value of N
counts (a Poisson distribution has a mean equal to its parameter).
Therefore, $\text{SNR} = \frac{N}{\sqrt{N}} = \sqrt{N}$. Longer exposure
times would therefore provide better precision, but with diminishing
returns.

A more comprehensive consideration [@Signala]

However,

it has been noted that water is a good fluorescence quencher and that
this might be how

If time-domain filtering is sufficient,

Low background is required.

Contrary to standard microscopy, you want as little excitation light to
enter the objective as possible. Using the existing

the input edge is considered a clock; the minimum pulse width limits
apply, but are not clearly specified in the datasheet. In this case
(1/155 mhz) = 6 ns.

However, we had no luck with precipitation.

With the setup we're using and the small quantities, the excitation
light is somewhere around  $10^5$ times as powerful as the emission.
This doesn't seem to be a big issue gel-docs, picking out bands on
gels - they don't usually seem to use excitation filters; however, to
get the excitation bleed-through low enough to do this quantitative
assay, the bleed-through must be really low, and in our testing proper
dielectric filters are required on both the excitation and emission
sides.

There are a few sources of noise:

PMT dark counts Some be filtered out by judicious use of comparator
pulse height threshold, the lock-in takes care of it. A non-issue in our
case. Ambient light leakage It'll be fine. Even with the room lights
Using microscope optics and the lock-in, essentially a non-issue for
use, surprisingly. Some fluorescence microscopes use micron-size
apertures to limit the depth of field to avoid Putting

make Dia diagram of system

The PMT was at maximum sensitivity (in fact, slightly above max voltage)

You might be wondering why the filters are even required - why not just
subtract the excitation bleed-through with a control? Unfortunately, any
miniscule variation in the scattering of the excitation will be orders
of magnitude larger than the fluorescence signal you're looking for.

Some papers discuss adding a third chopper or gate period or
photomultiplier or to measure the drift of the excitation light source.
Putting some feedback in the loop would probably

Silicon photomultipliers like ON's C-Series are almost certainly
sufficient for this application, eliminating the HV requirements of PMTs
at the cost of a smaller active area, requiring a larger lens to collect

half-life is 0.693 times the average lifetime.

Simple spectrally-filtered intensity is good enough.

Polarization is a neat way to filter; linearly polarize the excitation,
the emission comes out whatever orientation the DNA happens to be, which
is usually random. Apparently

## Performance and characteristics

Performance of this arrangement was very satisfactory. A 10-second
integration time, with, produced a background fluorescence signal of
 1500 counts, with per-sample stability of approximately $\pm 1500$
counts. The

## Literature review {#literature-review .unnumbered}

[^1]: pulse_1.pnw line 2567

[^2]: pulse_1.pnw lines 2517

[^3]: pulse_1.pnw line 1367

[^4]: pulse_1.pnw line 1719, 1755

[^5]: pulse_1.pnw line 1879

[^6]: pulse_1.pnw line 1879
