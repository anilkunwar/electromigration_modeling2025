# previous test case had eta5 as main eta for h6
# also previously wrong eta_i values in AC kernels
# This test is for the 3-phase KKS model
###########################################################################################################################
# The multicomponent is represented by the suffixes a and b for ternary system A-B-C
# For multiphase system with eta1, eta2, and eta3, the suffixes 1,2 and 3 come after the variables and materials properties  
############################################################################################################################
[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 22 #25 #20 #50 #40 #50 #20
  ny = 28 #25 #20 #50 50 #40 #50 #20
  nz = 0
  xmin = 0
  xmax = 600 #80
  ymin = 0
  ymax = 1000 #50
  zmin = 0
  zmax = 0
  elem_type = QUAD4
[]
#########################################################################################


#########################################################################################
[BCs]
  [./Periodic]
    [./all]
      #auto_direction = 'x y'
      auto_direction = 'y'
      variable = 'ca wa c1a c2a c3a eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
    [../]
  [../]
  
  [./neumann1]
        type = NeumannBC
        boundary = 'left'
        variable = 'eta3'
        value = 0
    [../]
    [./neumann2]
       type = NeumannBC
        boundary = 'right'
        variable = 'eta1'
        value = 0
   [../]
  #[./neumann_pota] #anode Cu
  #     type = NeumannBC
   #     boundary = 'left'
  #      variable = 'pot'
   #     value = 8.50E-11 #-17.0E-11 #-17.0E-11 #j=5.0E+2 A/cm2=5.0E+6 A/m2 = 5.0E-12 A/nm2 grad_u = -j*rho_cu V/m i.e. factor= 1.0/(length_scale)
   #[../]
  # [./dir_potmid] #anode Sn
    #   type = DirichletBC
    #    boundary = 'right'
    #    variable = 'pot'
    #    value = 0.005 #5.0E+2 A/cm2=5.0E+6 A/m2 = 5.0E-12 A/nm2 i.e. factor= 1.0/(length_scale^2)
   #[../]
   [./dir_potleft] #anode Cu
       type = DirichletBC
        boundary = 'left'
        variable = 'pot'
        value = 0.005 #0.005 #5.0E+2 A/cm2=5.0E+6 A/m2 = 5.0E-12 A/nm2 i.e. factor= 1.0/(length_scale^2)
   [../]
   [./neumann_potmid] #anode Sn
       type = NeumannBC
        boundary = 'right'
        variable = 'pot'
        value = -5.50E-10 #-1.75E-8 #-11.0E-10 #-11.0E-10 #5.0E+2 A/cm2=5.0E+6 A/m2 = 5.0E-12 A/nm2 i.e. factor= 1.0/(length_scale^2)
   [../]
   #[./neumann_potmid] #anode Sn
    #   type = NeumannBC
    #    boundary = 'right'
    #    variable = 'pot'
    #    value = -11.0E-10 #-11.0E-10 #5.0E+2 A/cm2=5.0E+6 A/m2 = 5.0E-12 A/nm2 i.e. factor= 1.0/(length_scale^2)
   #[../]
  
   #[./dir_pota] #anode Cu
   #    type = DirichletBC
   #     boundary = 'left'
   #     variable = 'pot'
   #     value = 5.0E-3 #j=5.0E+2 A/cm2=5.0E+6 A/m2 = 5.0E-12 A/nm2 grad_u = -j*rho_cu V/m i.e. factor= 1.0/(length_scale)
   #[../]
   #[./dir_potmid] #anode Sn
   #    type = DirichletBC
   #     boundary = 'right'
   #     variable = 'pot'
   #     value = 0 #5.0E+2 A/cm2=5.0E+6 A/m2 = 5.0E-12 A/nm2 i.e. factor= 1.0/(length_scale^2)
   #[../]

[]
#########################################################################################


#########################################################################################
[AuxVariables]
  [./bnds]
  [../]
  [./Energy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gr_c]
      order = CONSTANT
     family = MONOMIAL
  [../]
[]
#########################################################################################


#########################################################################################

[Variables]
# For A-B-C alloy, cA+cB+cC = 1
# So, DOF = 2 i.e. cA and cB are sufficient to describe the composition of the ternary system A-B-C
############################################
  # potential variable used in SplitCHCRes and kkssplitchcres (global)
  [./wa] #A 
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-02
  [../]
  
#  [./wb] # B
#    order = FIRST
#    family = LAGRANGE
#    ###scaling = 1.0E-02
#  [../]
############################################
 
############################################
  # concentration (global) of A
  [./ca]
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-04
  [../]
  
   # concentration (global) of B
 # [./cb]
 #   order = FIRST
 #   family = LAGRANGE
 #   ###scaling = 1.0E+02
 # [../]
############################################

################################################################ 
# Phase concentrations corresponding to global composition cA
############################################################### 
  # phase concentration 1
  [./c1a]
    order = FIRST
    family = LAGRANGE
    #initial_condition = 0.2
    scaling = 1.0E-04
  [../]
######################

######################
  # phase concentration 2
  [./c2a]
    order = FIRST
    family = LAGRANGE
    #initial_condition = 0.5
    scaling = 1.0E-04
  [../]
######################

######################
  # phase concentration 3
  [./c3a]
    order = FIRST
    family = LAGRANGE
    #initial_condition = 0.8
    scaling = 1.0E-04
  [../]
############################################
################################################################ 
# Phase concentrations corresponding to global composition cB
############################################################### 
  # phase concentration 1
 # [./c1b]
 #   order = FIRST
 #   family = LAGRANGE
 #   #initial_condition = 0.2
 #   ###scaling = 1.0E+02
 # [../]
######################

######################
  # phase concentration 2
#  [./c2b]
#    order = FIRST
#    family = LAGRANGE
#    #initial_condition = 0.5
#    ###scaling = 1.0E+02
#  [../]
######################

######################
  # phase concentration 3
 # [./c3b]
 #   order = FIRST
 #   family = LAGRANGE
 #   #initial_condition = 0.8
 #   ###scaling = 1.0E+02
 # [../]
############################################


############################################
  # order parameter 1 FCC
  [./eta1]
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-04
  [../]
######################

######################
  # order parameter 2 IMC
  [./eta2]
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-04
  [../]
######################

######################
  # order parameter 3 LIQUID
  [./eta3]
    order = FIRST
    family = LAGRANGE
    #initial_condition = 0.0
    scaling = 1.0E-04
  [../]
  
  ######################
  # order parameter 2
  [./eta4]
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-04
  [../]
######################
######################
  # order parameter 2
  [./eta5]
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-04
  [../]
######################
 ######################
  # order parameter 2
  [./eta6]
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-04
  [../]
######################
######################
  # order parameter 2
  [./eta7]
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-04
  [../]
######################
 ######################
  # order parameter 2
  [./eta8]
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-04
  [../]
######################
######################
  # order parameter 2
  [./eta9]
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-04
  [../]
######################
 ######################
  # order parameter 2
  [./eta10]
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-04
  [../]
######################
######################
  # order parameter 2
  [./eta11]
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-04
  [../]
######################
 [./eta12]
    order = FIRST
    family = LAGRANGE
    scaling = 1.0E-04
  [../]
  ###################
     [./pot] 
        initial_condition = 0.005 # V unit 1 mV
        order = FIRST
        family = LAGRANGE
        scaling=1.0E+0
    [../]
[]
#########################################################################################
###########Upto here#####################################


#########################################################################################

[ICs]

############################################
    [./eta1]  # extends from y = 0 to y = 20 , x no change
        variable = eta1
        type = FunctionIC
        function = 'if(x<=200,1,0)'
    [../]
######################

######################    
    [./eta2] # extends from y = 20 to y = 30 , x no change
        variable = eta2
        type = FunctionIC
        #function = 'if(y>20&y<=30,1,0)'
        function = 'if(x>200&x<=250&y>15&y<=75,1,0)'
    [../]
######################
#############Define the initial condition of eta very carefully####################
# The following definition cause convergence difficulty
# function = 'if(y<=200,0,if(y>200&y<=250&x>15&x<=75,0,if(y>200&y<=250&x>105&x<=195,0,if(y>200&y<=250&x>225&x<=315,0,if(y>200&y<=250&x>345&x<=385,0,
#     if(y>200&y<=250&x>415&x<=485,0,if(y>200&y<=250&x>515&x<=565,0,if(y>200&y<=250&x>595&x<=675,0,if(y>200&y<=250&x>705&x<=775,0,if(y>200&y<=250&x>805&x<=885,0,
#     if(y>200&y<=250&x>915&x<=985,1,0)))))))))))'
# This is because the 1,0 definition at 915 <x ,985 and 200 <y<250 enforces two etas : eta3 and eta12 to be in the same region
#################################################################################################################################### 
 [./eta3] # extends from y = 20 to y = 30 , x no change
        variable = eta3
        type = FunctionIC
        #function = 'if(y>30,1,0)'
        function = 'if(x<=200,0,if(x>200&x<=250&y>15&y<=75,0,if(x>200&x<=290&y>105&y<=195,0,if(x>200&x<=290&y>225&y<=315,0,if(x>200&x<=245&y>345&y<=385,0,if(x>200&x<=270&y>415&y<=485,0,if(x>200&x<=250&y>515&y<=565,0,if(x>200&x<=280&y>595&y<=675,0,if(x>200&x<=270&y>705&y<=775,0,if(x>200&x<=280&y>805&y<=885,0,if(x>200&x<=270&y>915&y<=985,0,1)))))))))))'
[../]
######################
    [./eta4] # extends from y = 20 to y = 30 , x no change
        variable = eta4
        type = FunctionIC
        #function = 'if(y>30,1,0)'
        function = 'if(x>200&x<=290&y>105&y<=195,1,0)'
    [../]
############################################
[./eta5] # extends from y = 20 to y = 30 , x no change
        variable = eta5
        type = FunctionIC
        #function = 'if(y>30,1,0)'
        function = 'if(x>200&x<=290&y>225&y<=315,1,0)'
[../]

#################################################
[./eta6] # extends from y = 20 to y = 30 , x no change
        variable = eta6
        type = FunctionIC
        #function = 'if(y>30,1,0)'
        function = 'if(x>200&x<=245&y>345&y<=385,1,0)'
[../]

#################################################
[./eta7] # extends from y = 20 to y = 30 , x no change
        variable = eta7
        type = FunctionIC
        #function = 'if(y>30,1,0)'
        function = 'if(x>200&x<=270&y>415&y<=485,1,0)'
[../]
#################################################
[./eta8] # extends from y = 20 to y = 30 , x no change
        variable = eta8
        type = FunctionIC
        #function = 'if(y>30,1,0)'
        function = 'if(x>200&x<=250&y>515&y<=565,1,0)'
[../]
############################################
#################################################
[./eta9] # extends from y = 20 to y = 30 , x no change
        variable = eta9
        type = FunctionIC
        #function = 'if(y>30,1,0)'
        function = 'if(x>200&x<=280&y>595&y<=675,1,0)'
[../]
############################################
#################################################
[./eta10] # extends from y = 20 to y = 30 , x no change
        variable = eta10
        type = FunctionIC
        #function = 'if(y>30,1,0)'
        function = 'if(x>200&x<=270&y>705&y<=775,1,0)'
[../]
############################################
#################################################
[./eta11] # extends from y = 20 to y = 30 , x no change
        variable = eta11
        type = FunctionIC
        #function = 'if(y>30,1,0)'
        function = 'if(x>200&x<=280&y>805&y<=885,1,0)'
[../]
############################################
#################################################
[./eta12] # extends from y = 20 to y = 30 , x no change
        variable = eta12
        type = FunctionIC
        #function = 'if(y>30,1,0)'
        function = 'if(x>200&x<=270&y>915&y<=985,1,0)'
[../]
############################################
############################################
    [./ca] #Global Composition of A for ternary A-B-C alloy
        variable = ca
        type = FunctionIC
        #function = 'if(y<=20,0.01,0)+if(y>20&y<=30,0.667,0)+if(y>30,0.95,0)'
                   function = '0.1*if(x<=200,1,0)+0.455*if(x>200&x<=250&y>15&y<=75,1,if(x>200&x<=290&y>105&y<=195,1,if(x>200&x<=290&y>225&y<=315,1,if(x>200&x<=245&y>345&y<=385,1,if(x>200&x<=270&y>415&y<=485,1,if(x>200&x<=250&y>515&y<=565,1,if(x>200&x<=280&y>595&y<=675,1,if(x>200&x<=270&y>705&y<=775,1,if(x>200&x<=280&y>805&y<=885,1,if(x>200&x<=270&y>915&y<=985,1,0))))))))))+0.90*if(x<=200,0,if(x>200&x<=250&y>15&y<=75,0,if(x>200&x<=290&y>105&y<=195,0,if(x>200&x<=290&y>225&y<=315,0,if(x>200&x<=245&y>345&y<=385,0,if(x>200&x<=270&y>415&y<=485,0,if(x>200&x<=250&y>515&y<=565,0,if(x>200&x<=280&y>595&y<=675,0,if(x>200&x<=270&y>705&y<=775,0,if(x>200&x<=280&y>805&y<=885,0,if(x>200&x<=270&y>915&y<=985,0,1)))))))))))'      
 [../] 
############################################  
 #[./cb] #Global Composition of B for ternary A-B-C alloy
 #       variable = cb
 #       type = FunctionIC
 #       #function = 'if(y<=20,0.01,0)+if(y>20&y<=30,0.667,0)+if(y>30,0.95,0)'
 #       function = '0.94*if(y<=20,1,0)+0.267*if(y>20&y<=30&x>5&x<=15,1,if(y>20&y<=35&x>20&x<=30,1,if(y>20&y<=30&x>35&x<=45,1,0)))+0.02*if(y<=20,0,if(y>20&y<=30&x>5&x<=15,0,if(y>20&y<=35&x>20&x<=30,0,if(y>20&y<=30&x>35&x<=45,0,1))))'      
# [../]

[]

########################################################################################
#####upto here####################################################################### 08.05.2023 Monday

########################################################################################

[Materials]
##When kappa is increased by a factor of f_kappa=energy_scale/length_scale, simulation converges at factor_f1 = 1.0E+07
# When f_kappa=1, factor_f1 = 1.0E+09
############################################
  # simple toy free energies
  [./f1] # this phase is expected to shrink
    type = DerivativeParsedMaterial
    f_name = F1
    args = 'c1a pot'
    material_property_names = 'length_scale energy_scale Nav echarge zeff1'
    constant_names = 'factor_f1 factor_e1'
    #constant_expressions = '1.0E+06 1.0E+05'
    constant_expressions = '6.14E+07 6.14E+05' # Recommended 6.14E+07 '1.0E+08' '1.0E+08' factor = N/molar_volume here, the division by V_molar ensures that the quantity is free energy density
    function = '(energy_scale/(length_scale)^3) *(167.1*(c1a-0.01)^2 -40.5*(c1a-0.01)-13.0)*factor_f1+(energy_scale/length_scale^3)*(Nav*echarge*pot*(zeff1*0.01))*factor_e1'
    #function = '(energy_scale/(length_scale)^3) *(167.1*(c1a-0.01)^2 -40.5*(c1a-0.01)-13.0)*factor_f1+(energy_scale/length_scale^3)*(Nav*echarge*pot*(zeff1*c1a))*factor_e1'
    #function = '(energy_scale/(length_scale)^3) *(1.239e4*(c1a-0.01)^2 -2000*(c1a-0.01)-1460.0)*factor_f1+(energy_scale/length_scale^3)*(Nav*echarge*pot*(zeff1*c1a))*factor_e1'
    #function = '(energy_scale/(length_scale)^3) *(110.0*(c1a-0.15)^2 -5.0*(c1a-0.15)-5.0)*factor_f1+(energy_scale/length_scale^3)*(Nav*echarge*pot*(zeff1*c1a))*factor_e1'
    #function = '(energy_scale/(length_scale)^3) *(70.6*(c1a-0.2)^2 + 7.2*(c1a-0.2)-9.7)*factor_f1'
    #function = '1.0E+05*(-0.01+0.02*(c1a-0.2)^2)'
  [../]
######################

######################
  [./f2] # this phase is expected to grow
    type = DerivativeParsedMaterial
    f_name = F2
    args = 'c2a pot'
    material_property_names = 'length_scale energy_scale Nav echarge zeff2'
    constant_names = 'factor_f2 factor_e2'
    #constant_expressions = '1.0E+06 1.0E+05'
    constant_expressions = '6.14E+07 6.14E+05' # Recommended 6.14E+07 '1.0E+08' '1.0E+08' factor = N/molar_volume here, the division by V_molar ensures that the quantity is free energy density
    function = '(energy_scale/(length_scale)^3) *(322.5*(c2a-0.39)^2-43.1*(c2a-0.39)-32.4)*factor_f2+(energy_scale/length_scale^3)*(Nav*echarge*pot*(zeff2*0.455))*factor_e2'
    #function = '(energy_scale/(length_scale)^3) *(322.5*(c2a-0.39)^2-43.1*(c2a-0.39)-32.4)*factor_f2+(energy_scale/length_scale^3)*(Nav*echarge*pot*(zeff2*c2a))*factor_e2'
    #function = '(energy_scale/(length_scale)^3) *(2.55e4*(c2a-0.39)^2+0.165e3*(c2a-0.39)-2.97e+03)*factor_f2+(energy_scale/length_scale^3)*(Nav*echarge*pot*(zeff2*c2a))*factor_e2'
    #function = '(energy_scale/(length_scale)^3) *(300.0*(c2a-0.667)^2-5.0*(c2a-0.667)-15.0)*factor_f2+(energy_scale/length_scale^3)*(Nav*echarge*pot*(zeff2*c2a))*factor_e2'
    #function = '(energy_scale/(length_scale)^3) *(690.00*(c2a-0.667)^2+290.00*(c2a-0.667)-20.0)*factor_f2'
    #function = '(energy_scale/(length_scale)^3) *(95.4*(c2a-0.667)^2+34*(c2a-0.667)-20.0)*factor_f2'
  [../]
######################

######################
  [./f3] # this phase is expected to shrink
    type = DerivativeParsedMaterial
    f_name = F3
    args = 'c3a pot'
    material_property_names = 'length_scale energy_scale Nav echarge zeff3'
    constant_names = 'factor_f3 factor_e3'
    #constant_expressions = '1.0E+06 1.0E+05'
    constant_expressions = '6.14E+07 6.14E+05' # Recommended 6.14E+07 '1.0E+08' '1.0E+08' factor = N/molar_volume here, the division by V_molar ensures that the quantity is free energy density
    function = '(energy_scale/(length_scale)^3) *(180.1*(c3a-0.90)^2-9.5*(c3a-0.90)-17.5)*factor_f3+(energy_scale/length_scale^3)*(Nav*echarge*pot*(zeff3*0.9))*factor_e3'
    #function = '(energy_scale/(length_scale)^3) *(180.1*(c3a-0.90)^2-9.5*(c3a-0.90)-17.5)*factor_f3+(energy_scale/length_scale^3)*(Nav*echarge*pot*(zeff3*c3a))*factor_e3'
    #function = '(energy_scale/(length_scale)^3) *(1.921e4*(c3a-0.90)^2+0.054e4*(c3a-0.90)-1660.0)*factor_f3+(energy_scale/length_scale^3)*(Nav*echarge*pot*(zeff3*c3a))*factor_e3'
    #function = '(energy_scale/(length_scale)^3) *(100.0*(c3a-0.95)^2+10*(c3a-0.95)-5.0)*factor_f3+(energy_scale/length_scale^3)*(Nav**pot*(zeff3*c3a))*factor_e3'
    #function = '(energy_scale/(length_scale)^3) *(75.0*(c3a-0.95)^2+15*(c3a-0.95)-8.8)*factor_f3'
  [../]
############################################
  
  
############################################
#SwitchingFunction        ## Eq 10,11 of https://doi.org/10.1016/j.actamat.2010.10.038 A quantitative and thermodynamically Moelans 2011
   [./h1]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h1
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
        phase_etas = eta1
        #outputs = exodus
    [../]
######################
######################

######################
   [./h2]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h2
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
        phase_etas = eta2
        #outputs = exodus
    [../]
######################

######################
    [./h3]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h3
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
        phase_etas = eta3
        #outputs = exodus
    [../] 
############################################

######################
    [./h4]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h4
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
        phase_etas = eta4
        #outputs = exodus
    [../] 
############################################

######################
    [./h5]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h5
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
        phase_etas = eta5
        #outputs = exodus
    [../] 
############################################

######################
    [./h6]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h6
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
        phase_etas = eta6
        #outputs = exodus
    [../] 
############################################
######################
    [./h7]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h7
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
        phase_etas = eta7
        #outputs = exodus
    [../] 
############################################
######################
    [./h8]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h8
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
        phase_etas = eta8
        #outputs = exodus
    [../] 
############################################
######################
    [./h9]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h9
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
        phase_etas = eta9
        #outputs = exodus
    [../] 
############################################
######################
    [./h10]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h10
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
        phase_etas = eta10
        #outputs = exodus
    [../] 
############################################
######################
    [./h11]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h11
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
        phase_etas = eta11
        #outputs = exodus
    [../] 
############################################
######################
    [./h12]
        type = SwitchingFunctionMultiPhaseMaterial
        h_name = h12
        all_etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
        phase_etas = eta12
        #outputs = exodus
    [../] 
############################################




############################################    
    # Barrier functions for each phase
  [./g1]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta1
    function_name = g1
  [../]
######################

######################
  [./g2]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta2
    function_name = g2
  [../]
######################

######################
  [./g3]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta3
    function_name = g3
  [../]
############################################

######################
  [./g4]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta4
    function_name = g4
  [../]
############################################

######################
  [./g5]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta5
    function_name = g5
  [../]
############################################

######################
  [./g6]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta6
    function_name = g6
  [../]
############################################

######################
  [./g7]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta7
    function_name = g7
  [../]
############################################

######################
  [./g8]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta8
    function_name = g8
  [../]
############################################

######################
  [./g9]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta9
    function_name = g9
  [../]
############################################

######################
  [./g10]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta10
    function_name = g10
  [../]
############################################

######################
  [./g11]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta11
    function_name = g11
  [../]
############################################

######################
  [./g12]
    type = BarrierFunctionMaterial
    g_order = SIMPLE
    eta = eta12
    function_name = g12
  [../]
############################################

############################################
# constant properties M is needed by SplitCHWRes kernel

  [./constants_mobility] #maximum limit for convergence 1.0E-17 
    type = GenericConstantMaterial
    prop_names  = 'pseudo_L_si   pseudo_kappa  D  M_si_fcc M_si_imc M_si_liq  pseudo_mu'
    #prop_values = '50   0.5   1  1.0e-24 5.0e-24 8.0e-24   500 '
    prop_values = '50   0.5   1  1.0e-23 5.0e-23 8.0e-23  500 '
    #prop_values = '50   0.5   1  1.0e-23 2.0e-23 1.0e-23  500 '
    #prop_values = '50   0.5   1  1.0e-23 1.0e-23 1.0e-21  500 ' 
    #prop_values = '50   0.5   1  1.0e-22 1.0e-21 1.0e-20  500 ' 
    #prop_values = '50   0.5   1  1.0e-20 1.0e-19 1.0e-18  500 ' # L must be 10 or greater (Eureka for convergence test) Ratio between fbulk to L, M, m and kappa important
    #prop_values = '50   0.5   1  1.0e-19  500 ' # L must be 10 or greater (Eureka for convergence test) Ratio between fbulk to L, M, m and kappa important
    #prop_values = '10  0.5   1  8  1.5 500 ' #Perfect for factor_fi=1.0
    #prop_values = '1000 0.5   1  800 1.5 1000' #perfect
    #prop_values = '100.0 0.5   1  80.0 1.5 1000'
    #prop_values = '50.0 0.5   1  40.0 1.5 500' # converged
    #prop_values = '10.0 0.5   1  10.0 1.5 1000' #solve converged once
    #prop_values = '1.0 1.0    1  1.0 1.5 500' #more more better
    #prop_values = '1.0 1.0    1  1.0 1.5 150' #more more better
    #prop_values = '1.0 5.0    1  1.0 1.5 0.5' # more better
    #prop_values = '0.17 5.0    1  0.1 1.5 0.5' #better
    #prop_values = '0.0017 0.005    1  0.001 1.5 0.05' # no convergence
    #prop_values = '0.017 5.0    1  0.01 1.5 0.5' # good
  [../]
############################################
[./constants_interface]
    type = GenericConstantMaterial
    prop_names  = 'gamma sigma delta length_scale energy_scale time_scale'
    prop_values = '1.5 0.5   50E-09  1e9 6.24150943e18 1.0e9 ' # L must be 10 or greater (Eureka for convergence test) Ratio between fbulk to L, M, m and kappa important
    #prop_values = '1.5 0.5   25E-09  1e9 6.24150943e18 1.0e9 ' # L must be 10 or greater (Eureka for convergence test) Ratio between fbulk to L, M, m and kappa important
    #prop_values = '1.5 0.5   40E-09  1e9 6.24150943e18 1.0e9 ' # L must be 10 or greater (Eureka for convergence test) Ratio between fbulk to L, M, m and kappa important
[../]
  ################################################33
[./kappa]
    type = ParsedMaterial
    material_property_names = 'sigma delta length_scale energy_scale'
    f_name = kappa
    constant_names = 'factor_kappa'
    constant_expressions = '2.5' #'10.0' # 1.0E-1 to make the kappa scaled from 702.225 to 70.225 so that its magnitude is less than scaled fbulk's absolute magnitude
    function = '(energy_scale/length_scale)*0.75*sigma*delta*factor_kappa' #eV/nm
  [../]
  [./mu]
    type = ParsedMaterial
    material_property_names = 'sigma delta length_scale energy_scale'
    f_name = mu
    constant_names = 'factor_mu'
    constant_expressions = '2.5' #'2.50'
    function = '(energy_scale/(length_scale)^3)*6*(sigma/delta)*factor_mu' #eV/nm^3
  [../]
############################################
 [./interface_mobility] # considered the same in isotropic and anisotropic
    type = ParsedMaterial
    #material_property_names = 'M_si mu kappa'
    f_name = L
    constant_names = 'factor_L'
    constant_expressions = '1.0' # To make the scaled quantity in the range of 5
    material_property_names = 'length_scale energy_scale time_scale M mu kappa' # We will later use M_si instead of M because of unit reasons
    function = '((length_scale)^3/(energy_scale*time_scale))*(16/3)*(mu*M/kappa)*factor_L' #l^3/energy*time
  [../]


  [./ch_mobility] # considered the same in isotropic and anisotropic
    type = ParsedMaterial
    #material_property_names = 'M_si'
    f_name = M
    #args = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
    material_property_names = 'length_scale energy_scale time_scale M_si_fcc M_si_imc M_si_liq  M_gb h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    function = '((length_scale)^5/(energy_scale*time_scale))*((h2+h4+h5+h6+h7+h8+h9+h10+h11+h12)*M_si_imc+h1*M_si_fcc+h3*M_si_liq+(h2+h4+h5+h6+h7+h8+h9+h10+h11+h12)*(h2+h4+h5+h6+h7+h8+h9+h10+h11+h12)*M_gb)' #l^5/energy*time
  [../]
  
  [./M_gb]
    type = ParsedMaterial
    material_property_names = 'M_si_imc'
    f_name = M_gb
    #function = '100.0*M_si_imc'
    function = '10*M_si_imc'
    #function = '200*M_si_imc'
  [../]
  
  #########################################
  # Electromigration properties
  [./electromigration_properties] #optimized z
      type = GenericConstantMaterial
      prop_names = 'Vmimc Nav echarge zeff1 zeff2 zeff3 pseudoelectcond'
      prop_values = '16.29E-06 6.0221E+23 -1.6022E-19 6.63 18.835 4.43 5.714E+06' #m to nm J to eV s to h the univt of 16.29E-06 m3/mol
      #prop_values = '16.29E-06 6.0221E+23 -1.6022E-19 0 0 0 5.714E+06' #m to nm J to eV s to h the univt of 16.29E-06 m3/mol
  [../]
  
  [./electriccond] # considered the same in isotropic and anisotropic
    type = ParsedMaterial
    f_name = electcond
    #args = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
    constant_names = 'factor_ec ec_1 ec_2 ec_3 ' # Use Equation 25 of Hektor2016 paper M=sigma_hiMi, where Mi=D_i/A_i and A_i = coeff of parabolic free energy
    constant_expressions = '1.0 0.882E+07 5.714E+06 9.096E+06 ' #m^2 mol/J s mobility of Sn is used as 10E-23 to be near to that of Cu and IMC
    material_property_names = 'length_scale energy_scale time_scale  h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    function = 'factor_ec*(1.0/(length_scale))*(5.714E+06)'
    #function = 'factor_ec*(1.0/(length_scale))*(ec_1*h1+ec_2*(h2+h4+h5+h6+h7+h8+h9+h10+h11+h12)+ec_3*h3)'
  [../]
##################################################3
[]

########################################################################################



########################################################################################

[Kernels]

############################################
######## First put the KKS condition with kernels of phase concentrations (local) related to cA global #######

############################################
# Phase concentration constraints
  [./chempot12a]
    type = KKSPhaseChemicalPotential
    variable = c1a
    cb       = c2a
    fa_name  = F1
    fb_name  = F2
    args_a = 'pot'
  [../]
######################

######################
  [./chempot23a]
    type = KKSPhaseChemicalPotential
    variable = c2a
    cb       = c3a
    fa_name  = F2
    fb_name  = F3
    args_a = 'pot'
  [../]
############################################

######################
  [./chempot31a]
    type = KKSPhaseChemicalPotential
    variable = c3a
    cb       = c1a
    fa_name  = F3
    fb_name  = F1
    args_a = 'pot'
  [../]
############################################

############################################
  [./phaseconcentration_a]
    type = KKSMultiPhaseConcentration
    variable = c3a
    cj = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    hj_names = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    etas = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
    c = ca
  [../]
############################################

############################################
######## First put the KKS condition for kernels of phase concentrations (local) related to cB global #######

############################################
# Phase concentration constraints
#  [./chempot12b]
#    type = KKSPhaseChemicalPotential
#    variable = c1b
#    cb       = c2b
#    fa_name  = F1
#    fb_name  = F2
#  [../]
######################

######################
#  [./chempot23b]
#    type = KKSPhaseChemicalPotential
#    variable = c2b
#    cb       = c3b
#    fa_name  = F2
#    fb_name  = F3
#  [../]
############################################

############################################
#  [./phaseconcentration_b]
#    type = KKSMultiPhaseConcentration
#    variable = c3b
#    cj = 'c1b c2b c3b c2b c2b'
#    hj_names = 'h1 h2 h3 h4 h5'
#    etas = 'eta1 eta2 eta3 eta4 eta5'
#    c = cb
#  [../]
############################################

############################################
## Kernels for split Cahn-Hilliard type equation
    ## CHBulk known as KKSSplitCHCRes is here to replace SplitCHParsed
    ## because in KKS model , gradient energy term is not allowed in the C-H type equation [Tonks2018-ComputationalMaterialsScience,vol. 147, pp.353-362.]
    ## while SplitCHParsed kernel consists of the term k\nabla^2 c_i (thus making it unsuitable here), KKSSplitCHCRes fortunately avoids this term.
    ## Never use SplitCHParsed kernel with KKS model
    ## Because of the KKS condition 1 (equality of chemical potential between any two adjacent phases), one KKSSplitCHCRes kernel (either for c1, c2 or c3) is sufficient and there is no need to put three such kernels corresponding to c1, c2 and c3.

##############################################################################3  
# Diffusion kernels corresponding to phase concentrations of global cA
########################################################################  
#    [./CHBulka] # Gives the residual for the concentration, dF/dc-mu
#        type = KKSSplitCHCRes
#        variable = ca
#        ca       = c2a
#        fa_name  = F2 #only F2 is used
#        w        = wa
#    [../]
############################################
########################################################################  
   [./CHBulka] # Gives the residual for the concentration, dF/dc-mu
        type = KKSSplitCHCRes
        variable = ca
        ca       = c3a
        fa_name  = F3 #only F3 is used
        w        = wa
        args_a = 'pot'
    [../]
############################################

############################################
    [./dcdta] # Gives dc/dt
        type = CoupledTimeDerivative
        variable = wa
        v = ca
    [../]
############################################

############################################    
    [./ckernela] # Gives residual for chemical potential dc/dt+M\grad(mu)
        type = SplitCHWRes
        mob_name = M
        variable = wa
        args = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
    [../]
############################################

##############################################################################3  
# Diffusion kernels corresponding to phase concentrations of global cB
########################################################################  
#    [./CHBulkb] # Gives the residual for the concentration, dF/dc-mu
#        type = KKSSplitCHCRes
#        variable = cb
#        ca       = c2b
#        fa_name  = F2 #only F2 is used
#        w        = wb
#    [../]
############################################

############################################
#    [./dcdtb] # Gives dc/dt
#        type = CoupledTimeDerivative
#        variable = wb
#        v = cb
#    [../]
############################################

############################################    
#    [./ckernelb] # Gives residual for chemical potential dc/dt+M\grad(mu)
#        type = SplitCHWRes
#        mob_name = M
#        variable = wb
#        args = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
#    [../]
############################################

##################################################################

  # Kernels for Allen-Cahn equation for eta1
  
######################  
  [./deta1dt]
    type = TimeDerivative
    variable = eta1
  [../]
######################  
######################################################################################################################################
###################################################################################################################
  [./ACBulkF1]
    type = KKSMultiACBulkF
    variable  = eta1
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gi_name   = g1
    eta_i     = eta1
    wi        = 5.0 #1.0
    args      = 'c1a c2a c3a eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################
###############################################################################################################
# In ACBulkC1, the kernel requires  the definition of a particular element (A or B) as a separate list of vectors
################################################################################################################
######################  
  [./ACBulkC1a]
    type = KKSMultiACBulkC
    variable  = eta1
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    cj_names  = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    eta_i     = eta1
    args      = 'eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################
 #[./ACBulkC1b]
 #   type = KKSMultiACBulkC
 #   variable  = eta1
 #   Fj_names  = 'F1 F2 F3 F2 F2'
 #   hj_names  = 'h1 h2 h3 h4 h5'
 #   cj_names  = 'c1b c2b c3b c2b c2b'
 #   eta_i     = eta1
 #   args      = 'eta2 eta3 eta4 eta5 '
 #   mob_name = L
 # [../]

######################################################################################################################################
######################  
  [./ACInterface1]
    type = ACInterface
    variable = eta1
    kappa_name = kappa
    mob_name = L
  [../]
##################################################################
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta1] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta1
      v = 'eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
      gamma_names = 'gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
[../]
 
##################################################################

  # Kernels for Allen-Cahn equation for eta2
  
######################
  [./deta2dt]
    type = TimeDerivative
    variable = eta2
  [../]
######################

######################  
  [./ACBulkF2]
    type = KKSMultiACBulkF
    variable  = eta2
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gi_name   = g2
    eta_i     = eta2
    wi        = 5.0 #1.0
    args      = 'c1a c2a c3a eta1 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################

######################
  [./ACBulkC2a]
    type = KKSMultiACBulkC
    variable  = eta2
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    cj_names  = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    eta_i     = eta2
    args      = 'eta1 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################
# [./ACBulkC2b]
#    type = KKSMultiACBulkC
#    variable  = eta2
#    Fj_names  = 'F1 F2 F3 F2 F2'
#    hj_names  = 'h1 h2 h3 h4 h5'
#    cj_names  = 'c1b c2b c3b c2b c2b'
#    eta_i     = eta2
#    args      = 'eta1 eta3 eta4 eta5'
#    mob_name = L
#  [../]

######################  
  [./ACInterface2]
    type = ACInterface
    variable = eta2
    kappa_name = kappa
    mob_name = L
  [../]
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
#################################################################
[./ACdfintdeta2] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta2
      v = 'eta1 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
      gamma_names = 'gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta3 eta4 eta5 eta6 eta8 eta9 eta10 eta11 eta12 pot'
[../]
#################################################################
  # Kernels for Allen-Cahn equation for eta4
  
######################
  [./deta4dt]
    type = TimeDerivative
    variable = eta4
  [../]
######################

######################  
  [./ACBulkF4]
    type = KKSMultiACBulkF
    variable  = eta4
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gi_name   = g4
    eta_i     = eta4
    wi        = 5.0 #1.0
    args      = 'c1a c2a c3a eta1 eta3 eta2 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################

######################
  [./ACBulkC4a]
    type = KKSMultiACBulkC
    variable  = eta4
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    cj_names  = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    eta_i     = eta4
    args      = 'eta1 eta3 eta2 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
  
 #  [./ACBulkC4b]
 #   type = KKSMultiACBulkC
 #   variable  = eta2
 #   Fj_names  = 'F1 F2 F3 F2 F2'
 #   hj_names  = 'h1 h2 h3 h4 h5'
 #   cj_names  = 'c1b c2b c3b c2b c2b'
 #   eta_i     = eta4
 #   args      = 'eta1 eta3 eta2 eta5'
 #   mob_name = L
 # [../]
######################

######################  
  [./ACInterface4]
    type = ACInterface
    variable = eta4
    kappa_name = kappa
    mob_name = L
  [../]
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta4] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta4
      v = 'eta1 eta3 eta2 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
      gamma_names = 'gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta3 eta2 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
[../]
###################################################################

  # Kernels for Allen-Cahn equation for eta5
  
######################
  [./deta5dt]
    type = TimeDerivative
    variable = eta5
  [../]
######################

######################  
  [./ACBulkF5]
    type = KKSMultiACBulkF
    variable  = eta5
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gi_name   = g5
    eta_i     = eta5
    wi        = 5.0 #1.0
    args      = 'c1a c2a c3a eta1 eta3 eta2 eta4 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################

######################
  [./ACBulkC5a]
    type = KKSMultiACBulkC
    variable  = eta5
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    cj_names  = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    eta_i     = eta5
    args      = 'eta1 eta3 eta2 eta4 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################
######################
 # [./ACBulkC5b]
 #   type = KKSMultiACBulkC
 #   variable  = eta2
 #   Fj_names  = 'F1 F2 F3 F2 F2'
 #   hj_names  = 'h1 h2 h3 h4 h5'
 #   cj_names  = 'c1b c2b c3b c2b c2b'
 #   eta_i     = eta5
 #   args      = 'eta1 eta3 eta2 eta4'
 #   mob_name = L
 # [../]
######################

######################  
  [./ACInterface5]
    type = ACInterface
    variable = eta5
    kappa_name = kappa
    mob_name = L
  [../]
##################################################################
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta5] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta5
      v = 'eta1 eta3 eta2 eta4 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
      gamma_names = 'gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta3 eta2 eta4 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
[../]
##################################################################
# Kernels for Allen-Cahn equation for eta6
  
######################
  [./deta6dt]
    type = TimeDerivative
    variable = eta6
  [../]
######################

######################  
  [./ACBulkF6]
    type = KKSMultiACBulkF
    variable  = eta6
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gi_name   = g6
    eta_i     = eta6
    wi        = 5.0 #1.0
    args      = 'c1a c2a c3a eta1 eta3 eta2 eta4 eta5 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################

######################
  [./ACBulkC6a]
    type = KKSMultiACBulkC
    variable  = eta6
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    cj_names  = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    eta_i     = eta6
    args      = 'eta1 eta3 eta2 eta4 eta5 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################
######################
 # [./ACBulkC5b]
 #   type = KKSMultiACBulkC
 #   variable  = eta2
 #   Fj_names  = 'F1 F2 F3 F2 F2'
 #   hj_names  = 'h1 h2 h3 h4 h5'
 #   cj_names  = 'c1b c2b c3b c2b c2b'
 #   eta_i     = eta6
 #   args      = 'eta1 eta3 eta2 eta4'
 #   mob_name = L
 # [../]
######################

######################  
  [./ACInterface6]
    type = ACInterface
    variable = eta6
    kappa_name = kappa
    mob_name = L
  [../]
##################################################################
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta6] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta6
      v = 'eta1 eta3 eta2 eta4 eta5 eta7 eta8 eta9 eta10 eta11 eta12'
      gamma_names = 'gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta3 eta2 eta4 eta5 eta7 eta8 eta9 eta10 eta11 eta12 pot'
[../]
##################################################################
##################################################################
# Kernels for Allen-Cahn equation for eta7
  
######################
  [./deta7dt]
    type = TimeDerivative
    variable = eta7
  [../]
######################

######################  
  [./ACBulkF7]
    type = KKSMultiACBulkF
    variable  = eta7
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gi_name   = g7
    eta_i     = eta7
    wi        = 5.0 #1.0
    args      = 'c1a c2a c3a eta1 eta3 eta2 eta4 eta5 eta6 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################

######################
  [./ACBulkC7a]
    type = KKSMultiACBulkC
    variable  = eta7
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    cj_names  = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    eta_i     = eta7
    args      = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################
######################
 # [./ACBulkC5b]
 #   type = KKSMultiACBulkC
 #   variable  = eta2
 #   Fj_names  = 'F1 F2 F3 F2 F2'
 #   hj_names  = 'h1 h2 h3 h4 h5'
 #   cj_names  = 'c1b c2b c3b c2b c2b'
 #   eta_i     = eta7
 #   args      = 'eta1 eta3 eta2 eta4'
 #   mob_name = L
 # [../]
######################

######################  
  [./ACInterface7]
    type = ACInterface
    variable = eta7
    kappa_name = kappa
    mob_name = L
  [../]
##################################################################
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta7] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta7
      v = 'eta1 eta3 eta2 eta4 eta5 eta6 eta8 eta9 eta10 eta11 eta12'
      gamma_names = 'gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta3 eta2 eta4 eta5 eta6 eta8 eta9 eta10 eta11 eta12 pot'
[../]
##################################################################
##################################################################
# Kernels for Allen-Cahn equation for eta8
  
######################
  [./deta8dt]
    type = TimeDerivative
    variable = eta8
  [../]
######################

######################  
  [./ACBulkF8]
    type = KKSMultiACBulkF
    variable  = eta8
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gi_name   = g8
    eta_i     = eta8
    wi        = 5.0 #1.0
    args      = 'c1a c2a c3a eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################

######################
  [./ACBulkC8a]
    type = KKSMultiACBulkC
    variable  = eta8
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    cj_names  = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    eta_i     = eta8
    args      = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################
######################
 # [./ACBulkC5b]
 #   type = KKSMultiACBulkC
 #   variable  = eta2
 #   Fj_names  = 'F1 F2 F3 F2 F2'
 #   hj_names  = 'h1 h2 h3 h4 h5'
 #   cj_names  = 'c1b c2b c3b c2b c2b'
 #   eta_i     = eta8
 #   args      = 'eta1 eta3 eta2 eta4'
 #   mob_name = L
 # [../]
######################

######################  
  [./ACInterface8]
    type = ACInterface
    variable = eta8
    kappa_name = kappa
    mob_name = L
  [../]
##################################################################
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta8] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta8
      v = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta9 eta10 eta11 eta12'
      gamma_names = 'gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta9 eta10 eta11 eta12 pot'
[../]
##################################################################
##################################################################
# Kernels for Allen-Cahn equation for eta9
  
######################
  [./deta9dt]
    type = TimeDerivative
    variable = eta9
  [../]
######################

######################  
  [./ACBulkF9]
    type = KKSMultiACBulkF
    variable  = eta9
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gi_name   = g9
    eta_i     = eta9
    wi        = 5.0 #1.0
    args      = 'c1a c2a c3a eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################

######################
  [./ACBulkC9a]
    type = KKSMultiACBulkC
    variable  = eta9
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    cj_names  = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    eta_i     = eta9
    args      = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################
######################
 # [./ACBulkC5b]
 #   type = KKSMultiACBulkC
 #   variable  = eta2
 #   Fj_names  = 'F1 F2 F3 F2 F2'
 #   hj_names  = 'h1 h2 h3 h4 h5'
 #   cj_names  = 'c1b c2b c3b c2b c2b'
 #   eta_i     = eta9
 #   args      = 'eta1 eta3 eta2 eta4'
 #   mob_name = L
 # [../]
######################

######################  
  [./ACInterface9]
    type = ACInterface
    variable = eta9
    kappa_name = kappa
    mob_name = L
  [../]
##################################################################
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta9] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta9
      v = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta10 eta11 eta12'
      gamma_names = 'gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta10 eta11 eta12 pot'
[../]
##################################################################
##################################################################
# Kernels for Allen-Cahn equation for eta10
  
######################
  [./deta10dt]
    type = TimeDerivative
    variable = eta10
  [../]
######################

######################  
  [./ACBulkF10]
    type = KKSMultiACBulkF
    variable  = eta10
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gi_name   = g10
    eta_i     = eta10
    wi        = 5.0 #1.0
    args      = 'c1a c2a c3a eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta11 eta12 pot'
    mob_name = L
  [../]
######################

######################
  [./ACBulkC10a]
    type = KKSMultiACBulkC
    variable  = eta10
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    cj_names  = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    eta_i     = eta10
    args      = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta11 eta12 pot'
    mob_name = L
  [../]
######################
######################
 # [./ACBulkC5b]
 #   type = KKSMultiACBulkC
 #   variable  = eta2
 #   Fj_names  = 'F1 F2 F3 F2 F2'
 #   hj_names  = 'h1 h2 h3 h4 h5'
 #   cj_names  = 'c1b c2b c3b c2b c2b'
 #   eta_i     = eta10
 #   args      = 'eta1 eta3 eta2 eta4'
 #   mob_name = L
 # [../]
######################

######################  
  [./ACInterface10]
    type = ACInterface
    variable = eta10
    kappa_name = kappa
    mob_name = L
  [../]
##################################################################
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta10] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta10
      v = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta11 eta12'
      gamma_names = 'gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta11 eta12 pot'
[../]
##################################################################
##################################################################
# Kernels for Allen-Cahn equation for eta11
  
######################
  [./deta11dt]
    type = TimeDerivative
    variable = eta11
  [../]
######################

######################  
  [./ACBulkF11]
    type = KKSMultiACBulkF
    variable  = eta11
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gi_name   = g11
    eta_i     = eta11
    wi        = 5.0 #1.0
    args      = 'c1a c2a c3a eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta12 pot'
    mob_name = L
  [../]
######################

######################
  [./ACBulkC11a]
    type = KKSMultiACBulkC
    variable  = eta11
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    cj_names  = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    eta_i     = eta11
    args      = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta12 pot'
    mob_name = L
  [../]
######################
######################
 # [./ACBulkC5b]
 #   type = KKSMultiACBulkC
 #   variable  = eta2
 #   Fj_names  = 'F1 F2 F3 F2 F2'
 #   hj_names  = 'h1 h2 h3 h4 h5'
 #   cj_names  = 'c1b c2b c3b c2b c2b'
 #   eta_i     = eta11
 #   args      = 'eta1 eta3 eta2 eta4'
 #   mob_name = L
 # [../]
######################

######################  
  [./ACInterface11]
    type = ACInterface
    variable = eta11
    kappa_name = kappa
    mob_name = L
  [../]
##################################################################
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta11] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta11
      v = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta12'
      gamma_names = 'gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta12 pot'
[../]
##################################################################
##################################################################
# Kernels for Allen-Cahn equation for eta12
  
######################
  [./deta12dt]
    type = TimeDerivative
    variable = eta12
  [../]
######################

######################  
  [./ACBulkF12]
    type = KKSMultiACBulkF
    variable  = eta12
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gi_name   = g12
    eta_i     = eta12
    wi        = 5.0 #1.0
    args      = 'c1a c2a c3a eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 pot'
    mob_name = L
  [../]
######################

######################
  [./ACBulkC12a]
    type = KKSMultiACBulkC
    variable  = eta12
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    cj_names  = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    eta_i     = eta12
    args      = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 pot'
    mob_name = L
  [../]
######################
######################
 # [./ACBulkC5b]
 #   type = KKSMultiACBulkC
 #   variable  = eta2
 #   Fj_names  = 'F1 F2 F3 F2 F2'
 #   hj_names  = 'h1 h2 h3 h4 h5'
 #   cj_names  = 'c1b c2b c3b c2b c2b'
 #   eta_i     = eta12
 #   args      = 'eta1 eta3 eta2 eta4'
 #   mob_name = L
 # [../]
######################

######################  
  [./ACInterface12]
    type = ACInterface
    variable = eta12
    kappa_name = kappa
    mob_name = L
  [../]
##################################################################
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta12] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta12
      v = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11'
      gamma_names = 'gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta3 eta2 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 pot'
[../]
##################################################################
# Kernels for Allen-Cahn equation for eta3

######################
  [./deta3dt]
    type = TimeDerivative
    variable = eta3
  [../]
######################

######################
  [./ACBulkF3]
    type = KKSMultiACBulkF
    variable  = eta3
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gi_name   = g3
    eta_i     = eta3
    wi        = 5.0 #1.0
    args      = 'c1a c2a c3a eta2 eta1 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################


######################
  [./ACBulkC3a]
    type = KKSMultiACBulkC
    variable  = eta3
    Fj_names  = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names  = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    cj_names  = 'c1a c2a c3a c2a c2a c2a c2a c2a c2a c2a c2a c2a'
    eta_i     = eta3
    args      = 'eta2 eta1 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
    mob_name = L
  [../]
######################

######################
#  [./ACBulkC3b]
#    type = KKSMultiACBulkC
#    variable  = eta3
#    Fj_names  = 'F1 F2 F3 F2 F2'
#    hj_names  = 'h1 h2 h3 h4 h5'
#    cj_names  = 'c1b c2b c3b c2b c2b'
#    eta_i     = eta3
#    args      = 'eta2 eta1 eta4 eta5'
#    mob_name = L
#  [../]
######################

######################
  [./ACInterface3]
    type = ACInterface
    variable = eta3
    kappa_name = kappa
    mob_name = L
  [../]
######################
##################################################################
# This kernel requires the model parameter m (mu) and the gamma parameter
###########################################################################
[./ACdfintdeta3] #L*m*(eta_i^3-eta_i+2*beta*eta_i*sum_j eta_j^2)
      type = ACGrGrMulti
      variable = eta3
      v = 'eta1 eta5 eta2 eta4 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
      gamma_names = 'gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma gamma'
      mob_name = L
      args = 'eta1 eta5 eta2 eta4 eta6 eta7 eta8 eta9 eta10 eta11 eta12 pot'
[../]
########################################################################################
####Laplacian of potential variable
# Kernel for electric potential
  [./Laplacian]
    type = MatDiffusion
    variable = pot
    diffusivity = electcond # electrical_conductivity name in Derivative Parsed Material parser , sigma_el(eta_i)
  [../]
[]

########################################################################################




########################################################################################

[AuxKernels]
[./bnds]
    type = BndsCalcAux
    variable = bnds
    var_name_base = eta
    op_num = 5 #2
    v = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
  [../]
############################################
  [./Energy_total]
    type = KKSMultiFreeEnergy
    Fj_names = 'F1 F2 F3 F2 F2 F2 F2 F2 F2 F2 F2 F2'
    hj_names = 'h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12'
    gj_names = 'g1 g2 g3 g4 g5 g6 g7 g8 g9 g10 g11 g12'
    variable = Energy
    w = 1
    interfacial_vars =  'eta1  eta2  eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
    kappa_names =       'kappa kappa kappa kappa kappa kappa kappa kappa kappa kappa kappa kappa'
  [../]
############################################
[./grains_hsquarec]
      type = TwelvePhasesSumCdothsquare
      variable = gr_c
      var1 = ca
      h1_name = h1
      h2_name = h2
      h3_name = h3
      h4_name = h4
      h5_name = h5
      h6_name = h6
      h7_name = h7
      h8_name = h8
      h9_name = h9
      h10_name = h10
      h11_name = h11
      h12_name = h12
[../]

[]

########################################################################################
[Postprocessors]
    [./cu_area_h]
      type = ElementIntegralMaterialProperty
      mat_prop = h1
      execute_on = 'Initial TIMESTEP_END'
    [../]
    [./imc1_area_h]
      type = ElementIntegralMaterialProperty
      mat_prop = h2
      execute_on = 'Initial TIMESTEP_END'
    [../]
    [./sn_area_h]
      type = ElementIntegralMaterialProperty
      mat_prop = h3
      execute_on = 'Initial TIMESTEP_END'
    [../]
    [./imc2_area_h]
      type = ElementIntegralMaterialProperty
      mat_prop = h4
      execute_on = 'Initial TIMESTEP_END'
    [../]
    [./imc3_area_h]
      type = ElementIntegralMaterialProperty
      mat_prop = h5
      execute_on = 'Initial TIMESTEP_END'
    [../]
    [./imc4_area_h]
      type = ElementIntegralMaterialProperty
      mat_prop = h6
      execute_on = 'Initial TIMESTEP_END'
    [../]
    [./imc5_area_h]
      type = ElementIntegralMaterialProperty
      mat_prop = h7
      execute_on = 'Initial TIMESTEP_END'
    [../]
    [./imc6_area_h]
      type = ElementIntegralMaterialProperty
      mat_prop = h8
      execute_on = 'Initial TIMESTEP_END'
    [../]
    [./imc7_area_h]
      type = ElementIntegralMaterialProperty
      mat_prop = h9
      execute_on = 'Initial TIMESTEP_END'
    [../]
    [./imc8_area_h]
      type = ElementIntegralMaterialProperty
      mat_prop = h10
      execute_on = 'Initial TIMESTEP_END'
    [../]
    [./imc9_area_h]
      type = ElementIntegralMaterialProperty
      mat_prop = h11
      execute_on = 'Initial TIMESTEP_END'
    [../]
    [./imc10_area_h]
      type = ElementIntegralMaterialProperty
      mat_prop = h12
      execute_on = 'Initial TIMESTEP_END'
    [../]
  
[]

########################################################################################

[Executioner]

############################################
  type = Transient
  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -sub_pc_type   -sub_pc_factor_shift_type'
  petsc_options_value = 'asm       ilu            nonzero'
  l_max_its = 100 #100 #30
  nl_max_its = 50 #10
  l_tol = 1.0e-4
  nl_rel_tol = 1.0e-10
  nl_abs_tol = 1.0e-11

  #num_steps = 45 #2
  #dt = 0.5
  #end_time=1.0E+010
  end_time=7.2E+012   #2 hr
  ############################################
[./TimeStepper]
    ## Turn on time stepping
    type = IterationAdaptiveDT
    dt = 2.0E+02
    #dt = 2.0E+02 #5.0E+01 #2.0e+2 #1500 #2000 #50 #100 #200 #200 #10.0 #1.0E+01 #-02 #1.0E-02 #1.0E-1 #0.5 #1.00E+04 #06
    cutback_factor = 0.95 #0.7 #0.7
    growth_factor = 1.5 #1.5 #1.50 #1.5
    optimal_iterations = 7
    #num_steps = 55
[../]
############################################
############################################
# adaptive mesh to resolve an interface
   [./Adaptivity]
     initial_adaptivity    = 2 #3 #3 #2             # Number of times mesh is adapted to initial condition
     refine_fraction       = 0.7           # Fraction of high error that will be refined
     coarsen_fraction      = 0.1           # Fraction of low error that will coarsened
     max_h_level           = 3 #2 #3 #3 #2 #3             # Max number of refinements used, starting from initial mesh (before uniform refinement)
     weight_names          = 'eta1 eta2 eta3 eta4 eta5 eta6 eta7 eta8 eta9 eta10 eta11 eta12'
     weight_values         = '1 1 1 1 1 1 1 1 1 1 1 1'
   [../]
[]

########################################################################################



########################################################################################

[Preconditioning]

############################################
  active = 'full'
  [./full]
    type = SMP
    full = true
  [../]
  [./mydebug]
    type = FDP
    full = true
  [../]
############################################

[]

########################################################################################



########################################################################################

[Outputs]

############################################
  exodus = true
  csv  = true
  interval = 50 #50 #50 #50 #1 #20 #1 #50 # 10 #20 #5 #50 #1 #50 #20 #10
  checkpoint = true
############################################
 #[./my_checkpoint]
  #  type = Checkpoint
  #  num_files = 4
  #  interval = 10 #5
 # [../]

[]

########################################################################################


[Debug]
  show_var_residual_norms = true
[]
