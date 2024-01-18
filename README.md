# Clinic Patient Details

**Group Name:** 2.5 Pieces

**Group members:**
- Ahmad Azim bin Abdul Aziz (2014781)
- Muhammad Haikal Wijdan bin Rizal (1916771)
- Afnan Iman bin Azman (1920311)

**Assigned tasks:**
- **Azim Aziz:**
  - Linked firebase_core in `main.dart`.
  - Set up a file for all Firebase functions in `database.dart`.
  - Created the registration form in `create.dart`.
  
- **Haikal Wijdan:**
  - Created a homepage that can retrieve data in `homepage.dart`.
  - Implemented a delete function to remove patient details in `delete.dart`.

- **Afnan Iman bin Azman:**
  - Developed an update function based on selected patient details.
  - Implemented user alerts with Snackbars for updates in both `create.dart` and `update.dart`.
  - Worked on the overall CSS design.

**Brief Description:**
Our Clinic Patient Detail app is a user-friendly mobile application used by clinics in Malaysia to efficiently manage patient information. With this app, clinics can easily Create, Read, Update, and Delete patient details, making the entire process smooth and hassle-free.

**Project Structure:**
- **Create:** The creation functionality is in `create.dart`.
- **Retrieve:** Data retrieval is handled in `homepage.dart`.
- **Update:** Updates are performed in `update.dart`.
- **Delete:** Deletion tasks are managed in `delete.dart`.

To simplify access to these functions, we've centralized them into a single file named `database.dart`.

**Included Packages (pubspec.yaml):**
- `intl`: Used for date formatting purposes (dd-mm-yyyy).
- `random_number`: Utilized to set a unique ID on each patient detail.
