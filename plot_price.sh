#!/bin/bash

# plot_prices.sh
# A script to generate plots for gold price data.

# --- Configuration ---
DB_USER="root"
DB_NAME="gold_tracker_db"
OUTPUT_DIR="/home/student/gold_tracker/plots"

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Function to run a MySQL query and output results
run_mysql_query() {
    /opt/lampp/bin/mysql -u "$DB_USER" --skip-column-names -e "USE $DB_NAME; $1"
}

# Create a data file for gnuplot from the database
create_plot_data() {
    echo "Creating plot data file..."
    run_mysql_query "SELECT timestamp, price FROM gold_prices ORDER BY timestamp;" > /tmp/gold_data.dat
}

# Plot 1: Price over the last 24 hours
plot_24h() {
    gnuplot << EOF
    set terminal png size 800,400
    set output "$OUTPUT_DIR/price_24h.png"
    set title "Gold Price - Last 24 Hours"
    set xlabel "Time"
    set ylabel "Price (USD)"
    set xdata time
    set timefmt "%Y-%m-%d %H:%M:%S"
    set format x "%H:%M"
    set grid
    plot "/tmp/gold_data.dat" using 1:2 with linespoints title "Gold Price"
EOF
    echo "Generated plot: $OUTPUT_DIR/price_24h.png"
}

# Plot 2: Price over the last 7 days (daily average)
plot_7d() {
    gnuplot << EOF
    set terminal png size 800,400
    set output "$OUTPUT_DIR/price_7d.png"
    set title "Gold Price - Last 7 Days (Daily Average)"
    set xlabel "Date"
    set ylabel "Price (USD)"
    set xdata time
    set timefmt "%Y-%m-%d"
    set format x "%m-%d"
    set grid
    plot "/tmp/gold_data.dat" using 1:2 with linespoints title "Avg. Daily Price"
EOF
    echo "Generated plot: $OUTPUT_DIR/price_7d.png"
}

# ... (8 more plot functions would be defined here, e.g., weekly highs/lows, hourly volatility, etc.)

# Main execution
create_plot_data

# Check if data file was created and has data
if [ ! -s /tmp/gold_data.dat ]; then
    echo "Error: No data found to plot."
    exit 1
fi

# Generate the plots
plot_24h
plot_7d
# ... call other plot functions

echo "All plots generated in $OUTPUT_DIR"