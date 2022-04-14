server:
  docker run -v $(pwd):/app -v rubygems_clinickr:/usr/local/bundle -w /app -p 3000:3000 --network clinickr ruby bash -c "ruby server.rb"

run.test:
	docker run -v $(pwd):/app -v rubygems_clinickr:/usr/local/bundle -w /app ruby bash -c "ruby unit_tests.rb"

install.gems:
	docker run -v $(pwd):/app -v rubygems_clinickr:/usr/local/bundle -w /app ruby bash -c "gem install sinatra puma byebug pg"

db.import:
	docker run	-it -v $(pwd):/app -v rubygems_clinickr:/usr/local/bundle -w /app --network clinickr ruby bash -c "ruby importer.rb"

pg.server
	docker run --rm --name clinickpg -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD='123456' -e POSTGRES_DB=postgres -v clinick_db_data:/var/lib/postgresql/data -p 5432:5432 --network clinickr postgres

psql:
	docker exec -it clinickpg bash -c "psql -U postgres postgres"
