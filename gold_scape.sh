#!/bin/bash

# gold_scraper.sh
# A script to scrape current gold price from goldprice.org and store it in a MySQL database.

# --- Configuration ---
DB_USER="root"
DB_NAME="gold_tracker_db"
DB_TABLE="gold_prices"
LOG_FILE="/home/student/gold_tracker/scrape.log"
DATA_FILE="/home/student/gold_tracker/latest_data.txt"

# Function to log messages with timestamp
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Function to handle errors and exit gracefully
handle_error() {
    log_message "ERROR: $1"
    exit 1
}

# Check if required commands are available
for cmd in curl mysql awk; do
    if ! command -v $cmd &> /dev/null; then
        handle_error "Required command '$cmd' is not installed."
    fi
done

log_message "Starting gold price scrape."

# Use curl to fetch the webpage, silently. Follow redirects (-L).
# Using a user-agent to look less like a bot.
curl -s -L -A "Mozilla/5.0 (X11; Linux x86_64; rv:100.0) Gecko/20100101 Firefox/100.0" https://goldprice.org/ > "$DATA_FILE"

# Check if curl was successful
if [ $? -ne 0 ]; then
    handle_error "CURL failed to retrieve the webpage."
fi

# Check if the file has content and is not a blocked page (e.g., by Cloudflare)
if ! grep -q "Gold Price Per Ounce" "$DATA_FILE"; then
    handle_error "Webpage content is not as expected. Site might be blocked or HTML structure changed."
fi

# --- DATA PARSING & MANIPULATION ---
# Extract the price using awk. Look for the specific span id.
# Example HTML: <span id="gpxt-price">1,934.65</span>
PRICE=$(awk -F'[<>]' '/id="gpxt-price"/{gsub(/[,]/,"", $3); print $3}' "$DATA_FILE")

# Check if price was extracted
if [ -z "$PRICE" ]; then
    handle_error "Could not extract price from webpage. Parsing logic may be broken."
fi

# Get the current timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

log_message "Successfully extracted gold price: \$$PRICE"

# --- DATABASE INSERTION ---
# Construct the MySQL query
QUERY="INSERT INTO $DB_TABLE (price, timestamp) VALUES ($PRICE, '$TIMESTAMP');"

# Execute the query
/opt/lampp/bin/mysql -u "$DB_USER" -e "USE $DB_NAME; $QUERY"

# Check if MySQL query was successful
if [ $? -eq 0 ]; then
    log_message "Successfully inserted data into database."
else
    handle_error "MySQL query failed to execute."
fi

log_message "Scraping cycle completed successfully."