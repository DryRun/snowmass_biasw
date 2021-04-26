C ************************************************************
C Source for the library implementing a bias function that 
C populates the large pt tale of the leading jet. 
C
C The two options of this subroutine, that can be set in
C the run card are:
C    > (double precision) ptj_bias_target_ptj : target ptj value
C    > (double precision) ptj_bias_enhancement_power : exponent
C
C Schematically, the functional form of the enhancement is
C    bias_wgt = [ptj(evt)/mean_ptj]^enhancement_power
C ************************************************************
C
C The following lines are read by MG5aMC to set what are the 
C relevant parameters for this bias module.
C
C  parameters = {}
C

C ************************************************************
C Helpers
C ************************************************************

      subroutine bias_wgt(p, original_weight, bias_weight)
          implicit none
C
C Parameters
C
          include '../../maxparticles.inc'         
          include '../../nexternal.inc'
C
C Accessing the details of the event
C
          include '../../run_config.inc'
          include '../../lhe_event_infos.inc'
C
C Event kinematics
C
          double precision p(0:3,nexternal)
          double precision original_weight, bias_weight
          double precision pTW

C Cut variables, from run card          
          double precision p4(4)
          integer i
          integer j
          integer k
C
C Global variables
C
C
C Mandatory common block to be defined in bias modules
C
          double precision stored_bias_weight
          data stored_bias_weight/1.0d0/          
          logical impact_xsec, requires_full_event_info
C         Don't unweight the bias: we really want a flat distribution
          data impact_xsec/.True./
C         Of course this module does not require the full event
C         information (color, resonances, helicities, etc..)
          data requires_full_event_info/.True./ 
          common/bias/stored_bias_weight,impact_xsec,
     &                requires_full_event_info
C
C Accessingt the details of the event
C
C --------------------
C BEGIN IMPLEMENTATION
C --------------------
          include '../../run.inc'
          include '../../cuts.inc'

          include '../bias.inc'

          p4(1) = 0.
          p4(2) = 0.
          p4(3) = 0.
          p4(4) = 0.

          DO i=1,npart
            IF (jpart(1,i) .eq. 24) THEN
              p4(1) = pb(1,i)
              p4(2) = pb(2,i)
              p4(3) = pb(3,i)
              p4(4) = pb(0,i)
              pTW = sqrt(p4(4)**2 - p4(1)**2 - p4(2)**2 - p4(3)**2)
            ENDIF
          ENDDO

          bias_weight = 1. / (pTW + 0.01)**2

          RETURN
      END subroutine bias_wgt


