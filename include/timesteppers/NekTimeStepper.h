#pragma once

#include "TimeStepper.h"

class NekTimeStepper;

template<>
InputParameters validParams<NekTimeStepper>();

/**
 * \brief Time stepper that reads time step information directly from nekRS
 *
 * This time stepper performs the very simple action of reading stepping
 * information from nekRS. This is necessary for the correct simulation time
 * and time step size to be reflected through the Moose App running nekRS.
 * This class will ignore any constantDT-type time stepping parameters set
 * directly within the [Executioner] block, instead reading all stepping
 * information (start time, end time, number of time steps, and time step
 * size) directly from nekRS data structures. The only situation for which
 * some control can be exerted from the MOOSE side is if NekApp is run as
 * a sub-application, in which case the simulation end time is controlled
 * from the master application.
 **/
class NekTimeStepper : public TimeStepper
{
public:
  NekTimeStepper(const InputParameters & parameters);

protected:
  virtual Real computeInitialDT() override;

  virtual Real computeDT() override;
};
