# Hospital Data Management System

A comprehensive log management and analysis system for hospital device monitoring.

### Overview

This system monitors and manages data from critical hospital devices including heart rate monitors, temperature sensors, and water usage meters. It provides automated data collection, intelligent log archival, and detailed analysis reporting.

### System Architecture


hospital-management-system/
├── active_logs/                 # Current monitoring data
│   ├── heart_rate.log          # Real-time heart rate readings
│   ├── temperature.log         # Temperature sensor data
│   └── water_usage.log         # Water consumption metrics
├── heart_data_archive/         # Archived heart rate logs
├── temperature_archive/        # Archived temperature logs
├── water_archive/             # Archived water usage logs
├── reports/                   # Analysis and system reports
│   ├── analysis_report.txt    # Device activity analysis
│   └── archive_log.txt        # Archival activity log
├── archive_logs.sh            # Log archival script
├── analyze_logs.sh            # Log analysis script
├── heart_rate_monitor.py      # Heart rate data simulator
├── temperature_recorder.py    # Temperature data simulator
└── water_consumption.py       # Water usage data simulator


### Quick Start

#### Prerequisites
- Python 3.x
- Bash shell environment
- Git (for version control)

#### Installation
bash
# Clone the repository
git clone https://github.com/therealigor007/Coding-lab_Group11.git
cd Coding-lab_Group11/hospital-management-system

# Make scripts executable
chmod +x archive_logs.sh
chmod +x analyze_logs.sh


#### Running the System

1. **Start Data Collection:**
   bash
   # Terminal 1: Heart rate monitoring
   python3 heart_rate_monitor.py start
   
   # Terminal 2: Temperature monitoring  
   python3 temperature_recorder.py start
   
   # Terminal 3: Water usage monitoring
   python3 water_consumption.py start
   

2. **Analyze Current Data:**
   bash
   ./analyze_logs.sh
   

3. **Archive Old Logs:**
   bash
   ./archive_logs.sh
   

### Components

#### Data Collection Scripts

##### heart_rate_monitor.py
- **Purpose:** Simulates hospital heart rate monitors
- **Output:** Real-time heart rate readings (bpm)
- **Format:** `YYYY-MM-DD HH:MM:SS - Device_HR###: ## bpm`
- **Usage:** `python3 heart_rate_monitor.py start`

##### temperature_recorder.py
- **Purpose:** Simulates hospital temperature sensors
- **Output:** Patient and room temperature readings
- **Format:** `YYYY-MM-DD HH:MM:SS - Device_TEMP###: ##.#°F`
- **Usage:** `python3 temperature_recorder.py start`

##### water_consumption.py
- **Purpose:** Simulates hospital water usage monitoring
- **Output:** Water flow rates and consumption data
- **Format:** `YYYY-MM-DD HH:MM:SS - Device_WATER###: #.# gal/min`
- **Usage:** `python3 water_consumption.py start`

#### Management Scripts

##### archive_logs.sh
Interactive script for archiving active log files.

**Features:**
- User-friendly menu selection
- Timestamp-based file naming
- Automatic directory creation
- Comprehensive error handling

**Usage:**
bash
./archive_logs.sh

Select log to archive:
1) Heart Rate
2) Temperature  
3) Water Usage
Enter choice (1-3): 1

Archiving heart_rate.log...
Successfully archived to heart_data_archive/heart_rate_2024-06-04_15:22:10.log


##### analyze_logs.sh
Intelligent analysis script for device activity monitoring.

**Features:**
- Device activity counting
- First/last seen timestamps
- Statistical reporting
- Cumulative analysis history

**Usage:**
bash
./analyze_logs.sh

Select log file to analyze:
1) Heart Rate (heart_rate.log)
2) Temperature (temperature.log)
3) Water Usage (water_usage.log)
Enter choice (1-3): 1

Analyzing heart_rate.log...
Found 3 unique devices with 150 total entries
Analysis complete! Results saved to reports/analysis_report.txt


### Sample Output

#### Analysis Report Example

=== HEART RATE LOG ANALYSIS ===
Date: 2024-06-04 15:22:10

Device Activity Summary:
Device_HR001: 45 entries
  First seen: 2024-06-04 08:00:10
  Last seen:  2024-06-04 15:20:30

Device_HR002: 38 entries
  First seen: 2024-06-04 08:05:15  
  Last seen:  2024-06-04 15:18:45

Device_HR003: 42 entries
  First seen: 2024-06-04 08:10:20
  Last seen:  2024-06-04 15:19:55

Total devices found: 3
Total log entries: 125
===============================


### Technical Details

#### Log File Format
All log files follow a consistent format:

YYYY-MM-DD HH:MM:SS - Device_TYPE###: VALUE UNIT


#### Error Handling
- **Invalid user input:** Validates menu selections (1-3 only)
- **Missing files:** Checks file existence before processing
- **Empty files:** Handles empty log files gracefully
- **Directory issues:** Automatically creates required directories

#### Key Technologies
- **Bash scripting:** System automation and file management
- **Python:** Data simulation and logging
- **AWK:** Text processing and data extraction
- **Unix utilities:** grep, sort, uniq, head, tail for data analysis

### Troubleshooting

#### Common Issues

**Problem:** Scripts not executable
bash
# Solution:
chmod +x *.sh


**Problem:** Python simulators won't start
bash
# Solution: Check Python version
python3 --version
# Ensure Python 3.x is installed


**Problem:** Analysis shows no devices
bash
# Solution: Verify log file format and content
head hospital_data/active_logs/heart_rate.log


#### Stopping Simulators
bash
# Stop all Python processes
sudo pkill -f python
```
