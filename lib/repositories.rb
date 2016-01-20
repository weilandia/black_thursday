module Repositories
  def instantiate_repos(all)
    @all = []
    all.each { |hash| create_instance hash }
  end

  def exact_search(search_result)
    return nil if search_result.nil?
    search_result
  end

  def find_by_id(id)
    search_result = all.select {|s| s.id == id}[0]
    exact_search(search_result)
  end

  def find_by_name(name)
    result = all.select {|s| s.name.downcase == name.downcase}[0]
    exact_search(result)
  end

  def find_all_by_name(search_frag)
    all.select {|s| s.name.downcase.include? search_frag.downcase}
  end
end
