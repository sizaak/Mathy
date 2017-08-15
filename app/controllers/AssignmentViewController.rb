class AssignmentViewController < UIViewController
  def viewDidLoad
    super
    screen_width = UIScreen.mainScreen.bounds.size.width
    self.view = UIScrollView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    screen_width = UIScreen.mainScreen.bounds.size.width
    problem_number = 10
    rect_height = 60
    assignment_length = problem_number * rect_height * 2
    @problems, @answers = problems_and_answers
    content = UIView.alloc.initWithFrame(CGRectMake(0, 0, screen_width, assignment_length))
    (0...problem_number).each do |i|
      cell = UITextView.alloc.initWithFrame(CGRectMake(0, i * rect_height * 2, screen_width, rect_height))
      problem = @problems.shift
      fname = problem.split[0]
      var = 'x' if problem.include? 'x'
      var = 't' if problem.include? 't'
      var = 'r' if problem.include? 'r'
      cell.text = (i + 1).to_s + ". " + "Find the derivative:\n" + problem + "\n" + fname + "\' ="
      cell.editable = false
      cell2 = UITextField.alloc.initWithFrame(CGRectMake(0, i * rect_height * 2 + rect_height, screen_width, rect_height))
      cell2.backgroundColor = UIColor.yellowColor
      keys = [var, 'π', ' ', ' ', '+', '(', '1', '2', '3', '-', ')', '4', '5', '6', '*', '^', '7', '8', '9', '/', '...', '.', '0', '', 'Submit']
      cell2.placeholder = 'Answer'
      cell2.inputView = MathyKeyboard::Keyboard.alloc.initWithTextFieldAndLayout(cell2, keys, self)
      content.addSubview(cell)
      content.addSubview(cell2)
    end
    self.view.contentSize = CGSizeMake(screen_width, assignment_length)
    self.view.addSubview(content)
  end

  def problems_and_answers
    problems = ["y = x^8",
                "y = x^(1/3)",
                "y = x^(-2/5)",
                "v(r) = (4/3)πr^3",
                "y(t) = 6t^(-9)",
                "f(x) = x^2 - 10x + 100",
                "g(x) = x^100 + 50x + 1",
                "f(x) = (2x)^3",
                "g(x) = x^2 + 1/(x^2)",
                "s(t) = t^8 + 6t^7 - 18t^2 + 2t"]
    answers =  ["8x^7",
                "(1/3)x^(-2/3)",
                "(-2/5)x^(-7/5)",
                "4πr^2",
                "-54t^(-10)",
                "2x-10",
                "100x^99+50",
                "24x^2",
                "2x-2/(x^3)",
                "8t^7+42t^6-36t+2"]
    return problems, answers
  end

  def check_answer
    current = nil
    boxes = self.view.subviews[0].subviews
    boxes.each {|field| current = field if field.isEditing}
    problem_index = (boxes.index(current) - 1) / 2
    if current.text == @answers[problem_index]
      current.backgroundColor = UIColor.greenColor
    else
      current.backgroundColor = UIColor.redColor
    end
  end
end
