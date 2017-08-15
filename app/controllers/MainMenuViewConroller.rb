class MainMenuViewController < MyTableController
  def viewDidLoad
    super
    self.title = "Menu"
    @data = ["Assignments", "Grades", "Settings"]
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if @data[indexPath.row] == "Assignments"
      self.navigationController.pushViewController(MasterAssignmentsViewController.alloc.init, animated: true)
    else
      super
    end
  end

end
