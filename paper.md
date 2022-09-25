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

The `ExciteSW` software package allows users to rapidly calculate the frequency-dependent radiation pattern as well as source excitation (amplitude) and phase for the Rayleigh and Love wave fundamental mode and overtones generated from an earthquake. By incorporating pre-calculated eigenfunctions, the majority of the computational effort is eliminated and the calculations can be completed extremely rapidly. Options are provided to calculate excitation for homogenous continental and oceanic Earth, Lunar, and Martian models, as well as for a laterally heterogeneous Earth model.

# Statement of need

Measurements of the frequency-dependent phase and amplitude of surface waves generated from earthquakes are essential to improve our understanding of Earth structure and earthquake source processes. Successful modeling and use of these measurements requires accurately accounting for the contribution to these measurements from the earthquake of interest, which has a significant impact on the character of surface wave measurements. For instance, studies using surface-wave observables for imaging sometimes implement quality-control steps to eliminate surface wave measurements near nodes in the radiation pattern [@godfrey2019comparison].

 However, calculating the fundamental-mode and overtone radiation pattern is a non-trivial problem and easy-to-use codes to enable this calculation are non-existent, particularly for applications at the scale of a large dataset of multiple earthquakes and for surface wave overtones. Traditional workflows to do so require solving the surface-wave eigenproblem, which is a computationally difficult task that has been tackled using multiple approaches. The involved nature of this problem has precluded the availability of easy-to-use codes to calculate surface-wave excitation.

`ExciteSW` is an MATLAB package for the calculation of surface-wave radiation pattern and rapid computation of surface-wave phase and amplitude. `ExciteSW` works within a normal-mode framework, and uses a database of pre-calculated eigenfunctions to circumvent the majority of the computational effort in a typical workflow to calculate surface-wave excitation. The code is designed with ease-of-use as a first priority, and only requires a single input file with the source depth and moment tensor specified for earthquakes of interest in order to run. `ExciteSW` was designed to be used by both researchers and students. The ease of computing surface wave radiation patterns will enable more researchers to conduct nuanced analyses of surface wave measurements by accounting for the contribution from earthquake source parameters. This can allow for accurate comparisons of surface wave measurements and predictions. Furthermore, estimates of overtone excitation can allow scientists to make estimates of overtone contamination in surface-wave measurements due to both minor and major-arc overtone interference, and use these estimates as a means to improve the quality of measured datasets of fundamental-mode dispersion [@hariharan2022controls] by eliminating the impact of overtone interference [@foster2014overtone; @hariharan2020evidence].

# Functionality and Implementation

`ExciteSW` implements equation 11.34 in [@dahlen1998theoretical] as follows:

\begin{equation}\label{eq:Ray}
\begin{array}{l}
 R = \omega[(|M_{rr} \dot{U_s} + (M_{\theta \theta} + M_{\phi \phi}) r_s^{-1}(U_s-\frac{1}{2} kV_s)) e^{i \pi/4}  \\  + (-1)^q (\dot{V_s} - r^{-1}_s V_s + k r^{-1}_s U_s)(M_{r \phi} \sin \Psi + M_{r \theta} \cos \Psi) e^{-i \pi/4}  \\  - k r^{-1}_s V_s[M_{\theta \phi} \sin(2 \Psi) + \frac{1}{2}(M_{\theta \theta}-M_{\phi \phi}) \cos(2 \Psi)] e^{i \pi/4}]
\end{array}
\end{equation}



\begin{equation}\label{eq:Lov}
\begin{array}{l}
L = \omega((-1)^q (\dot{W_s} - r^{-1}_s W_s)(M_{r\theta} \sin(\Psi) - M_{r \phi} \cos(\Psi)) e^{-i \pi/4} - \\ k r^{-1}_s W_s [\frac{1}{2} (M_{\theta \theta} - M_{\phi\phi}) \sin (2 \Psi) - M_{\theta \phi} \cos (2 \Psi)]e^{i \pi/4})
\end{array}
\end{equation}

where $\omega$ is the angular frequency, $k$ is the wavenumber,  $M_n$ represents the components of the moment tensor, $r_s$ is the source radius, $\Psi$ is the azimuth measured counterclockwise from south, $q$ is the wavegroup index, and $U_s$, $V_s$, $W_s$, $\dot{U_s}$, $\dot{V_s}$, and $\dot{W_s}$ are the normalized displacement eigenfunctions and their derivatives, respectively, evaluated at the source depth.

The source amplitude $A_R$ and $A_L$ for Rayleigh and Love waves respectively is the absolute value of $R$ and $L$, and the source phase is obtained by taking the arctangent of the ratio of the real and imaginary components.

To run the code, the user first edits a setup_parameter script to assign whether they are interested in Rayleigh or Love waves, which frequencies(periods) they are interested in, which overtones they are interested in, which wavegroup(major or minor-arc waves) and which velocity model they will use for this calculation. The user must also provide an input file where each row corresponds to an earthquake of interest and the columns contain source depth and moment tensor for every earthquake. Following this, the code will loop over every earthquake, frequency, and overtone that the user is interested in, extracting the value of the displacement eigenfunction at the most relevant source depth and frequency using \autoref{eq:Ray} and \autoref{eq:Lov} to calculate source amplitude and phase. The code loads the eigenfunctions relevant to the velocity model chosen, and for the heterogeneous earth model, the eigenfunction loaded is closest to the earthquake hypocenter, which must be provided in the input file.

# Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.


For a quick reference, the following citation commands can be used:
- `@author:2001`  ->  "Author et al. (2001)"
- `[@author:2001]` -> "(Author et al., 2001)"
- `[@author1:2001; @author2:2001]` -> "(Author1 et al., 2001; Author2 et al., 2002)"

# Figures


# Acknowledgements

We thank Joshua Russell and Yiran Huang for testing and using initial versions of `ExciteSW`.

# References
