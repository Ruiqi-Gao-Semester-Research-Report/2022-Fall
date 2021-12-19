# Build

## To compile the latex file, run:
```bash
make
```
in the root folder, and the generated pdf file will be ``proposal/build/proposal.pdf`` and ``report/build/paper.pdf``


## To delete all the file generated during latex compilation, run:
```bash
make clean
```

# Reproducible Experiment
Code and Reproducible Experiment are available [here](https://github.com/Kuigesi/PipelineExecution-Reproducible.git), follow the README of that repo to reproduce the experiment.

# Required LaTeX Packages
## Texlive

This document requires a full texlive distribution that can be installed by running
`apt-get install texlive-full` in the terminal. Because `texlive-full` is very
large (about 5 Gigabytes) you can also install the smaller texlive bundles and
add any missing packages manually.

## Anaconda

The script to generate the evaluation plot requires Anaconda environment. Please activate the conda environment before `make`