//
// QuadraTb_T2.cpp -- test bench for task 2 - checking accuracy
//

#include <cstdint>
#include <algorithm>    // std::max
#include <vector>
#include <iostream>
#include <iomanip>
#include <bitset>

#include "Quadra.hpp"

bool testFunction2 (const double & x_dbl)
{
    using namespace std;

    const int PREC  = 28;
    const int WIDTH = PREC + 3;

    // Input:
    x_fxd_t x_fxd = x_dbl;

    if constexpr (DBG_TST) {
        cout << "x_dbl  = " << dec << fixed      << setw(WIDTH) << setprecision(PREC) << setfill(' ') << right
             <<  x_dbl     << endl;
    }

    // Approximation:
#ifdef DOUBLE_OVERRIDE
    y_fxd_t y_fxd = approxDouble (x_fxd); // use this to override fixed point with doubles
#else
    //NEW NAME y_fxd -> y_impl
    y_fxd_t y_impl_fxd = approxFixed  (x_fxd); // fixed-point data path
#endif

    // Ouput:
    double y_impl_dbl = y_impl_fxd .to_double();

    // Reference (CPU):
    double f_ref = sin((2.0 * x_dbl) - PI_OVER_4);

    // Error: 
    //NEW 
    //double delta = abs(f_ref - y_impl_dbl);
    double delta = f_ref - y_impl_dbl;

    if constexpr (DBG_TST) {
            //NEW  
        cout << "y_impl  = " << dec << fixed      << setw(WIDTH) << setprecision(PREC) << setfill(' ') << right
             <<  y_impl_dbl     << endl;
        cout << "f_ref  = " << dec << fixed      << setw(WIDTH) << setprecision(PREC) << setfill(' ') << right
             <<  f_ref << endl;
        cout << "delta  = " << dec << scientific << setw(9)     << setprecision(2)    << setfill(' ') << right
             <<  delta << endl << endl;
    }

    // Pass/fail:
    bool in_spec = (delta < ERR_TASK_II);

    return in_spec;
}

bool testFunction2 (void)
{
    using namespace std;

    // Test params:
    uint32_t m_start = 0x000000; // 0.0
    uint32_t m_stop  = 0xffffff; // 1.999...
    uint32_t m_step  = 0x000101; // sparse test
//  uint32_t m_step  = 0x000001; // exhaustive test

    // Initialize test status:
    bool ok_sts = true;

    // Main simulation loop:
    for (uint32_t m = m_start; m <= m_stop; m += m_step)
    {
        double x_dbl = double(m) / double(0x00800000);
        //             ---------------------
        bool in_spec = testFunction2 (x_dbl);
        //             ---------------------

        ok_sts &= in_spec;
    }

    return ok_sts;
}

int main2 (int argc, char *argv[])
{
    bool ok_sts = true;

    ok_sts &= testFunction2();

    int ret_sts = (ok_sts) ? 0 : -1;

    return ret_sts;
}
