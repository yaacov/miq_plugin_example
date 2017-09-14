# MiqPluginExample
ManageIQ UI Classic Plugin capabilities example and demonstration

## Usage

You need to checkout manageiq, manageiq-ui-classic and manageiq-schema next to each other and setup the gem overrides.

Then you need to add this gem to your Gemfile or bundler.d/:

```ruby
gem 'miq_plugin_example', :path => File.expand_path('../../miq_plugin_example/', __dir__)
```

You need this PR: https://github.com/ManageIQ/manageiq-ui-classic/pull/2132 to make the React part work (or remove it).

You need a migration to create the Demo entity:
```
devil - [~/Projects/manageiq-schema] (master)$ git diff --staged
diff --git a/db/migrate/20170615141045_create_demo.rb b/db/migrate/20170615141045_create_demo.rb
new file mode 100644
index 0000000..bba437a
--- /dev/null
+++ b/db/migrate/20170615141045_create_demo.rb
@@ -0,0 +1,12 @@
+class CreateDemo < ActiveRecord::Migration[5.0]
+  def change
+    create_table :demos do |t|
+      t.bigint :vm_id
+      t.string :name
+      t.string :title
+      t.boolean :foobar
+
+      t.timestamps
+    end
+  end
+end
```

Then you need an empty model for the Demo entity:
```
devil - [~/Projects/manageiq] (master)$ git diff --staged
diff --git a/app/models/demo.rb b/app/models/demo.rb
new file mode 100644
index 0000000..9cc6e22
--- /dev/null
+++ b/app/models/demo.rb
@@ -0,0 +1,2 @@
+class Demo < ApplicationRecord
+end

```

### Making it work:

Run the migration. Add a row or 2 to the table. Run `./bin/webpacker` in manageiq-ui-classic. Run the UI.


## Contributing
Leave a PR.

## License
The gem is available as open source under the terms of the [Apache License 2.0](https://opensource.org/licenses/apache-2.0).
