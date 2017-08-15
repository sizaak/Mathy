class MasterAssignmentsViewController < MyTableController
  def viewDidLoad
    super
    self.title = "Assignments"
    assignments = {'current' => ['Power Rule'],
             'future' => ['Product Rule', 'Chain Rule', 'Quotient Rule'],
             'past' => []}
    @data = []
    assignments.each_pair do |key, value|
      @data << key
      value.each {|assignment| @data << assignment}
    end
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @assignmentIdentifier ||= 'assignment'
    @headingIdentifier ||= 'heading'
    headers = ['current', 'future', 'past']
    label = @data[indexPath.row]
    if headers.include?(label)
      cell = tableView.dequeueReusableCellWithIdentifier(@headingIdentifier) || makeCell(2, @headingIdentifier, label)
    else
      cell = tableView.dequeueReusableCellWithIdentifier(@assignmentIdentifier) || makeCell(1, @assignmentIdentifier, label)
    end

    cell
  end

  def makeCell(mode, identifier, text)
    if mode == 1
      # Create assignment cell
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:identifier)
      cell.textLabel.text = text
    else
      # Create header cell
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:identifier)
      cell.detailTextLabel.text = "-------------------------"
      cell.textLabel.text = text.swapcase
    end

    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if @data[indexPath.row] == 'Power Rule'
      self.navigationController.pushViewController(AssignmentViewController.alloc.initWithNibName(nil, bundle: nil), animated: true)
    else
      super
    end
  end
end
