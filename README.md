## Setup
```
source /cvmfs/cms.cern.ch/cmsset_default.sh
git clone git@github.com:DryRun/snowmass_biasw
cd snowmass_biasw
git clone git@github.com:DryRun/genproductions -b biasweights
```

## Test
```
cd genproductions/bin/MadGraph5_aMCatNLO
source submit_condor_gridpack_generation.sh wjets ../../../cards/wjets_test
```

Debugging the fortran compilation is currently difficult. You can try interrupting the gridpack script, `cd genproductions/bin/MadGraph5_aMCatNLO/wjets/wjets_gridpack/work/processtmp/Source/BIAS/wjets_bias`, and `make`.
