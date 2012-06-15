dep "on deploy", :old_id, :new_id, :branch, :env do
  requires 'benhoskings:when path changed'.with('app/assets/', 'assets fully precompiled', old_id, new_id, env)
end

dep 'assets fully precompiled', :env, :deploying, :template => 'task' do
  run {
    shell "bundle exec rake assets:precompile RAILS_ENV=#{env}"
  }
end
