#!/bin/bash

set -Ceu

pcscd -f --error &
npm start
