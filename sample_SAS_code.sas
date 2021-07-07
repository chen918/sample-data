proc import datafile = 'sample_data.csv'
out=data
dbms=CSV;
run;

proc glimmix data=data oddsratio initglm maxopt=200 itdetails;
class hrr  year (ref='2009') provider practice acomacopost;
model y (descending) =aco aco*acopost year cov1 cov2/ dist=binary cl solution;
random intercept yearcnt / subject=hrr type=vc;
random  aco*acopost / subject=provider type=vc;
random intercept yearcnt / subject= practice(provider) group= acomacopost type=vc;
covtest 'practice variation' general 0 0 0 1 0 -1 0,
                                     0 0 0 0 1 0 -1;
run;
