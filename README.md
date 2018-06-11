### Sinatra 정리


july0325:~/workspace $ touch new.erb
july0325:~/workspace $ touch views/create.erb
july0325:~/workspace $ gem install datamapper
Fetching: public_suffix-3.0.2.gem (100%)
Successfully installed public_suffix-3.0.2
Fetching: addressable-2.5.2.gem (100%)
Successfully installed addressable-2.5.2
Fetching: dm-core-1.2.1.gem (100%)
Successfully installed dm-core-1.2.1
Fetching: uuidtools-2.1.5.gem (100%)
Successfully installed uuidtools-2.1.5
Fetching: stringex-1.5.1.gem (100%)
Successfully installed stringex-1.5.1
Fetching: json-1.8.6.gem (100%)
Building native extensions.  This could take a while...
Successfully installed json-1.8.6
Fetching: fastercsv-1.5.5.gem (100%)
Successfully installed fastercsv-1.5.5
Fetching: bcrypt-3.1.12.gem (100%)
Building native extensions.  This could take a while...
Successfully installed bcrypt-3.1.12
Fetching: bcrypt-ruby-3.1.5.gem (100%)

#######################################################

The bcrypt-ruby gem has changed its name to just bcrypt.  Instead of
installing `bcrypt-ruby`, you should install `bcrypt`.  Please update your
dependencies accordingly.

#######################################################

Successfully installed bcrypt-ruby-3.1.5
Fetching: dm-types-1.2.2.gem (100%)
Successfully installed dm-types-1.2.2
Fetching: dm-validations-1.2.0.gem (100%)
Successfully installed dm-validations-1.2.0
Fetching: dm-timestamps-1.2.0.gem (100%)
Successfully installed dm-timestamps-1.2.0
Fetching: json_pure-1.8.6.gem (100%)
Successfully installed json_pure-1.8.6
Fetching: dm-serializer-1.2.2.gem (100%)
Successfully installed dm-serializer-1.2.2
Fetching: dm-transactions-1.2.0.gem (100%)
Successfully installed dm-transactions-1.2.0
Fetching: dm-migrations-1.2.0.gem (100%)
Successfully installed dm-migrations-1.2.0
Fetching: dm-constraints-1.2.0.gem (100%)
Successfully installed dm-constraints-1.2.0
Fetching: dm-aggregates-1.2.0.gem (100%)
Successfully installed dm-aggregates-1.2.0
Fetching: datamapper-1.2.0.gem (100%)
Successfully installed datamapper-1.2.0
19 gems installed
july0325:~/workspace $ gem install dm-sqlite-adapter
Fetching: data_objects-0.10.17.gem (100%)
Successfully installed data_objects-0.10.17
Fetching: dm-do-adapter-1.2.0.gem (100%)
Successfully installed dm-do-adapter-1.2.0
Fetching: do_sqlite3-0.10.17.gem (100%)
Building native extensions.  This could take a while...
Successfully installed do_sqlite3-0.10.17
Fetching: dm-sqlite-adapter-1.2.0.gem (100%)
Successfully installed dm-sqlite-adapter-1.2.0
4 gems installed
july0325:~/workspace $ 


ORM:object relational mapper
객체지향언어 ruby와 데이터베이스 sqlite을 연결하는 것을 도와주는 도구
datamapper(http://recipes.sinatrarb.com/p/models/data_mapper)

사전준비사항
상단 인스톨...
gem install datamapper
gem install dm-sqlite-adapter
코드상에는,
app.rb상단에 c9에서 제이슨 라이브러리 충돌로인한코드
gem 'json','~> 1.6'

require 'data_mapper' # metagem, requires common plugins too.

# need install dm-sqlite-adapter
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!

////////////////////////////
terminal에서 게시판에 게시글쓰기
july0325:~/workspace $ irb
2.4.0 :001 > require '/app.rb'
LoadError: cannot load such file -- /app.rb
        from /usr/local/rvm/rubies/ruby-2.4.0/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
        from /usr/local/rvm/rubies/ruby-2.4.0/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
        from (irb):1
        from /usr/local/rvm/rubies/ruby-2.4.0/bin/irb:11:in `<main>'
2.4.0 :002 > require './app.rb'
/usr/local/rvm/gems/ruby-2.4.0/gems/data_objects-0.10.17/lib/data_objects/pooling.rb:149: warning: constant ::Fixnum is deprecated
 => true 
2.4.0 :003 > Post.create(title:"test", body:"testcontents")
 => #<Post @id=1 @title="test" @body="testcontents" @created_at=#<DateTime: 2018-06-11T02:39:00+00:00 ((2458281j,9540s,433024077n),+0s,2299161j)>> 
2.4.0 :004 > Post.all
 => [#<Post @id=1 @title="test" @body=<not loaded> @created_at=#<DateTime: 2018-06-11T02:39:00+00:00 ((2458281j,9540s,0n),+0s,2299161j)>>] 
2.4.0 :005 > 


/////////////////////////////////////////
데이터 조작
-기본
irb
require './app.rb'
Post.all
-C
1)
Post.create(title:"test",body:"test") 
2)
p=Post.new
p.title="test"
p.body="test"
p.save #db에 작성


-R
Post.get(1) #get(id)

-U
1)Post.get(1).update(title:"tet", body:"tet")
2)p=Post.get(1)
p.title="wphr"
p.body="dgfaga"
p.save


-D
Post.get(1).destroy


////////////////
simbol은 불변!
같은 스트링이더라도, simbol이 아니면 다른값가짐.
///////////////


/////////////시작페이지 만들기 라우팅 설정 및 대응되는 뷰


/////params
1.variable routing: 
app.rd에서 
get 'hello/:name'
@name=params[:name]
erb:name
end

2.form tag 이용하여 받는법
html 문서에서 
<form action="//">
제목:<input name="title">
<action>