gen lMedian_House_Value = log( Median_House_Value )
gen lMedian_Income = log( Median_House_Value )
gen lMedian_Age = log( Median_House_Value ) 
gen lTot_Rooms = log( Median_House_Value )
gen lTot_Bedrooms = log( Median_House_Value )
gen lPopulation = log( Median_House_Value )
gen lHouseholds = log( Median_House_Value )
gen lDistance_to_coast = log( Median_House_Value )
gen lDistance_to_LA = log( Median_House_Value )
gen lDistance_to_SanDiego = log( Median_House_Value )
gen lDistance_to_SanJose = log( Median_House_Value )
gen lDistance_to_SanFrancisco = log( Median_House_Value )

recode Median_Income (0.49/1.25 = 1) (1.250000001/2.6 = 2) (2.6000001/5.2083 = 3) (5.20831/12.5 = 4) (12.5000001/max = 5), gen(Renda_Classes)

label define renda 1 "Lower_Class" 2 "Lower_Middle_Class" 3 "Middle_Class" 4 "Upper_Middle_Class" 5 "Upper_Class

label values Renda_Classes renda
quietly tabulate Renda_Classes , generate( Renda_Classes )

gen maLW = Median_Age*Renda_Classes1
gen maMC = Median_Age*Renda_Classes2
gen maUP = Median_Age*Renda_Classes3
gen maLMC = Median_Age*Renda_Classes4
gen maUMC = Median_Age*Renda_Classes5

gen hhLW = Household*Renda_Classes1
gen hhMC = Household*Renda_Classes2
gen hhUP = Household*Renda_Classes3
gen hhLMC = Household*Renda_Classes4
gen hhUMC = Household*Renda_Classes5

gen ppLW = Population*Renda_Classes1
gen ppMC = Population*Renda_Classes2
gen ppUP = Population*Renda_Classes3
gen ppLMC = Population*Renda_Classes4
gen ppUMC = Population*Renda_Classes5

reg Median_House_Value Median_Income Median_Age Tot_Rooms Tot_Bedrooms Population Households lDistance_to_coast lDistance_to_LA lDistance_to_SanDiego lDistance_to_SanJose lDistance_to_SanFrancisco maMC maUP maLMC maUMC hhMC hhUP hhLMC hhUMC ppMC ppUP ppLMC ppUMC


predict resid_pad1,rstandard

scatter resid_pad1 maLW

gen indiv = _n

scatter resid_pad1 indiv

. scatter resid_pad1 maMC

. scatter resid_pad1 maUP

. scatter resid_pad1 maLMC

. scatter resid_pad1 maUMC

. scatter resid_pad1 hhLW

.  scatter resid_pad1 hhMC

. scatter resid_pad1 hhUP

. scatter resid_pad1 hhLMC

. scatter resid_pad1 hhUMC

.  scatter resid_pad1 ppLW

. scatter resid_pad1 ppMC

. scatter resid_pad1 ppUP

. scatter resid_pad1 ppLMC

. scatter resid_pad1 ppUMC

. scatter resid_pad1 Median_Income

. scatter resid_pad1 Median_Age

. scatter resid_pad1 Tot_Rooms

. scatter resid_pad1 Tot_Bedrooms

. scatter resid_pad1 Population

. scatter resid_pad1 Households

. scatter resid_pad1 lDistance_to_coast

. scatter resid_pad1 lDistance_to_LA

. scatter resid_pad1 lDistance_to_SanDiego

. scatter resid_pad1 lDistance_to_SanJose

. scatter resid_pad1 lDistance_to_SanFrancisco


 ssc install jb

jb resid_pad1
summ resid_pad1, detail
hist resid_pad1, normal
ssc install whitetst
whitetst
qnorm resid_pad1

