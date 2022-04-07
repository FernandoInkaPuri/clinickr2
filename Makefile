server:
  docker run -v $(pwd):/app -v rubygems_clinickr:/usr/local/bundle -w /app -p 3000:3000 ruby bash -c "ruby server.rb"

run.test:
	docker run -v $(pwd):/app -v rubygems_clinickr:/usr/local/bundle -w /app ruby bash -c "ruby unit_tests.rb"

install.gems:
	docker run -v $(pwd):/app -v rubygems_clinickr:/usr/local/bundle -w /app ruby bash -c "gem install sinatra puma byebug"
