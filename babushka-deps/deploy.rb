dep "on deploy", :old_id, :new_id, :branch, :env do
  requires 'benhoskings:when path changed'.with('app/assets/', 'assets precompiled', old_id, new_id, env)
end
