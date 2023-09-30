#!/usr/bin/env bash
cd history && git config core.hooksPath ../.husky
cd ..
cd metadata && git config core.hooksPath ../.husky
cd ..
cd video-streaming && git config core.hooksPath ../.husky