make DBG_TST=1 clean all run-quadraTb-T2 | egrep delta | cut -d'=' -f2 > err_t2.dat
