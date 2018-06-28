Routing switch
==============

This directory includes an OpenFlow controller that emulates a layer 2
switch.

                     packet out
                 .---------------------------------------.
                 v                                       |
        +----------+           +-----------+           +---------+          +----------+
        |  switch  |  *    1   | packet in |  1    *   | routing |  *   1   | topology |
        |  daemon  | --------> |  filter   | --------> | switch  | <------> | daemon   |
        +----------+ packet in +-----------+ packet in +---------+ topology +----------+
          ^ 1    ^                       |                                    ^ 1
          |      |                       |                                    | topology
          |      `-------.               |                                    |
          v 1            |               |                                    v 1
        +----------+     |               |   packet in(LLDP)                +-----------+
        | openflow |     |               `--------------------------------->| topology  |
        |  switch  |     `--------------------------------------------------| discovery |
        +----------+                         packet out(LLDP)               +-----------+


How to build
------------

  Get Trema and Apps

        $ sudo gem install trema
        $ git clone git://github.com/trema/apps.git apps

  Build topology

        $ cd apps/topology
        $ make
        $ cd ../..

  Build Routing switch

        $ cd apps/routing_switch
        $ make
        $ cd ../..

How to run
----------

        $ sudo trema run -c ./apps/routing_switch/routing_switch.conf

