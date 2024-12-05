mport csv

def csv_to_jira_table(csv_file_path):
    """
    Converts a CSV file into Jira table syntax and replaces ";" with "|".
    
    Args:
        csv_file_path (str): Path to the input CSV file.
        
    Returns:
        str: Jira table syntax as a string.
    """
    try:
        with open(csv_file_path, 'r') as file:
            reader = csv.reader(file, delimiter=';')  # Handle CSVs with ";" as delimiter
            rows = list(reader)
            
            # Ensure the file is not empty
            if not rows:
                return "The CSV file is empty."
            
            # Generate the Jira table header
            jira_table = f"|| {' || '.join(rows[0])} ||\n"
            
            # Generate the Jira table rows
            for row in rows[1:]:
                jira_table += f"| {' | '.join(row)} |\n"
                
            return jira_table
    except FileNotFoundError:
        return f"Error: The file '{csv_file_path}' does not exist."
    except Exception as e:
        return f"An error occurred: {e}"

# Example usage
if __name__ == "__main__":
    # Provide the path to your CSV file here
    csv_file = "Da_Migrare.csv"
    
    jira_table_syntax = csv_to_jira_table(csv_file)
    if jira_table_syntax:
        print("Jira Table Syntax:")
        print(jira_table_syntax)
