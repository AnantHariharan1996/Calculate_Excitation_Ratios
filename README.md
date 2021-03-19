# Calculate_Excitation_Ratios
README: 

This folder contains several scripts that are designed to make calculating excitation ratios a trivial task. 
The main script that you run is Calc_Excitation_Ratios_Main. 
You can do this right now, using the preconfigured settings, if you want
to get a sense for what these codes can do. 
[Note that all calculations assume the oceanic Earth model ATL2a (James et al., 2014)]

To tailor the code for your application, read below:

STEP 0: Untar all the .zip files!!!
The only script you should need to -EDIT- is Setup_Calculation_Parameters.m.
In Setup_Calculation_Parameters.m, you must tell the code 
(1) Which surface wave you are interested in (edit the variable RayleighorLove, setting it 1 for Rayleigh and 0 for Love), 
(2) Which periods you are interested in, (enter a vector of periods, e.g. [50 100])
(3) Which kind of interference you are interested in (Major-or-Minor-Arc), (1 for Major, 0 for Minor) 
(4) The name of your input file (e.g. 'EventList_ExampleInputFile.txt'), and 
(5) Whether you want to make some brief plots of your results (set VisualizeMyResults to 1 if so).
*for (5), the script plots excitation and excitation ratios as a function of depth. 

The other thing you need to set is your input file, which contains information 
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
you can run the main script, Calc_Excitation_Ratios_MAIN.m. 

The other thing you might want to know is the format of the output files 
There are two output files; one contains the raw excitation of each surface wave mode,
and the other contains Overtone/Fundamental mode excitation ratios.
The first output file should have as many columns as there are overtones+1, 
and the second output file should have as many columns as there are overtones. 
In the first, each row contains excitation for the events in the corresponding row in the input file. 
In the second, each row contains excitation ratios for the events in the corresponding row in the input file. 

CAVEATS:
1) For Rayleigh waves, this is currently only set up to work at periods between 25-200s: For the fundamental mode
 and first 50 overtones, it can only do 25,40,50,60,75,80,100,120,125,140,150,175,180, and 200s. 
Although sometimes these periods physically cannot exist at the larger overtones.
The max overtones that exist at periods of [25 40 50 60 80 100 120 140 180] 
would be something like approximatley [50 50 50 46 35 26 23 18 14] 

2) For Love waves, this is only set up to do the FM and first 10 overtones, 
at periods of 50,75,100,125,150,175s.  
Due to approaching L = 1, 
The largest period at B6  available is 150s
The largest period at B7 available is 125s
The largest period at B8 available is 100s
The largest period at B9 available is 100s
The largest period at B10 available is 75s

NOTE that the code will spit out an error if you choose a period/overtone
combination that doesn't have an eigenfunction calculated.  

----
Miscellaneous Notes: 

The folder Branch_Intersection_Calculations also contains two scripts that use equation (1)
in Hariharan et al., 2021 to calculate the intersection distance between the FM and
major-arc overtones, for Rayleigh and Love waves. 

The file ATL2a_DistintersectionList_50Overtones contains this for Rayleigh waves, organized by period
in the left column and each column after corresponding to an increasing overtone number.

The folder atl2a_TUC_br0to50 contains files containing period, grp.vel, and phase vel, for the first 50 overtones
and FM for ATL2a.
----

This code is probably not perfect!
We strive to keep it bug-free, but let us know if there are issues.
Please contact Anant Hariharan or Colleen Dalton with any questions. 
anant_hariharan@brown.edu
colleen_dalton@brown.edu
