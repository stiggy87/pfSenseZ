pfSenseZ
========

An implementation of the pfSense (http://www.pfsense.org) for Zedboard (and ultimately Zynq).

Goal
====

To provide a way to run pfSense off a Zedboard.

TODO
====

- Design a daughter board (will look into compliance for Pmod licensing from Digilent) to contain an Ethernet PHY. (This lets the Zynq chip do the MAC)
- Provide a way for on-board OLED/LEDs to provide statusing of key aspects of pfSense (and make it customizable)
- Provide a way to display pfSense status via OLED via buttons

Basic Design
============

The general design is more ARM based than PL based. PL is just providing pass-through for Ethernet, as well as some control logic for the statusing items

More to be written.
