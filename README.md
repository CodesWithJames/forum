== README

- Ruby version: 2.2.2

- Server: AWS EC2 - Micro T2

- Configuration: Unicorn with Nginx

- Database: MongoDBb on Mongolab

- How to run the test suite
  ``` shell
  $ bundle install
  $ bundle exec rspec
  ```
- Deployment instructions
  ``` shell
  $ cap deploy
  ```

- Blacklist 
Itens que estão sendo colocados como proibidos na hora de criar e comentar sobre um tópico
``` ruby
"porra" "caralho" "buceta"  "foda" "vsf" "foda-se" "fdp" "filho da puta" "pqp" "puta" "cuzã"o "viado" "veado" "bixa" "viadinho"
````
