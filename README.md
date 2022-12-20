# CTMC-NAFLD-fibrosis
# A Continuous-Time Markov Chain Model for Liver Fibrosis in NAFLD and NASH

## Description
-----------
 This is a continuous-time markov chain model employing a next reaction algorithm to predict stages of fibrosis over time in patients with NAFLD and NASH. The model is used to describe fibrosis progression in the absence of an intervention. An example of how parameters may be changed with a pharmacological intervention is also included.

   ## Primary Results  
   -----

This code reproduces figures from *A Continuous-Time Markov Chain Model of Fibrosis Progression in NAFLD and NASH*
 
### Prerequisites
---
MATLAB

This code was written in Matlab (v. 2019b)

## Setup
---
Add all files/directories in this repository to the MATLAB working directory/path.

## Contents
---
### *Scripts and Functions* 
#### Step 1: Fibrosis Progession Parameter fitting
1. `Run_Model_Generate_Figures.m` -> Main Script to generate figures from the manuscript
2. `RunPlaceboFunc.m` -> Fits the model with multiple datasets of fibrosis
3. `Read_in_data.m` -> Formats data input
4. `Fit_Fibrosis_Gen.m` -> Generalized fit fibrosis function
5. `scoreFibrosisModel_Gennan.m` -> Scores the fit to fibrosis model - excluding missing or NaN data
6. `fibrosis_model_construct.m` -> Builds reaction structure used in next reaction algorithm
7.  `run_fibrosis_model_popgen.m` -> population run of fibrosis model
8. `run_fibrosis_model.m` -> Single run of fibrosis model
9. `next_reaction.m` -> Run next reaction algortihm: determines the time to next event in markov chain model for each individual
10. `simdataGenN.m` -> Simulates the trial 500 times with a distribution of patients that matches the trial
11. `cmt_odes.m` -> Function that could be used to convert to odes (currently not used)
12. `ScorestructureGenN.m` -> Generates a structure containing all of the data  from simulation
13. `plot_bar_fibrosis.m` -> Generates bar charts comparing the observed data and model simulations with standard deviation
#### Step 2: Sensitivity Analysis
Changes each parameter from 0.001 to 100 fold, simulates trial and calculates change in average fibrosis score and generates plot of change in fibrosis score vs. parameter fold change 
1. `sensitivity_analysis.m` -> Visualizes sensitivty of change in the average fibrosis score with changes in parameter values
2. `Fit_Fibrosis_test.m`-> Helper function to format data
3. `Read_in_data.m` -> Reads in formatted data
4. `Parameter_sweep.m` -> Cycles through parameters 
5. `simdataGenN.m` -> Simulates the trial multiple times to incorporate variability
6. `Calculate_iterative_change.m`-> Calculates how the fibrosis score changed for each individual
7.`Change_Fib_Score.m` and `Change_Fib_ScoreRSD.m` -> calculates how the average fibrosis score changed and the relative standard deviation

#### Step 3: Effects of Pioglitazone
Pioglitazone is an insulin sensitizer and has been studied in the clinical setting for the treatment of NAFLD. Here, we investigated the effects of pioglitazone on fibrosis progression parameters.

1. `Read_in_Data.m` and `Fit_Fibrosis_test.m` -> Format data for analysis
2. `Estimate_Alpha2.m` ->Fits parameters specific to a clinical trial
3. `Fit_Fibrosis_Distribution_Alpha` -> Uses gentic algorithm to fit placebo effect (alpha) paramters
4. `simdataGenN.m`->Simulates the trial multiple times to incorporate variability
5. `Change_Fib_scoreRSD.m` -> -> Calculates the average change in fibrosis score and the relative standard deviation
6. `Percent_Pop_Improved.m`-> Calculates what percentage of the intial population that stayed the same, improved or worsened
7. `Distributioncheck.m` -> Generates figures plotting final distribution vs. initial distribution

#### Step 4: Percent of population with improved fibrosis score
1. `figure5.m`-> Produces figure 5A from the manuscript
2. `Placebo_simulation_alpha_multDist.m` -> Demonstrates average expected number of progressors in each stage of fibrosis over 12 months
3. `simdataGenN.m`->> Simulates the trial 500 times with a distribution of patients that matches the trial
#### Step 5: Power Analysis
1. `PowerCalculations1.m`-> Calculate the sample size necessary to run a clinical trial
2. `Calc_Boot.m`->  Generate a new data set from bootstrapping from the weighted distribution
3. `Read_in_data.m` & `Fit_Fibrosis_test` -> formats data
4. `Estimate_Alpha2.m`->->Fits parameters specific to a clinical trial
3. `Fit_Fibrosis_Distribution_Alpha` -> Uses gentic algorithm to fit new parameters
4. `simdataGenN.m`->> Simulates the trial 500 times with a distribution of patients that matches the trial
5. `Change_Fib_scoreRSD.m` -> calculates how the average fibrosis score changed and the relative standard deviation
6. `Percent_Pop_Improved.m`-> Calculates what percentage of the intial population stayed the same, improved or worsened
7. `Distributioncheck.m` -> Generates figures plotting final distribution vs. initial distribution

##
## Usage
---
To generate figures from the manuscript:

`Run_Model_Generate_Figures.m `

Figures are saved in pdf format

## Authors
---
Lyndsey F. Meyer*, CJ Musante, Richard Allen

*Correspodence to Lyndsey.Meyer@pfizer.com

![alt text](https://github.com/openPfizer/DigitalHealthData/blob/master/img/osbypfizer.png)

