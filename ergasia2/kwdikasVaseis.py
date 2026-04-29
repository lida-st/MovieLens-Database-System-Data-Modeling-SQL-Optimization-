import csv
import json

# Δημιουργήστε δύο λεξικά για να αποθηκεύσετε τα μοναδικά δεδομένα
unique_keywords = {}
movie_keywords_relations = []

# Ανοίξτε το αρχείο CSV για ανάγνωση
with open('keywords.csv', mode='r', encoding='utf-8') as file:
    reader = csv.reader(file)
    next(reader, None)  # Παραλείψτε την επικεφαλίδα αν υπάρχει
    for row in reader:
        movie_id = row[0]
        try:
            # Αναλύστε τη συμβολοσειρά JSON των λέξεων-κλειδιών
            keywords_list = json.loads(row[1].replace("'", '"'))  # Αντικαταστήστε τα μονά με διπλά εισαγωγικά
            for keyword in keywords_list:
                keyword_id = keyword['id']
                keyword_name = keyword['name']
                # Προσθέστε τη λέξη-κλειδί στο λεξικό αν δεν υπάρχει ήδη
                if keyword_id not in unique_keywords:
                    unique_keywords[keyword_id] = keyword_name
                # Προσθέστε τη σχέση ταινίας-λέξης-κλειδί
                movie_keywords_relations.append((movie_id, keyword_id))
        except json.JSONDecodeError:
            print(f"Σφάλμα κατά την ανάλυση JSON στη γραμμή {reader.line_num}: {row[1]}")

# Αφαιρέστε τα διπλότυπα από τα keywords
unique_keywords = {k: v for k, v in unique_keywords.items()}

# Αφαιρέστε τα διπλότυπα από τις σχέσεις ταινιών-λέξεων-κλειδιών
movie_keywords_relations = list(set(movie_keywords_relations))

# Ανοίξτε τα αρχεία CSV για εγγραφή
with open('keywords_output.csv', mode='w', newline='', encoding='utf-8') as keywords_file, \
     open('movies_keywords.csv', mode='w', newline='', encoding='utf-8') as movies_keywords_file:
    
    keywords_writer = csv.writer(keywords_file)
    movies_keywords_writer = csv.writer(movies_keywords_file)
    
    # Γράψτε τις επικεφαλίδες για τα αρχεία CSV
    keywords_writer.writerow(['id', 'name'])
    movies_keywords_writer.writerow(['movie_id', 'keyword_id'])
    
    # Γράψτε τα μοναδικά δεδομένα των λέξεων-κλειδιών στο αρχείο keywords_output.csv
    for keyword_id, keyword_name in unique_keywords.items():
        keywords_writer.writerow([keyword_id, keyword_name])
    
    # Γράψτε τις σχέσεις ταινιών-λέξεων-κλειδιών στο αρχείο movies_keywords.csv
    for movie_id, keyword_id in movie_keywords_relations:
        movies_keywords_writer.writerow([movie_id, keyword_id])