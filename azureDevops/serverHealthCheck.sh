#!/bin/bash

# Function to check CPU usage
check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    echo "CPU Usage: ${CPU_USAGE}%"
}

# Function to check memory usage
check_memory() {
    MEMORY_USAGE=$(free -m | awk '/Mem:/ { printf("%.2f"), $3/$2 * 100.0 }')
    echo "Memory Usage: ${MEMORY_USAGE}%"
}

# Function to check disk space
check_disk() {
    DISK_USAGE=$(df -h / | awk 'NR==2 { print $5 }')
    echo "Disk Usage: ${DISK_USAGE}"
}

# Function to check running processes
check_processes() {
    PROCESS_COUNT=$(ps aux | wc -l)
    echo "Running Processes: ${PROCESS_COUNT}"
}

# Perform health checks
check_cpu
check_memory
check_disk
check_processes

echo "Server health check completed."
