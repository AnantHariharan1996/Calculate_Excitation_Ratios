---
title: 'ExciteSW: A MATLAB/Octave tool for calculation of surface wave and overtone excitation from Earthquakes on Earth and other Planetary Bodies'
tags:
  - MATLAB
  - Octave
  - Seismology
  - Surface waves
  - Free oscillations
  - Earthquakes
authors:
  - name: Anant Hariharan
    orcid: 0000-0001-5750-2632
    affiliation: 1 # (Multiple affiliations must be quoted)
  - name: Colleen A. Dalton
    orcid: 0000-0003-0932-7539
    affiliation: 1
affiliations:
 - name: Department of Earth, Environmental, and Planetary Sciences, Brown University, Providence, RI, USA
   index: 1
date: 13 September 2022
bibliography: paper.bib

# Optional fields if submitting to a AAS journal too, see this blog post:
# https://blog.joss.theoj.org/2018/12/a-new-collaboration-with-aas-publishing
---

# Summary

The `ExciteSW` software package allows users to rapidly calculate the radiation pattern as well as source excitation (amplitude) and phase for the Rayleigh and Love wave fundamental mode and overtones generated from an earthquake. By incorporating pre-calculated eigenfunctions, the majority of the computational effort is eliminated and the calculations can be completed extremely rapidly. Options are provided to calculate excitation for homogenous continental and oceanic Earth, Lunar, and Martian models, as well as for a laterally heterogeneous Earth model.

# Statement of need

Measurements of the phase and amplitude of surface waves generated from earthquakes are essential to improve our understanding of Earth structure and earthquake source processes. Successful modeling and use of these measurements requires accurately accounting for the contribution to these measurements from the earthquake of interest, which has a significant impact on the character of surface wave measurements. For instance, studies using surface-wave observables for imaging sometimes implement quality-control steps to eliminate surface wave measurements near nodes in the radiation pattern.

 However, calculating the fundamental-mode and overtone radiation pattern is a non-trivial problem and easy-to-use codes to enable this calculation are non-existent, particularly for applications at the scale of a large dataset of multiple earthquakes and for surface wave overtones. Traditional workflows to do so require solving the surface-wave eigenproblem, which is a computationally difficult task that has been tackled using multiple approaches. The involved nature of this problem has precluded the availability of easy-to-use codes to calculate surface-wave excitation.

`ExciteSW` is an MATLAB package for the calculation of surface-wave radiation pattern and rapid computation of surface-wave phase and amplitude. `ExciteSW` works within a normal-mode framework, and uses a database of pre-calculated eigenfunctions to circumvent the majority of the computational effort in a typical workflow to calculate surface-wave excitation. The code is designed with ease-of-use as a first priority, and only requires a single input file with the source depth and moment tensor specified for earthquakes of interest in order to run. `ExciteSW` was designed to be used by both seismological researchers and by students. The ease of computing surface wave radiation patterns will enable more researchers to conduct nuanced analyses of surface wave measurements by accounting for the contribution from earthquake source parameters. This can allow for accurate comparisons of surface wave measurements and predictions. Furthermore, estimates of overtone excitation can allow scientists to make estimates of overtone contamination in surface-wave measurements due to both minor and major-arc overtone interference, and use these estimates as a means to improve the quality of measured datasets of fundamental-mode dispersion.

# Functionality and Implementation

We implement equation 11.34 in Dahlen \& Tromp as follows:

$$  R = {} & \omega[(|M_{rr} \dot{U_s} + (M_{\theta \theta} + M_{\phi \phi}) r_s^{-1}(U_s-\frac{1}{2} kV_s)) e^{i \pi/4}  \\ & + (-1)^q (\dot{V_s} - r^{-1}_s V_s + k r^{-1}_s U_s)(M_{r \phi} \sin \Psi + M_{r \theta} \cos \Psi) e^{-i \pi/4}  \\ & - k r^{-1}_s V_s[M_{\theta \phi} \sin(2 \Psi) + \frac{1}{2}(M_{\theta \theta}-M_{\phi \phi}) \cos(2 \Psi)] e^{i \pi/4}] $$



$$L = {} & \omega((-1)^q (\dot{W_s} - r^{-1}_s W_s)(M_{r\theta} \sin(\Psi) - M_{r \phi} \cos(\Psi)) e^{-i \pi/4}  \\
& - k r^{-1}_s W_s [\frac{1}{2} (M_{\theta \theta} - M_{\phi\phi}) \sin (2 \Psi) - M_{\theta \phi} \cos (2 \Psi)]e^{i \pi/4})$$

and the source amplitude is the absolute value of R and L and the source phase is the arctangent of the ratio of the real and imaginary components. 


# Mathematics

Single dollars ($) are required for inline mathematics e.g. $f(x) = e^{\pi/x}$

Double dollars make self-standing equations:

$$\Theta(x) = \left\{\begin{array}{l}
0\textrm{ if } x < 0\cr
1\textrm{ else}
\end{array}\right.$$

You can also use plain \LaTeX for equations
\begin{equation}\label{eq:fourier}
\hat f(\omega) = \int_{-\infty}^{\infty} f(x) e^{i\omega x} dx
\end{equation}
and refer to \autoref{eq:fourier} from text.

# Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

If you want to cite a software repository URL (e.g. something on GitHub without a preferred
citation) then you can do it with the example BibTeX entry below for @fidgit.

For a quick reference, the following citation commands can be used:
- `@author:2001`  ->  "Author et al. (2001)"
- `[@author:2001]` -> "(Author et al., 2001)"
- `[@author1:2001; @author2:2001]` -> "(Author1 et al., 2001; Author2 et al., 2002)"

# Figures

Figures can be included like this:
![Caption for example figure.\label{fig:example}](figure.png)
and referenced from text using \autoref{fig:example}.

Figure sizes can be customized by adding an optional second parameter:
![Caption for example figure.](figure.png){ width=20% }

# Acknowledgements

We acknowledge contributions from Brigitta Sipocz, Syrtis Major, and Semyeong
Oh, and support from Kathryn Johnston during the genesis of this project.

# References
