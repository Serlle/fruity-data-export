## Fruity Data Export
This application allows you to export fruit data from the FruityVice API and create a downloadable file. Make sure you have Ruby 3.0.3 and Rails 7.0.7 installed to run this application.

### Installation
To get started, follow these steps:

Clone the repository:

```sh
git clone https://github.com/Serlle/fruity-data-export.git
```

Navigate to the project directory:

```sh
cd fruity-data-export
```

Install the required gems:

```sh
bundle install
```

Start the Rails server:

```sh
rails server
```

Open your web browser and visit http://localhost:3000 to use the application.

## Usage

### API Documentation
You can find the API documentation for FruityVice [here](https://www.fruityvice.com/doc/index.html#api-GET).

### Interface

* Root: The root page of the application is /home.
* Create: To create a downloadable file, go to the /new page.
* Backend: The backend endpoint for creating the file is /create.

### Filters
Before exporting data, please note the following filters:

* If the user does not provide a file name, the export will not be processed.
* If the user does not provide at least one field in the "Search by filter" section, the export will not be processed
* If the user tries to search by "name" or by "filter" simultaneously, the export will not be processed.

### Error Messages
You may encounter the following error messages:

* If a fruit is not found or does not exist, you will receive an appropriate error message.