BRANCH=$(shell git branch --show-current)

postmd: 
	@./update_post_md

readme: 
	@./update_readme

