# ExciteSurf

## Purpose.

This folder contains scripts that are designed to help calculate azimuth-dependent surface wave excitation for different modes, periods, for sources with any depth and moment tensor, and for a range of Earth/Planetary models. 

## Installation.

Clone this repository and add all folders to your MATLAB path. Specifically, you want the 'Constants', 'MATLABver', and 'Eigenfunction_Mats' folders in your MATLAB path.

## Running these codes.

The script that you run to calculate excitation ratios is ExciteSurf_Main.m. 

The only script you should need to *edit* is Setup_Calculation_Parameters.m.

In Setup_Calculation_Parameters.m, you must tell the code 
1. Which surface wave you are interested in (edit the variable RayleighorLove, setting it 1 for Rayleigh and 0 for Love), 
2. Which periods you are interested in, (enter a vector of periods, e.g. [50 100])
3. Which kind of excitation you are interested in (Major-or-Minor-Arc), (1 for Major, 0 for Minor) 
4. The name of your input file (e.g. 'EventList_ExampleInputFile.txt') 
5. How many overtones (MaxN) you want to use, 
6. Which earth model (Velmod) you want to use. (The code comes with the possibilities of using ATL2a,PREM,STW105-C,and TAYAK.
7. Whether you want phase or amplitude predictions.

## Input File Format

In Setup_Calculation_Parameters.m, you need to set up your input file, which contains information 
about every event for which you want to calculate excitation.
The input file is a text file. It should have 8 columns. 
The 1st is depth (in km), 
the next 6 are the independent elements of the moment tensor, in order of Mrr,Mtt,Mpp,Mrt,Mrp,Mtp, 
and the last is the source-station azimuth in degrees. 
Note that if you set the source-station azimuth to 9999 instead of its true 
value, then the code will return the excitation and ratios at the maximum of the radiation pattern. 

We have included several example input files in the folder Example_Input_Files, for different types of faults
as described in their file names, as well as for the USArray dataset used in Hariharan et al., 2021, from Babikoff 
and Dalton, 2019 (EventList_ExampleInputFile.txt).

Once you have set up the input file and the parameters in Setup_Calculation_Parameters.m,
you can run the main script, ExciteSurf_Main.m. 

## Output File Format

The output file contains the raw excitation of each surface wave mode.
Each column corresponds to a different surface wave mode with a different radial order n and also a different period, corresponding to a different angular order.
The first row is the mode number. The second row is the period we wanted to search for. 
The third row is the -actual- period that corresponds to the specific n,l combination of that- 
this is typically extremely close to the period you wanted to find.
Each row below this corresponds to the corresponding row in your input file. 

CAVEATS:
Works only for mode within a certain range, depending on which earth model. 
The code will let you know what modes are not retrieved if we don't have the corresponding eigenfunction saved.

This code is probably not perfect!
We strive to keep it bug-free, but let us know if there are issues.
Please contact Anant Hariharan with any questions. 
ahariharan@ucsb.edu
