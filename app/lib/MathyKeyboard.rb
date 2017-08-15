module MathyKeyboard
  class Keyboard < UIView

    def initWithTextFieldAndLayout(textField, keys, controller)

      define_constants
      calc_sizes

      self.initWithFrame(CGRectMake(0.0, 0.0, @screen_width, @keyboardHeight))
      @controller = controller
      @keys = keys
      @textField = WeakRef.new(textField)
      self.backgroundColor = @bg_color
      self.createButtons
      self
    end

    def define_constants
      @bg_color = UIColor.lightGrayColor
      @text_color = UIColor.lightTextColor
      @screen_width = UIScreen.mainScreen.bounds.size.width
      @screen_height = UIScreen.mainScreen.bounds.size.height
    end

    def calc_sizes
      @key_height = 54
      @numrows = 5.0
      @numberOfKeys = 25
      @keyboardHeight = @key_height * @numrows
      @key_width  = @screen_width / 5.0
      @rect = CGRectMake(0.0, 0.0, @key_width, @key_height)
    end

    def createButtons
      (0...@numberOfKeys).each do |num|
        @rect.origin = self.buttonOriginPointForNumber(num)
        self.makeButtonWithRect(@rect,num,false)
      end
    end

    def makeButtonWithRect(rect, num, grayBackground)
      button = UIButton.buttonWithType(UIButtonTypeCustom)
      button.frame = rect
      fontSize = 25.0

      button.backgroundColor = UIColor.whiteColor

      if num < 23
        button.titleLabel.font = UIFont.systemFontOfSize(fontSize)
        button.setTitleColor(UIColor.darkTextColor, forState:UIControlStateNormal)
        button.setTitle(@keys[num], forState:UIControlStateNormal)
      elsif num == 23
        button.setImage(UIImage.imageNamed("deleteButton"), forState:UIControlStateNormal)
        button.setAccessibilityLabel("delete")
      else
        button.titleLabel.font = UIFont.systemFontOfSize(20.0)
        button.setTitleColor(UIColor.darkTextColor, forState:UIControlStateNormal)
        button.setTitle(@keys[num], forState:UIControlStateNormal)
        button.addTarget(@controller, action:"check_answer", forControlEvents: UIControlEventTouchUpInside)
      end

      button.tag = num
      button.addTarget(self, action:"changeButtonBackgroundColourForHighlight:", forControlEvents: (UIControlEventTouchDown|UIControlEventTouchDragEnter|UIControlEventTouchDragExit))
      button.addTarget(self, action:"changeTextFieldText:", forControlEvents: UIControlEventTouchUpInside) unless num == 24

      self.addSubview(button)
    end

    def buttonOriginPointForNumber(num)
      point = CGPointMake(0.0,0.0)
      point.x = (@key_width * (num % 5)).ceil
      point.y = (num / 5.0).floor * (@key_height + 0.5)
      point
    end

    def changeButtonBackgroundColourForHighlight(button)
      if button.backgroundColor == @text_color
         button.backgroundColor = UIColor.whiteColor
      else
         button.backgroundColor = @text_color
      end
    end

    def changeTextFieldText(button)
      if button.tag == 23
        @textField.text = "#{@textField.text.chop}"
      elsif button.tag == 20
      elsif button.titleLabel.text != ' '
        @textField.insertText(button.titleLabel.text)
      end
      self.changeButtonBackgroundColourForHighlight(button)
      @textField.sendActionsForControlEvents(UIControlEventEditingChanged)
    end

  end
end

=begin
The license of the library that this library was derived from.
https://github.com/DiogoAndre/motion-ipkeyboard

The MIT License (MIT)

Copyright (c) 2014 Diogo André de Assumpção

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
=end
