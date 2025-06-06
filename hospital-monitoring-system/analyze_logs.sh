#!/bin/bash

# analyze_logs.sh - Intelligent log analysis system

ACTIVE_LOGS_DIR="hospital_data/active_logs"
REPORTS_DIR="hospital_data/reports"
REPORT_FILE="$REPORTS_DIR/analysis_report.txt"

create_directories() {
    mkdir -p "$ACTIVE_LOGS_DIR"
    mkdir -p "$REPORTS_DIR"
}

show_menu() {
    echo "Select log file to analyze:"
    echo "1) Heart Rate (heart_rate.log)"
    echo "2) Temperature (temperature.log)"
    echo "3) Water Usage (water_usage.log)"
}

validate_input() {
    local input=$1
    if [[ "$input" =~ ^[1-3]$ ]]; then
        return 0
    else
        return 1
    fi
}

analyze_heart_rate() {
    local log_file="$ACTIVE_LOGS_DIR/heart_rate.log"
    local log_type="HEART RATE"
    
    echo "Analyzing heart_rate.log..."
    
    if [ ! -f "$log_file" ] || [ ! -s "$log_file" ]; then
        echo "Error: Heart rate log file not found or empty!"
        return 1
    fi
    
    {
        echo ""
        echo "=== $log_type LOG ANALYSIS ==="
        echo "Date: $(date '+%Y-%m-%d %H:%M:%S')"
        echo ""
    } >> "$REPORT_FILE"
    
    local devices=$(awk -F' - ' '/Device_HR/ {split($2, arr, ":"); print arr[1]}' "$log_file" | sort | uniq)
    local total_entries=$(grep -c "Device_HR" "$log_file")
    local device_count=0
    
    echo "Device Activity Summary:" >> "$REPORT_FILE"
    
    for device in $devices; do
        local count=$(grep -c "$device" "$log_file")
        local first_time=$(grep "$device" "$log_file" | head -1 | awk '{print $1, $2}')
        local last_time=$(grep "$device" "$log_file" | tail -1 | awk '{print $1, $2}')
        
        {
            echo "$device: $count entries"
            echo "  First seen: $first_time"
            echo "  Last seen:  $last_time"
            echo ""
        } >> "$REPORT_FILE"
        
        ((device_count++))
    done
    
    {
        echo "Total devices found: $device_count"
        echo "Total log entries: $total_entries"
        echo "==============================="
        echo ""
    } >> "$REPORT_FILE"
    
    echo "Found $device_count unique devices with $total_entries total entries"
    echo "Analysis complete! Results saved to reports/analysis_report.txt"
}

analyze_temperature() {
    local log_file="$ACTIVE_LOGS_DIR/temperature.log"
    local log_type="TEMPERATURE"
    
    echo "Analyzing temperature.log..."
    
    if [ ! -f "$log_file" ] || [ ! -s "$log_file" ]; then
        echo "Error: Temperature log file not found or empty!"
        return 1
    fi
    
    {
        echo ""
        echo "=== $log_type LOG ANALYSIS ==="
        echo "Date: $(date '+%Y-%m-%d %H:%M:%S')"
        echo ""
    } >> "$REPORT_FILE"
    
    local devices=$(awk -F' - ' '/Device_TEMP/ {split($2, arr, ":"); print arr[1]}' "$log_file" | sort | uniq)
    local total_entries=$(grep -c "Device_TEMP" "$log_file")
    local device_count=0
    
    echo "Device Activity Summary:" >> "$REPORT_FILE"
    
    for device in $devices; do
        local count=$(grep -c "$device" "$log_file")
        local first_time=$(grep "$device" "$log_file" | head -1 | awk '{print $1, $2}')
        local last_time=$(grep "$device" "$log_file" | tail -1 | awk '{print $1, $2}')
        
        {
            echo "$device: $count entries"
            echo "  First seen: $first_time"
            echo "  Last seen:  $last_time"
            echo ""
        } >> "$REPORT_FILE"
        
        ((device_count++))
    done
    
    {
        echo "Total devices found: $device_count"
        echo "Total log entries: $total_entries"
        echo "==============================="
        echo ""
    } >> "$REPORT_FILE"
    
    echo "Found $device_count unique devices with $total_entries total entries"
    echo "Analysis complete! Results saved to reports/analysis_report.txt"
}

analyze_water_usage() {
    local log_file="$ACTIVE_LOGS_DIR/water_usage.log"
    local log_type="WATER USAGE"
    
    echo "Analyzing water_usage.log..."
    
    if [ ! -f "$log_file" ] || [ ! -s "$log_file" ]; then
        echo "Error: Water usage log file not found or empty!"
        return 1
    fi
    
    {
        echo ""
        echo "=== $log_type LOG ANALYSIS ==="
        echo "Date: $(date '+%Y-%m-%d %H:%M:%S')"
        echo ""
    } >> "$REPORT_FILE"
    
    local devices=$(awk -F' - ' '/Device_WATER/ {split($2, arr, ":"); print arr[1]}' "$log_file" | sort | uniq)
    local total_entries=$(grep -c "Device_WATER" "$log_file")
    local device_count=0
    
    echo "Device Activity Summary:" >> "$REPORT_FILE"
    
    for device in $devices; do
        local count=$(grep -c "$device" "$log_file")
        local first_time=$(grep "$device" "$log_file" | head -1 | awk '{print $1, $2}')
        local last_time=$(grep "$device" "$log_file" | tail -1 | awk '{print $1, $2}')
        
        {
            echo "$device: $count entries"
            echo "  First seen: $first_time"
            echo "  Last seen:  $last_time"
            echo ""
        } >> "$REPORT_FILE"
        
        ((device_count++))
    done
    
    {
        echo "Total devices found: $device_count"
        echo "Total log entries: $total_entries"
        echo "==============================="
        echo ""
    } >> "$REPORT_FILE"
    
    echo "Found $device_count unique devices with $total_entries total entries"
    echo "Analysis complete! Results saved to reports/analysis_report.txt"
}

main() {
    create_directories
    show_menu
    read -p "Enter choice (1-3): " choice
    
    if ! validate_input "$choice"; then
        echo "Error: Invalid input! Please enter a number between 1-3."
        exit 1
    fi
    
    case $choice in
        1) analyze_heart_rate ;;
        2) analyze_temperature ;;
        3) analyze_water_usage ;;
        *) echo "Error: Invalid choice!"; exit 1 ;;
    esac
}

main
