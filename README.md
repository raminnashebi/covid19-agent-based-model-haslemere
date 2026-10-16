# Agent-Based Model of COVID-19 Transmission on a Real-World Contact Network

MATLAB code and simulation outputs for a stochastic agent-based epidemic model of COVID-19 running on the time-varying contact network of the Haslemere dataset. Each contact is classified as household, workplace or social environment. The simulations explore how transmission in these settings, stay-at-home days, working hours, vaccination coverage and variant (wild type vs Delta) affect spread and the basic reproduction number R0.

## Citation

If you use this code or data, please cite:

> Nashebi, R., Sarı, M. and Kotil, S. (2022). Using a real-world network to model the trade-off between stay-at-home restriction, vaccination, social distancing and working hours on COVID-19 dynamics. *PeerJ*, 10:e14353. https://doi.org/10.7717/peerj.14353

The model was developed for the MSc thesis *Effects of Various Parameters on the Containment of Pandemics* (R. Nashebi, Yildiz Technical University).

## History

This repository combines two earlier repositories:

- `AGENT_BASED_MODEL`: the model code (now `code/` and `data/`)
- `AGENT_BASED_MODEL_SIMULATED_DATA`: the simulation outputs (now `simulation_results/`)

The git history of both is preserved.

## Repository structure

```
.
├── setup_paths.m              Adds code/shared and data/ to the MATLAB path
├── code/
│   ├── shared/                Functions used by several figures
│   │   ├── StateUpdate.m          Disease-state transition for one agent
│   │   └── shadedErrorBar.m       Plotting helper (Rob Campbell, third party)
│   ├── fig1/ … fig7/          Scripts for each main-text figure
│   └── figS1/ figS2/ figS4/   Scripts for supplementary figures
├── data/
│   ├── Kissler_DataS1.csv     Haslemere contact data
│   ├── Kissler_DataS2.csv     Time step → timestamp lookup
│   └── contact_networks/      Household / workplace / social-environment networks (FNM_*.mat)
└── simulation_results/        Saved MATLAB workspaces from full simulation runs
    ├── fig2/  fig3/  fig4/  fig7/
```

## Requirements

- MATLAB. The simulation code uses base MATLAB only.
- **Statistics and Machine Learning Toolbox** for the plotting scripts, which compute confidence intervals with `tinv`.
- `code/figS4/sampling_Trial.m` uses `parfor`. It runs serially without the Parallel Computing Toolbox.

## How to run

1. **Make the figure's folder the current folder**, e.g. `cd code/fig2`. Several figures have their own version of `agent_based_simulator.m`, so don't add the figure folders to the MATLAB path. If MATLAB asks when you press **Run**, choose *Change Folder*, not *Add to Path*.
2. Run the scripts. Each script calls `setup_paths.m` itself, so the shared functions and input data are found automatically.

For the simulation figures (2, 3, 5, 7, S4), the typical order is:

1. `Trial.m` runs `agent_based_simulator` 500 times for each transmission-rate setting. This is slow.
2. Post-processing scripts such as `R0_calculator.m` and `Infection_occurance_ratio_calculator.m` work on the variables `Trial.m` leaves in the workspace.
3. A plotting script draws the figure.

To skip step 1, load the matching file from `simulation_results/` into the workspace, then run steps 2–3.

## Figure guide

| Folder | Scripts | Saved results |
|--------|---------|---------------|
| `code/fig1` | `findingEdgeFrequency.m`: hourly number of 5-min encounters by setting (household, workplace, social) for Thursday–Saturday | |
| `code/fig2` | `Trial.m` → `R0_calculator.m`, `Infection_occurance_ratio_calculator.m` → `plot_Errorbar_figure_2.m` (uses `createfigure2.m`) | `simulation_results/fig2/`: real vs random network |
| `code/fig3` | `Trial.m` → `Creating_Third_Order_Infection_Chains.m` → `Plotting_Errorbars_of_3rd_order_inf_chain.m` | `simulation_results/fig3/`: R0 = 1 and R0 = 2.87 scenarios, real and random networks |
| `code/fig4` | `findingEdgeFrequency.m`, `createfigure4a_4c.m`, plus `M_20m_Inf_Problar_{1,2}day_home.mat` | `simulation_results/fig4/`: stay at home on Sunday, or on Saturday and Sunday |
| `code/fig5` | `Trial.m` → `R0_calculator.m`, `Infection_occurance_ratio_calculator.m` → `plot_Errorbar_figure_5.m` (uses `createfigure5.m`) | |
| `code/fig6` | `findingEdgeFrequency.m`, `createfigure6a.m` … `createfigure6e.m` | |
| `code/fig7` | `Trial.m` (working hours reduced from 9 h, `L = 5:9`; wild-type and Delta transmission rates) → `R0_calculator.m` → `plot_figure_2.m` | `simulation_results/fig7/`: 60 runs = {unvaccinated, 51 %, 61 %, 71 %, 81 %, 91 % vaccinated} × {wild type, Delta} × stay at home 0–4 days |
| `code/figS1` | `classification_Algorithm.m` (classifies contacts into settings), `Testing_classification_Algorithm.m` | |
| `code/figS2` | `Visualization_Method.m` | |
| `code/figS4` | `sampling_Trial.m` (R0 and secondary attack rate with randomly sampled parameters), `createfigureS4.m` | |

## Data

### Haslemere dataset

From Kissler, S. M. *et al.* (2018), *Sparking "The BBC Four Pandemic": Leveraging citizen science and mobile phones to model the spread of disease*, bioRxiv 479154 (Data S1 and S2).

- `Kissler_DataS1.csv`: one row per contact, with columns `[time step, person i, person j, distance (m)]`. Time steps are 5-minute intervals from 1 to 576, people are numbered up to 469, and distances run from 0 to 50 m. Scripts drop contacts over 20 m.
- `Kissler_DataS2.csv`: `[time step, timestamp]`, covering Thu 12 Oct 2017 07:00 to Sat 14 Oct 2017 22:55, 16 hours per day.

### Contact networks (`data/contact_networks/`)

| File | Variable | Size |
|------|----------|------|
| `FNM_HOME_5m+20m_symmetry.mat` | `FNM_Home` | 350 × 2 |
| `FNM_HOME_5m+20m_time.mat` | `FNM_Home_time` | 25900 × 4 |
| `FNM_HOME_5m+20m_time_symmetry.mat` | `FNM_Home_time` | 51800 × 4 |
| `FNM_WORK_5m+20m_time.mat` | `FNM_Work_time` | 6580 × 4 |
| `FNM_WORK_5m+20m_time_symmetry.mat` | `FNM_Work_time` | 13160 × 4 |
| `FNM_OUTDOOR_5m+20m.mat` | `FNM_Outdoor` | 1716 × 2 |
| `FNM_OUTDOOR_5m+20m_time.mat` | `FNM_Outdoor_time` | 8619 × 4 |
| `FNM_OUTDOOR_5m+20m_time_symmetry.mat` | `FNM_Outdoor_time` | 17238 × 4 |
| `FNM_Outside_Home_5m+20m_symmetry.mat` | `FNM_outside_home` | 6040 × 2 |

`_time` files keep the time step of each contact. `_symmetry` files list each contact in both directions.

### Simulation results

Each file in `simulation_results/` is a MATLAB workspace saved after a full run. It contains the simulation outputs (e.g. `Total_Ancestor1`, `State_counter1`, `INIT_EXP`, `PROB*`) and, for most runs, the post-processed quantities (`R0_final*`, `ydata_ratio`, …) that the plotting scripts use.

## Known issues

These come from the original code and were not changed:

- **`code/fig3/Trial.m` has a syntax error.** The `for j = …` loop header appears twice, so one `end` is missing. The file also sets several scenarios one after another, each overwriting the last. Edit it to keep the scenario you want before running.
- **Two network files are missing.** `FNM_WORK_5m+20m_symmetry.mat` and `FNM_OUTDOOR_5m+20m_symmetry.mat` are loaded by `Infection_occurance_ratio_calculator.m` (fig2, fig5) and `Testing_classification_Algorithm.m` (figS1), but they are not in either original repository.
- **`code/fig1/findingEdgeFrequency.m` and `code/fig6/findingEdgeFrequency.m` stop with indexing errors.** Both read the raw 3-day `Kissler_DataS1.csv` into `M`, but expect a reshaped or expanded version of it. FIG1 indexes `M` up to column 24 (the CSV has 4). FIG6 looks for time steps up to 2496 of the 14-day expanded matrix (the CSV stops at 576).
- **`code/figS1/classification_Algorithm.m` uses `U_20m_time` before creating it.**

## Changes from the original layout

| Previous | Now |
|----------|-----|
| `FIGn CODES/` | `code/figN/` |
| `FIGn DATA/` (simulated-data repository) | `simulation_results/figN/` |
| `Kissler_DataS*.csv` (10 copies) | `data/` (one copy) |
| `FNM_*.mat` (up to 8 copies each) | `data/contact_networks/` (one copy each) |
| `StateUpdate.m` (5 copies), `shadedErrorBar.m` (3 copies) | `code/shared/` |
| `FIG4 CODES/findingEgdgeFrequency.m`, `FIG6 CODES/findingEgdgeFrequency.m` | `code/fig4/findingEdgeFrequency.m`, `code/fig6/findingEdgeFrequency.m` |
| `FIG5 CODES/plot_Errorba_figure_5.m` | `code/fig5/plot_Errorbar_figure_5.m` |
| `FIGS4 CODES/samplin_Trial.m` | `code/figS4/sampling_Trial.m` |
| `FIG5 CODES/agent_based_simulator.asv` | removed (MATLAB editor autosave) |

Only byte-identical duplicates were removed.

Code fixes made during the reorganisation:

- **Shared inputs found from any figure folder.** Scripts now load the Haslemere data and networks through `setup_paths.m`. Before, scripts could only load files in their own folder, which was missing some networks: for example, FIG2, FIG5 and FIG7 `Trial.m` failed on `FNM_HOME_5m+20m_symmetry` or `FNM_Outside_Home_5m+20m_symmetry`.
- **`StateUpdate.m` naming.** Its function name now matches the file name (it was `StateUpdate_V0`).
- **FIGS4 function call.** `code/figS4/agent_based_simulator.m` now calls `@StateUpdate` instead of `@StateUpdate_V0`, a name with no matching file.
