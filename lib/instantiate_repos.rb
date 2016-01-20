module InstantiateRepos
  def instantiate_repos(all)
    @all = []
    all.each { |hash| create_instance hash }
  end
end
