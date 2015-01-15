require "version_bomb/version"

module VersionBomb
  def self.blow_up_if_gem_version_changes(gem, version)
    Gem::Specification.find_by_name(gem, version)
  rescue Gem::LoadError
    abort <<-ERROR
  #{'*' * 75}
  It looks like #{gem} has been upgraded beyond version #{version}. Awesome!
  Please take a look at the #{gem} monkeypatch in the following file and either delete
  it or increment the version number:
  #{caller.second}
  #{'*' * 75}
    ERROR
  end

  def self.blow_up_if_ruby_version_changes(version)
    if RUBY_VERSION != version
      abort <<-ERROR
  #{'*' * 75}
  It looks like ruby has been upgraded beyond version #{version}. Awesome!
  Please take a look at the ruby monkeypatch in the following file and either delete
  it or increment the version number:
  #{caller.second}
  #{'*' * 75}
    ERROR
    end
  end
end
